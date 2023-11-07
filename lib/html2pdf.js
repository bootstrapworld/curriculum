const topdir = process.env["TOPDIR"];
const { Cluster } = require("puppeteer-cluster");
const { knownLongPages } = require(topdir + "/lib/bootstraplesson.js");
const { PDFDocument } = require("pdf-lib");

// args to run puppeteer in lightweight mode, 
// and be smart about proxies and font hinting
const puppeteerArgs = [
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

  // use the new headless system
  "--headless=new"
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


// construct the array of pages from passed args
const htmlFileSpecs = require(process.argv[2]).htmlFileSpecs;
htmlFileSpecs.shift();

// constants that are used in the PDF conversion
const workingDir = process.cwd();
const pageOpts = { scale: 1.0 }; // match screen scale
const landscapePageCSS = "@page { size: letter landscape; }";
const portraitPageCSS  = "@page { size: letter portrait;  }";

// Set number of cores, and debug for Flannery's machine
let numCores = parseInt(process.env.NUMCORES) || 1; // minumum 1 core

// Load the bytes in pdf-lib and get the page count
// Throw a warning if > 1,unless the file is whitelisted
async function checkOnePage(bytes, outputFile) {
  const doc   = await PDFDocument.load(bytes);
  const count = doc.getPageIndices().length;
  const fileName = outputFile.match(/[ \w-]+\.[\w]+/)[0];
  if(count > 1) {
    console.log(`WARNING: ${outputFile} has ${count} pages`);
  }
}

async function HtmlToPdf(htmlFileSpecs) {
  const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // maximize sharing data between jobs
    maxConcurrency: numCores, // cluster with NUMCORES workers
    monitor: true, // show the cluster's progress
    headless: 'new',
    puppeteerOptions: {
      headless: "new",
      userDataDir: './distribution/.cached',
      args: puppeteerArgs, 
    }
  });

  // Event handler to be called in case of problems
  cluster.on('taskerror', (err, data) => {
      console.log(`Could not load ${data}: ${err.message}`);
  });

  // task : BrowserTab, htmlFileSpec -> PDF
  await cluster.task(async ({ page, data: htmlFileSpec0 }) => {
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

    const htmlFileSpec = JSON.parse(htmlFileSpec0);
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
      waitUntil: "networkidle2", // wait for MathJax
      preferCSSPageSize: true,
      printBackground: true,
    });

    // tell puppeteer to wait until window.status is anything
    // OTHER than "not_ready_to_print". If MathJax is used on
    // the page, this flag will have been set to block printing
    // until math rendering is complete.
    await page.waitForFunction('window.status !== "not_ready_to_print"');
  
    // add print options, and generate the bytes of the file
    const bytes = await page.pdf({ ...pageOpts, path: outputFile, landscape: landscapeP });

    // if the file is inside /pages/ or /solution-pages/
    // and isn't whitelisted, check page length and warn
    const fileName = outputFile.match(/[ \w-]+\.[\w]+/)[0];
    if((outputFile.includes("/pages/") || outputFile.includes("/solution-pages/")) &&
       !knownLongPages.includes(fileName)) {
      checkOnePage(bytes, outputFile);
    }

    // return the (unmodified) file
    return bytes;
  });

  // Queue up all the page options to be completed
  htmlFileSpecs
    .forEach((p) => cluster.queue(JSON.stringify(p)));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

HtmlToPdf(htmlFileSpecs)
  .then(() => {})
  .catch(console.error);
