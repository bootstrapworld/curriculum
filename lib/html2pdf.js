const puppeteer = require("puppeteer");
const { Cluster } = require("puppeteer-cluster");

// construct the array of pages from passed args
const htmlFileSpecs = require(process.argv[2]).htmlFileSpecs;
htmlFileSpecs.shift();

// constants that are used in the PDF conversion
const workingDir = process.cwd();
<<<<<<< HEAD

// Set number of cores, and debug for Flannery's machine
let numCores = parseInt(process.env.NUMCORES) || 1; // minumum 1 core
if (process.env.USER === 'flannery') { numCores = 4; }
=======
const pageOpts = { scale: 1.0 }; // match screen scale
const landscapePageCSS = "@page { size: letter landscape; }";
const portraitPageCSS = "@page { size: letter portrait;  }";

// Set number of cores, and debug for Flannery's machine
let numCores = parseInt(process.env.NUMCORES) || 1; // minumum 1 core
if (process.env.USER === "flannery") {
  numCores = 4;
}
>>>>>>> master

async function HtmlToPdf(htmlFileSpecs) {
  const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // use one page per worker
<<<<<<< HEAD
    maxConcurrency: numCores,              // cluster with NUMCORES workers
    monitor: true,                         // show the cluster's progress
=======
    maxConcurrency: numCores, // cluster with NUMCORES workers
    monitor: true, // show the cluster's progress
    args: ["--font-render-hinting=medium"], // force font width to be something reasonable
>>>>>>> master
  });

  // task : BrowserTab, htmlFileSpec -> PDF
  await cluster.task(async ({ page, data: htmlFileSpec0 }) => {
    const htmlFileSpec = JSON.parse(htmlFileSpec0);
<<<<<<< HEAD
=======
    const landscapeP = htmlFileSpec.aspect === "landscape";
>>>>>>> master
    const htmlFile = htmlFileSpec.input;
    let outputFile = htmlFileSpec.output;
    if (!outputFile) {
      //console.log('no output file spec for', htmlFile);
      outputFile = htmlFile.replace(/\.s?html$/, ".pdf");
    }
<<<<<<< HEAD
    const htmlPage = 'file:///' + workingDir + '/' + htmlFile;
    await page.emulateMediaType('print');
=======
    const htmlPage = "file:///" + workingDir + "/" + htmlFile;
    await page.emulateMediaType("print");
    await page.addStyleTag({
      content: landscapeP ? landscapePageCSS : portraitPageCSS,
    });
>>>>>>> master
    await page.goto(htmlPage, {
      waitUntil: "networkidle2", // wait for MathJax
      preferCSSPageSize: true,
      printBackground: true,
<<<<<<< HEAD
     });
    // match screen scale
    await page.pdf( { scale: 1.00, path: outputFile} );
=======
    });
    // add the orientation as a page option
    await page.pdf({ ...pageOpts, path: outputFile, landscape: landscapeP });
>>>>>>> master
  });

  // Queue up all the page options to be completed
  htmlFileSpecs.forEach((p) => cluster.queue(JSON.stringify(p)));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

HtmlToPdf(htmlFileSpecs)
  .then(() => {})
  .catch(console.error);
