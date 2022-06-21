const puppeteer = require("puppeteer");
const { Cluster } = require("puppeteer-cluster");

// construct the array of pages from passed args
const htmlFileSpecs = require(process.argv[2]).htmlFileSpecs;
htmlFileSpecs.shift();

// constants that are used in the PDF conversion
const workingDir = process.cwd();
const pageOpts = { scale: 1.0 }; // match screen scale
const landscapePageCSS = "@page { size: letter landscape; }";
const portraitPageCSS = "@page { size: letter portrait;  }";

// Set number of cores, and debug for Flannery's machine
let numCores = parseInt(process.env.NUMCORES - 1) || 1; // minumum 1 core
if (process.env.USER === "flannery") {
  numCores = 4;
}

async function HtmlToPdf(htmlFileSpecs) {
  const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // maximize sharing data between jobs
    maxConcurrency: numCores, // cluster with NUMCORES workers
    monitor: true, // show the cluster's progress
    args: ["--font-render-hinting=medium"], // force font width to be something reasonable
  });

  // Event handler to be called in case of problems
  cluster.on('taskerror', (err, data) => {
      console.log(`Could not load ${data}: ${err.message}`);
  });

  // task : BrowserTab, htmlFileSpec -> PDF
  await cluster.task(async ({ page, data: htmlFileSpec0 }) => {
    const htmlFileSpec = JSON.parse(htmlFileSpec0);
    const landscapeP = htmlFileSpec.aspect === "landscape";
    const htmlFile = htmlFileSpec.input;
    let outputFile = htmlFileSpec.output;
    if (!outputFile) {
      //console.log('no output file spec for', htmlFile);
      outputFile = htmlFile.replace(/\.s?html$/, ".pdf");
    }
    const htmlPage = "file:///" + workingDir + "/" + htmlFile;
    await page.emulateMediaType("print");
    await page.addStyleTag({
      content: landscapeP ? landscapePageCSS : portraitPageCSS,
    });

    await page.goto(htmlPage, {
      waitUntil: "networkidle2", // wait for MathJax
      preferCSSPageSize: true,
      printBackground: true,
    });

    // tell puppeteer to wait until window.status is anything
    // OTHER than "not_ready_to_print". If MathJax is used on
    // the page, this flag will have been set to block printing
    // until math rendering is complete.
    await page.waitForFunction('window.status !== "not_ready_to_print"');

    // If MathJax is defined, we queue an action for MathJax 
    // to execute after it's done rendering, whihch is to
    // change window.status to literally *anything* else
    await page.evaluate(async () => {
      if(window.MathJax) { 
        window.MathJax.Hub.Queue(
          () => window.status="MathJax Complete!"
        )
      }
    });
  
    // add the orientation as a page option
    await page.pdf({ ...pageOpts, path: outputFile, landscape: landscapeP });
  });

  // Queue up all the page options to be completed
  // Ignore gdrive-import pages
  htmlFileSpecs
    .filter(p => !p.input.includes("gdrive-import"))
    .forEach((p) => cluster.queue(JSON.stringify(p)));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

HtmlToPdf(htmlFileSpecs)
  .then(() => {})
  .catch(console.error);
