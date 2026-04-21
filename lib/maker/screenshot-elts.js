puppeteer = require("puppeteer")
const { Cluster } = require("puppeteer-cluster");
const ProgressBar = require('progress');
const fs = require('fs');
const path = require('path');

// set env variables
let numCores = parseInt(process.env.NUMCORES) || 1; // minimum 1 core
const { TOPDIR, NATLANG, LESSON } = process.env;

// load the graph, and use either *every* lesson or the one from the env
const { configureGraph } = require(TOPDIR + "/lib/bootstraplesson.js");
let graph = require(TOPDIR + "/distribution/"+NATLANG+"/lib/dependency-graph.js");
configureGraph(graph);
// remove artificial graph entries for pseudo-projects
Object.keys(graph).forEach(k => {
	if(graph[k].title.startsWith("Project: ")) delete graph[k]; 
});
const lessons =  LESSON? [LESSON] : Object.keys(graph);
//lessons = ['absolute-value-and-opposites','absolute-value-and-opposites-wescheme', 'absolute-value-and-opposites-2','additive-inverse','associative-property','absolute-value-and-opposites-2-wescheme'];

// set up arguments to puppeteer-cluster and puppeteer
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
	'--disable-features=site-per-process',
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
	'--use-gl=swiftshader',
	'--use-mock-keychain',

	// these two args (hopefully) speed up puppeteer when running through
	// a proxy server (e.g. working at a starbucks)
	// see https://github.com/puppeteer/puppeteer/issues/1718
	"--proxy-server='direct://'",
	"--proxy-bypass-list=*",

	// force font width to be something reasonable
	"--font-render-hinting=medium",
];
// 3rd party domains to block (currently unused)
const blocked_domains = [
  'googlesyndication.com',
  'adservice.google.com',
  'apis.google.com',
  'drive.google.com',
  'accounts.google.com',
  'ssl.gstatic.com',
  'www.googletagmanager.com',
  'unpkg.com',
  'googleads.g.doubleclick.net',
  'www.googletagmanager.com',
  'google.internal',
  'play.google.com',
  'youtube.com',
  's3.amazonaws.com',
  'cdn-images.mailchimp.com',
];

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
  'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-chtml-full-speech.min.js',
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
  // wordpress-specific stuff
  'https://beta.bootstrapworld.org/wp-content/uploads/2024/07/right-blue-arrow.png',
  'https://beta.bootstrapworld.org/wp-content/uploads/2024/07/arrow-white-right-1.webp',
];

// All of our screenshot configurations
const configs = [
	{selector: '.circleevalsexp>.expression',    prefix: 'AUTOGEN-COE'},
	{selector: '.image-figure',                  prefix: 'AUTOGEN-IMAGE'},
	//{selector: '.image-figure:has(.image-caption:not(:empty)', prefix: 'AUTOGEN-IMAGE'},
	{selector: '.sect1 :not(td>.content)>table', prefix: 'AUTOGEN-TABLE'},
]

async function processLessons(tabsPerCore=1) {
	console.log(`Generating screenshots for slides using ${tabsPerCore} tabs per core.`)

	const ms = 1000;
	const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE,
    maxConcurrency: numCores * tabsPerCore,
    headless: 'new',
    monitor: true,
    timeout: 90*ms,
    retryLimit: 5,
    puppeteerOptions: {
      headless: "new",
      userDataDir: TOPDIR + '/distribution/.cached',
      args: chromeArgs,
	    timeout: 90*ms,
    }
  });

	// define a global cache
  let CACHE = {};
  async function addUrlToCache(url) {
    const response = await fetch(url);
    const arrayBuffer = await response.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);
    CACHE[url] = {
      status: response.status,
      headers: response.headers,
      body: buffer,
    };
  }

  // go through all the things to cache, and add them
  await Promise.all(thingsToCache.map(addUrlToCache))
  console.log(`Added ${Object.keys(CACHE).length} files to cache`);

  // Event handler to be called in case of problems
  cluster.on('taskerror', (err, data) => {
     console.log(`Error when processing ${JSON.stringify(data)}: ${err}`);
  });

  // task : BrowserTab -> Void
  // screenshots all *visible* images matching our selectors,
	// and saves them as PNGs in that lessons' images folder
  await cluster.task(async ({ page, data:url }) => {

		/***********************************************
		 * REQUEST OPTIMIZATION
		 * intercept every request...
		 * 		blocking ones we wish to ignore
		 * 		and retrieving the rest from cache, if possible
		 * for those that succeed, add to cache
		*/

    await page.setRequestInterception(true);
    page.on('request', async request => {
      const url = request.url().trim();
      if (blocked_domains.some(domain => url.includes(domain))) {
        return request.abort();
      }
      if (CACHE[url]) { await request.respond(CACHE[url]); }
      else            { return request.continue(); }
    });

    // load the page
    // make sure viewport is big enough, and set deviceScaleFactor for hi-res images
    // set print media type (typically makes screenshots easier)
	  await page.goto(`file://${url}`, {
	    waitUntil: ['domcontentloaded'],
	    preferCSSPageSize: true,
	    printBackground: true,
	  });
	  await page.setViewport({ width: 1920, height: 100000, deviceScaleFactor: 2 });
	  await page.emulateMediaType('print');

	  // wait for mathjax to finish running and fonts to be ready
	  await page.waitForFunction('window.status !== "not_ready_to_print"');
	  await page.evaluateHandle('document.fonts.ready');

	  /* CUSTOM STYLES:
	      - printed pages are narrower than web pages, so manually expand the width 
	      - make hidden things visible, so we can screenshot them
	  */
	  await page.addStyleTag({content: `
	      @media print { 
          body { width: 670px !important; }
          body::after { content: unset !important; }
          .hiddenblock { display: unset !important; }
	      }
	  `});

	  for({selector, prefix} of configs) {  
	  	// ADD rule for this selector: everything else should have a transparentBG
		  const styleHandle = await page.addStyleTag({content: `
        :not(${selector}) { background-color: transparent !important; }
		  `});

		  // get all the elts matching the selector, then take a screenshot 
		  // of each one and save it to the lesson's /images/ folder
		  const outputPrefix = url.split('/').slice(0, -1).join('/') + '/images/';
		  const eltPromises = await page.$$(selector);
		  await Promise.all(eltPromises.map(async (elt, i) => {
		      // skip if the element is not visible (has no bounding box)
		      if(!await elt.boundingBox()) return;
		      // add 1 to 0, to preserve luaesque semantics ;)
		      await elt.screenshot({
		          path: outputPrefix + prefix + (i+1) + '.png',
		          omitBackground: true,
		      });
		  }));
		  // REMOVE rule for this selector
		  const elt = await page.evaluate(el => el.remove(), styleHandle);
	  };
	});

  // Enqueue a job for each config, on each page
  lessons.forEach((p) => {
  	const path = `${TOPDIR}/distribution/${NATLANG}/lessons/${p}/index.shtml`;
  	cluster.queue(path);
  });

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

processLessons()
