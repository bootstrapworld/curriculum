import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const cluster = require('cluster');
const adocFiles = require(process.argv[2]);
const TOPDIR = process.env.TOPDIR;
const NATLANG = process.env.NATLANG;

if (cluster.isMaster) {
  const numCores = parseInt(process.env.NUMCORES) || 1;
  const adocFilesLen = adocFiles.length;
  const splitSize = Math.ceil(adocFilesLen / numCores);

  for (let i = 0; i < numCores; i++) {
    cluster.fork({
      start: i * splitSize,
      finish: Math.min((i + 1) * splitSize, adocFilesLen)
    });
  }
} else {
  const { convertFile } = await import('asciidoctor');
  const workingDir = process.cwd();
  const stylesheetFile = `${TOPDIR}/distribution/${NATLANG}/lib/curriculum.css`;

  const opts = {
    safe: 'unsafe',
    base_dir: workingDir,
    attributes: {
      linkcss: true,
      stylesheet: stylesheetFile,
      cachedir: '.cached/'
    }
  };

  const chunk = adocFiles.slice(process.env.start, process.env.finish);
  await Promise.all(chunk.map(file => convertFile(file, opts)));
  process.exit();
};