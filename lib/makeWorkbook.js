PDFLib  = require("pdf-lib");
fontkit = require('@pdf-lib/fontkit')
const graph        = require('./dependency-graph.js');

// If we're running via a node process...
const NODE_PROCESS = (typeof process !== "undefined");

// check to see if this script is being loaded in a browser pointed at a lesson
const loadedLesson = (typeof window !== "undefined") && window.location.pathname.includes('lessons')
const capitalizeFirst = (val) => String(val).charAt(0).toUpperCase() + String(val).slice(1);

const stripEmojis = (str) => str.replace(
  /([\u2700-\u27BF]|[\uE000-\uF8FF]|\uD83C[\uDC00-\uDFFF]|\uD83D[\uDC00-\uDFFF]|[\u2011-\u26FF]|\uD83E[\uDD10-\uDDFF])/g,
    '')
  .replace(/\s+/g, ' ')
  .trim();

function romanize(num) {
  if (isNaN(num)){ return NaN; }
  var digits = String(+num).split(""),
      key = ["","c","cc","ccc","cd","d","dc","dcc","dccc","cm",
             "","x","xx","xxx","xl","l","lx","lxx","lxxx","xc",
             "","i","ii","iii","iv","v","vi","vii","viii","ix"],
      roman = "",
      i = 3;
  while (i--) {
    roman = (key[+digits.pop() + (i * 10)] || "") + roman;
  }
  return Array(+digits.join("") + 1).join("M") + roman;
}

const knownLongPages = [
  'flags-of-the-world-resource.pdf',
  'SavingImagesGuide.pdf',
  'infographics.pdf',
  'animation-worksheet.pdf',
  'pythag-practice.pdf',
  'dr-telephone.pdf',
  'Contracts.pdf',
  'datasets-and-starter-files.pdf',
  'wip-project-stress-or-chill.pdf',
  'wip-project-Time-Use.pdf',
];

async function makeCustomBook(pathwayName, lessonList, opts) {
  const config = {
    "courseName": pathwayName,
    "lessons": lessonList,
    "outputPath" : ""            
  }

  // turn on status DOM, and initialize progress bar
  const status   = document.getElementById('status');
  const label    = status.querySelector('label');
  const progress = status.querySelector('progress');   
  
  // calculate the pageList, and use it to set the progress bar
  const pageList = makePageList(config, opts);
  progress.max = pageList.length;
  status.style.display = "inline-block";

  // when reading a file, check to see if the progress bar needs updating
  async function readFile(url, idx) {
    if(!isNaN(idx)) { progress.value = idx + 1; }
    return await fetch(url).then((res) => res.arrayBuffer())
  }

  function showPDFAndCleanup(file, bytes) {
    status.style.display = "none";
    const blb = new Blob([ bytes ], {type: 'application/pdf'});
    const fileURL = window.URL.createObjectURL(blb);
    const w = window.open();
    const html = `<iframe src="${fileURL}" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>`;
    w.document.title = pathwayName + " - Student Workbook.pdf";
    w.document.write(`<title>${pathwayName} - StudentWorkbook.pdf</title> ${html}`);    
  }
  await makeBook(config, opts, "", readFile, showPDFAndCleanup)
}

