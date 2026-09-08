#!/usr/bin/env node
//
// author-server.mjs -- a single dev server for the whole distribution/ tree.
//
// Serves distribution/$NATLANG as one origin (so quizzes, self-guided
// lessons, and plain pages are all reachable from one running process
// instead of each needing their own bespoke local-preview script), watches
// the rest of the repo, and re-runs `make` (+ build-mdquiz) whenever
// something changes, live-reloading the browser when the rebuild succeeds.
//
// Self-guided lessons are special-cased: rather than serving their (broken,
// as of this writing -- see README) production vite build, each one gets
// its own vite dev server mounted in middleware mode at its own URL prefix,
// so authors get real HMR on the React source while previewing.

import http from 'node:http';
import https from 'node:https';
import fs from 'node:fs';
import fsp from 'node:fs/promises';
import path from 'node:path';
import dns from 'node:dns/promises';
import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import chokidar from 'chokidar';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const TOPDIR = path.resolve(__dirname, '..', '..');

const RELOAD_PATH = '/__author/reload';

// A real hostname bootstrapworld.org's WordPress CORS allow-list can trust
// (see README-author.adoc), as opposed to bare 127.0.0.1/localhost -- which
// isn't a trustworthy identity to allow-list with credentials at all, since
// it's just "whatever's listening on that port on that machine". This
// domain deliberately has no public DNS record; it only resolves at all on
// a machine where an author has added it to /etc/hosts themselves, which is
// what makes it safe to allow-list. If it's not set up, teacher-hash and
// quiz-link fetches just keep failing the same way they always have --
// nothing else here depends on this succeeding.
const DEV_HOSTNAME = 'dev-author.bootstrapworld.org';

async function detectDevHostname() {
  try {
    // /etc/hosts is checked before any real DNS query, so this resolves
    // near-instantly when it's set up; bounded with a timeout so a slow or
    // absent network (this domain has no public DNS record, so a real
    // lookup means a slow NXDOMAIN, not a fast one) can't stall startup.
    const lookup = dns.lookup(DEV_HOSTNAME);
    const timeout = new Promise((resolve) => setTimeout(() => resolve(null), 1500));
    const result = await Promise.race([lookup, timeout]);
    return result && (result.address === '127.0.0.1' || result.address === '::1') ? DEV_HOSTNAME : null;
  } catch {
    return null;
  }
}

const CERT_DIR = path.join(TOPDIR, '.author-certs');

// Generates (once, cached in .author-certs/) a locally-trusted TLS cert for
// DEV_HOSTNAME via mkcert, so `author` can serve HTTPS -- which turns out to
// be required, not optional, for the WordPress login cookie to be sent at
// all. Browsers now treat http:// and https:// as different "sites" for
// SameSite cookie purposes ("schemeful same-site"), so even with the right
// CORS origin and /etc/hosts entry, a SameSite=Lax cookie set by
// https://bootstrapworld.org is never attached to a fetch from a plain
// http:// origin, regardless of how the two hosts' domains relate.
//
// Returns {key, cert} buffers, or null if mkcert isn't installed (or its
// local CA hasn't been trusted yet via `mkcert -install`, which this
// deliberately never runs itself -- installing a root CA is a system trust
// change, not something to do without the author doing it themselves).
async function ensureDevCert(hostname) {
  const keyPath = path.join(CERT_DIR, `${hostname}-key.pem`);
  const certPath = path.join(CERT_DIR, `${hostname}.pem`);
  if (fs.existsSync(keyPath) && fs.existsSync(certPath)) {
    return { key: await fsp.readFile(keyPath), cert: await fsp.readFile(certPath) };
  }
  await fsp.mkdir(CERT_DIR, { recursive: true });
  const ok = await new Promise((resolve) => {
    const mkcert = spawn('mkcert', ['-cert-file', certPath, '-key-file', keyPath, hostname], { stdio: 'inherit' });
    mkcert.on('error', () => resolve(false)); // mkcert not on PATH
    mkcert.on('exit', (code) => resolve(code === 0));
  });
  if (!ok || !fs.existsSync(keyPath) || !fs.existsSync(certPath)) return null;
  return { key: await fsp.readFile(keyPath), cert: await fsp.readFile(certPath) };
}

