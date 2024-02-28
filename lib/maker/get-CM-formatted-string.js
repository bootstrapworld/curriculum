const cm = require("codemirror/addon/runmode/runmode.node.js");
require('../pyret-mode.js');
require('../scheme2.js');

const [language] = process.argv.slice(2);

function getTokens(src, language) {
    var tokens = [];
    const outf = function(token, tokenClass) {
     tokens.push({token: token, className: 'cm-'+tokenClass});
    }
    cm.runMode(src, language, outf);
    return tokens;
}

function extractUnformattedCode(language) {
    process.stdin.on("data", src => {
        str = "";
        getTokens(src.toString(), language).forEach(({token, className}) => {
            console.log('str=', str)
            str += token;
        })
        console.log('output=', str)
        process.stdout.write(str);
        process.exit(0);
    });
}

extractUnformattedCode(language);