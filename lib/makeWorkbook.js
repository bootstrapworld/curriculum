const topdir = process.env["TOPDIR"];
const prefix = topdir + "/" + process.env["COURSE_DIR"];
const cachedPrefix = prefix + "/.cached/.filelist-";
const makeMasterWorkbook = process.env["MASTERWORKBOOK"];

const fs = require("fs");
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

async function makeLuluCover(frontCoverPath, backCoverPath) {

  const [coverWidth, coverHeight] = [17.98, 11.188];  // in inches, from lulu.com
  const [safety, bleed, spine] = [0.5, 0.125, 0.787];  // in inches, also from lulu.com

  // convert page dimensions and print settings using 72pt per inch
  const coverDoc = await pdfLib.PDFDocument.create();
  const cover = coverDoc.addPage([coverWidth * 72, coverHeight * 72]);
  const backSettings  = { x: safety * 72,                 y: safety * 72 };
  const frontSettings = { x: (safety + 8.5 + spine) * 72, y: safety * 72 };
    
  // read the files
  const frontCover = fs.readFileSync(frontCoverPath);
  const backCover  = fs.readFileSync(backCoverPath);
  const [embeddedFront] = await coverDoc.embedPdf(frontCover);
  const [embeddedBack]  = await coverDoc.embedPdf(backCover);
  const dimensions = embeddedFront.scale(1.0); // both front and back have the same dimensions, so just use one

  cover.drawPage(embeddedFront, { ...dimensions, ...frontSettings });
  cover.drawPage(embeddedBack,  { ...dimensions, ...backSettings });
  const coverBytes = await coverDoc.save();
  fs.writeFileSync(prefix + "/workbook/cover.pdf", coverBytes);  
}

async function makeWorkbookFromSpecList(specList, outputPath, longworkbook = false) {
  // extract the actual paths we care about
  const paths = specList.map(spec => topdir + "/" + spec.file);

  // if it's the standard workbook, generate the cover page for Lulu
  // (check to make sure it's also not an EMPTY workbook)
  if(outputPath == prefix+"/workbook/workbook.pdf" && paths.length > 0) {
    // Pass the paths for the front cover (first) and back cover (last)
    makeLuluCover(
      paths[0], 
      paths[paths.length-1]);
  }
  // call the core workbook generator
  makeWorkbook(
    pdfLib,
    process.env["COURSE_DIR"], 
    paths, 
    outputPath, 
    async (idx, path) => await fs.readFileSync(path), // onProcessPage: read the file
    async (file, bytes) => await fs.writeFileSync(file, bytes), // onDone: save file
    longworkbook);
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
