const topdir = process.env["TOPDIR"];
const course_filter = process.env["COURSE"] || false;
const semester = process.env['SEMESTER'];
const year = process.env['YEAR'];
const { Cluster } = require("puppeteer-cluster");
const { knownLongPages } = require(topdir + "/lib/bootstraplesson.js");
const { PDFDocument } = require("pdf-lib");
const ProgressBar = require('progress');

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

// args to run chrome in lightweight mode, 
// and be smart about proxies and font hinting
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
  'www.googletagmanager.com',
  'unpkg.com',
  'googleads.g.doubleclick.net',
  'www.googletagmanager.com',
  'google.internal',
  'play.google.com',
  'youtube.com',
];

// Simple cache object
const CACHE = {};
// If the URL contains one of these, cache the response for later
const CACHABLES = ['.css', '.woff', '.woff2', '.js', 'css2'];

// construct the array of pages from passed args
const { htmlFileSpecs } = require(process.argv[2]);
let tabsPerCore;
if((process.argv.length > 3) && (process.argv[3] == "--tabsPerCore")) {
  tabsPerCore = process.argv[4];
}

htmlFileSpecs.shift();

// constants that are used in the PDF conversion
const workingDir = process.cwd();
const pageOpts = { scale: 1.0 }; // match screen scale
const landscapePageCSS = "@page { size: letter landscape; }";
const portraitPageCSS  = "@page { size: letter portrait;  }";

let warnings = [];

// Set number of cores (min 1)
let numCores = parseInt(process.env.NUMCORES) || 1;

// Load the bytes in pdf-lib and get the page count
// Throw a warning if > 1,unless the file is whitelisted
async function checkOnePage(bytes, outputFile) {
  const doc   = await PDFDocument.load(bytes);
  const count = doc.getPageIndices().length;
  const fileName = outputFile.match(/[ \w-]+\.[\w]+/)[0];
  if(count > 1) {
    const shortPath = outputFile.split('/').slice(2).join('/');
    warnings.push(`${shortPath} has ${count} pages`);
  }
}

