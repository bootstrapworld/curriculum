#!/usr/bin/env node
/*
 * Run every Pyret starter file the curriculum links to through a headless
 * browser against a deployed Pyret editor, and report
 * pass / expected-error / broken.
 *
 *   node run.js [--lang=en-us] [--jobs=4] [--grep=<regex>] [--list]
 *               [--json=<path>] [--summary=<path>] [--retries=1]
 *               [--update-expectations=<path>]
 *
 * PYRET_HOST selects the deployment under test (default
 * https://pyret.bootstrapworld.org); point it at a local CPO to bisect a
 * Pyret-side regression.
 */
const fs = require("fs");
const path = require("path");
const registry = require("./lib/registry");
const { drive } = require("./lib/runner");
const { launchChromium } = require("./lib/browser");
const { ProceduralError } = require("./lib/errors");

const REPO_ROOT = path.resolve(__dirname, "..");
const HOST = process.env.PYRET_HOST || "https://pyret.bootstrapworld.org";

const HEALTHY = ["ok", "interactive"];

function parseArgs(argv) {
  const a = { lang: "en-us", jobs: 4, retries: 1, grep: null, list: false, json: null, summary: null, expectations: path.join(__dirname, "expectations.json"), update: null };
  for (const arg of argv) {
    const m = /^--([^=]+)(?:=(.*))?$/.exec(arg);
    if (!m) { console.error("unrecognized argument: " + arg); process.exit(2); }
    const [, k, v] = m;
    if (k === "lang") a.lang = v;
    else if (k === "jobs") a.jobs = Math.max(1, parseInt(v, 10));
    else if (k === "retries") a.retries = Math.max(0, parseInt(v, 10));
    else if (k === "grep") a.grep = new RegExp(v, "i");
    else if (k === "list") a.list = true;
    else if (k === "json") a.json = v;
    else if (k === "summary") a.summary = v;
    else if (k === "expectations") a.expectations = v;
    else if (k === "update-expectations") a.update = v || path.join(__dirname, "expectations.json");
    else { console.error("unrecognized flag: --" + k); process.exit(2); }
  }
  return a;
}

function loadExpectations(file) {
  if (!fs.existsSync(file)) return {};
  return JSON.parse(fs.readFileSync(file, "utf8")).expectations || {};
}

// verdict: PASS | EXPECTED-ERROR | BROKEN | UNVERIFIED
function judge(entry, run, exp) {
  if (run.procedural) return { verdict: "UNVERIFIED", why: run.detail };
  // A starter file whose URL 404s is broken no matter what the table says.
  if (run.outcome === "missing-file") return { verdict: "BROKEN", why: run.detail };
  const e = exp[entry.label];
  const want = !e ? HEALTHY : (Array.isArray(e.expect) ? e.expect : [e.expect]);
  const got = run.outcome;
  if (!want.includes(got)) {
    return { verdict: "BROKEN", why: `expected ${want.join("|")}, got ${got}: ${run.detail}` };
  }
  if (e && e.errorContains && (got === "error" || got === "tests-failed")) {
    const hay = (run.detail || "") + " " + ((run.result && run.result.outputText) || "");
    if (!hay.toLowerCase().includes(String(e.errorContains).toLowerCase())) {
      return { verdict: "BROKEN", why: `expected error containing ${JSON.stringify(e.errorContains)}, got: ${run.detail}` };
    }
  }
  if (got === "error" || got === "tests-failed") return { verdict: "EXPECTED-ERROR", why: e && e.reason };
  return { verdict: "PASS", why: run.detail };
}

async function pool(items, jobs, fn) {
  const out = new Array(items.length);
  let next = 0;
  await Promise.all(Array.from({ length: Math.min(jobs, items.length) }, async () => {
    for (;;) {
      const i = next++;
      if (i >= items.length) return;
      out[i] = await fn(items[i], i);
    }
  }));
  return out;
}

async function runEntry(browser, entry, retries) {
  for (let attempt = 0; ; attempt++) {
    try {
      return await drive(browser, entry, {});
    } catch (e) {
      const procedural = e instanceof ProceduralError;
      if (attempt < retries) continue;
      return { outcome: "unverified", procedural, detail: (procedural ? "" : e.name + ": ") + e.message, result: null, ms: 0, log: [] };
    }
  }
}

