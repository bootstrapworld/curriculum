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
let failedSpecs = [];   // pages that failed the bulk run; retried sequentially after drain

// Cheaply estimate a Chrome-generated PDF's page count by scanning for plaintext
// "/Type /Page" leaf-page dicts (the negative lookahead skips the "/Type /Pages"
// tree node and keys like /PageLabel). Chrome's printToPDF output has no object/xref
// streams (verified), so it never *under*-counts -- but the literal bytes can appear
// inside uncompressed streams, so it can *over*-count. Hence callers may only trust
// a result of exactly 1; anything else must be confirmed with a real parse.
function pdfPageCount(bytes) {
  const matches = Buffer.from(bytes).toString('latin1').match(/\/Type\s*\/Page(?![s\w])/g);
  return matches ? matches.length : 0;
}

// Warn if a PDF is unexpectedly more than 1 page (unless the file is whitelisted).
async function checkOnePage(bytes, outputFile) {
  // The scan never under-counts, so scan===1 means exactly one page (verified across
  // the whole corpus: 0 false single-page verdicts) -- trust it and skip the parse,
  // which is the case for ~92% of checked pages. For anything else (0 => object
  // streams; >1 => possible spurious matches in stream bytes) get the authoritative
  // count from pdf-lib.
  let count = pdfPageCount(bytes);
  if (count !== 1) {
    count = (await PDFDocument.load(bytes)).getPageIndices().length;
  }
  if(count > 1) {
    const shortPath = outputFile.split('/').slice(2).join('/');
    warnings.push(`${shortPath} has ${count} pages`);
  }
}

// Set up a fresh tab once: jQuery stub, request interception (block + cache), print
// media. Guarded so it's a no-op when the tab is reused across the pages in a chunk.
async function initPage(page, CACHE) {
  if (page._eventHandlersInitialized) return;
  page.setDefaultTimeout(pageTimeout);
  // stub jQuery to prevent bogus JS errors
  await page.evaluateOnNewDocument(() => {
    const noop = () => noop;
    noop.noConflict = () => noop;
    window.jQuery = window.$ = noop;
  });
  // kill requests to blocked domains; use the cache whenever possible
  await page.setRequestInterception(true);
  setupRequestInterception(page, CACHE);
  await page.emulateMediaType('print');
  page._eventHandlersInitialized = true;
}

