puppeteer = require("puppeteer")

var args = process.argv.slice(2);

const path = process.env.TOPDIR + 
             "/distribution/" + 
             process.env.NATLANG + 
             "/lessons/" + 
             process.env.LESSON + 
             "/index.shtml";

// loads the page at the specified URL, then screenshots all *visible* images
// matching a selector and saves them as PNGs in that lessons' .cached folder
// NOTE(Emmanuel): for now we're hardcoding the selector
async function saveSelectorResultsAsImages(selector = '.sect1 table') {

    // set up the browser and load the page
	const browser = await puppeteer.launch({headless: "new"});
	const page = await browser.newPage();
	await page.goto(`file://${path}`, {
      waitUntil: "load", // wait for MathJax
      preferCSSPageSize: true,
      printBackground: true,
    });

    // set print media type (typically makes screenshots easier)
    await page.emulateMediaType('print');

    // get all the elts matching the selector, then for all of them:
    // skip if the element is not visible (has no bounding box)
    // otherwise, take a screenshot and save it to .cached
    const outputPrefix = path.split('/').slice(0, -1).join('/') + '/.cached/';
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