const MIME = {
  '.html': 'text/html; charset=utf-8',
  '.shtml': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.mjs': 'application/javascript; charset=utf-8',
  '.jsx': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.map': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.pdf': 'application/pdf',
  '.mp4': 'video/mp4',
  '.webm': 'video/webm',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.eot': 'application/vnd.ms-fontobject',
  '.txt': 'text/plain; charset=utf-8',
  '.xml': 'application/xml; charset=utf-8',
  '.csv': 'text/csv; charset=utf-8',
  '.zip': 'application/zip',
  '.wav': 'audio/wav',
  '.mp3': 'audio/mpeg',
};

const COLOR = { red: '\x1b[31m', green: '\x1b[32m', cyan: '\x1b[36m', yellow: '\x1b[33m', reset: '\x1b[0m' };
const log = {
  info: (msg) => console.log(`${COLOR.cyan}➤${COLOR.reset} ${msg}`),
  ok: (msg) => console.log(`${COLOR.green}✓${COLOR.reset} ${msg}`),
  warn: (msg) => console.log(`${COLOR.yellow}!${COLOR.reset} ${msg}`),
  err: (msg) => console.log(`${COLOR.red}✗${COLOR.reset} ${msg}`),
};

function parseArgs(argv) {
  const opts = {
    port: parseInt(process.env.PORT, 10) || 8000,
    natlang: process.env.NATLANG || 'en-us',
    build: true,
    open: true,
    watch: true,
  };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--port') opts.port = parseInt(argv[++i], 10);
    else if (a === '--nomake') opts.build = false;
    else if (a === '--no-open') opts.open = false;
    else if (a === '--no-watch') opts.watch = false;
    else if (a === '--help' || a === '-h') {
      console.log(`Usage: author [--port N] [--nomake] [--no-open] [--no-watch]

  --port N     serve on port N (default 8000, or $PORT)
  --nomake     skip the initial build; serve whatever's already in distribution/
  --no-open    don't open a browser window on startup
  --no-watch   don't watch the repo or hot-rebuild on changes

  NATLANG env var selects the language tree to serve (default en-us).`);
      process.exit(0);
    } else {
      console.error(`Unknown argument: ${a}`);
      process.exit(1);
    }
  }
  return opts;
}

// ---------------------------------------------------------------------------
// Build pipeline: `make` (pages + self-guided scaffolding) then build-mdquiz
// (quizzes). Overlapping triggers are coalesced: if changes arrive while a
// build is running, exactly one more build runs after it finishes.
// ---------------------------------------------------------------------------

function runBuild(natlang) {
  return new Promise((resolve) => {
    const env = { ...process.env, NATLANG: natlang };
    const make = spawn('make', [], { cwd: TOPDIR, env, stdio: 'inherit' });
    make.on('error', (e) => { log.err(`Could not run make: ${e.message}`); resolve(false); });
    make.on('exit', (code) => {
      if (code !== 0) return resolve(false);
      const quiz = spawn('./build-mdquiz', ['--skip-make'], { cwd: TOPDIR, env, stdio: 'inherit' });
      quiz.on('error', (e) => { log.err(`Could not run build-mdquiz: ${e.message}`); resolve(false); });
      quiz.on('exit', (qcode) => resolve(qcode === 0));
    });
  });
}

// make itself touches things inside the directories we watch on every run
// (dir-hoist-timestamp.sh bumps every lessons//pathways/ lesson directory's
// mtime -- filtered out in startWatcher below since those are addDir/unlinkDir
// events -- and the `phases` target unconditionally touches
// pathways/__sample/langs/en-us/lesson-order.txt). Left unchecked, either one
// re-triggers the watcher once the build that touched it finishes, forever,
// with no real edits involved. The lesson-order.txt touch is ignored by path
// in startWatcher; this cooldown is a general backstop for that plus any
// other such self-touch: events arriving within COOLDOWN_MS of a build
// finishing are assumed to be an echo of that build and are dropped rather
// than queued.
const COOLDOWN_MS = 2000;