// Convert a single htmlFileSpec to a PDF. One attempt; throws on failure.
async function convertPage(page, htmlFileSpec) {
  const landscapeP = htmlFileSpec.aspect === "landscape";
  const htmlFile = htmlFileSpec.input;
  const outputFile = htmlFileSpec.output || htmlFile.replace(/\.s?html$/, ".pdf");
  const htmlPage = "file:///" + workingDir + "/" + htmlFile;

  // don't block on the `load` event: it waits for every subresource, including the
  // Google Tag Manager <iframe> and apis.google.com script our interceptor aborts --
  // an aborted subframe can leave `load` pending forever. DOM-ready is enough here;
  // MathJax readiness is gated separately by the window.status wait below.
  await page.goto(htmlPage, {
    waitUntil: "domcontentloaded",
    preferCSSPageSize: true,
    printBackground: true,
    timeout: navigationTimeout,
  }).catch(e => { throw new Error(`Navigation timeout: ${e.message}`); });
  await page.addStyleTag({ content: landscapeP ? landscapePageCSS : portraitPageCSS });

  // wait until window.status clears "not_ready_to_print" (set by MathJax pages until
  // rendering finishes). A page stuck there is hung: throw so it's retried/deferred
  // rather than printing a half-rendered PDF.
  try {
    await page.waitForFunction(
      'window.status !== "not_ready_to_print"', { timeout: readinessTimeout });
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

  // generate the PDF; print the background on the Contracts page (it adds blank
  // rows to fill out the last printed page)
  const bytes = await page.pdf({
    ...pageOpts,
    path: outputFile,
    landscape: landscapeP,
    printBackground: htmlFile.includes("Contracts.shtml"),
  });

  // for /pages/ and /solution-pages/ (non-whitelisted, non-authoring), warn if >1 page
  const longPage = await page.$("body.canBeLongerThanAPage,body.LessonPlan") != null;
  if((outputFile.includes("/pages/") || outputFile.includes("/solution-pages/")) &&
     !longPage &&
     !outputFile.includes("/authoring/") &&
     !knownLongPages.some(p => outputFile.includes(p))) {
    checkOnePage(bytes, outputFile);
  }
}

// Re-convert the pages that failed the bulk run, one at a time on a single worker.
// Those failures are overwhelmingly contention casualties from the saturated tail --
// the pages themselves load fine in isolation -- so running them with no contention
// recovers them reliably. Returns the list of pages that STILL fail (genuine problems).
async function retryFailedSequentially(specs, CACHE) {
  console.warn(`\nRetrying ${specs.length} deferred page(s) sequentially (no contention)...`);
  const cluster = await launchCluster(Cluster.CONCURRENCY_PAGE, 1);
  const stillFailed = [];
  await cluster.task(async ({ page, data }) => {
    await initPage(page, CACHE);
    const spec = JSON.parse(data);
    const totalAttempts = pageRetryLimit + 1;
    for (let attempt = 1; attempt <= totalAttempts; attempt++) {
      try {
        await convertPage(page, spec);
        console.warn(`  recovered ${spec.input}`);
        return;
      } catch (e) {
        if (attempt < totalAttempts) {
          await new Promise(resolve => setTimeout(resolve, pageRetryDelay));
        } else {
          // genuine failure: remove any partial PDF so `make book` retries it next run
          const outputFile = spec.output || spec.input.replace(/\.s?html$/, ".pdf");
          await fs.promises.unlink(outputFile).catch(() => {});
          stillFailed.push(`${spec.input}: ${e.message}`);
          console.warn(`  STILL FAILED ${spec.input}: ${e.message}`);
        }
      }
    }
  });
  specs.forEach(s => cluster.queue(JSON.stringify(s)));
  await cluster.idle();
  await cluster.close();
  return stillFailed;
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

  // Assign the task: consume a chunk of htmlFileSpecs and generate a PDF for each.
  await cluster.task(async ({ page, data }) => {
    await initPage(page, CACHE);
    for (const htmlFileSpec of JSON.parse(data)) {
      const htmlFile = htmlFileSpec.input;
      // Retry within the chunk to absorb transient flakiness. A page that fails
      // every in-loop attempt is almost always a contention casualty in the
      // saturated tail (it loads fine without contention), so rather than giving
      // up we DEFER it to the sequential post-drain pass (see below).
      const totalAttempts = pageRetryLimit + 1;
      for (let attempt = 1; attempt <= totalAttempts; attempt++) {
        try {
          await convertPage(page, htmlFileSpec);
          break; // success -- on to the next page in the chunk
        } catch (e) {
          if (attempt < totalAttempts) {
            await new Promise(resolve => setTimeout(resolve, pageRetryDelay));
          } else {
            failedSpecs.push(htmlFileSpec);
            console.warn(`\nDeferring ${htmlFile} to post-run retry (failed ${totalAttempts}x under load): ${e.message}`);
          }
        }
      }
      bar.tick();
    }
  });

  const chunks = splitToSizeChunks(htmlFileSpecs);
  console.log(`   • Using ${numCores} out of ${numCores} cores, processing chunks with ${chunks[0].length} pages each`);
  
  // enqueue each chunk
  chunks.forEach( (c) => cluster.queue(JSON.stringify(c)));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();

  // Mop up the deferred stragglers sequentially. With the bulk run finished there's
  // no contention, so pages that timed out under load convert in ~0.2s. Only pages
  // that STILL fail here (genuine problems) count as real failures.
  let stillFailed = [];
  if (failedSpecs.length > 0) {
    stillFailed = await retryFailedSequentially(failedSpecs, CACHE);
  }

  // If there are warnings, trim them to only show unique lesson/pages/filename paths
  if(warnings.length > 0) {
    // use only the lesson, folder, and filename (drop everything else)
    warnings = warnings.map(w => w.split("/").slice(-3).join("/"));
    // convert to a Set and back to remove duplicates, then sort
    warnings = [...new Set(warnings)].sort();
    console.warn('\n\nWARNING: the following files unexpectedly have more than 1 page!\n'+warnings.join('\n'));
  }
  // Report only pages that failed even the no-contention retry -- these are real
  if(stillFailed.length > 0) {
    console.warn(`\n\nERROR: the following ${stillFailed.length} file(s) failed to convert (even after a no-contention retry):\n`+stillFailed.join('\n'));
  }
}

HtmlToPdf(htmlFileSpecs)
  .then(() => {})
  .catch(console.error);
