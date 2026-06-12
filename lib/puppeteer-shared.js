const { Cluster } = require("puppeteer-cluster");
const ProgressBar = require('progress');

const os = require('os');

const sec = 1000;
const numCores = (navigator?.hardwareConcurrency || os.cpus().length);

// Timeout Tuning
// Per-page work is split into three phases, each with its own short timeout so a hang
// in any one of them fails fast and gets retried, rather than wedging until a long
// catch-all timer fires:
// These catch GENUINELY stuck pages (infinite loop, frozen Chrome), not normal-but-slow
// work. Under full-cluster contention (16 tabs saturating ~8 physical cores) a few pages
// in the saturated tail get starved badly enough to blow any reasonable timeout -- even
// though they load in ~0.2s in isolation. We DON'T fight that with ever-bigger timeouts
// (that just drags the tail); instead these stay moderate so the bulk run fails fast, and
// html2pdf.js mops up the deferred stragglers in a sequential post-drain pass where, with
// no contention, they convert reliably. So tune these for "fast-fail under load," not
// "never false-positive" -- the post-drain pass is the correctness net.
// pageTimeout -- default per-op timeout, and the budget for page.pdf() generation
// navigationTimeout -- page.goto() to DOM-ready
// readinessTimeout -- wait for window.status to clear "not_ready_to_print" (set by MathJax
//                     pages until rendering completes); a stuck page is retried, not printed
// pagesPerChunk -- pages assigned to a single cluster task (one browser tab). Kept well below
//                  totalPages/numCores so there are many more chunks than cores: this lets the
//                  cluster load-balance dynamically and keeps a wedged chunk's blast radius small
// chunkTimeout -- backstop for a wedged chunk (e.g. Chrome itself frozen). Sized to fit the worst
//                 case where every page exhausts its retries, so it never fires on healthy work
// retryLimit -- chunk-level retries. 0: we retry per-page instead (see pageRetryLimit), and a
//               failed page is recovered by re-running `make book`, which skips finished PDFs
// retryDelay -- time between chunk-level retries (unused while retryLimit is 0)
// pageRetryLimit -- per-page retries within the chunk before the page is reported as failed
// pageRetryDelay -- time to wait between per-page retries
// protocolTimeout -- max a single CDP call may hang before we consider Chrome frozen and kill it
const pageTimeout       = 20 * sec;
const navigationTimeout = 15 * sec;
const readinessTimeout  = 15 * sec;
const pagesPerChunk     = 5;
const retryLimit        = 0;
const retryDelay        = 10 * sec;
const pageRetryLimit    = 2;
const pageRetryDelay    = 3 * sec;
const protocolTimeout   = 60 * sec; // 1m
// fits the worst case (every page in the chunk exhausting its retries) so the per-page
// failure reporting always gets to run instead of the chunk dying out from under it
const chunkTimeout      = (navigationTimeout + readinessTimeout + pageTimeout) * (pageRetryLimit + 1) * pagesPerChunk;

const chromeArgs = [
  '--autoplay-policy=user-gesture-required',
  '--disable-background-networking',
  '--disable-background-timer-throttling',
  '--disable-backgrounding-occluded-windows',
  '--disable-breakpad',
  '--disable-client-side-phishing-detection',
  '--disable-component-update',
  '--disable-default-apps',
  '--disable-dev-shm-usage',
  '--disable-domain-reliability',
  '--disable-extensions',
  '--disable-features=AudioServiceOutOfProcess',
  '--disable-hang-monitor',
  '--disable-ipc-flooding-protection',
  '--disable-notifications',
  '--disable-offer-store-unmasked-wallet-cards',
  '--disable-popup-blocking',
  '--disable-print-preview',
  '--disable-prompt-on-repost',
  '--disable-renderer-backgrounding',
  '--disable-setuid-sandbox',
  '--disable-speech-api',
  '--disable-sync',
  '--disable-web-security',
  '--hide-scrollbars',
  '--ignore-gpu-blacklist',
  '--metrics-recording-only',
  '--mute-audio',
  '--no-default-browser-check',
  '--no-first-run',
  '--no-pings',
  '--no-sandbox',
  '--no-zygote',
  '--password-store=basic',
  '--use-gl=angle',
  '--use-angle=swiftshader',
  '--use-mock-keychain',

  // these two args (hopefully) speed up puppeteer when running through
  // a proxy server (e.g. working at a starbucks)
  // see https://github.com/puppeteer/puppeteer/issues/1718
  "--proxy-server=direct://",
  "--proxy-bypass-list=*",

  // force font width to be something reasonable
  "--font-render-hinting=medium",
];