function makeBuildQueue(natlang, { onStart, onSuccess, onFailure }) {
  let building = false;
  let timer = null;
  let cooldownUntil = 0;
  let currentBuildPaths = new Set(); // paths folded into the in-flight build
  let pendingPaths = new Set();      // paths seen since, not yet folded into a build

  async function runNow() {
    building = true;
    currentBuildPaths = pendingPaths;
    pendingPaths = new Set();
    log.info(`Rebuilding (${new Date().toLocaleTimeString()})…`);
    onStart();
    const ok = await runBuild(natlang);
    building = false;
    cooldownUntil = Date.now() + COOLDOWN_MS;
    currentBuildPaths = new Set();
    if (ok) {
      log.ok('Rebuild complete -- reloading browser');
      onSuccess();
    } else {
      log.err('Rebuild failed -- see errors above; not reloading');
      onFailure();
    }
    if (pendingPaths.size > 0) runNow();
  }

  return {
    // changedPath lets a change to a file already folded into the in-flight
    // build be recognized as an echo of that same save rather than a new
    // edit worth a follow-up rebuild -- Sublime (confirmed) writes a saved
    // file's content more than once per save, and without this, the second
    // write alone was enough to queue an entirely redundant second rebuild
    // every time.
    schedule(changedPath) {
      if (building) {
        if (currentBuildPaths.has(changedPath)) return;
        pendingPaths.add(changedPath); // picked up by runNow's trailing check once this build finishes
        return;
      }
      if (Date.now() < cooldownUntil) return; // self-touch echo of the build that just finished (see COOLDOWN_MS)
      pendingPaths.add(changedPath);
      clearTimeout(timer);
      timer = setTimeout(() => { if (!building) runNow(); }, 500);
    },
    runNow,
  };
}

// ---------------------------------------------------------------------------
// Live reload + build-status HUD, both over one trivial SSE channel. The
// injected client script reconnects on its own (that's just how EventSource
// behaves), so a server restart is enough to pick back up once it's back.
// ---------------------------------------------------------------------------

const reloadClients = new Set();

function handleReloadSSE(req, res) {
  res.writeHead(200, {
    'Content-Type': 'text/event-stream',
    'Cache-Control': 'no-store',
    Connection: 'keep-alive',
  });
  res.write('\n');
  reloadClients.add(res);
  req.on('close', () => reloadClients.delete(res));
}

function broadcastEvent(name) {
  for (const res of reloadClients) res.write(`event: ${name}\ndata: {}\n\n`);
}

const RELOAD_SNIPPET = `
<script>
(function () {
  var hud = document.createElement('div');
  hud.style.cssText = 'position:fixed;bottom:14px;right:14px;z-index:2147483647;' +
    'font:13px/1.4 -apple-system,BlinkMacSystemFont,sans-serif;padding:7px 14px;' +
    'border-radius:6px;color:#fff;box-shadow:0 2px 10px rgba(0,0,0,.25);display:none;';
  document.addEventListener('DOMContentLoaded', function () { document.body.appendChild(hud); });

  function show(text, color) {
    hud.textContent = text;
    hud.style.background = color;
    hud.style.display = 'block';
  }

  var timer = null;
  function stopTimer() { clearInterval(timer); timer = null; }

  var es = new EventSource(${JSON.stringify(RELOAD_PATH)});
  es.addEventListener('building', function () {
    stopTimer();
    var startedAt = Date.now();
    show('⟳ Rebuilding… 0s', '#2563eb');
    timer = setInterval(function () {
      show('⟳ Rebuilding… ' + Math.round((Date.now() - startedAt) / 1000) + 's', '#2563eb');
    }, 1000);
  });
  es.addEventListener('build-failed', function () { stopTimer(); show('✗ Build failed -- see terminal', '#dc2626'); });
  es.addEventListener('reload', function () { stopTimer(); location.reload(); });
})();
</script>`;

function injectReloadSnippet(html) {
  if (html.includes('</body>')) return html.replace('</body>', `${RELOAD_SNIPPET}\n</body>`);
  return html + RELOAD_SNIPPET;
}

// ---------------------------------------------------------------------------
// Self-guided lessons: mount a vite dev server (middleware mode) per lesson,
// lazily, the first time it's requested. Lessons whose self-guided/ has
// already been through a (production) vite build -- no vite.config.js left,
// just static dist output -- fall through to the plain static file server.
// ---------------------------------------------------------------------------

