const {
  sec, numCores, chromeArgs, blocked_domains, thingsToCache, pageTimeout,
  splitToSizeChunks, buildPreWarmedCache, setupRequestInterception,
  Cluster, launchCluster, makeProgressBar, TOPDIR, NATLANG, LESSON
} = require('./puppeteer-shared.js');

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

      await page.goto(htmlPage, {
        waitUntil: "load", // wait for all scripts (esp MathJax!)
        preferCSSPageSize: true,
        printBackground: true,
      }).catch(e => { throw new Error(`Navigation timeout on ${htmlFile}: ${e.message}`); });
      await page.addStyleTag({
        content: landscapeP ? landscapePageCSS : portraitPageCSS,
      });

      // tell puppeteer to wait until window.status is anything
      // OTHER than "not_ready_to_print". If MathJax is used on
      // the page, this flag will have been set to block printing
      // until math rendering is complete.
      // If MathJax failed for some reason, report it.
      try {
        await page.waitForFunction(
          'window.status !== "not_ready_to_print"',
          { timeout: 30 * sec }
        );
        if (await page.evaluate(() => window.status === "MathJax Failed!")) {
          console.warn(`\nMathJax failed on ${htmlFile}`);
        }
      } catch (e) {
        console.warn(`\nMathJax timed out on ${htmlFile}`);
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
  
}

HtmlToPdf(htmlFileSpecs)
  .then(() => {})
  .catch(console.error);