// 3rd party domains to block
const blocked_domains = [
  's3.amazonaws.com',
  'googlesyndication.com',
  'adservice.google.com',
  'apis.google.com',
  'drive.google.com',
  'accounts.google.com',
  'ssl.gstatic.com',
  'unpkg.com',
  'googleads.g.doubleclick.net',
  'www.googletagmanager.com',
  'google.internal',
  'play.google.com',
  'youtube.com',
  'cdn-images.mailchimp.com',
];
const blockedDomainsRegex = new RegExp(blocked_domains.map(d => d.replaceAll('.', '\\.')).join('|'));

// commonly-loaded files
const thingsToCache = [
  'https://www.bootstrapworld.org/styles.css',
  'https://www.bootstrapworld.org/fonts/hack/hack-italic.woff2',
  'https://www.bootstrapworld.org/fonts/hack/hack-regular.woff2',
  'https://www.bootstrapworld.org/fonts/hack/hack-bold.woff2',
  'https://www.bootstrapworld.org/fonts/hack/hack-bolditalic.woff2',
  'https://cdn.jsdelivr.net/npm/hack-font@3/build/web/hack.css',
  'https://www.bootstrapworld.org/fonts/hack/hack-regular.woff2?sha=3114f1256',
  'https://cdn.jsdelivr.net/npm/hack-font@3/build/web/fonts/hack-regular.woff2?sha=3114f1256',
  'https://cdn.jsdelivr.net/npm/hack-font@3/build/web/fonts/hack-italic.woff2?sha=3114f1256',
  'https://cdn.jsdelivr.net/npm/hack-font@3/build/web/fonts/hack-bold.woff2?sha=3114f1256',
  'https://cdn.jsdelivr.net/npm/hack-font@3/build/web/fonts/hack-bolditalic.woff2?sha=3114f1256',
  'https://www.bootstrapworld.org/fonts/lato/lato-v24-latin_latin-ext-regular.woff2',
  'https://www.bootstrapworld.org/fonts/lato/lato-v24-latin_latin-ext-italic.woff2',
  'https://www.bootstrapworld.org/fonts/lato/lato-v24-latin_latin-ext-700.woff2',
  'https://www.bootstrapworld.org/fonts/lato/lato-v24-latin_latin-ext-900.woff2',
  'https://www.bootstrapworld.org/fonts/lato/lato-v24-latin_latin-ext-900italic.woff2',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Main-Bold.woff',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Main-Regular.woff',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Zero.woff',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Math-Italic.woff',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Math-BoldItalic.woff',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Main-Italic.woff',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Size3-Regular.woff',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-chtml.js',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/a11y/assistive-mml.js',
  'https://fonts.gstatic.com/s/reeniebeanie/v20/z7NSdR76eDkaJKZJFkkjuvWxXPq1q6Gjb_0.woff2',
  'https://fonts.gstatic.com/s/reeniebeanie/v20/z7NSdR76eDkaJKZJFkkjuvWxbP0.ttf',
  'https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300..900;1,300..900&display=swap',
  'https://fonts.gstatic.com/s/rubik/v31/iJWbBXyIfDnIV7nEt3KSJbVDV49rz8tdE0Uw.ttf',
  'https://fonts.gstatic.com/s/rubik/v31/iJWbBXyIfDnIV7nEt3KSJbVDV49rz8u6FEUw.ttf',
  'https://fonts.gstatic.com/s/rubik/v31/iJWZBXyIfDnIV5PNhY1KTN7Z-Yh-4I-1UA.ttf',
  'https://fonts.gstatic.com/s/rubik/v31/iJWZBXyIfDnIV5PNhY1KTN7Z-Yh-B4i1UA.ttf',
  'https://fonts.gstatic.com/s/rubik/v31/iJWZBXyIfDnIV5PNhY1KTN7Z-Yh-ro-1UA.ttf',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Size1-Regular.woff',
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/output/chtml/fonts/woff-v2/MathJax_Size2-Regular.woff',
];


