puppeteer = require("puppeteer")

var args = process.argv.slice(2);

const path = process.env.TOPDIR + 
             "/distribution/" + 
             process.env.NATLANG + 
             "/lessons/" + 
             process.env.LESSON + 
             "/index.shtml";

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

  // use the new headless system
  "--headless=new",
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


// loads the page at the specified URL, then screenshots all *visible* images
// matching a selector and saves them as PNGs in that lessons' images folder
// NOTE(Emmanuel): for now we're hardcoding the selector
async function saveSelectorResultsAsImages(selector = '.sect1 table') {

    // set up the browser and load the page
	const browser = await puppeteer.launch({headless: "new", args: chromeArgs});
	const page = await browser.newPage();
	await page.goto(`file://${path}`, {
      waitUntil: ['domcontentloaded', 'networkidle0'],
      preferCSSPageSize: true,
      printBackground: true,
    });

    // set deviceScaleFactor for higher-res images
    await page.setViewport({ width: 1920, height: 1080, deviceScaleFactor: 2 });
    // set print media type (typically makes screenshots easier)
    await page.emulateMediaType('print');
    // printed pages are narrower than web pages, so manually expand the width 
    await page.addStyleTag({content: '@media print { body.LessonPlan { width: 8in !important; } }'})
    // make hidden things visible, so we can screenshot them
    await page.addStyleTag({content: 'div.hiddenblock { display: unset !important; }'});
    await page.addStyleTag({content: '.lesson-instruction, .q-and-a { background: none !important; }'});

    // same conditions as PDF printing, to avoid screenshotting when
    // mathjax hasn't finish running
    await page.waitForFunction('window.status !== "not_ready_to_print"');

    // wait for fonts to be ready
    await page.evaluateHandle('document.fonts.ready');

    // get all the elts matching the selector, then for all of them:
    // skip if the element is not visible (has no bounding box)
    // otherwise, take a screenshot and save it to .cached
    const outputPrefix = path.split('/').slice(0, -1).join('/') + '/images/';
    const eltPromises = await page.$$(selector);
    await Promise.all(eltPromises.map(async (elt, i) => {
        if(!await elt.boundingBox()) return;
        const tagName = await (await elt.getProperty('tagName')).jsonValue();
        // add 1 to 0, to preserve luaesque semantics ;)
        return elt.screenshot({path: outputPrefix + tagName + (i+1) + '.png'});
    }));

    await browser.close();
}

saveSelectorResultsAsImages()