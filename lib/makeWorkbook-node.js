const makeMasterWorkbook = process.env["MASTERWORKBOOK"]; // adds lesson plans (unused)
const topdir = process.env["TOPDIR"];
prefix = topdir + "/" + process.env["COURSE_DIR"];
const { knownLongPages, makeBook } = require(`../distribution/${process.env["NATLANG"]}/lib/makeWorkbook.js`);

async function makeAllWorkbooks(config) {
  const fs     = require("fs").promises;
  let warnings = [];
  let opts;

  // *this* reader will only be run from within lib/, so we need to back out one level
  reader = async (path, _)     => await fs.readFile(path); 
  writer = async (path, bytes) => await fs.writeFile(path, bytes); 

  // required pages ONLY, with and without solutions - no handouts
  opts = { reqPages: true, optPages: false, solns: false, addTOC: true }
  warnings.push(await makeBook(config, opts, prefix + "/workbook/workbook.pdf", reader, writer));
  opts = { reqPages: true, optPages: false, solns: true, addTOC: true }
  warnings.push(await makeBook(config, opts, prefix + "/resources/protected/workbook-sols.pdf", reader, writer));

  // optional pages ONLY, with and without solutions - no handouts
  opts = { reqPages: false, optPages: true, solns: false, addTOC: true }
  warnings.push(await makeBook(config, opts, prefix + "/workbook/opt-exercises.pdf", reader, writer));
  opts = { reqPages: false, optPages: true, solns: true, addTOC: true }
  warnings.push(await makeBook(config, opts, prefix + "/resources/protected/opt-exercises-sols.pdf", reader, writer));

  // all pages, with and without solutions - no handouts
  opts = { reqPages: true, optPages: true, solns: false, addTOC: true }
  warnings.push(await makeBook(config, opts, prefix + "/workbook/workbook-long.pdf", reader, writer));
  opts = { reqPages: true, optPages: true, solns: true, addTOC: true }
  warnings.push(await makeBook(config, opts, prefix + "/resources/protected/workbook-long-sols.pdf", reader, writer));

  const uniqueWarnings = new Set(warnings.flat(2).map( ({path, length}) => 
    `WARNING: ${path} has ${length} pages`));
  if(uniqueWarnings.size > 0) {
    console.warn(`\nIn the ${process.env["COURSE_DIR"]} workbook...`);
    [...uniqueWarnings].sort().forEach( w => console.warn(w));
  }
}

function makeBooksFromConfigFile(path) {
  const config = require(prefix + "/.cached/.new-workbook-page-index.json");
  makeAllWorkbooks(config)
    .then(() => {})
    .catch(console.error);
};

if(process.env["COURSE_DIR"]) makeBooksFromConfigFile(prefix)

  module.exports = { makeBooksFromConfigFile: makeBooksFromConfigFile }