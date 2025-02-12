const fs = require('fs');

const jsDir = process.argv[2];
const finalJsFile = process.argv[3];

if (fs.existsSync(finalJsFile)) {
  fs.unlinkSync(finalJsFile);
}

const varName = jsDir.replace(/^.*\//, '');

if (fs.existsSync(jsDir)) {
  // console.log('jsDir', jsDir, 'exists');
  let ff = fs.readdirSync(jsDir);
  // console.log('ff len is', ff.length);
  let everything = {};
  for (let i = 0; i < ff.length; i++) {
    let f = jsDir + '/' + ff[i];
    // console.log('f is', f);
    if (!f.match(/\.json$/)) { continue; }
    if (!fs.existsSync(f)) { continue; }
    // console.log('I');
    // f = f.replace(/\.js$/, '');
    // console.log('f now is', f);
    // console.log('II');
    let j = require(f);
    // console.log('file', f, 'returns', JSON.stringify(j));
    everything = { ...everything, ...j };
  }
  let jsonString = JSON.stringify(everything);
  fs.writeFileSync(finalJsFile, 
    `var ${varName} = ${jsonString};
     module.exports = { ${varName} : ${varName} }`);
}
