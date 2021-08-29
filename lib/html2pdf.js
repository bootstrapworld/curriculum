const puppeteer = require('puppeteer');

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
};

let portraitPageOptions = {...pageOptions,
  margin: portraitMarginSpec
};

let landscapePageOptions = {...pageOptions,
  margin: landscapeMarginSpec,
  landscape: true
};

async function HtmlToPdf(portraitFiles, landscapeFiles) {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  for (let htmlFile of portraitFiles) {
    const htmlPage = 'file:///' + workingDir + '/' + htmlFile;
    const pdfFile = htmlFile.replace(/\.s?html$/, '.pdf');
    //console.log('converting', htmlFile, 'to', pdfFile);
    const pageOptions = portraitPageOptions;
    const pageOptions2 = {...pageOptions,
      path: pdfFile
    };
    await page.emulateMediaType('print');
    await page.goto(htmlPage, {
      waitUntil: 'networkidle2'
    });
    await page.pdf(pageOptions2);
  }
  for (let htmlFile of landscapeFiles) {
    const htmlPage = 'file:///' + workingDir + '/' + htmlFile;
    const pdfFile = htmlFile.replace(/\.s?html$/, '.pdf');
    //console.log('converting', htmlFile, 'to', pdfFile);
    const pageOptions = landscapePageOptions;
    const pageOptions2 = {...pageOptions,
      path: pdfFile
    };
    await page.emulateMediaType('print');
    await page.goto(htmlPage, {
      waitUntil: 'networkidle2'
    });
    await page.pdf(pageOptions2);
  }
  await browser.close();
}

HtmlToPdf(portraitFiles, landscapeFiles).then(console.log).catch(console.error)