async function buildPreWarmedCache() {
  const CACHE = {};

  async function addUrlToCache(url) {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), pageTimeout);
    try {
      const response = await fetch(url, { signal: controller.signal });
      if (!response.ok) {
        throw new Error(`Failed to cache URL "${url}": HTTP ${response.status}`);
      }
      const arrayBuffer = await response.arrayBuffer();
      CACHE[url] = {
        status: response.status,
        headers: response.headers,
        body: Buffer.from(arrayBuffer),
      };
    } catch (err) {
      const reason = err.name === 'AbortError'
        ? `timed out after ${pageTimeout}ms`
        : err.message;
      throw new Error(`Failed to cache URL "${url}": ${reason}`);
    } finally {
      clearTimeout(timeoutId);
    }
  }

  await Promise.all(thingsToCache.map(addUrlToCache));
  console.log(`Added ${Object.keys(CACHE).length} (out of ${thingsToCache.length}) files to cache`);
  return CACHE;
}


async function launchCluster(
  concurrency,
  numWorkers=numCores,
  debug=!!process.env.DEBUG_MEMORY) {
  const cluster = await Cluster.launch({
    concurrency: concurrency,
    maxConcurrency: numWorkers,
    retryLimit: retryLimit,
    retryDelay: retryDelay,
    timeout: chunkTimeout,
    puppeteerOptions: {
      headless: true,
      protocolTimeout: protocolTimeout,
      userDataDir: (concurrency == Cluster.CONCURRENCY_PAGE)? './distribution/.cached' : null,
      args: chromeArgs,
    }
  });
  // Only fires for chunk-level failures (e.g. browser crash) that escape
  // the per-page try/catch in the task itself; list the chunk's files by
  // name instead of dumping the raw JSON, so it's clear this is a whole
  // *chunk* failing, not an individual page
  cluster.on('taskerror', (err, data) => {
    let files = data;
    try {
      files = JSON.parse(data).map(item => typeof item === 'string' ? item : item.input).join(', ');
    } catch (e) { /* not JSON, or not in the expected shape -- fall back to raw data */ }
    console.log(`\nChunk failed (${err.message}): ${files}`);
  });

  // for debugging memory leaks: print out the heap info every 15sec
  if (debug) {
    const memTimer = setInterval(() => {
      const { heapUsed, heapTotal, external, rss } = process.memoryUsage();
      const mb = n => Math.round(n / 1024 / 1024);
      console.log(`\nMemory: heap ${mb(heapUsed)}/${mb(heapTotal)}MB, external ${mb(external)}MB, rss ${mb(rss)}MB\n`);
    }, 15000);
    const originalClose = cluster.close.bind(cluster);
    cluster.close = () => { clearInterval(memTimer); originalClose(); }
  }

  return cluster;
}

function setupRequestInterception(page, CACHE) {
  page.on('request', async request => {
    const url = request.url().trim();

    if (blockedDomainsRegex.test(url)) return request.abort();

    // requests to fetch:
    // 1) Anything local (file:///)
    // 2) Data URLs whose MIME type is not text/javascript
    // 3) http/https URLs that don't load from bootstrapworld\.org\/wp-content
    const fileUrl = url.startsWith("file:///")
    const fetchableDataUrl = /^(?:data:(?!text\/javascript))/.test(url)
    const fetchableUrl = /^https?:\/\/(?!(?:[a-zA-Z0-9-]+\.)*bootstrapworld\.org\/wp-content\/)/.test(url);

    // retrieve from cache, continue with request, or abort
    const fetchable = fileUrl || fetchableDataUrl || fetchableUrl;
    if (CACHE[url])     { await request.respond(CACHE[url]); }
    else if (fetchable) { return request.continue();         }
    else                { return request.abort();            }
  });
}



// Queue up all the page options to be completed, as chunks
function splitToSizeChunks(array, size = pagesPerChunk) {
  return array.reduce((resultArray, item, index) => {
    const chunkIndex = Math.floor(index/size)
    if(!resultArray[chunkIndex]) {
      resultArray[chunkIndex] = [] // start a new chunk
    }
    resultArray[chunkIndex].push(item)
    return resultArray
  }, [])
}

// Make a progress bar, and return the object for bar.tick()
function makeProgressBar(total) {
  return new ProgressBar('[:bar] :rate pages/sec: :percent. :elapseds elapsed, :etas remaining', {
    complete: '=',
    incomplete: ' ',
    width: 30,
    total: total,
  });
}

// grab constants from the process
const { TOPDIR, NATLANG, LESSON } = process.env;


// exported constants and functions
module.exports = {
  sec, numCores, chromeArgs, blocked_domains, thingsToCache, pageTimeout,
  navigationTimeout, readinessTimeout, pageRetryLimit, pageRetryDelay,
  splitToSizeChunks, buildPreWarmedCache, setupRequestInterception,
  Cluster, launchCluster, makeProgressBar, TOPDIR, NATLANG, LESSON
};