// because of page blocking/waiting, always use at least 2
async function HtmlToPdf(htmlFileSpecs, tabsPerCore=2) {
  console.log(`Converting to PDF using ${tabsPerCore} tabs per core.`)

  // if we have a course filter, only process files that:
  // 1) have no output source defined
  // 2) have an output, but it's not in the courses directory
  // 3) have an output in the courses directory, but it's *that* course
  if(course_filter) {
    console.log(`Limiting PDFs to: ${course_filter}`);
    htmlFileSpecs = htmlFileSpecs.filter(({input, output}) => !output
      || output.startsWith("distribution/en-us/courses/"+course_filter+"/") 
      || !output.startsWith("distribution/en-us/courses/"));
  }

  const bar = new ProgressBar('Making PDFs at :rate pages/sec: :percent complete. :elapseds elapsed, :etas remaining', { 
    complete: '=',
    incomplete: ' ',
    width: 20,
    total: htmlFileSpecs.length 
  });

  const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // maximize sharing data between jobs
    maxConcurrency: numCores * tabsPerCore,
    puppeteerOptions: {
      headless: 'new',
      userDataDir: './distribution/.cached',
      args: chromeArgs, 
    }
  });

  // Event handler to be called in case of problems
  cluster.on('taskerror', (err, data) => {
      console.log(`Could not load ${data}: ${err.message}`);
  });

  // task : BrowserTab, htmlFileSpec -> PDF
  await cluster.task(async ({ page, data }) => {
    // block tracking requests
    await page.setRequestInterception(true);
    page.on('request', async request => {
      const url = request.url();
      
      /*
      if(![...CACHABLES, 'file://'].some(ext => url.includes(ext))) {
        console.log('NOT SAVING ' + url);
      }
      */

      if (blocked_domains.some(domain => url.includes(domain))) {
        return request.abort();
      }
      if (CACHE[url] && CACHE[url].expires > Date.now()) {
          //console.log(`RETRIEVING ${url} from cache`);
          await request.respond(CACHE[url]);
          return;
      }
      return request.continue();
    });

    page.on('response', async (response) => {
      const url = response.url();
      const headers = response.headers();
      const cacheControl = headers['cache-control'] || '';
      const maxAgeMatch = cacheControl.match(/max-age=(\d+)/);
      const maxAge = maxAgeMatch && maxAgeMatch.length > 1 ? parseInt(maxAgeMatch[1], 10) : 0;
      if (maxAge) {
        if (CACHE[url] && CACHE[url].expires > Date.now()) return;

        let buffer;
        try {
            buffer = await response.buffer();
        } catch (error) {
            // some responses do not contain buffer and do not need to be caught
            return;
        }
        if(CACHABLES.some(ext => url.includes(ext))) {
          //console.log(`saving ${url} into cache` );
          CACHE[url] = {
              status: response.status(),
              headers: response.headers(),
              body: buffer,
              expires: Date.now() + (maxAge * 1000),
          };
        } else {
          //console.log(`NOT caching ${url}`);
        }
      }
    });

    const htmlFileSpec = JSON.parse(data);
    const landscapeP = htmlFileSpec.aspect === "landscape";
    const htmlFile = htmlFileSpec.input;
    let outputFile = htmlFileSpec.output;
    if (!outputFile) {
      //console.log('no output file spec for', htmlFile);
      outputFile = htmlFile.replace(/\.s?html$/, ".pdf");
    }
    const htmlPage = "file:///" + workingDir + "/" + htmlFile;
    await page.emulateMediaType("print");
    await page.addStyleTag({
      content: landscapeP ? landscapePageCSS : portraitPageCSS,
    });

    await page.goto(htmlPage, {
      waitUntil: "load", // wait for MathJax
      preferCSSPageSize: true,
      printBackground: true,
    });

    // tell puppeteer to wait until window.status is anything
    // OTHER than "not_ready_to_print". If MathJax is used on
    // the page, this flag will have been set to block printing
    // until math rendering is complete.
    await page.waitForFunction('window.status !== "not_ready_to_print"');

    // Convert relative links to absolute ones, so PDF links work correctly
    await page.evaluate((str) => {
      const links = document.querySelectorAll('a');
      links.forEach( a => {
        const href= a.getAttribute('href');
        if(href?.startsWith('../../')) {
          a.setAttribute('href', href.replace("../../","https://www.bootstrapworld.org/materials/"+str+"/en-us/"));
        } else if(href?.startsWith('../')) {
          a.setAttribute('href', href.replace("../","https://www.bootstrapworld.org/materials/"+str+"/en-us/lessons/"));
        }
      });
    }, semester+year);

    // add print options, and generate the bytes of the file
    // be sure to print the background of the contracts page,
    // which adds blank rows to fill up the last printed page
    const bytes = await page.pdf({ 
      ...pageOpts, 
      path: outputFile, 
      landscape: landscapeP,
      printBackground: htmlFile.includes("Contracts.shtml") 
    });

    // if the file is inside /pages/ or /solution-pages/
    // and isn't whitelisted, check page length and warn
    const longPage = await page.$("body.canBeLongerThanAPage,body.LessonPlan") != null
    const fileName = outputFile.match(/[ \w-]+\.[\w]+/)[0];
    if((outputFile.includes("/pages/") || outputFile.includes("/solution-pages/")) &&
       !longPage &&
       !outputFile.includes("/authoring/") &&
       !knownLongPages.some(p => outputFile.includes(p))) {
      checkOnePage(bytes, outputFile);
    }
    bar.tick();
  });

  // Queue up all the page options to be completed
  htmlFileSpecs
    .forEach((p) => cluster.queue(JSON.stringify(p)));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
  if(warnings.length > 0) {
    console.warn('\n\nWARNING: the following files unexpectedly have more than 1 page!\n'+warnings.join('\n'));  
  }
  
}

HtmlToPdf(htmlFileSpecs, tabsPerCore)
  .then(() => {})
  .catch(console.error);
