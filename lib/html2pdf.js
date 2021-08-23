const puppeteer = require('puppeteer');

const aspect = process.argv[2];

const htmlFile = process.argv[3];

const workingDir = process.cwd();

const htmlPage = 'file:///' + workingDir + '/' + htmlFile;

const pdfFile = htmlFile.replace(/\.s?html$/, '.pdf');



let marginSpec = {
  top: '12.7mm',
  right: '12.7mm' 
}

if (aspect === 'portrait') {
  marginSpec = {...marginSpec, 
    bottom: '18mm', 
    left: '12.7mm'
  }
} else {
  marginSpec = {...marginSpec, 
    bottom: '12.7mm', 
    left: '18mm'
  }
}

let pageOptions = {
  path: pdfFile,
  format: 'a4',
  margin: marginSpec
}

if (aspect === 'landscape') {
  pageOptions = {...pageOptions,
    landscape: true
  }
}

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.emulateMediaType('print');
  await page.goto(htmlPage, {
    waitUntil: 'networkidle2',
  });
  await page.pdf(pageOptions);

  await browser.close();
})();

