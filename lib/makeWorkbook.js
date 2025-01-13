const topdir = process.env["TOPDIR"];
const prefix = topdir + "/" + process.env["COURSE_DIR"];
const cachedPrefix = prefix + "/.cached/.filelist-";
const makeMasterWorkbook = process.env["MASTERWORKBOOK"];
const graph = require(topdir + "/distribution/en-us/dependency-graph.js");
const fs = require("fs").promises;

const { romanize, makeWorkbook, configureGraph } = require(topdir + "/lib/bootstraplesson.js");
const pdfLib = require("pdf-lib");

// defaults for custom workbooks, or books without their own logo
const defaultCourseJSON = {
  "front-matter": [
    "distribution/en-us/courses/TODO/front-matter/pages/front-cover.pdf",
    "distribution/en-us/courses/TODO/front-matter/pages/attributes.adoc",
  ],
  "lessons": [],
  "longWorkbook" : false,
  "optExercises" : false,
  "back-matter": [
     "distribution/en-us/courses/TODO/back-matter/pages/back-cover.pdf",
  ],
  "outputPath" : ""
};

optExercisesFiles     = require(cachedPrefix + "opt-exercises.json"     ).fileList.slice(1);
optExercisesSolsFiles = require(cachedPrefix + "opt-exercises-sols.json").fileList.slice(1);
workbookFiles         = require(cachedPrefix + "workbook.json"          ).fileList.slice(1);
workbookSolsFiles     = require(cachedPrefix + "workbook-sols.json"     ).fileList.slice(1);
workbookLongFiles     = require(cachedPrefix + "workbook-long.json"     ).fileList.slice(1);
workbookLongSolsFiles = require(cachedPrefix + "workbook-long-sols.json").fileList.slice(1);

async function makeWorkbookFromSpecList(specList, outputPath, longworkbook = false) {
  // extract the actual paths we care about
  const paths = specList.map(spec => topdir + "/" + spec.file);

  // call the core workbook generator
  const {path, bytes, warnings} = await makeWorkbook(
    pdfLib,
    process.env["COURSE_DIR"], 
    paths, 
    outputPath, 
    async (idx, path) => await fs.readFile(path), // onProcessPage: read the file
    false,
    longworkbook);
  const doc   = await pdfLib.PDFDocument.load(bytes);
  const pageCount = doc.getPageCount();

  // If it's a standard (non-empty) workbook, generate book and Lulu cover page
  // Covers are needed for workbook.pdf, workbook-long.pdf
  const coverNeeded = outputPath.match(/(.*)(workbook(-.*)*\.)pdf/)

  if(coverNeeded && (pageCount > 2)) {
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
    cover.drawPage(embeddedFront, { ...printSettings, x: 72 * (bleed + 8.5 + spine) });
    cover.drawPage(embeddedBack,  { ...printSettings, x: 72 *  bleed                });
    const coverBytes = await coverDoc.save();

    // write the page
    await fs.writeFile(coverNeeded[1] + "/cover-"+coverNeeded[2]+"pdf", coverBytes);
  }
  // write the book
  await fs.writeFile(outputPath, bytes);
  return warnings;
}

// Given a series of booleans, generate a specList that allows 
// makeWorkbookFromSpecList to collate the pages into a single book
async function makeSpecList(requiredPages, optionalPages, solutions) {
  configureGraph(graph);
  let courseJSON = require(prefix + "/.cached/.new-workbook-page-index.json");
  courseJSON = {...defaultCourseJSON, ...courseJSON};
  let pageList = [];
  courseJSON["front-matter"].forEach((path,landscape) => pageList.push(path));

  // for each lesson:
  // Add the required pages and (if optional=true) the optional ones
  // Add the filepath. If solutions=true, use the solutions folder
  courseJSON["lessons"].forEach(l => {
    if(!graph[l]) throw "could not find lesson: "+l;
    const optPages = optionalPages? graph[l].optPages : [];
    const reqPages = requiredPages? graph[l].optPages : [];
    const paths = [...reqPages, ...optPages].map(({fileName, title}) => 
      `distribution/en-us/lessons/${l}/${(solutions? "solution-pages" : "pages")}/${fileName}`);
    pageList = pageList.concat(paths)
  });

  courseJSON["back-matter"].forEach((path,landscape) => pageList.push(path));

  // Replace ".adoc" with ".pdf"
  pageList = pageList.map(p => {
    if(!p) throw "@@p is undefined!"
    return {'file' : p.replace('.adoc', '.pdf'), 'paginate': false };
  });
  return pageList;
}

async function makeAllWorkbooks() {
  let warnings = [];
  // optional pages ONLY, with and without solutions
  warnings.push(await makeWorkbookFromSpecList(await makeSpecList(false, true, false), prefix + "/workbook/opt-exercises.pdf"));
  warnings.push(await makeWorkbookFromSpecList(await makeSpecList(false, true, true),  prefix + "/workbook/opt-exercises-sols.pdf"));
  // required pages ONLY, with and without solutions
  warnings.push(await makeWorkbookFromSpecList(await makeSpecList(true, false, false), prefix + "/workbook/workbook.pdf"));
  warnings.push(await makeWorkbookFromSpecList(await makeSpecList(true, false, true),  prefix + "/resources/protected/workbook-sols.pdf"));
  // all pages, with and without solutions
  warnings.push(await makeWorkbookFromSpecList(await makeSpecList(true, true, false),  prefix + "/workbook/workbook-long.pdf", true));
  warnings.push(await makeWorkbookFromSpecList(await makeSpecList(true, true, false),  prefix + "/resources/protected/workbook-long-sols.pdf", true));

  const uniqueWarnings = new Set(warnings.flat().map( ({path, length}) => 
    `WARNING: ${path} has ${length} pages`));
  if(uniqueWarnings.size > 0) {
    console.warn(`\nIn the ${process.env["COURSE_DIR"]} workbook...`);
    [...uniqueWarnings].sort().forEach( w => console.warn(w));
  }
}

makeAllWorkbooks()
  .then(() => {})
  .catch(console.error);
