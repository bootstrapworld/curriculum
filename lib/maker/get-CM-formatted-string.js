const CodeMirror = require("codemirror/addon/runmode/runmode.node.js");
var args = process.argv.slice(2);
    console.log(CodeMirror.defineMode)
require('./../pyret-mode.js')

function getCodeString(language, code) {
    console.log(language, code);
    var html = "<pre class=\"cm-s-default\">\n";
    const outf = function(token, tokenClass) {
     html = html + "<span class=\"pm-" + tokenClass + "\">" + token + "</span>\n"
    }
    CodeMirror.runMode(code, language, outf);
    html = html + "</pre>\n";
    console.log(html)
}

getCodeString(...args);
