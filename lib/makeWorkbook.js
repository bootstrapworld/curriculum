const topdir = process.env["TOPDIR"];
const prefix = topdir + "/" + process.env["COURSE_DIR"];
const cachedPrefix = prefix + "/.cached/.filelist-";
const makeMasterWorkbook = process.env["MASTERWORKBOOK"];

const fs = require("fs").promises;

const { romanize, makeWorkbook } = require(topdir + "/lib/bootstraplesson.js");
const pdfLib = require("pdf-lib");

optExercisesFiles     = require(cachedPrefix + "opt-exercises.json"     ).fileList.slice(1);
optExercisesSolsFiles = require(cachedPrefix + "opt-exercises-sols.json").fileList.slice(1);
workbookFiles         = require(cachedPrefix + "workbook.json"          ).fileList.slice(1);
workbookSolsFiles     = require(cachedPrefix + "workbook-sols.json"     ).fileList.slice(1);
workbookLongFiles     = require(cachedPrefix + "workbook-long.json"     ).fileList.slice(1);
workbookLongSolsFiles = require(cachedPrefix + "workbook-long-sols.json").fileList.slice(1);
if (makeMasterWorkbook) {
  pdWorkbookFiles = require(cachedPrefix + "pd-workbook.json").fileList.slice(1);
  // pdWorkbookLongFiles = require(cachedPrefix + "pd-workbook-long.json").fileList.slice(1);
}

async function makeWorkbookFromSpecList(specList, outputPath, longworkbook = false) {
  // extract the actual paths we care about
  const paths = specList.map(spec => topdir + "/" + spec.file);

  // call the core workbook generator
  const {path, bytes} = await makeWorkbook(
    pdfLib,
    process.env["COURSE_DIR"], 
    paths, 
    outputPath, 
    async (idx, path) => await fs.readFile(path), // onProcessPage: read the file
    longworkbook);

  const doc   = await pdfLib.PDFDocument.load(bytes);
  const pageCount = doc.getPageCount();

  // If it's a standard (non-empty) workbook, generate book and Lulu cover page
  if((outputPath == prefix+"/workbook/workbook.pdf") && (pageCount > 2)) {
    // Page dimensions in INCHES. Spine formula from
    // https://assets.lulu.com/media/guides/en/lulu-book-creation-guide.pdf
    const safety = 0.5, bleed = 0.125, spine = ((pageCount-2) / 444) + 0.06; 
    const coverWidth  = (bleed + 8.5) * 2 + spine;
    const coverHeight =     bleed     * 2 + 11.0;

    // Convert dimensions to PIXELS using 72dpi, and compute print settings
    const coverDoc = await pdfLib.PDFDocument.create();
    const cover = coverDoc.addPage([coverWidth * 72, coverHeight * 72]);
      
    // Read the cover files: frontCover is the first path, backCover is the last path
    const frontCover = await fs.readFile(paths[0]);
    const backCover  = await fs.readFile(paths[paths.length-1]);
    const [embeddedFront] = await coverDoc.embedPdf(frontCover);
    const [embeddedBack]  = await coverDoc.embedPdf(backCover);

    // Embed the cover pages at the specified locations
    const printSettings = {...embeddedFront.scale(1), y: bleed * 72}; // front/back are the same dimensions
    cover.drawPage(embeddedFront, { ...printSettings, x: 72 *  bleed                });
    cover.drawPage(embeddedBack,  { ...printSettings, x: 72 * (bleed + 8.5 + spine) });
    const coverBytes = await coverDoc.save();

    // write the page
    await fs.writeFile(prefix + "/workbook/cover.pdf", coverBytes);
  }
  // write the book
  await fs.writeFile(outputPath, bytes);
}

async function makeAllWorkbooks() {
  await makeWorkbookFromSpecList(optExercisesFiles, prefix + "/workbook/opt-exercises.pdf");
  await makeWorkbookFromSpecList(optExercisesSolsFiles, prefix + "/resources/protected/opt-exercises-sols.pdf");
  await makeWorkbookFromSpecList(workbookFiles, prefix + "/workbook/workbook.pdf");
  await makeWorkbookFromSpecList(workbookSolsFiles, prefix + "/resources/protected/workbook-sols.pdf");
  await makeWorkbookFromSpecList(workbookLongFiles, prefix + "/workbook/workbook-long.pdf", true);
  await makeWorkbookFromSpecList(workbookLongSolsFiles, prefix + "/resources/protected/workbook-long-sols.pdf", true);
  if (makeMasterWorkbook) {
    await makeWorkbookFromSpecList(pdWorkbookFiles, prefix + "/resources/protected/pd-workbook.pdf");
    // await makeWorkbook(pdWorkbookLongFiles, prefix + "/resources/protected/pd-workbook-long.pdf");
  }
}

makeAllWorkbooks()
  .then(() => {})
  .catch(console.error);
