const fs = require("fs");
const { PDFDocument, rgb, degrees } = require("pdf-lib");

const prefix = process.env["TOPDIR"] + "/distribution/" + process.env["LANGUAGE"] +
  "/courses/" + process.env["TGTPATHWAY"];

const cachedPrefix = prefix + "/.cached/.filelist-";

bmContractsFiles = require(cachedPrefix + "bm-contracts.json").fileList.slice(1);
bmContractsSolsFiles = require(cachedPrefix + "bm-contracts-sols.json").fileList.slice(1);
optExercisesFiles = require(cachedPrefix + "opt-exercises.json").fileList.slice(1);
optExercisesSolsFiles = require(cachedPrefix + "opt-exercises-sols.json").fileList.slice(1);
workbookFiles = require(cachedPrefix + "workbook.json").fileList.slice(1);
workbookSolsFiles = require(cachedPrefix + "workbook-sols.json").fileList.slice(1);
workbookLongFiles = require(cachedPrefix + "workbook-long.json").fileList.slice(1);
workbookLongSolsFiles = require(cachedPrefix + "workbook-long-sols.json").fileList.slice(1);
//pdWorkbookFiles = require(cachedPrefix + "pd-workbook.json").fileList.slice(1);
//pdWorkbookLongFiles = require(cachedPrefix + "pd-workbook-long.json").fileList.slice(1);

const knownLongPages = [
  'flags-of-the-world-resource.pdf',
  'SavingImagesGuide.pdf',
  'infographics.pdf',
  'animation-worksheet.pdf',
  'image-contracts.pdf'
];

async function makeWorkbook(fileSpecList, pdfFile) {
  const pdfDoc = await PDFDocument.create();

  let pageNo = 0;
  let isRightHand = false;

  for (fileSpec of fileSpecList) {
    // Read the file
    const file = prefix + "/" + fileSpec.file;
    const bytes = fs.readFileSync(file);

    // Check that each PDF file has only one page
    const doc = await PDFDocument.load(bytes);
    const fileName = fileSpec.file.match(/[ \w-]+\.[\w]+/)[0];
    const pageCount = await doc.getPageCount();
    if(pageCount > 1 && !knownLongPages.includes(fileName)) {
      console.log(`WARNING: `,fileSpec.file,`has`, pageCount,`pages`);
    }

    // Compute dimensions and orientation
    isRightHand = !isRightHand;
    const page = pdfDoc.addPage();
    const [embedded] = await pdfDoc.embedPdf(bytes);
    const dimensions = embedded.scale(1.0);
    const isLandscape = dimensions.width > dimensions.height;

    const portrait = {
      x: page.getWidth() / 2 - dimensions.width / 2, // center on the page
      y: 55, // seems to give us a 0.5" top margin
    };

    const landscape = {
      x: isRightHand ? 20 + page.getWidth() : -20, // center on the page
      y: isRightHand ? 35 : page.getHeight(), // seems to give us a 0.5" top margin
      rotate: degrees(isRightHand ? 90 : -90),
    };

    // Draw the page based on computed settings
    const pageSettings = isLandscape ? landscape : portrait;
    page.drawPage(embedded, { ...dimensions, ...pageSettings });

    // Add page number
    const paginateP = fileSpec.paginate;
    if (paginateP) { pageNo++; }
    if (paginateP && pageNo > 1) {
      page.drawText(String(pageNo), {
        x:             page.getWidth() / 2,
        y:             35,
        size:          8,
        color:         rgb(0, 0, 0),
        rotateDegrees: isLandscape ? -90 : 0,
      });
    }
  }

  const pdfBytes = await pdfDoc.save();

  fs.writeFileSync(pdfFile, pdfBytes);
}

async function makeAllWorkbooks() {
  await makeWorkbook(bmContractsFiles, prefix + "/resources/pages/contracts.pdf");
  await makeWorkbook(bmContractsSolsFiles, prefix + "/resources/solution-pages/contracts.pdf");
  await makeWorkbook(optExercisesFiles, prefix + "/workbook/opt-exercises.pdf");
  await makeWorkbook(optExercisesSolsFiles, prefix + "/resources/protected/opt-exercises-sols.pdf");
  await makeWorkbook(workbookFiles, prefix + "/workbook/workbook.pdf");
  await makeWorkbook(workbookSolsFiles, prefix + "/resources/protected/workbook-sols.pdf");
  await makeWorkbook(workbookLongFiles, prefix + "/workbook/workbook-long.pdf");
  await makeWorkbook(workbookLongSolsFiles, prefix + "/resources/protected/workbook-long-sols.pdf");
  //await makeWorkbook(pdWorkbookFiles, prefix + "/resources/protected/pd-workbook.pdf");
  //await makeWorkbook(pdWorkbookLongFiles, prefix + "/resources/protected/pd-workbook-long.pdf");
}

makeAllWorkbooks()
  .then(() => {})
  .catch(console.error);
