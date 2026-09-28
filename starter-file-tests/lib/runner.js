/*
 * Drive one registry entry in a fresh browser context and classify what the
 * editor did with it.
 *
 * Outcomes (what happened), separate from the verdict (was that expected):
 *   ok            ran to completion, nothing errored, any check blocks passed
 *   interactive   opened an animation dialog and kept running (reactor/animate)
 *   error         the editor reported a compile or runtime error
 *   tests-failed  ran, but check/examples blocks failed
 *   missing-file  the editor loaded GitHub's "404: Not Found" body as the program
 *
 * Anything that stops us from finding out throws ProceduralError: navigation
 * failed, the editor never booted, the run never started. Those are reported
 * apart from program results so "the site was down" never reads as "the
 * curriculum is broken".
 */
const { ProceduralError } = require("./errors");
const { SOURCE } = require("./page-assertions");
const { wireBrowserLogs } = require("./browser");

const DEFAULTS = {
  navMs: 120000,
  readyMs: 90000,
  startMs: 60000,
  settleMs: 240000,
  renderMs: 30000,
};

// GitHub serves a plain-text 404 body, which CPO installs as the program; the
// parse error that follows names line 1 and hides the real problem.
const GITHUB_404 = /^\s*404: Not Found\s*$/;

async function drive(browser, entry, opts) {
  const t = { ...DEFAULTS, ...(opts.timeouts || {}) };
  const log = [];
  const started = Date.now();
  const ctx = await browser.newContext({ viewport: { width: 1280, height: 900 } });
  const page = await ctx.newPage();
  wireBrowserLogs(page, log);
  page.setDefaultTimeout(t.navMs);

  const finish = (res) => ({ ...res, ms: Date.now() - started, log });

  try {
    try {
      await page.goto(entry.url, { waitUntil: "domcontentloaded", timeout: t.navMs });
    } catch (e) {
      throw new ProceduralError(`navigation failed: ${String(e).split("\n")[0]}`);
    }
    await page.evaluate(SOURCE);

    if (entry.kind === "page") {
      // Reachability only: the program list is not an editor.
      if (entry.isEditor) {
        const ready = await waitFor(page, "window.SFA.editorReady()", t.readyMs);
        if (!ready) throw new ProceduralError("editor never became ready");
      }
      const sticky = await page.evaluate(() => window.SFA.stickyErrors());
      if (sticky.length) return finish({ outcome: "error", detail: sticky.join(" | "), result: { stickyErrors: sticky } });
      return finish({ outcome: "ok", detail: entry.isEditor ? "editor booted" : "page loaded" });
    }

    await page.evaluate(SOURCE);
    const ready = await waitFor(page, "window.SFA.editorReady()", t.readyMs);
    if (!ready) {
      const sticky = await page.evaluate(() => window.SFA.stickyErrors()).catch(() => []);
      const cmLen = await page.evaluate(() => { const v = window.SFA.cmValue(); return v === null ? null : v.length; }).catch(() => null);
      if (sticky.length) throw new ProceduralError(`editor posted: ${sticky.join(" | ")}`);
      throw new ProceduralError(`program never loaded into the editor (CodeMirror ${cmLen === null ? "absent" : cmLen + " chars"})`);
    }

    const code = await page.evaluate(() => window.SFA.cmValue());
    if (GITHUB_404.test(code)) {
      return finish({ outcome: "missing-file", detail: "the starter file URL returns GitHub's 404 page", result: null });
    }

    const begun = await page.evaluate(() => window.SFA.beginRun());
    if (!begun) throw new ProceduralError("no #runButton / #output to drive");

    const didStart = await waitFor(page, "window.SFA.runState().started", t.startMs);
    if (!didStart) throw new ProceduralError("clicking Run produced no run");

    const settled = await waitFor(
      page, "window.SFA.runState().settled || window.SFA.runState().dialogs.length > 0", t.settleMs
    );
    const state = await page.evaluate(() => window.SFA.runState());

    if (!settled && !state.dialogs.length) {
      await page.evaluate(() => window.SFA.closeDialogs());
      throw new ProceduralError(`run did not finish within ${Math.round(t.settleMs / 1000)}s`);
    }

    if (state.dialogs.length) {
      // Let it draw a few frames, then close it the way a student does and
      // check nothing errored on the way.
      await page.waitForTimeout(2000);
      const mid = await page.evaluate(() => window.SFA.collectResult());
      const dialogs = await page.evaluate(() => window.SFA.openDialogs());
      await page.evaluate(() => window.SFA.closeDialogs());
      await page.evaluate(() => window.SFA.endRun());
      const bad = errorsOf(mid);
      if (bad) return finish({ outcome: "error", detail: bad, result: mid });
      const names = (dialogs.length ? dialogs : state.dialogs).map((d) => d.title).join(", ");
      return finish({ outcome: "interactive", detail: `opened dialog: ${names}`, result: mid, dialogs });
    }

    // Check results render asynchronously; wait for them only when there are
    // check blocks to render (a compile error has none, and waiting on it would
    // add renderMs of dead time to every failing starter file).
    if (state.checkBlocks > 0) {
      await waitFor(page, "window.SFA.runState().doneRendering", t.renderMs);
    }
    const result = await page.evaluate(() => window.SFA.collectResult());
    await page.evaluate(() => window.SFA.endRun());

    const bad = errorsOf(result);
    if (bad) return finish({ outcome: "error", detail: bad, result });
    if (result.failedBlocks > 0) {
      return finish({ outcome: "tests-failed", detail: result.failures.join(" ;; ").slice(0, 400), result });
    }
    const drew = result.images > 0 ? `, drew ${result.images}` : "";
    const detail = result.checkBlocks > 0
      ? `${result.checkBlocks} check block(s) passed${drew}`
      : (result.outputText ? `no check blocks; output rendered${drew}` : `no check blocks; no output${drew}`);
    return finish({ outcome: "ok", detail, result });
  } finally {
    await ctx.close().catch(() => {});
  }
}

function errorsOf(r) {
  if (!r) return null;
  if (r.compileErrors && r.compileErrors.length) return "compile error: " + r.compileErrors[0].slice(0, 400);
  if (r.runtimeErrors && r.runtimeErrors.length) return "runtime error: " + r.runtimeErrors[0].slice(0, 400);
  if (r.stickyErrors && r.stickyErrors.length) return "editor error: " + r.stickyErrors.join(" | ").slice(0, 400);
  return null;
}

async function waitFor(page, expr, timeout) {
  try {
    await page.waitForFunction(new Function("return !!(" + expr + ");"), undefined, { timeout, polling: 250 });
    return true;
  } catch (e) {
    return false;
  }
}

module.exports = { drive, DEFAULTS };
