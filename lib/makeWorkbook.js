const fs = require("fs");
const { PDFDocument, rgb, degrees, PageSizes } = require("pdf-lib");

const topdir = process.env["TOPDIR"];

const prefix = topdir + "/" + process.env["COURSE_DIR"];

const cachedPrefix = prefix + "/.cached/.filelist-";

const makeMasterWorkbook = process.env["MASTERWORKBOOK"];

bmContractsFiles = require(cachedPrefix + "bm-contracts.json").fileList.slice(1);
bmContractsSolsFiles = require(cachedPrefix + "bm-contracts-sols.json").fileList.slice(1);
optExercisesFiles = require(cachedPrefix + "opt-exercises.json").fileList.slice(1);
optExercisesSolsFiles = require(cachedPrefix + "opt-exercises-sols.json").fileList.slice(1);
workbookFiles = require(cachedPrefix + "workbook.json").fileList.slice(1);
workbookSolsFiles = require(cachedPrefix + "workbook-sols.json").fileList.slice(1);
workbookLongFiles = require(cachedPrefix + "workbook-long.json").fileList.slice(1);
workbookLongSolsFiles = require(cachedPrefix + "workbook-long-sols.json").fileList.slice(1);
if (makeMasterWorkbook) {
  pdWorkbookFiles = require(cachedPrefix + "pd-workbook.json").fileList.slice(1);
  // pdWorkbookLongFiles = require(cachedPrefix + "pd-workbook-long.json").fileList.slice(1);
}

const knownLongPages = [
  'flags-of-the-world-resource.pdf',
  'SavingImagesGuide.pdf',
  'infographics.pdf',
  'animation-worksheet.pdf',
  'image-contracts.pdf',
  'pythag-practice.pdf',
  'dr-telephone.pdf',
];

function romanize (num) {
    if (isNaN(num))
        return NaN;
    var digits = String(+num).split(""),
        key = ["","c","cc","ccc","cd","d","dc","dcc","dccc","cm",
               "","x","xx","xxx","xl","l","lx","lxx","lxxx","xc",
               "","i","ii","iii","iv","v","vi","vii","viii","ix"],
        roman = "",
        i = 3;
    while (i--)
        roman = (key[+digits.pop() + (i * 10)] || "") + roman;
    return Array(+digits.join("") + 1).join("M") + roman;
}

async function makeLuluCover(frontCoverPath, backCoverPath) {
  const [coverWidth, coverHeight] = [17.6, 11.25];     // in inches, from lulu.com
  const [safety, bleed, spine] = [0.125, 0.5, 0.402];    // in inches, also from lulu.com

  // convert page dimensions and print settings using 72pt per inch
  const coverDoc = await PDFDocument.create();
  const cover = coverDoc.addPage([coverWidth * 72, coverHeight * 72]);
  const backSettings  = { x: safety * 72,                 y: safety * 72 };
  const frontSettings = { x: (safety + 8.5 + spine) * 72, y: safety * 72 };
    
  // read the files
  const frontCover = fs.readFileSync(topdir + "/" + frontCoverPath);
  const backCover  = fs.readFileSync(topdir + "/" + backCoverPath);
  const [embeddedFront] = await coverDoc.embedPdf(frontCover);
  const [embeddedBack]  = await coverDoc.embedPdf(backCover);
  const dimensions = embeddedFront.scale(1.0); // both front and back have the same dimensions, so just use one

  cover.drawPage(embeddedFront, { ...dimensions, ...frontSettings });
  cover.drawPage(embeddedBack,  { ...dimensions, ...backSettings });
  const coverBytes = await coverDoc.save();
  fs.writeFileSync(prefix + "/workbook/cover.pdf", coverBytes);  
}

