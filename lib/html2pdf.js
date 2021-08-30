const puppeteer = require('puppeteer');
const { Cluster } = require('puppeteer-cluster');

const portraitFiles = require(process.argv[2]).portrait;
const landscapeFiles = require(process.argv[3]).landscape;

portraitFiles.shift();
landscapeFiles.shift();

const workingDir = process.cwd();

// sSet margins for the portrait pages
let portraitPageOpts = {
  top:      '12.7mm',
  right:    '12.7mm',
  bottom:   '18.0mm', // extra space for page number
  left:     '12.7mm',
  format:   'letter',
  scale:    0.85,
};

// Landscape is mostly the same. Swap left/bottom margins
let landscapePageOpts = {...portraitPageOpts,
  bottom:   '12.7mm',
  left:     '18mm',
  landscape: true,
};

async function HtmlToPdf(portraitFiles, landscapeFiles) {
  const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // use one page per worker
    maxConcurrency: parseInt(process.env.NUMCORES), // cluster with NUMCORES workers
    monitor: true, // show the cluster's progress
  });
 
  // Assign a task: set print options and filepaths, then print the page
  await cluster.task(async ({page, data: htmlFile }) => {
    const opts = landscapeFiles.includes(htmlFile)? landscapePageOpts : portraitPageOpts;
    const htmlPage = 'file:///' + workingDir + '/' + htmlFile;
    const path = htmlFile.replace(/\.s?html$/, '.pdf');
    const p = { pageOptions: {...opts, path: path}, htmlPage: htmlPage };
    await page.emulateMediaType('print');
    await page.goto(p.htmlPage, { waitUntil: 'networkidle2' }); // wait for MathJax
    await page.pdf(p.pageOptions);
  });

  // Queue up all the page options to be completed
 const pages = [...portraitFiles, ...landscapeFiles];
 pages.forEach(p => cluster.queue(p));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

HtmlToPdf(portraitFiles, landscapeFiles).then(console.log).catch(console.error)
