const cm = require("codemirror/addon/runmode/runmode.node.js");
require('../pyret-mode.js');
require('../scheme2.js');

const [language] = process.argv.slice(2);

// the Map below is hand-copied from shared.less!!!
// it's SUPER BRITTLE, and I'm sure we can do better
const tokenClassMap = {
    /* WESCHEME STYLES */
    'cm-scheme-string':       'color: green;',
    'cm-scheme-number':       'color: blue;',
    'cm-scheme-boolean':      'color: darkred;',
    'cm-scheme-character':    'color: orange;',
    'cm-scheme-symbol':       'color: steelblue;',
    'cm-scheme-comment':      'color: #cd7054;',
    'cm-scheme-punctuation':  'color: black;',
    'cm-scheme-rparen':       'color: black;',
    /* PYRET STYLES */
    'cm-s-default.CodeMirror':'color: black;',
    'cm-comment':             'color: #cd7054;',
    'cm-boolean':             'color: darkred;',
    'cm-builtin':             'color: #555;',
    'cm-variable':            'color: #4d5966;',
    'cm-keyword':             'color: black; font-weight: bold;',
    'cm-number':              'color: navy;',
    'cm-roughnum':            'color: blue;',
    'cm-bad-number':          'color: red; font-weight: bold;',
    'cm-string':              'color: forestgreen;',
    'cm-type':                'color: #374049;',
    'cm-function-name':       'color: #374049;',
    'cm-unterminated-string': 'color: red; font-weight: bold;',
    'pyretkeyword':           'font-weight: bold; margin-right: 1ex;',
}

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

function extractFormattedCode(src, language) {
    process.stdin.on("data", src => {
        str = "";
        getTokens(src.toString(), language).forEach(({token, className}) => {
            // extract the css rules (if they exist), and add code font
            let css = tokenClassMap[className] || "";
            css += "font-family: Courier New";
            // newlines need to be doubled for md2googleslides to do the right thing
            if(token.includes("\n")) str += "\n\n";
            else str += `<span style="${css}">${token}</span>`;
            str += token;
        })
        process.stdout.write(str);
        process.exit(0);
    });
}

extractUnformattedCode(language);