(async () => {
  const args = parseArgs(process.argv.slice(2));
  const { entries, problems } = registry.load(REPO_ROOT, { lang: args.lang, host: HOST });
  const exp = loadExpectations(args.expectations);

  let testable = entries.filter((e) => e.kind !== "skip");
  if (args.grep) testable = testable.filter((e) => args.grep.test(e.label) || args.grep.test(e.url || "") || args.grep.test(e.title || ""));
  const skipped = entries.filter((e) => e.kind === "skip");

  console.log(`host          ${HOST}`);
  console.log(`language      ${args.lang}`);
  console.log(`registry      ${entries.length} entries -> ${testable.length} to run, ${skipped.length} not Pyret`);
  if (problems.length) {
    console.log(`\nregistry problems (${problems.length}):`);
    for (const p of problems) console.log(`  ! ${p.kind}: ${p.detail}`);
  }
  if (args.list) {
    for (const e of testable) console.log(`  ${e.kind.padEnd(8)} ${e.label.padEnd(42)} ${e.url}`);
    console.log("\nnot Pyret:");
    const byReason = {};
    for (const e of skipped) (byReason[e.reason] ||= []).push(e.label);
    for (const [r, ls] of Object.entries(byReason)) console.log(`  ${String(ls.length).padStart(3)}  ${r}: ${ls.join(", ")}`);
    return;
  }

  console.log(`\nrunning ${testable.length} programs, ${args.jobs} at a time\n`);
  const browser = await launchChromium();
  let done = 0;
  const rows = await pool(testable, args.jobs, async (entry) => {
    const run = await runEntry(browser, entry, args.retries);
    const j = judge(entry, run, exp);
    done++;
    const mark = { PASS: "ok  ", "EXPECTED-ERROR": "xerr", BROKEN: "FAIL", UNVERIFIED: "????" }[j.verdict];
    console.log(`[${String(done).padStart(3)}/${testable.length}] ${mark} ${entry.label.padEnd(42)} ${(run.ms / 1000).toFixed(1)}s  ${(j.why || run.detail || "").slice(0, 110)}`);
    return { entry, run, ...j };
  });
  await browser.close();

  const by = (v) => rows.filter((r) => r.verdict === v);
  const broken = by("BROKEN"), unverified = by("UNVERIFIED");

  console.log(`\n${"=".repeat(72)}`);
  console.log(`PASS ${by("PASS").length}   EXPECTED-ERROR ${by("EXPECTED-ERROR").length}   BROKEN ${broken.length}   UNVERIFIED ${unverified.length}   (skipped ${skipped.length} non-Pyret)`);

  for (const [title, set] of [["BROKEN", broken], ["UNVERIFIED (could not be tested)", unverified]]) {
    if (!set.length) continue;
    console.log(`\n${title}:`);
    for (const r of set) {
      console.log(`  ${r.entry.label}`);
      console.log(`    ${r.entry.url}`);
      console.log(`    ${r.why}`);
      for (const l of r.run.log.slice(0, 3)) console.log(`    . ${l}`);
    }
  }

  if (args.json) {
    fs.writeFileSync(args.json, JSON.stringify({
      host: HOST, lang: args.lang, when: new Date().toISOString(),
      counts: { pass: by("PASS").length, expectedError: by("EXPECTED-ERROR").length, broken: broken.length, unverified: unverified.length, skipped: skipped.length },
      problems,
      results: rows.map((r) => ({
        label: r.entry.label, file: r.entry.file, title: r.entry.title, kind: r.entry.kind,
        url: r.entry.url, source: r.entry.source || null,
        outcome: r.run.outcome, verdict: r.verdict, why: r.why, ms: r.run.ms,
        detail: r.run.detail, log: r.run.log,
        result: r.run.result || null,
      })),
      skipped: skipped.map((e) => ({ label: e.label, file: e.file, reason: e.reason, url: e.url })),
    }, null, 2));
    console.log(`\nwrote ${args.json}`);
  }

  // Authoring aid: pin the files that legitimately open an animation dialog,
  // so losing the animation later reads as a regression instead of a pass.
  // Errors are never written automatically -- an expected error needs a human
  // to say why, so those are listed for triage instead.
  if (args.update) {
    const next = { expectations: { ...exp } };
    const triage = [];
    for (const r of rows) {
      if (r.run.procedural) continue;
      if (r.run.outcome === "interactive") {
        next.expectations[r.entry.label] = { ...(exp[r.entry.label] || {}), expect: "interactive" };
      } else if (r.run.outcome !== "ok" && !exp[r.entry.label]) {
        triage.push(r);
      }
    }
    fs.writeFileSync(args.update, JSON.stringify(next, null, 2) + "\n");
    console.log(`wrote ${args.update}`);
    if (triage.length) {
      console.log(`\n${triage.length} result(s) need a human decision before they can be expectations:`);
      for (const r of triage) console.log(`  ${r.entry.label}: ${r.run.outcome} -- ${r.run.detail}`);
    }
  }

  if (args.summary) {
    const line = (r) => `| ${r.entry.label} | ${r.run.outcome} | ${String(r.why || r.run.detail || "").replace(/\|/g, "\\|").slice(0, 160)} |`;
    let md = `## Starter file check — \`${HOST}\`\n\n`;
    md += `**${by("PASS").length} pass**, ${by("EXPECTED-ERROR").length} expected-error, **${broken.length} broken**, ${unverified.length} unverified, ${skipped.length} non-Pyret skipped.\n\n`;
    for (const [t, set] of [["Broken", broken], ["Unverified", unverified]]) {
      if (!set.length) continue;
      md += `### ${t}\n\n| starter file | outcome | detail |\n|---|---|---|\n${set.map(line).join("\n")}\n\n`;
    }
    if (problems.length) md += `### Registry problems\n\n${problems.map((p) => `- \`${p.kind}\`: ${p.detail}`).join("\n")}\n`;
    fs.writeFileSync(args.summary, md);
  }

  process.exitCode = broken.length > 0 ? 1 : 0;
})().catch((e) => { console.error(e); process.exit(2); });
