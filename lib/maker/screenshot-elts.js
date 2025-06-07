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

// Define the path for the cache file, and wipe it clean
const cachePath = path.join(__dirname, 'cache.json');
if (fs.existsSync(cachePath)) {
	fs.unlinkSync(cachePath);
}

// All of our screenshot configurations
const configs = [
	{selector: '.circleevalsexp>.expression',    prefix: 'AUTOGEN-COE'},
	{selector: '.image-figure',                  prefix: 'AUTOGEN-IMAGE'},
	//{selector: '.image-figure:has(.image-caption:not(:empty)', prefix: 'AUTOGEN-IMAGE'},
	{selector: '.sect1 :not(td>.content)>table', prefix: 'AUTOGEN-TABLE'},
]

async function processLessons(tabsPerCore=1) {
	console.log(`Generating screenshots for slides using ${tabsPerCore} tabs per core.`)

	const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_CONTEXT,
    maxConcurrency: numCores * tabsPerCore,
    headless: 'new',
    monitor: true,
    puppeteerOptions: {
      headless: "new",
      userDataDir: TOPDIR + '/distribution/.cached',
      args: chromeArgs,
    }
  });

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
		 * if needed, create a cache file
		 * intercept every request...
		 * 		blocking ones we wish to ignore 
		 * 		and retrieving the rest from cache, if possible
		 * for those that succeed, add to cache
		*/		
    let cache = {};
    if (fs.existsSync(cachePath)) {
      // Read cache data from the file
      const cacheData = fs.readFileSync(cachePath, 'utf-8');
      cache = JSON.parse(cacheData);
    }
    await page.setRequestInterception(true);
    page.on('request', request => {
    	const url = request.url();
      if (blocked_domains.some(domain => url.includes(domain))) {
        request.abort();
      } else if (cache[url]) {
      	// Serve request from the cache if available
        request.respond(cache[url]);
      } else {
      	// Continue with the original request
        request.continue();
        //if(!url.includes('file://')) console.log('Retrieving', request.resourceType(), 'from the web');
        
      }
    });
    page.on('response', async (response) => {
      const url = response.url();
      // don't cache images or HTML
      if(['document', 'image'].includes(response.request().resourceType())){ return; } 
      //console.log('updating cache with response from', url);
      if (!cache[url] && response.ok()) {
      	//console.log('caching', response.request().resourceType())
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

    // load the page
    // make sure viewport is big enough, and set deviceScaleFactor for hi-res images
    // set print media type (typically makes screenshots easier)
	  await page.goto(`file://${url}`, {
	    waitUntil: ['domcontentloaded', 'networkidle0'],
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
