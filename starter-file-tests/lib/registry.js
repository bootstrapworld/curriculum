/*
 * Read shared/langs/<lang>/starterFiles/*.json and work out, for each label,
 * the URL a reader of the built curriculum actually clicks.
 *
 * Mirrors lib/preproc.rkt's @starter-file directive:
 *   p   = entry[proglang]                       (preproc.rkt: *proglang-sym*)
 *   raw = p.url
 *   use-pyret-prefix? = proglang == "pyret"
 *                       && raw starts with *github-prefix*
 *                       && p.prefix is not false
 *   url = use-pyret-prefix? ? *pyret-starter-file-prefix* + raw : raw
 * An entry with no `p`, or with an empty url, is a curriculum authoring error
 * (preproc.rkt warns); we report those rather than testing them.
 */
const fs = require("fs");
const path = require("path");

const GITHUB_PREFIX = "https://raw.githubusercontent.com/bootstrapworld/starter-files";
const PYRET_PREFIX = "https://pyret.BootstrapWorld.org/editor#shareurl=";

// Every host we knowingly do not drive, and why. Anything not listed shows up
// as an unclassified skip so a new kind of link cannot slip past silently.
const NON_PYRET_HOSTS = {
  "classroom.amplify.com": "Desmos/Amplify activity",
  "www.desmos.com": "Desmos graph",
  "teacher.desmos.com": "Desmos activity",
  "docs.google.com": "Google Docs/Sheets/Forms",
  "drive.google.com": "Google Drive file",
  "codap.concord.org": "CODAP document",
  "www.wescheme.org": "WeScheme program",
  "bootstrapworld.org": "Bootstrap website page",
  "www.bootstrapworld.org": "Bootstrap website page",
};

function starterFilesDir(repoRoot, lang) {
  return path.join(repoRoot, "shared", "langs", lang, "starterFiles");
}

function hostOf(url) {
  try { return new URL(url).host.toLowerCase(); } catch (e) { return null; }
}

// Point a pyret.bootstrapworld.org URL at whatever host we are testing, so the
// same registry can be run against a local CPO build (PYRET_HOST).
function retarget(url, host) {
  const u = new URL(url);
  const h = new URL(host);
  u.protocol = h.protocol;
  u.host = h.host;
  if (h.pathname !== "/") u.pathname = h.pathname.replace(/\/$/, "") + u.pathname;
  return u.toString();
}

function load(repoRoot, { lang = "en-us", proglang = "pyret", host } = {}) {
  const dir = starterFilesDir(repoRoot, lang);
  const files = fs.readdirSync(dir).filter((f) => f.endsWith(".json")).sort();

  const entries = [];
  const problems = [];
  const seen = new Map();

  for (const file of files) {
    const json = JSON.parse(fs.readFileSync(path.join(dir, file), "utf8"));
    for (const [label, c] of Object.entries(json)) {
      if (seen.has(label)) {
        problems.push({
          kind: "duplicate-label", label,
          detail: `defined in both ${seen.get(label)} and ${file}; preproc.rkt keeps one of them`,
        });
      }
      seen.set(label, file);

      const p = c[proglang];
      const title = (p && p.title) || c.title || label;
      const base = { label, file, title, proglang };

      if (!p || typeof p !== "object") {
        // Name what the entry *does* offer -- "CODAP-only" is a more useful
        // line in --list than "no pyret key".
        const others = Object.keys(c).filter((k) => k !== "title" && k !== "autoinclude");
        const reason = others.length
          ? `${others.join("/")}-only, no "${proglang}" version`
          : `no "${proglang}" key`;
        entries.push({ ...base, kind: "skip", reason, url: null });
        continue;
      }
      const raw = p.url || "";
      if (raw === "") {
        problems.push({ kind: "missing-url", label, detail: `${file}: "${proglang}" entry has no url` });
        entries.push({ ...base, kind: "skip", reason: "no url", url: null });
        continue;
      }

      const usePyretPrefix =
        proglang === "pyret" && raw.startsWith(GITHUB_PREFIX) && p.prefix !== false;

      if (usePyretPrefix) {
        const url = PYRET_PREFIX + raw;
        entries.push({
          ...base, kind: "program", source: raw,
          url: host ? retarget(url, host) : url,
        });
        continue;
      }

      const h = hostOf(raw);
      const isPyretHost = h === "pyret.bootstrapworld.org";
      if (isPyretHost && /#share=/.test(raw)) {
        // Google-Drive-backed share link: the editor resolves it itself.
        entries.push({
          ...base, kind: "program", source: raw,
          url: host ? retarget(raw, host) : raw,
        });
        continue;
      }
      if (isPyretHost) {
        // The bare editor / the program list: reachability only, no program.
        entries.push({
          ...base, kind: "page", source: raw,
          isEditor: /\/editor\b/.test(raw),
          url: host ? retarget(raw, host) : raw,
        });
        continue;
      }
      if (raw.startsWith(GITHUB_PREFIX)) {
        // prefix:false on a starter-files URL -- raw text, not an editor link.
        entries.push({ ...base, kind: "skip", reason: "prefix:false on a starter-files URL", url: raw });
        continue;
      }
      const why = NON_PYRET_HOSTS[h];
      if (why) {
        entries.push({ ...base, kind: "skip", reason: why, url: raw });
      } else {
        problems.push({ kind: "unknown-host", label, detail: `${file}: unrecognized host ${h} (${raw})` });
        entries.push({ ...base, kind: "skip", reason: `unrecognized host ${h}`, url: raw });
      }
    }
  }

  return { entries, problems, files };
}

module.exports = { load, GITHUB_PREFIX, PYRET_PREFIX, retarget };
