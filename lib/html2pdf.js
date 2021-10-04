const puppeteer = require('puppeteer');
const { Cluster } = require('puppeteer-cluster');

// construct the array of pages from passed args
const htmlFileSpecs = require(process.argv[2]).htmlFileSpecs;
htmlFileSpecs.shift();

// constants that are used in the PDF conversion
const workingDir = process.cwd();

// Set number of cores, and debug for Flannery's machine
let numCores = parseInt(process.env.NUMCORES) || 1; // minumum 1 core
if (process.env.USER === 'flannery') { numCores = 4; }

async function HtmlToPdf(htmlFileSpecs) {
  const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // use one page per worker
    maxConcurrency: numCores,              // cluster with NUMCORES workers
    monitor: true,                         // show the cluster's progress
  });

  // task : BrowserTab, htmlFileSpec -> PDF
  await cluster.task(async ({page, data: htmlFileSpec0 }) => {
    const htmlFileSpec = JSON.parse(htmlFileSpec0);
    const htmlFile = htmlFileSpec.input;
    let outputFile = htmlFileSpec.output;
    if (!outputFile) {
      //console.log('no output file spec for', htmlFile);
      outputFile = htmlFile.replace(/\.s?html$/, '.pdf');
    }
    const htmlPage = 'file:///' + workingDir + '/' + htmlFile;
    await page.emulateMediaType('print');
    await page.goto(htmlPage, {
      waitUntil: 'networkidle2',  // wait for MathJax
      preferCSSPageSize: true,
      printBackground: true,
     });
    // match screen scale
    await page.pdf( { scale: 1.00, path: outputFile} );
  });

  // Queue up all the page options to be completed
  htmlFileSpecs.forEach(p => cluster.queue(JSON.stringify(p)));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

HtmlToPdf(htmlFileSpecs).then(() => {}).catch(console.error);
