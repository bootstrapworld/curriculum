const fs = require('fs');
const { PDFDocument } = require('pdf-lib');

const prefix = process.env['TOPDIR'] + '/distribution/' + process.env['LANGUAGE'] + '/courses/' + process.env['TGTPATHWAY'];

const cachedPrefix = prefix + '/.cached/.filelist-';

bmContractsFiles = require(cachedPrefix + 'bm-contracts.json').fileList.slice(1);
bmContractsSolsFiles = require(cachedPrefix + 'bm-contracts-sols.json').fileList.slice(1);
optExercisesFiles = require(cachedPrefix + 'opt-exercises.json').fileList.slice(1);
optExercisesSolsFiles = require(cachedPrefix + 'opt-exercises-sols.json').fileList.slice(1);
workbookFiles = require(cachedPrefix + 'workbook.json').fileList.slice(1);
workbookSolsFiles = require(cachedPrefix + 'workbook-sols.json').fileList.slice(1);
workbookLongFiles = require(cachedPrefix + 'workbook-long.json').fileList.slice(1);
workbookLongSolsFiles = require(cachedPrefix + 'workbook-long-sols.json').fileList.slice(1);
pdWorkbookFiles = require(cachedPrefix + 'pd-workbook.json').fileList.slice(1);
pdWorkbookLongFiles = require(cachedPrefix + 'pd-workbook-long.json').fileList.slice(1);


async function makeWorkbook(fileSpecList, pdfFile) {
  const pdfDoc = await PDFDocument.create();

  for (fileSpec of fileSpecList) {
    const file = prefix + '/' + fileSpec.file;
    //console.log('reading', fileSpec, file);
    const page = pdfDoc.addPage();
    const bytes = fs.readFileSync(file);
    const [embedded] = await pdfDoc.embedPdf(bytes);
    const dimensions = embedded.scale(1.0);
    const portrait = {
      x: (page.getWidth() / 2) - dimensions.width / 2,
      y: (page.getHeight() / 2) - dimensions.height / 2,
    };

    const pageSettings = portrait;

    page.drawPage(embedded, {...dimensions, ...pageSettings});
  }

    const pdfBytes = await pdfDoc.save();

  fs.writeFileSync(pdfFile, pdfBytes);

}

async function makeAllWorkbooks() {

  await makeWorkbook(bmContractsFiles, prefix + '/resources/pages/contracts.pdf');
  await makeWorkbook(bmContractsSolsFiles, prefix + '/resources/solution-pages/contracts.pdf');
  await makeWorkbook(optExercisesFiles, prefix + '/workbook/opt-exercises.pdf');
  await makeWorkbook(optExercisesSolsFiles, prefix + '/resources/protected/opt-exercises-sols.pdf');
  await makeWorkbook(workbookFiles, prefix + '/workbook/workbook.pdf');
  await makeWorkbook(workbookSolsFiles, prefix + '/resources/protected/workbook-sols.pdf');
  await makeWorkbook(workbookLongFiles, prefix + '/workbook/workbook-long.pdf');
  await makeWorkbook(workbookLongSolsFiles, prefix + '/resources/protected/workbook-long-sols.pdf');
  await makeWorkbook(pdWorkbookFiles, prefix + '/resources/protected/pd-workbook.pdf');
  await makeWorkbook(pdWorkbookLongFiles, prefix + '/resources/protected/pd-workbook-long.pdf');
}

makeAllWorkbooks().then( () => {} ).catch(console.error);