function makePageList(config, options) {
  const { reqPages, optPages, solns } = options;
  let pages         = [];
  
  // defaults for custom workbooks, or books without their own cover
  const defaultCourseJSON = {
    "front-matter": [
      "lib/default-front-cover.pdf",
      "lib/default-attributes.pdf",
    ],
    "lessons": [],
    "back-matter": [
      "lib/default-back-cover.pdf",
    ],
    "outputPath" : ""
  };

  const courseJSON = { ...defaultCourseJSON, ...config };
  if (!courseJSON['back-matter'].some(p => p.includes('back-cover.pdf'))) {
    courseJSON['back-matter'].push("lib/default-back-cover.pdf");
  }
  let basePath;

  // add an array of front-matter specs
  pages.push(courseJSON["front-matter"].map(path => ({path: path, kind: "front-matter"})));

  // for each lesson, add an array of specs for main pages 
  // (required, handouts, and optional)
  courseJSON.lessons.forEach(l => {
    lessonPages = [];
    if(!graph[l]) throw `could not find lesson ${l}`;
    if(reqPages) { 
      lessonPages.push(graph[l].pages.map(f => ({...f, kind:"required"})));
    }
    if(optPages) { 
      lessonPages.push(graph[l].handouts.map(f => ({...f, kind:"handouts"})));
      lessonPages.push(graph[l].optPages.map(f => ({...f, kind:"optional"})));
    }

    // If we're either running this from node, build a fully-qualified path
    if(NODE_PROCESS) {
      const paths  = require("path");
      basePath = paths.resolve(__dirname, "../distribution/", process.env["NATLANG"], `lessons/${l}`)+'/';
    } 
    // if we're running in a browser and on a lesson page, we're already IN the lesson folder
    else if(loadedLesson) {
      basePath = ""
    } 
    // if we're in a browser and on customPathway, build a path to the lesson folder
    else {
      basePath = `lessons/${l}/`;
    }

    // customize the path, pointing to pages or solution-pages
    lessonPages.flat().forEach(obj => 
      obj.path = `${basePath}${solns? "solution-" : ""}pages/${obj.fileName}`);
    pages.push(lessonPages);
  });

  // add an array of front-matter specs
  pages.push(courseJSON["back-matter"].map(path => ({path: path, kind: "back-matter"})));
  // flatten all the arrays and replace .adoc with .pdf
  return pages.flat(2).map(p => ({...p, path: p.path.replace('.adoc','.pdf')}));
}

// If it's a standard (non-empty) workbook, generate book and Lulu cover page
async function generateLuluCover(pageList, pageCount, outputPath, readFn, writeFn) {
   const { PDFDocument, PDFName, degrees, PageSizes } = PDFLib;

  // Covers are only needed for workbook.pdf, workbook-long.pdf,
  // and only if they contain more than 2 pages
  const coverNeeded = outputPath.match(/(.*)(workbook(-.*)*\.)pdf/)
  if(coverNeeded && (pageCount > 2)) {
    // Page dimensions in INCHES. Spine formula from
    // https://assets.lulu.com/media/guides/en/lulu-book-creation-guide.pdf
    const safety = 0.5, bleed = 0.125, spine = ((pageCount-2) / 444) + 0.06; 
    const coverWidth  = (bleed + 8.5) * 2 + spine;
    const coverHeight =     bleed     * 2 + 11.0;

    // Convert dimensions to PIXELS using 72dpi, and compute print settings
    const coverDoc = await PDFDocument.create();
    const cover = coverDoc.addPage([coverWidth * 72, coverHeight * 72]);
      
    // Read the cover files: frontCover is the first path, backCover is the last path
    const frontCover = await readFn(pageList[0].path);
    const backCover  = await readFn(pageList[pageList.length-1].path);
    const [embeddedFront] = await coverDoc.embedPdf(frontCover);
    const [embeddedBack]  = await coverDoc.embedPdf(backCover);

    // Embed the cover pages at the specified locations
    const printSettings = {...embeddedFront.scale(1), y: bleed * 72}; // front/back are the same dimensions
    cover.drawPage(embeddedFront, { ...printSettings, x: 72 * (bleed + 8.5 + spine) });
    cover.drawPage(embeddedBack,  { ...printSettings, x: 72 *  bleed                });
    const coverBytes = await coverDoc.save();

    // write the page
    await writeFn(coverNeeded[1] + "/cover-"+coverNeeded[2]+"pdf", coverBytes);
  }  
}