async function makeWorkbook(fileSpecList, pdfFile, longworkbook = false) {

  // if it's the standard workbook, generate the cover page for Lulu
  // (check to make sure it's also not an EMPTY workbook)
  if(pdfFile == prefix+"/workbook/workbook.pdf" && fileSpecList.length > 0) {
    // Pass the filepaths for the first and last file in the SpecList
    makeLuluCover(fileSpecList[0].file, fileSpecList[fileSpecList.length-1].file);
  }

  let pageNo = 0;
  let backPageNo = 0;
  let backPageLetter = "";
  let isRightHand = true;
  const workbook = await PDFDocument.create();
  for (fileSpec of fileSpecList) {

    // Read the file
    const file = topdir + "/" + fileSpec.file;
    const bytes = fs.readFileSync(file);

    // Check that each PDF file has only one page
    const doc = await PDFDocument.load(bytes);
    const fileName = fileSpec.file.match(/[ \w-]+\.[\w]+/)[0];
    if (longworkbook) {
      const pageCount = await doc.getPageCount();

      if(pageCount > 1 && !knownLongPages.includes(fileName)) {
        console.log(`WARNING: in ${process.env["COURSE_DIR"]} ${pdfFile.split('/').pop()}, ${fileSpec.file} has ${pageCount} pages`);
      }
    }

    // handle back matter pages differently
    const isBackMatter = fileSpec.file.includes("back-matter");

    // Compute dimensions and orientation
    isRightHand = !isRightHand;
    const page = workbook.addPage(PageSizes.Letter);
    const [embedded] = await workbook.embedPdf(bytes);
    const dimensions = embedded.scale(1.0);
    const isLandscape = dimensions.width > dimensions.height;

    const portrait = {
      x: page.getWidth() / 2 - dimensions.width / 2, // center on the page
      y: 0, // seems to give us a 0.5" top margin
    };

    const landscape = {
      x: isRightHand || isBackMatter ? page.getWidth() : 0,  // seems to give us a 0.5" top margin
      y: isRightHand || isBackMatter ? 20 : 6 + page.getHeight(), // seems to give us a 0.5" top margin
      rotate: degrees(isRightHand || isBackMatter ? 90 : -90),
    };

    // Draw the page based on computed settings
    const pageSettings = isLandscape ? landscape : portrait;
    page.drawPage(embedded, { ...dimensions, ...pageSettings });

    // Add page number
    const paginateP = fileSpec.paginate;
    if (paginateP)    { pageNo++;     }
    if (isBackMatter) { backPageNo++; }
    if ((paginateP && pageNo > 1) || isBackMatter) {
      page.drawText(isBackMatter? romanize(backPageNo) : String(pageNo), {
        x:             page.getWidth() / 2,
        y:             35,
        size:          8,
        color:         rgb(0, 0, 0),
        rotateDegrees: isLandscape ? -90 : 0,
      });
    }
  }

  const pdfBytes = await workbook.save();

  fs.writeFileSync(pdfFile, pdfBytes);
}

async function makeAllWorkbooks() {
  await makeWorkbook(bmContractsFiles, prefix + "/resources/pages/contracts.pdf");
  await makeWorkbook(bmContractsSolsFiles, prefix + "/resources/solution-pages/contracts.pdf");
  await makeWorkbook(optExercisesFiles, prefix + "/workbook/opt-exercises.pdf");
  await makeWorkbook(optExercisesSolsFiles, prefix + "/resources/protected/opt-exercises-sols.pdf");
  await makeWorkbook(workbookFiles, prefix + "/workbook/workbook.pdf");
  await makeWorkbook(workbookSolsFiles, prefix + "/resources/protected/workbook-sols.pdf");
  await makeWorkbook(workbookLongFiles, prefix + "/workbook/workbook-long.pdf", true);
  await makeWorkbook(workbookLongSolsFiles, prefix + "/resources/protected/workbook-long-sols.pdf", true);
  if (makeMasterWorkbook) {
    await makeWorkbook(pdWorkbookFiles, prefix + "/resources/protected/pd-workbook.pdf");
    // await makeWorkbook(pdWorkbookLongFiles, prefix + "/resources/protected/pd-workbook-long.pdf");
  }
}

makeAllWorkbooks()
  .then(() => {})
  .catch(console.error);