function makeSelfGuidedMounter(httpServer, webRoot) {
  const servers = new Map(); // absolute self-guided dir -> ViteDevServer | null

  return async function mount(req, res, next) {
    const url = new URL(req.url, 'http://localhost');

    // Two URL shapes can reach a lesson's self-guided app: the public one
    // (matching where lesson pages actually link to it) and an internal
    // one used only for vite's own injected asset/HMR URLs. They're kept
    // different on purpose -- a vite `base` that happens to exactly match
    // its dev server's own root path (root is .../lessons/<lsn>/self-guided,
    // and the "natural" base /lessons/<lsn>/self-guided/ reproduces that
    // same path exactly) breaks .jsx module transforms: requests for
    // main.jsx/SelfGuided.jsx come back as inert application/octet-stream
    // instead of transformed JS. Confirmed by bisecting against several
    // base strings of the same shape that *don't* coincide with root's own
    // path (all fine) -- root cause not fully pinned down beyond that, but
    // giving vite a synthetic base that can't coincide with any real
    // filesystem path sidesteps it entirely.
    const publicMatch = url.pathname.match(/^\/lessons\/([^/]+)\/self-guided(\/.*)?$/);
    const internalMatch = url.pathname.match(/^\/__self_guided__\/([^/]+)(\/.*)?$/);
    let lsn;
    if (publicMatch) {
      lsn = publicMatch[1];
      req.url = `/__self_guided__/${lsn}${publicMatch[2] || ''}${url.search}`;
    } else if (internalMatch) {
      lsn = internalMatch[1];
    } else {
      return next();
    }

    const dir = path.join(webRoot, 'lessons', lsn, 'self-guided');
    const configFile = path.join(dir, 'vite.config.js');
    if (!fs.existsSync(configFile)) return next(); // already built to static dist -- serve normally

    if (!servers.has(dir)) {
      const base = `/__self_guided__/${lsn}/`;
      log.info(`Starting self-guided dev server for ${lsn}`);
      try {
        // Deliberately not loading the lesson's own vite.config.js: its
        // serveFromEnUs plugin reaches outside the vite root for sibling
        // en-us/ assets (pages/, lib/, ...) by hand-checking `req.url`
        // against the filesystem, using its own tiny extension->mimetype
        // map (no .jsx entry). That's needed when the dev server runs
        // standalone (try-self-guided) with base '/', but here it's
        // mounted at a base that mirrors this lesson's real position in
        // the tree, so `req.url` (which includes the base) *also* happens
        // to resolve under en-us/ -- and the plugin ends up shadowing
        // vite's own module transform for main.jsx/SelfGuided.jsx,
        // serving them as inert application/octet-stream instead of
        // transformed JS. Our own static handler already serves the
        // whole en-us/ tree, so that plugin is redundant here anyway --
        // build the vite config inline instead of via configFile, minus
        // that plugin, and let requests it would have handled just fall
        // through to `next()` (our static handler) as normal.
        const { createServer } = await import('vite');
        const { default: react } = await import('@vitejs/plugin-react');
        const vite = await createServer({
          root: dir,
          base,
          configFile: false, // else vite auto-discovers dir/vite.config.js anyway
                              // (configFile only overrides *which* file, it doesn't
                              // disable the search) and merges its plugins with
                              // ours below, double-registering @vitejs/plugin-react's
                              // transform and duplicating its injected HTML preamble.
          plugins: [react()],
          logLevel: 'warn',
          server: {
            middlewareMode: { server: httpServer },
            open: false,
            fs: { allow: [webRoot] },
          },
        });
        servers.set(dir, vite);
      } catch (e) {
        log.err(`Self-guided dev server failed to start for ${lsn}: ${e.message}`);
        servers.set(dir, null);
      }
    }

    const vite = servers.get(dir);
    if (!vite) { res.writeHead(500); res.end(`Self-guided dev server for ${lsn} failed to start -- see terminal.`); return; }
    vite.middlewares(req, res, next);
  };
}

// ---------------------------------------------------------------------------
// Plain static file serving, with directory listings, live-reload injection
// for HTML, and basic Range support (mainly for PDFs/video).
// ---------------------------------------------------------------------------

function safeResolve(webRoot, pathname) {
  const normalized = path.posix.normalize(pathname);
  if (normalized.split('/').includes('..')) return null;
  return path.join(webRoot, normalized);
}