async function makeTOC(lessons, pdfDoc, font) {
  const { PDFDocument, PDFName, degrees, PageSizes } = PDFLib;
  
  const TOC    = pdfDoc.addPage(PageSizes.Letter);
  const { width, height } = TOC.getSize()
  let pageCount = 1;
  TOC.drawText("Table of Contents", {
    x: (width / 2) - 80,
    y: height - 80,
    size: 20,
    font: font,
  }); 
  lessons.forEach((l, i) => {
    const title = stripEmojis(graph[l].title); // trim emoji and leading spaces
    const pages = graph[l].pages.length;
    TOC.drawText(title, {
      x: 75,
      y: height - (120 + (i * 12)),
      size: 9,
      font: font,
    });
    TOC.drawText(String(pageCount), {
      x: width - 100,
      y: height - (120 + (i * 12)),
      size: 9,
      font: font,
    });
    pageCount += pages; 
  });
  return await pdfDoc.save();
}

async function makeCover(page, title, font) {
  const { PDFDocument, rgb } = PDFLib;

  let semester, year;
  if(NODE_PROCESS) { semester = process.env['SEMESTER'] }
  if(NODE_PROCESS) { year     = process.env['YEAR'] }
  
  // compute subtitle
  const seasonStr = `, ${capitalizeFirst(semester)} ${year}`;
  const subtitle = `Student Workbook` + (NODE_PROCESS? seasonStr : "");

  // font sizes for title and subtitle
  const titleSize    = 24;
  const subtitleSize = 16;

  // measure title and subtitle for centering
  titleWidth    = font.widthOfTextAtSize(title, titleSize)
  subtitleWidth = font.widthOfTextAtSize(subtitle, subtitleSize)

  // draw title and subtitle, centered on page
  const { width, height } = page.getSize()
  page.drawText(title, {
    size: titleSize, 
    color:  rgb(0.4, 0.4, 0.4), // 40% lighter than black
     x:   (width/2) - (titleWidth/2), 
     y:   height - 625,
//     font: font,
  }); 
  page.drawText(subtitle, {
    size:   subtitleSize, 
     x:     (width/2) - (subtitleWidth/2), 
     y:     height - (625 + titleSize + 1),
//     font: font,
  });
}

