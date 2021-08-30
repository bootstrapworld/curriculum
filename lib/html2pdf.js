const puppeteer = require('puppeteer');
const { Cluster } = require('puppeteer-cluster');

// construct the array of pages from passed args
const portraitFiles = require(process.argv[2]).portrait;
const landscapeFiles = require(process.argv[3]).landscape;
portraitFiles.shift();
landscapeFiles.shift();
const pages = [...portraitFiles, ...landscapeFiles];

// constants that are used in the PDF conversion
const workingDir = process.cwd();
const pageOpts = { scale: 0.75 }; // match the old wkhtmltopdf scale
const landscapePageCSS = "@page { size: 8.5in 11in landscape; }";
const portraitPageCSS  = "@page { size: 8.5in 11in portrait;  }";

async function HtmlToPdf(portraitFiles, landscapeFiles) {
  const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // use one page per worker
    maxConcurrency: parseInt(process.env.NUMCORES), // cluster with NUMCORES workers
    monitor: true, // show the cluster's progress
  });
 
  // task : BrowserTab, FileName -> PDF
  await cluster.task(async ({page, data: htmlFile }) => {
    const landscapeP = landscapeFiles.includes(htmlFile);
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
    await page.pdf( { ...p.pageOptions, landscape:landscapeP } );
  });

  // Queue up all the page options to be completed
 pages.forEach(p => cluster.queue(p));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

HtmlToPdf(portraitFiles, landscapeFiles).then(() => {}).catch(console.error);