async function sendDirectoryListing(res, fsPath, pathname) {
  let entries;
  try {
    entries = await fsp.readdir(fsPath, { withFileTypes: true });
  } catch {
    return send404(res, pathname);
  }
  entries = entries.filter((e) => !e.name.startsWith('.'));
  entries.sort((a, b) => (a.isDirectory() === b.isDirectory() ? a.name.localeCompare(b.name) : a.isDirectory() ? -1 : 1));

  const rows = entries.map((e) => {
    const name = e.name + (e.isDirectory() ? '/' : '');
    return `<li><a href="${encodeURIComponent(e.name)}${e.isDirectory() ? '/' : ''}">${name}</a></li>`;
  }).join('\n');
  const parentLink = pathname !== '/' ? `<li><a href="../">../</a></li>` : '';

  const html = injectReloadSnippet(`<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Index of ${pathname}</title>
<style>body{font:14px/1.5 -apple-system,sans-serif;margin:2em}li{list-style:none}a{text-decoration:none}a:hover{text-decoration:underline}</style>
</head><body>
<h1>Index of ${pathname}</h1>
<ul>${parentLink}${rows}</ul>
</body></html>`);
  res.writeHead(200, { 'Content-Type': MIME['.html'], 'Cache-Control': 'no-store' });
  res.end(html);
}

function send404(res, pathname) {
  res.writeHead(404, { 'Content-Type': MIME['.html'], 'Cache-Control': 'no-store' });
  res.end(`<h1>404 Not Found</h1><p>${pathname}</p>`);
}

async function sendFile(req, res, fsPath, stat) {
  const ext = path.extname(fsPath).toLowerCase();
  const contentType = MIME[ext] || 'application/octet-stream';

  if (ext === '.html' || ext === '.shtml') {
    const raw = await fsp.readFile(fsPath, 'utf8');
    const html = injectReloadSnippet(raw);
    res.writeHead(200, { 'Content-Type': contentType, 'Cache-Control': 'no-store' });
    res.end(html);
    return;
  }

  const range = req.headers.range;
  if (range) {
    const match = /^bytes=(\d*)-(\d*)$/.exec(range);
    if (match) {
      const start = match[1] ? parseInt(match[1], 10) : 0;
      const end = match[2] ? parseInt(match[2], 10) : stat.size - 1;
      if (start <= end && end < stat.size) {
        res.writeHead(206, {
          'Content-Type': contentType,
          'Content-Length': end - start + 1,
          'Content-Range': `bytes ${start}-${end}/${stat.size}`,
          'Accept-Ranges': 'bytes',
          'Cache-Control': 'no-store',
        });
        fs.createReadStream(fsPath, { start, end }).pipe(res);
        return;
      }
    }
  }

  res.writeHead(200, { 'Content-Type': contentType, 'Content-Length': stat.size, 'Accept-Ranges': 'bytes', 'Cache-Control': 'no-store' });
  fs.createReadStream(fsPath).pipe(res);
}

function makeStaticHandler(webRoot) {
  return async function serveStatic(req, res, pathname) {
    const fsPath = safeResolve(webRoot, pathname);
    if (!fsPath) { res.writeHead(400); res.end('Bad request'); return; }

    let stat;
    try {
      stat = await fsp.stat(fsPath);
    } catch {
      return send404(res, pathname);
    }

    if (stat.isDirectory()) {
      for (const indexName of ['index.html', 'index.shtml']) {
        const indexPath = path.join(fsPath, indexName);
        if (fs.existsSync(indexPath)) {
          return sendFile(req, res, indexPath, await fsp.stat(indexPath));
        }
      }
      return sendDirectoryListing(res, fsPath, pathname.endsWith('/') ? pathname : pathname + '/');
    }

    return sendFile(req, res, fsPath, stat);
  };
}

// ---------------------------------------------------------------------------
// File watcher: any change under the source directories triggers a rebuild.
// distribution/ itself is never watched, so the rebuild can't retrigger itself.
// ---------------------------------------------------------------------------

function startWatcher(buildQueue) {
  const watchDirs = ['lessons', 'pathways', 'shared', 'lib'].map((d) => path.join(TOPDIR, d));
  const watcher = chokidar.watch(watchDirs, {
    ignored: [
      path.join(TOPDIR, 'lib', 'maker') + path.sep + '**',
      /(^|[/\\])\../,
      // touched unconditionally by `make`'s own `phases` target every run
      path.join(TOPDIR, 'pathways', '__sample', 'langs', 'en-us', 'lesson-order.txt'),
    ],
    ignoreInitial: true,
    awaitWriteFinish: { stabilityThreshold: 300, pollInterval: 100 },
  });
  watcher.on('all', (event, changedPath) => {
    // Directory events only (addDir/unlinkDir) are excluded: `make` itself
    // touches every lessons//pathways/ lesson directory's mtime on *every*
    // run (lib/maker/dir-hoist-timestamp.sh -- that's how it decides what
    // needs rebuilding), which these directories being watched would
    // otherwise pick back up as "changed" and rebuild again, forever, even
    // with no real edits. Only real file changes should trigger a rebuild.
    if (event === 'addDir' || event === 'unlinkDir') return;
    console.log(`  ${event}: ${path.relative(TOPDIR, changedPath)}`);
    buildQueue.schedule(changedPath);
  });
  watcher.on('error', (e) => log.err(`Watcher error: ${e.message}`));
  return watcher;
}

