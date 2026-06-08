const {
  sec, numCores, chromeArgs, blocked_domains, thingsToCache, pageTimeout,
  navigationTimeout, readinessTimeout, pageRetryLimit, pageRetryDelay,
  splitToSizeChunks, buildPreWarmedCache, setupRequestInterception,
  Cluster, launchCluster, makeProgressBar, TOPDIR, NATLANG, LESSON
} = require('./puppeteer-shared.js');

const fs = require('fs');
const course_filter = process.env["COURSE"] || false;
const semester = process.env['SEMESTER'];
const year = process.env['YEAR'];
const { knownLongPages } = require(TOPDIR + "/distribution/en-us/lib/makeWorkbook.js");
const { PDFDocument } = require("pdf-lib");

// construct the array of pages from passed args
const { htmlFileSpecs } = require(process.argv[2]);

htmlFileSpecs.shift();

// constants that are used in the PDF conversion
const workingDir = process.cwd();
const pageOpts = { scale: 1.0 }; // match screen scale
const landscapePageCSS = "@page { size: letter landscape; }";
const portraitPageCSS  = "@page { size: letter portrait;  }";

let warnings = [];
let failures = [];

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

// because of page blocking/waiting, default to 1
async function HtmlToPdf(htmlFileSpecs) {

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

  // Returns a cache object which already has commonly used files in it
  const CACHE = await buildPreWarmedCache();

  // Launch the cluster and initialize progress bar
  const cluster = await launchCluster(Cluster.CONCURRENCY_PAGE);
  const bar = makeProgressBar(htmlFileSpecs.length);

  // Assign the task:
  // consume an htmlFileSpec, and generate a PDF version of the specified file
  await cluster.task(async ({ page, data }) => {
    // Give each pageOeration (MathJax, screenshot-ing, etc) 45s
    page.setDefaultTimeout(pageTimeout);
    let url = '(unknown)';

    // only initialize event handlers once per page,
    // reusing them across urls
    if (!page._eventHandlersInitialized) {
      // stub jQuery to prevent bogus JS errors
      await page.evaluateOnNewDocument(() => {
        const noop = () => noop;
        noop.noConflict = () => noop;
        window.jQuery = window.$ = noop;
      });

      //  Kill requests to blocked domains
      //  Use the cache whenever possible
      await page.setRequestInterception(true);
      setupRequestInterception(page, CACHE);
      page._requestInterceptionEnabled = true;
/*
      // Report on any JS errors
      page.on('pageerror', (err) => {
        console.error(`Page JS error on ${url}:\n${err.stack}`);
      });
*/
      // set print media type
      await page.emulateMediaType('print');

      page._eventHandlersInitialized = true;
    }

    data = JSON.parse(data);

    for await (const htmlFileSpec of data) {

      const landscapeP = htmlFileSpec.aspect === "landscape";

      const htmlFile = htmlFileSpec.input;
      url = htmlFile;

      let outputFile = htmlFileSpec.output;
      if (!outputFile) {
        outputFile = htmlFile.replace(/\.s?html$/, ".pdf");
      }
      const htmlPage = "file:///" + workingDir + "/" + htmlFile;

      // process this page in isolation, retrying it (within this same
      // chunk/tab) a few times if it fails. Only report -- and give up
      // on -- the page once every attempt has failed; this way a single
      // flaky page doesn't take down (or trigger a retry of) the whole chunk
      const totalAttempts = pageRetryLimit + 1;
      for (let attempt = 1; attempt <= totalAttempts; attempt++) {
        try {
          await page.goto(htmlPage, {
            // don't block on the `load` event: it waits for every subresource,
            // including the Google Tag Manager <iframe> and apis.google.com script
            // that our request interceptor aborts -- an aborted subframe can leave
            // `load` pending forever. DOM-ready is enough here; MathJax readiness is
            // gated separately by the window.status wait below.
            waitUntil: "domcontentloaded",
            preferCSSPageSize: true,
            printBackground: true,
            timeout: navigationTimeout,
          }).catch(e => { throw new Error(`Navigation timeout: ${e.message}`); });
          await page.addStyleTag({
            content: landscapeP ? landscapePageCSS : portraitPageCSS,
          });

          // tell puppeteer to wait until window.status is anything
          // OTHER than "not_ready_to_print". If MathJax is used on
          // the page, this flag will have been set to block printing
          // until math rendering is complete.
          // A page stuck at "not_ready_to_print" is hung: throw so the
          // retry loop re-attempts it, rather than printing a half-rendered PDF.
          try {
            await page.waitForFunction(
              'window.status !== "not_ready_to_print"',
              { timeout: readinessTimeout }
            );
          } catch (e) {
            throw new Error(`Render timeout: window.status stuck at "not_ready_to_print" after ${readinessTimeout / sec}s`);
          }
          // If MathJax failed for some reason, report it (but still print the page).
          if (await page.evaluate(() => window.status === "MathJax Failed!")) {
            console.warn(`\nMathJax failed on ${htmlFile}`);
          }

          // Convert relative links to absolute ones, so PDF links work correctly
          await page.evaluate((baseUrl) => {
            document.querySelectorAll('a[href]').forEach(a => {
              a.href = new URL(a.getAttribute('href'), baseUrl).href;
            });
          }, `https://www.bootstrapworld.org/materials/${semester+year}/en-us/`);

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
          break; // success -- move on to the next page in the chunk
        } catch (e) {
          if (attempt < totalAttempts) {
            /*
            if(attempt == 1) {
              failures.push(`\nHad to retry ${htmlFile} after error: ${e.message}`);
            } else {
              failures[failures.length-1] = `\nHad to retry ${htmlFile} ${attempt} times after error: ${e.message}`;
            }
            */
            await new Promise(resolve => setTimeout(resolve, pageRetryDelay));
          } else {
            failures.push(`${htmlFile}: ${e.message}`);
            console.warn(`\nFailed to convert ${htmlFile} after ${totalAttempts} attempt(s): ${e.message}`);
            // page.pdf() streams bytes to `outputFile` as they arrive, so a
            // timeout/crash mid-generation can leave a partial PDF on disk
            // with a fresh mtime -- which would look "up to date" to `make
            // book`'s dependency check and never get rebuilt. Remove it so
            // the next run picks this page back up.
            await fs.promises.unlink(outputFile).catch(() => {});
          }
        }
      }
      bar.tick();
    };
  });

  const chunks = splitToSizeChunks(htmlFileSpecs);
  console.log(`   • Using ${numCores} out of ${numCores} cores, processing chunks with ${chunks[0].length} pages each`);
  
  // enqueue each chunk
  chunks.forEach( (c) => cluster.queue(JSON.stringify(c)));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
  // If there are warnings, trim them to only show unique lesson/pages/filename paths
  if(warnings.length > 0) {
    // use only the lesson, folder, and filename (drop everything else)
    warnings = warnings.map(w => w.split("/").slice(-3).join("/"));
    // convert to a Set and back to remove duplicates, then sort
    warnings = [...new Set(warnings)].sort();
    console.warn('\n\nWARNING: the following files unexpectedly have more than 1 page!\n'+warnings.join('\n'));
  }
  // Report any pages that failed to convert, so individual failures
  // are easy to spot instead of being buried in chunk-level errors
  if(failures.length > 0) {
    console.warn(`\n\nERROR: the following ${failures.length} file(s) failed to convert:\n`+failures.join('\n'));
  }
}

HtmlToPdf(htmlFileSpecs)
  .then(() => {})
  .catch(console.error);
