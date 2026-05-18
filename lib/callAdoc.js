import { convertFile } from 'asciidoctor'
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const adocFiles = require(process.argv[2]);
const TOPDIR = process.env.TOPDIR;
const NATLANG = process.env.NATLANG;

const stylesheetFile = `${TOPDIR}/distribution/${NATLANG}/lib/curriculum.css`;

const opts = {
  safe: 'unsafe',
  base_dir: process.cwd(),
  attributes: {
    linkcss: true,
    stylesheet: stylesheetFile,
    cachedir: '.cached/'
  }
};

Promise.all(adocFiles.map(file => convertFile(file, opts)))
  .then(() => process.exit());