function openBrowser(url) {
  const platform = process.platform;
  const cmd = platform === 'darwin' ? 'open' : platform === 'win32' ? 'cmd' : 'xdg-open';
  const args = platform === 'win32' ? ['/c', 'start', '""', url] : [url];
  try {
    spawn(cmd, args, { stdio: 'ignore', detached: true }).unref();
  } catch (e) {
    log.warn(`Could not auto-open browser: ${e.message}`);
  }
}

// ---------------------------------------------------------------------------

async function main() {
  const opts = parseArgs(process.argv.slice(2));
  const webRoot = path.join(TOPDIR, 'distribution', opts.natlang);
  const devHostnamePromise = detectDevHostname(); // kicked off early, awaited near the end

  if (opts.build) {
    log.info('Building distribution/ before starting the server…');
    const ok = await runBuild(opts.natlang);
    if (!ok) {
      log.err('Initial build failed -- fix the error above and try again (or pass --nomake to serve what exists).');
      process.exit(1);
    }
  } else if (!fs.existsSync(webRoot)) {
    log.err(`${path.relative(TOPDIR, webRoot)} does not exist -- drop --nomake, or run make first.`);
    process.exit(1);
  }

  const devHostname = await devHostnamePromise;
  // HTTPS is only worth pursuing when the dev hostname is actually in play --
  // it exists solely so bootstrapworld.org's login cookie (SameSite=Lax) gets
  // attached to cross-site fetches, which "schemeful same-site" means only
  // happens scheme-for-scheme (https page -> https target). Plain 127.0.0.1
  // browsing keeps working exactly as before, over plain HTTP.
  const devCert = devHostname ? await ensureDevCert(devHostname) : null;
  const scheme = devCert ? 'https' : 'http';

  const serveStatic = makeStaticHandler(webRoot);
  const httpServer = devCert ? https.createServer(devCert) : http.createServer();
  const mountSelfGuided = makeSelfGuidedMounter(httpServer, webRoot);

  httpServer.on('request', async (req, res) => {
    const url = new URL(req.url, 'http://localhost');
    if (url.pathname === RELOAD_PATH) return handleReloadSSE(req, res);
    await mountSelfGuided(req, res, () => serveStatic(req, res, decodeURIComponent(url.pathname)));
  });

  const buildQueue = makeBuildQueue(opts.natlang, {
    onStart: () => broadcastEvent('building'),
    onSuccess: () => broadcastEvent('reload'),
    onFailure: () => broadcastEvent('build-failed'),
  });
  const watcher = opts.watch ? startWatcher(buildQueue) : null;

  const displayHost = devHostname || '127.0.0.1';

  httpServer.listen(opts.port, '127.0.0.1', () => {
    const url = `${scheme}://${displayHost}:${opts.port}/`;
    log.ok(`Serving ${path.relative(TOPDIR, webRoot)}/ at ${url}`);
    if (opts.watch) log.info('Watching lessons/, pathways/, shared/, lib/ for changes…');
    if (devCert) {
      log.info(`Using ${devHostname} over HTTPS so bootstrapworld.org recognizes this origin and sends its login cookie -- teacher-hash and quiz-link fetches should work.`);
    } else if (devHostname) {
      log.warn(`${devHostname} is set up, but mkcert isn't (or its CA isn't trusted yet) -- serving HTTP, so the WordPress login cookie won't be sent. See README-author.adoc.`);
    } else {
      log.warn('Teacher-hash / quiz-link fetches to bootstrapworld.org will fail (CORS) -- see README-author.adoc to enable them.');
    }
    if (opts.open) openBrowser(url);
  });

  let shuttingDown = false;
  async function shutdown() {
    if (shuttingDown) return;
    shuttingDown = true;
    console.log('\nShutting down…');
    if (watcher) await watcher.close();
    httpServer.close(() => process.exit(0));
    setTimeout(() => process.exit(0), 2000).unref();
  }
  process.on('SIGINT', shutdown);
  process.on('SIGTERM', shutdown);
}

main();
