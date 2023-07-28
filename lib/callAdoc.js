const cluster = require('cluster')

const adocFiles = require(process.argv[2]);

// console.log('numCores =', numCores);
// console.log('adocFilesLen =', adocFilesLen);

if (cluster.isMaster) {

  let numCores = parseInt(process.env.NUMCORES) || 1;

  const adocFilesLen = adocFiles.length;

  let splitSize = Math.ceil(adocFilesLen/numCores);

  for (let i = 0; i < numCores; i++) {

    (function (start) {
      cluster.fork({ start: start, finish: Math.min(start + splitSize, adocFilesLen) });
    })(i * splitSize);

  }

  // cluster.on('exit', () => {
  //   console.log('a process exited');
  // });

} else {
  const adoc = require('asciidoctor')();
  const workingDir = process.cwd();
  const stylesheetFile = '../lib/curriculum.css';

  async function workerTask() {
    for (let i = process.env.start; i < process.env.finish; i++) {
      let adocFile = adocFiles[i];
      // console.log('adocing ', adocFile);
      adoc.convertFile(adocFile, {
        safe: 'safe',
        base_dir: workingDir,
        attributes: {
          linkcss: true,
          stylesheet: stylesheetFile,
          cachedir: '.cached/'
        }
      });
    }
    return 'done';
  }

  workerTask().then(function(res) {
    // console.log('workerTask done');
    process.exit();
  });
  // console.log('did', process.env.start, 'to', process.env.finish);
  // process.exit();
}
