const sharp = require('sharp');

const {
  sec, numCores, chromeArgs, blocked_domains, thingsToCache, pageTimeout,
  splitToSizeChunks, buildPreWarmedCache, setupRequestInterception,
  Cluster, launchCluster, makeProgressBar, TOPDIR, NATLANG, LESSON
} = require('./../puppeteer-shared.js');

// load the graph, and use either *every* lesson or the one from the env
const { configureGraph } = require(TOPDIR + "/lib/bootstraplesson.js");
let graph = require(TOPDIR + "/distribution/"+NATLANG+"/lib/dependency-graph.js");
configureGraph(graph);
// remove artificial graph entries for pseudo-projects
Object.keys(graph).forEach(k => {
  if(graph[k].title.startsWith("Project: ")) delete graph[k];
});
const lessons = LESSON? [LESSON] : Object.keys(graph);

// All of our screenshot configurations
const configs = [
  {selector: '.circleevalsexp>.expression',    prefix: 'AUTOGEN-COE'},
  {selector: '.image-figure',                  prefix: 'AUTOGEN-IMAGE'},
  //{selector: '.image-figure:has(.image-caption:not(:empty)', prefix: 'AUTOGEN-IMAGE'},
  {selector: '.sect1 :not(td>.content)>table', prefix: 'AUTOGEN-TABLE'},
];

// deviceScaleFactor for hi-res screenshots
const SCALE = 2;

// Screenshots use CONCURRENCY_BROWSER so each worker has its own Chrome process,
// avoiding CDP render queue contention. Cut core count to avoid overwhelming the system.
const useCores = Math.ceil(numCores / 2);

async function processLessons() {
  console.log(`Generating screenshots for slides`);

  const urls = lessons.map(p => `${TOPDIR}/distribution/${NATLANG}/lessons/${p}/index.shtml`);

  // Returns a cache object which already has commonly used files in it
  const CACHE = await buildPreWarmedCache();

  // Launch the cluster with one Chrome per worker (no CDP contention between workers)
  const cluster = await launchCluster(Cluster.CONCURRENCY_BROWSER, useCores);
  const bar = makeProgressBar(urls.length);

  await cluster.task(async ({ page, data }) => {
    // Give each page operation (MathJax, screenshot-ing, etc) its allotted time
    page.setDefaultTimeout(pageTimeout);
    let currentUrl = '(unknown)';

    // With CONCURRENCY_BROWSER each task gets a fresh page, so no guard needed.
    // Set up request interception, error reporting, and viewport once per task.
    await page.setRequestInterception(true);
    setupRequestInterception(page, CACHE);

    page.on('pageerror', (err) => {
      if(err.message.startsWith("jQuery is not defined")) return;
      if(err.message.startsWith("graph is not defined")) return;
      console.error(`Page JS error on ${currentUrl}:\n${err.stack}`);
    });

    await page.emulateMediaType('print');

    const urls = JSON.parse(data);

    for await (const url of urls) {
      currentUrl = url;
      let numScreenshots = 0;
      let start = Date.now();

      await page.goto(`file://${url}`, {
        waitUntil: ['domcontentloaded'],
        preferCSSPageSize: true,
        printBackground: true,
      }).catch(e => { throw new Error(`Navigation timeout on ${url}: ${e.message}`); });

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

      // wait for fonts, or 10s -- whichever comes first
      const fontsHandle = await page.evaluateHandle('document.fonts.ready');
      await Promise.race([
        fontsHandle,
        new Promise((_, reject) => setTimeout(() => reject(new Error('fonts.ready timed out')), 10 * sec))
      ]).catch(e => console.warn(`${url}: ${e.message}`));
      await fontsHandle.dispose();

      await page.addStyleTag({content: `
        @media print {
          body { width: 670px !important; }
          body::after { content: unset !important; }
          .hiddenblock { display: unset !important; }
        }
      `});

      // resize viewport to actual page content before screenshotting
      const pageHeight = await page.evaluate(() => document.body.scrollHeight);
      await page.setViewport({
        width: 1000,
        height: Math.min(pageHeight, 25000),
        deviceScaleFactor: SCALE,
      });

      const outputPrefix = url.split('/').slice(0, -1).join('/') + '/images/';
      for (const {selector, prefix} of configs) {
        const elts = await page.$$(selector);

        // If there are no matching elements, move on to the next selector
        if (elts.length === 0) {
          elts.forEach(e => e.dispose());
          continue;
        }

        // build a styleHandle, and dispose when done
        const styleHandle = await page.addStyleTag({content: `
          :not(${selector}) { background-color: transparent !important; }
        `});

        // one full-page screenshot per selector pass, then crop in Node with sharp
        // this is much faster than one elt.screenshot() CDP call per element
        const pageScreenshot = await page.screenshot({ omitBackground: true, fullPage: true });
        const { width: imgWidth, height: imgHeight } = await sharp(pageScreenshot).metadata();
        const sharpInstance = sharp(pageScreenshot);

        // get all bounding boxes in one round trip
        const boxes = await page.evaluate((sel) => {
          return [...document.querySelectorAll(sel)].map(el => {
            const box = el.getBoundingClientRect();
            return box.width > 0 && box.height > 0
              ? { x: box.x, y: box.y, width: box.width, height: box.height }
              : null;
          });
        }, selector);

        await Promise.all(elts.map(async (elt, i) => {
          await elt.dispose();  // no longer need the element handle
          if (!boxes[i]) return;

          const left   = Math.max(0, Math.round(boxes[i].x * SCALE));
          const top    = Math.max(0, Math.round(boxes[i].y * SCALE));
          const right  = Math.min(imgWidth,  Math.round((boxes[i].x + boxes[i].width)  * SCALE));
          const bottom = Math.min(imgHeight, Math.round((boxes[i].y + boxes[i].height) * SCALE));
          const width  = right - left;
          const height = bottom - top;

          if (width <= 0 || height <= 0) return;

          await sharpInstance.clone()
            .extract({ left, top, width, height })
            .toFile(outputPrefix + prefix + (i+1) + '.png');
          numScreenshots++;
        }));

        await page.evaluate(el => el.remove(), styleHandle);
        await styleHandle.dispose();
      }
      bar.tick();
      //console.log(`\n${numScreenshots} done for ${currentUrl} in ${(Date.now() - start)/1000}ms\n`);
    }
  });

  // shuffle the URLs to get a more-even mix of lessons with many screenshots and those with few per chunk
  const shuffled = urls.sort(() => Math.random() - 0.5);
  const chunks = splitToSizeChunks(shuffled);
  console.log(`   • Using ${useCores} cores, processing chunks with ${chunks[0].length} pages each`);

  chunks.forEach(c => cluster.queue(JSON.stringify(c)));

  await cluster.idle();
  await cluster.close();
}

processLessons()
  .then(() => {})
  .catch(console.error);