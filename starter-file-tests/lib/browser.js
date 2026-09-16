/*
 * Launch headless Chromium. GOOGLE_CHROME_BINARY selects a system Chrome;
 * otherwise Playwright's bundled Chromium (`npx playwright install chromium`).
 * Same arrangement as pyret-lang/browser-test/shared/browser.js.
 */
const { chromium } = require("playwright");

async function launchChromium() {
  const opts = { headless: true, args: ["--no-sandbox", "--disable-dev-shm-usage"] };
  if (process.env.GOOGLE_CHROME_BINARY) opts.executablePath = process.env.GOOGLE_CHROME_BINARY;
  return chromium.launch(opts);
}

// Collect the page's own story -- console, uncaught exceptions, failed
// requests -- per starter file, so a failure report carries the browser-side
// reason instead of just a timeout.
//
// Anonymous CPO sessions always produce Google Drive noise (no access token ->
// 404 /getAccessToken, 403 content.googleapis.com). That is what a logged-out
// teacher sees too, so it is recorded but never treated as a failure.
const IGNORED_LOG = [
  // Bare "Failed to load resource" console lines carry no URL; the
  // requestfailed / response handlers report the same failure with one.
  /\[error\] Failed to load resource/,
  /getAccessToken/,
  /content\.googleapis\.com/,
  /admin-ajax\.php/,
  /Insufficient permissions for this file/,
  /Page was loaded without SES/,
  /caja\.appspot\.com/,
];

function wireBrowserLogs(page, sink) {
  const clip = (s) => { s = String(s); return s.length > 300 ? s.slice(0, 300) + " ...[clipped]" : s; };
  const push = (kind, text) => {
    const line = kind + " " + clip(text);
    if (IGNORED_LOG.some((re) => re.test(line))) return;
    if (sink.length < 40) sink.push(line);
  };
  page.on("console", (m) => { if (m.type() === "error" || m.type() === "warning") push("[" + m.type() + "]", m.text()); });
  page.on("pageerror", (e) => push("[pageerror]", e));
  page.on("requestfailed", (r) => { const f = r.failure(); push("[requestfailed]", r.url() + " -- " + (f ? f.errorText : "?")); });
  page.on("response", (r) => { if (r.status() >= 400) push("[http " + r.status() + "]", r.url()); });
}

module.exports = { launchChromium, wireBrowserLogs };