async function makeBook(courseJSON, opts, outputPath, readFn, writeFn) {
  const { PDFDocument, PDFName, degrees, PageSizes } = PDFLib;
  const { addTOC } = opts;
  
  // set font paths
  const latoPath = (loadedLesson? "../../" : "") + "lib/fonts/lato.medium.ttf";
  const notoPath = "https://www.1001fonts.com/download/font/noto-emoji.regular.ttf";
  const centuryPath = (loadedLesson? "../../" : "") + "lib/fonts/centurygothic.ttf";
  const centuryBPath = (loadedLesson? "../../" : "") + "lib/fonts/centurygothic_bold.ttf";

  // compute page pageList
  const pageList    = makePageList(courseJSON, opts)
  const customCover = addTOC && pageList[0].path.includes('default-front-cover');

  // initialize global state for making a workbook
  let isRightHand   = false;
  let mainPageCount = frontPageCount = backPageCount = 0;
  let pages         = [];

  // Make blanks PDF for the TOC and workbook, and embed our fonts into it
  const tocDoc    = await PDFDocument.create();
  const workbook  = await PDFDocument.create();
  const latoBytes = await readFn(latoPath);
  const centuryBytes = await readFn(centuryPath);
  const centuryBBytes= await readFn(centuryBPath);
  tocDoc.registerFontkit(fontkit);
  workbook.registerFontkit(fontkit);
  const lato = await tocDoc.embedFont(latoBytes, {subset: true});
  const century = await tocDoc.embedFont(centuryBytes, {subset: true});
  const centuryB = await tocDoc.embedFont(centuryBBytes, {subset: true});
  await workbook.embedFont(latoBytes, {subset: true});
  await workbook.embedFont(centuryBytes, {subset: true});
 
  // Iterate through pages, tracking page counts and warnings
  let warnings = [];
  for (const [idx, {path, kind}] of pageList.entries()) {

    // Read the file, calling readFn hook
    const bytes = await readFn(path, idx);

    // Load the file, prep the pages-to-be-copied, and check page count
    const doc = await PDFDocument.load(bytes);
    let pdfPages = await workbook.copyPages(doc, doc.getPageIndices());

    // Unless the file is whitelisted, truncate all PDFs to one page
    const fileName = path.match(/[ \w-]+\.[\w]+/)[0];
    if((pdfPages.length > 1) && !knownLongPages.includes(fileName)) {
      // save an abbreviated path (just the lesson, pages folder, and filename) to the file, 
      // along with the number of pages
      warnings.push({path: path.split('/').slice(-3).join('/'), length: pdfPages.length});
      pdfPages = pdfPages.splice(0, 1);
    }

    // For each page-to-be-copied, rotate and add page number
    // Insert the TOC before the first main page
    pdfPages.forEach(async page => {

      isRightHand = !isRightHand; // track which side of the book we're on

      // compute section counts and pageNum string
      if (kind == "front-matter") { ++frontPageCount; pageNum = "";      }
      if (kind == "back-matter" ) { pageNum = romanize(++backPageCount); }
      if (kind == "required"    ) { pageNum = ++mainPageCount;           }
      if (kind == "handout"     ) { pageNum = `(handout)`;               }
      if (kind == "optional"    ) { pageNum = `(optional page)`;         }

      // Rotate if it's landscape mode, and set pagenum opts for portrait or landscape
      const { width, height } = page.getSize()
      const isLandscape = width > height;
      if(isLandscape) { page.setRotation(degrees(isRightHand? 90 : -90)); }
      const portrait   = { x: width / 2, y: 26,         rotate: degrees(  0)}
      const landscapeL = { x: 26,        y: height / 2, rotate: degrees(-90)}
      const landscapeR = { x: width-26,  y: height / 2, rotate: degrees( 90)}

      // if we need a table of contents but don't have front-matter, then
      // we need to make a custom cover
      if((idx == 0) && customCover) {
        await makeCover(page, courseJSON.courseName, centuryB);
      }

      // If this is our first mainPage, add the table of contents to the book FIRST
      if(mainPageCount == 1 && addTOC) {
        let TOC   = await PDFDocument.load(await makeTOC(courseJSON.lessons, tocDoc, lato));
        const [TOCpage] = await workbook.copyPages(TOC, [0]);
        TOCpage.drawText(String(romanize(frontPageCount)), {size: 8, ...portrait}); 
        workbook.addPage(TOCpage);
        isRightHand = !isRightHand; // turn the page...
      }      
      
      // Add page number for main and back pages
      const opts = isLandscape? (isRightHand? landscapeR : landscapeL) : portrait;
      page.drawText(String(pageNum), {size: 8, ...opts}); 

      // Add the page to the workbook
      workbook.addPage(page);
    });
  }

  // Add page catalog (page numbers when viewed in PDF reader)
  //   Nums Format: [startIdx, pagination, startIdx, pagination...]
  // And save the PDF bytes
  const pageLabels = workbook.context.obj({
    Nums: [
      0,                           { S: 'a' }, // FRONT: a, b, c...
      frontPageCount,              { S: 'D' }, // MAIN:  1, 2, 3...
      frontPageCount+mainPageCount,{ S: 'r' }, // BACK:  i, ii, iii...
    ]
  });
  workbook.catalog.set(PDFName.of('PageLabels'), pageLabels);
  const pdfBytes = await workbook.save();

  // If we're saving this to a filesystem, generate the cover file for Lulu
  if(outputPath) await generateLuluCover(pageList, workbook.getPageCount(), outputPath, readFn, writeFn);

  // Write the bytes
  writeFn(outputPath, pdfBytes);

  // Return the warnings array
  return warnings;
}

// if we're in node, provide the module exports
if(typeof module !== 'undefined'){
  module.exports = {
    knownLongPages: knownLongPages,
  };
}
