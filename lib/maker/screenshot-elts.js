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
let graph = require(TOPDIR + "/distribution/"+NATLANG+"/dependency-graph.js");
configureGraph(graph);
// remove artificial graph entries for pseudo-projects
Object.keys(graph).forEach(k => {
	if(graph[k].title.startsWith("Project: ")) delete graph[k]; 
});
const lessons =  LESSON? [LESSON] : Object.keys(graph);

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
	// a proxy server (e.g. - working at a starbucks)
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
	'unpkg.com/',
];

// Define the path for the cache file
const cachePath = path.join(__dirname, 'cache.json');

// All of our screenshot configurations
const configs = [
	{selector: '.circleevalsexp>.expression',    prefix: 'AUTOGEN-COE'},
	{selector: '.image-figure',                  prefix: 'AUTOGEN-IMAGE'},
	//{selector: '.image-figure:has(.image-caption:not(:empty)', prefix: 'AUTOGEN-IMAGE'},
	{selector: '.sect1 :not(td>.content)>table', prefix: 'AUTOGEN-TABLE'},
]

async function processLessons(tabsPerCore=4) {
	console.log(`Generating screenshots for slides using ${tabsPerCore} tabs per core.`)

	const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // maximize sharing data between jobs
    maxConcurrency: numCores * tabsPerCore,
    headless: 'new',
    monitor: true,
    puppeteerOptions: {
      headless: "new",
      userDataDir: './distribution/.cached',
      args: chromeArgs,
    }
  });

  // Event handler to be called in case of problems
  cluster.on('taskerror', (err, data) => {
     console.log(`Error when processing ${JSON.stringify(data.url)}: ${err}`);
  });

  // task : BrowserTab -> Void
  // screenshots all *visible* images matching our selectors,
	// and saves them as PNGs in that lessons' images folder
  await cluster.task(async ({ page, data }) => {
		const {selector, prefix} = data.config;

		// Check if the cache file exists
    let cache = {};
    if (fs.existsSync(cachePath)) {
      // Read cache data from the file
      const cacheData = fs.readFileSync(cachePath, 'utf-8');
      cache = JSON.parse(cacheData);
    }

	  // block tracking requests and load from cache if possible
    await page.setRequestInterception(true);
    page.on('request', request => {
      const url = request.url()
      if (blocked_domains.some(domain => url.includes(domain))) {
        request.abort();
      } else if (cache[url]) {
      	// Serve request from the cache if available
        request.respond(cache[url]);
        //console.log('Retrieving', url, 'from the CACHE!');
      } else {
      	// Continue with the original request
        request.continue();
        //if(url.includes('file://')) console.log('Retrieving', url, 'from the web');
        
      }
    });

    // Intercept responses to update the cache
    page.on('response', async (response) => {
      const url = response.url();
      //console.log('updating cache with response from', url);
      if (!cache[url] && response.ok()) {
        // Cache the response
        cache[url] = {
          status: response.status(),
          contentType: response.headers()['content-type'],
          body: await response.text(),
        };

        // Update the cache file
        fs.writeFileSync(cachePath, JSON.stringify(cache));
      }
    });

	  // set up the browser and load the page
	  await page.goto(`file://${data.url}`, {
	    waitUntil: ['domcontentloaded', 'networkidle0'],
	    preferCSSPageSize: true,
	    printBackground: true,
	  });

	  // make sure viewport is big enough, and set deviceScaleFactor for hi-res images
	  await page.setViewport({ width: 1920, height: 100000, deviceScaleFactor: 2 });
	  // set print media type (typically makes screenshots easier)
	  await page.emulateMediaType('print');

	  /* CUSTOM STYLES:
	      - printed pages are narrower than web pages, so manually expand the width 
	      - make hidden things visible, so we can screenshot them
	      - anything we're not screenshotting should have a transparent BG
	  */
	  await page.addStyleTag({content: `
	      @media print { 
	          body { width: 865px !important; } 
	          .hiddenblock { display: unset !important; }
	          :not(${selector}) { 
	              background-color: transparent !important;
	          }
	      }
	  `});

	  // wait for mathjax to finish running
	  await page.waitForFunction('window.status !== "not_ready_to_print"');
	  // wait for fonts to be ready
	  await page.evaluateHandle('document.fonts.ready');

	  // get all the elts matching the selector, then take a screenshot 
	  // for each one and save it to /images/ using the prefix
	  const outputPrefix = data.url.split('/').slice(0, -1).join('/') + '/images/';
	  const eltPromises = await page.$$(selector);
	  await Promise.all(eltPromises.map(async (elt, i) => {
	      // skip if the element is not visible (has no bounding box)
	      if(!await elt.boundingBox()) return;
	      // add 1 to 0, to preserve luaesque semantics ;)
	      return elt.screenshot({
	          path: outputPrefix + prefix + (i+1) + '.png',
	          omitBackground: true,
	      });
	  }));
	});

  // Queue up all the page options to be completed
  lessons.forEach((p) => {
  	const path = `${TOPDIR}/distribution/${NATLANG}/lessons/${p}/index.shtml`;
  	configs.forEach(c => {
  		cluster.queue({url: path, config: c});
  	})
  });

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

processLessons()
