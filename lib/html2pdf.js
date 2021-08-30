const puppeteer = require('puppeteer');
const { Cluster } = require('puppeteer-cluster');

const portraitFiles = require(process.argv[2]).portrait;
const landscapeFiles = require(process.argv[3]).landscape;

portraitFiles.shift();
landscapeFiles.shift();

const workingDir = process.cwd();

let marginSpec = {
  top: '12.7mm',
  right: '12.7mm'
};

let portraitMarginSpec = {...marginSpec,
  bottom: '18mm',
  left: '12.7mm'
};

let landscapeMarginSpec = {...marginSpec,
  bottom: '12.7mm',
  left: '18mm'
};

let pageOptions = {
  format: 'letter',
  scale: 0.85
};

let portraitPageOpts = {...pageOptions,
  margin: portraitMarginSpec
};

let landscapePageOpts = {...pageOptions,
  margin: landscapeMarginSpec,
  landscape: true
};

async function HtmlToPdf(portraitFiles, landscapeFiles) {
  const cluster = await Cluster.launch({
    concurrency: Cluster.CONCURRENCY_PAGE, // use one page per worker
    maxConcurrency: parseInt(process.env.NUMCORES), // cluster with NUMCORES workers
    monitor: true,
  });
 
  const pages = [...portraitFiles, ...landscapeFiles];

  // Set print options and filepaths, then print the page
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
  pages.forEach(p => cluster.queue(p));

  // Wait for cluster to idle and close it
  await cluster.idle();
  await cluster.close();
}

HtmlToPdf(portraitFiles, landscapeFiles).then(console.log).catch(console.error)
