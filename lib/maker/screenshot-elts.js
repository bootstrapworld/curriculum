const sharp = require('sharp');

const {
  sec, numCores, chromeArgs, blocked_domains, thingsToCache, pageTimeout,
  splitToSizeChunks, buildPreWarmedCache, setupRequestInterception,
  launchCluster, makeProgressBar, TOPDIR, NATLANG, LESSON
} = require('./../puppeteer-shared.js');

// load the graph, and use either *every* lesson or the one from the env
const { configureGraph } = require(TOPDIR + "/lib/bootstraplesson.js");
let graph = require(TOPDIR + "/distribution/"+NATLANG+"/lib/dependency-graph.js");
configureGraph(graph);
// remove artificial graph entries for pseudo-projects
Object.keys(graph).forEach(k => {
	if(graph[k].title.startsWith("Project: ")) delete graph[k];
});
const lessons =  LESSON? [LESSON] : Object.keys(graph);

// All of our screenshot configurations
const configs = [
	{selector: '.circleevalsexp>.expression',    prefix: 'AUTOGEN-COE'},
	{selector: '.image-figure',                  prefix: 'AUTOGEN-IMAGE'},
	//{selector: '.image-figure:has(.image-caption:not(:empty)', prefix: 'AUTOGEN-IMAGE'},
	{selector: '.sect1 :not(td>.content)>table', prefix: 'AUTOGEN-TABLE'},
]

async function processLessons() {
  console.log(`Generating screenshots for slides`);

  const urls = lessons.map(p => `${TOPDIR}/distribution/${NATLANG}/lessons/${p}/index.shtml`);

  // Returns a cache object which already has commonly used files in it
  const CACHE = await buildPreWarmedCache();

  // Launch the cluster and initialize progress bar
  const cluster = await launchCluster();
  const bar = makeProgressBar(urls.length);

  await cluster.task(async ({ page, data }) => {
    // Give each pageOeration (MathJax, screenshot-ing, etc) 30s
    page.setDefaultTimeout(pageTimeout);
    let currentUrl = '(unknown)';

    // only initialize event handlers once per page,
    // reusing them across urls
    if (!page._eventHandlersInitialized) {

      await page.setRequestInterception(true);
      setupRequestInterception(page, CACHE);

      // we know jQuery or graph are not defined, but we DO want to know if something else fails
	    page.on('pageerror', (err) => {
	    	if(err.message.startsWith("jQuery is not defined")) return;
	    	if(err.message.startsWith("graph is not defined")) return;
        console.error(`Page JS error on ${currentUrl}:\n${err.stack}`);
      });

      await page.emulateMediaType('print');

      page._eventHandlersInitialized = true;
    }

    const urls = JSON.parse(data);

    for await (const url of urls) {
      currentUrl = url;

      const start = Date.now();
      const t = () => ((Date.now() - start) / 1000).toFixed(1) + 's';

      //await page.goto('about:blank', { timeout: 5 * sec });
      //cconsole.log(t(), 'blank done');
      await page.goto(`file://${url}`, {
        waitUntil: "load", // wait for all scripts (esp MathJax!)
        preferCSSPageSize: true,
        printBackground: true,
      }).catch(e => { throw new Error(`Navigation timeout on ${url}: ${e.message}`); });
      //console.log(t(), 'goto done');

      try {
        await page.waitForFunction(
          'window.status !== "not_ready_to_print"',
          { timeout: 30 * sec }
        );
        if (await page.evaluate(() => window.status === "MathJax Failed!")) {
          console.warn(`MathJax failed on ${url}`);
        }
      } catch (e) {
        console.warn(`MathJax timed out on ${url}`);
      }
      //console.log(t(), 'mathjax done');

      // build a fontsHandle, and dispose when done
      const fontsHandle = await page.evaluateHandle('document.fonts.ready');
      await Promise.race([
        fontsHandle,
        new Promise((_, reject) => setTimeout(() => reject(new Error('fonts.ready timed out')), 10 * sec))
      ]).catch(e => console.warn(`${url}: ${e.message}`));
      await fontsHandle.dispose();
      //console.log(t(), 'fonts done');

      await page.addStyleTag({content: `
        @media print {
          body { width: 670px !important; }
          body::after { content: unset !important; }
          .hiddenblock { display: unset !important; }
        }
      `});
      //console.log(t(), 'style done');

      const outputPrefix = url.split('/').slice(0, -1).join('/') + '/images/';
      for (const {selector, prefix} of configs) {
        const elts = await page.$$(selector);
        //console.log(t(), `$$(${selector}): ${elts.length} elts`);

        // If there are no validly-matching elements, move on to the next lesson
        if (elts.length === 0) {
          elts.forEach(e => e.dispose());
          continue;
        }

      	// build a styleHandle, and dispose when done
        const styleHandle = await page.addStyleTag({content: `
          :not(${selector}) { background-color: transparent !important; }
        `});

        const pageScreenshot = await page.screenshot({ omitBackground: true });
        const { width: imgWidth, height: imgHeight } = await sharp(pageScreenshot).metadata();

        await Promise.all(elts.map(async (elt, i) => {
          const box = await elt.boundingBox();
          if (!box) { await elt.dispose(); return; }

          const left   = Math.max(0, Math.round(box.x));
          const top    = Math.max(0, Math.round(box.y));
          const right  = Math.min(imgWidth,  Math.round(box.x + box.width));
          const bottom = Math.min(imgHeight, Math.round(box.y + box.height));
          const width  = right - left;
          const height = bottom - top;

          if (width <= 0 || height <= 0) { await elt.dispose(); return; }

          await sharp(pageScreenshot)
            .extract({ left, top, width, height })
            .toFile(outputPrefix + prefix + (i+1) + '.png');

          await elt.dispose();
        }));
        //console.log(t(), `screenshots done for ${selector}`);

        await page.evaluate(el => el.remove(), styleHandle);
        await styleHandle.dispose();
        //console.log(t(), 'style removed');
      }
      bar.tick();
      const elapsed = ((Date.now() - start) / 1000).toFixed(1);
  		//console.log(`\n${url.split('/').slice(-2,-1)[0]}: ${elapsed}s`);
    }
  });

  // shuffle the URLs to get a more-even mix of lessons with many screenshots and those with few per chunk
  const shuffled = urls.sort(() => Math.random() - 0.5);
  const chunks = splitToSizeChunks(shuffled);
  console.log(`   • Using ${ numCores } cores, processing chunks with ${chunks[0].length} pages each`);

  chunks.forEach(c => cluster.queue(JSON.stringify(c)));

  await cluster.idle();
  await cluster.close();
}

processLessons()
  .then(() => {})
  .catch(console.error);
