const puppeteer = require('puppeteer');
const { Cluster } = require('puppeteer-cluster');

// construct the array of pages from passed args
const htmlFileSpecs = require(process.argv[2]).htmlFileSpecs;
htmlFileSpecs.shift();

// constants that are used in the PDF conversion
const workingDir = process.cwd();
const pageOpts = { scale: 1.00  }; // match screen scale
const landscapePageCSS = "@page { size: letter landscape; margin: 0.5in; }";
const portraitPageCSS  = "@page { size: letter portrait;  margin: 0.5in; }";

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
    const landscapeP = (htmlFileSpec.aspect === 'landscape');
    const htmlFile = htmlFileSpec.input;
    const htmlPage = 'file:///' + workingDir + '/' + htmlFile;
    const path = htmlFile.replace(/\.s?html$/, '.pdf');
    const p = { pageOptions: {...pageOpts, path: path}, htmlPage: htmlPage };
    await page.emulateMediaType('print');
    await page.addStyleTag({ content: landscapeP ? landscapePageCSS : portraitPageCSS });
    await page.goto(p.htmlPage, { 
      waitUntil: 'networkidle2',  // wait for MathJax
      preferCSSPageSize: true, 
      printBackground: true,
     });
    // add the orientation as a page option
    await page.pdf( { ...p.pageOptions, landscape: landscapeP } );
  });

  // Queue up all the page options to be completed
  htmlFileSpecs.forEach(p => cluster.queue(JSON.stringify(p)));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

HtmlToPdf(htmlFileSpecs).then(() => {}).catch(console.error);
