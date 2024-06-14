puppeteer = require("puppeteer")
const { Cluster } = require("puppeteer-cluster");
const ProgressBar = require('progress');
let numCores = parseInt(process.env.NUMCORES) || 1; // minimum 1 core

// set env variables
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
	const bar = new ProgressBar('Processing lessons at :rate pages/sec: :percent complete. :elapseds elapsed, :etas remaining', { 
		complete: '=',
		incomplete: ' ',
		width: 20,
		total: lessons.length 
	});

	const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // maximize sharing data between jobs
    maxConcurrency: numCores * tabsPerCore,
    headless: 'new',
    puppeteerOptions: {
      headless: "new",
      userDataDir: './distribution/.cached',
      args: chromeArgs,
    }
  });

  // Event handler to be called in case of problems
  cluster.on('taskerror', (err, data) => {
     console.log(`Error when processing ${data}: ${err.message}`);
  });

  // task : BrowserTab -> Void
  // screenshots all *visible* images matching our selectors,
	// and saves them as PNGs in that lessons' images folder
  await cluster.task(async ({ page, data: url }) => {
    // block tracking requests
    await page.setRequestInterception(true);
    page.on('request', request => {
      const url = request.url()
      if (blocked_domains.some(domain => url.includes(domain))) {
        request.abort();
      } else {
        request.continue();
      }
    });

    // load the page
    await page.goto(url, {
      waitUntil: ['domcontentloaded', 'networkidle0'],
      preferCSSPageSize: true,
      printBackground: true,
    });

    // wait for mathjax to finish running and fonts to be ready
    await page.waitForFunction('window.status !== "not_ready_to_print"');
    await page.evaluateHandle('document.fonts.ready');

    /* CUSTOM STYLES:
        - printed pages are narrower than web pages, so manually expand the width 
        - make hidden things visible, so we can screenshot them
        - anything we're not screen-shooting should have a transparent BG
    */
    const combinedSelectors = configs.map(({selector, _}) => selector).join(',');
    await page.addStyleTag({content: `
	      @media print { 
	          body { width: 865px !important; } 
	          .hiddenblock { display: unset !important; }
	          :not(${combinedSelectors}) { 
	              background-color: transparent !important;
	          }
	      }
	  `});
	  await Promise.all(configs.map(async ({selector, prefix}) => {
		  // get all the elts matching the selector, then take a screenshot 
		  // for each one and save it to /images/ using the prefix
		  const outputPrefix = url.split('/').slice(2, -1).join('/') + '/images/';
		  const eltPromises = await page.$$(selector);
		  await Promise.all(eltPromises.map(async (elt, i) => {
		      // skip if the element is not visible (has no bounding box)
		      if(!await elt.boundingBox()) return;
		      // add 1 to 0, to preserve luae-sque semantics ;)
		      return elt.screenshot({
		          path: outputPrefix + prefix + (i+1) + '.png',
		          omitBackground: true,
		      });
		  }));
		}));
    bar.tick();
  });

  // Queue up all the page options to be completed
  lessons.forEach((p) => {
  	const path = `file://${TOPDIR}/distribution/${NATLANG}/lessons/${p}/index.shtml`;
  	cluster.queue(path)
  });

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

processLessons()
