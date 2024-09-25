const fs = require('fs');

const jsDir = process.argv[2];
const finalJsFile = process.argv[3];

if (fs.existsSync(finalJsFile)) {
  fs.unlinkSync(finalJsFile);
}

if (fs.existsSync(jsDir)) {
  // console.log('jsDir', jsDir, 'exists');
  let ff = fs.readdirSync(jsDir);
  // console.log('ff len is', ff.length);
  let allStarterFiles = {};
  for (let i = 0; i < ff.length; i++) {
    let f = jsDir + '/' + ff[i];
    // console.log('f is', f);
    if (!f.match(/\.js$/)) { continue; }
    if (!fs.existsSync(f)) { continue; }
    // console.log('I');
    f = f.replace(/\.js$/, '');
    // console.log('f now is', f);
    // console.log('II');
    let j = require(f);
    // console.log('file', f, 'returns', JSON.stringify(j));
    allStarterFiles = { ...allStarterFiles, ...j };
  }
  let jsonString = JSON.stringify(allStarterFiles);
  fs.writeFileSync(finalJsFile, 'var starterFiles = ' +
    jsonString + ';\n');
}
