var fs = require('fs');
var Spellchecker = require('hunspell-spellchecker');
var spellchecker = new Spellchecker();

var inputFilename = process.argv[2];

var DICT = spellchecker.parse({
  aff: fs.readFileSync('./shared/langs/en-us/hunspell/index.aff'),
  dic: fs.readFileSync('./shared/langs/en-us/hunspell/index.dic')
});

// In Sublime settings, the list of added_words and ignored_words
// are used to mean different things. In this context, however, they
// mean the same thing (ie - words to ignore). To make it easy to
// copy/paste back and forth between this file and sublime, they are
// kept separate here and merged programmatically.
const added_words = [ 
  // Products
  "Pyret",
  "pyret",
  "Pyret's",
  "WeScheme",
  "WeScheme's",
  "wescheme",
  "codap",
  "CODAP",
  "dataset",
  "autodesk",
  "Autodesk",
  "Desmos",
  "desmos",
  "PearDeck",
  "asciidoctor",
  "Infographic",
  "MathJax",
  // Names
  "Schanzer",
  "Fisler", "Kathi",
  "Sitaram", "Dorai",
  "Krishnamurthi", "Shriram",
  "Politz",
  "Flannery", 
  "Tabak", 
  "Pfenning",
  // Animals
  "Heathcliff", 
  "Miaulis", 
  "Nibblet", 
  "Bo", 
  "Kujo", 
  "Peanutbutter", 
  "Nori", 
  "Gir", 
  "Snowcone",
  // Words
  "Noticings",
  "Wonderings",
  "Makefile",
  "Boolean",
  "Booleans",
  "roleplay",
  "roleplaying",
  "rescale",
  "offscreen",
  "teachpack",
  "amongst",
  "ziti",
  "Ziti",
  "family’s",
  "teacher’s",
  "you’ve",
  "doesn’t",
  "isn’t",
  "doesn’t",
  "It’s",
  "it’s",
  "didn’t",
  "Didn't",
  "don’t",
  "Don’t",
  "we’ve",
  "We’ve",
  "they’ve",
  "They’ve",
  "they’re",
  "They’re",
  "character’s",
  "another's",
  "we’re",
  "We’re",
  "what’s",
  "What’s",
  "you’ll",
  "You’ll",
  "tech’s",
  "author’s",
  "wouldn’t",
  "aren’t",
  "We’ll",
  "hasn’t",
  "player’s",
  "Intelligences",
  "Gmail",
  "shorthands",
  "Where'd",
  "chatbot",
  "Frayer",
  "scaffolded",
  "datapoint",
  "PEMDAS",
  "pemdas",
  "parens",
  "Customizations",
  "x's",
  "y's",
  "Covid",
  "exponentials",
  "logarithmically",
  "datapoints",
  "pre",
  "kinesthetic",
  "ungrouped",
  "overlayed",
  "Maths",
  "lookups",
  "accessors",
  "accessor",
  "Infographics",
  "skewness",
  "glyphs",
  "infographics",
  "infographic",
  "someone’s",
  "unimodal",
  "clownfish",
  "capita",
  "olympics",
  "monospace",
  "videogame",
  "dataypes",
  "linkInstructions",
  "Roboto",
  "unclosed",
  "autonum",
  "Piecewise",
  "middle"
];

const ignored_words = [
  // Technical terms
  "Posn",
  "Posns",
  "Q1",
  "Q2",
  "Q3",
  "Q4",
  "activitybuilder",
  "adoc",
  "autonum",
  "autosuggest",
  "circleevalsexp",
  "classname",
  "codetwo",
  "coe",
  "desmosbutton",
  "dr",
  "dropdown",
  "dropdowns",
  "editbox",
  "elt",
  "fieldset",
  "fitb",
  "fitbruby",
  "frac",
  "functions2",
  "gif",
  "hspace",
  // Directives and Classnames
  "html",
  "http",
  "https",
  "ifnotslide",
  "ifpathway",
  "ifproglang",
  "ifslide",
  "ifsoln",
  "img",
  "indentedpara",
  "jpeg",
  "jpg",
  "js",
  "lang",
  "listingblock",
  "lua",
  "mathunicode",
  "mbox",
  "overline",
  "pdf",
  "png",
  "postproc",
  "postproc",
  "preproc",
  "prereqs",
  "proglang",
  "readonly",
  "sect2",
  "shtml",
  "slidebreak",
  "slidestyle",
  "smath",
  "soln",
  "td",
  "url",
  "usp",
  "vspace",
  "www",
  "png",
  "jpg",
  "gif",
  "frac",
  "^",
  "https",
  "multi",
  "FillVerticalSpace",
  "R^2",
  "qquad",
  "textit",
  "textbf",
  "#footer", 
  "StudentWorkbook",
  "Schoology",
  "viewport",
  "domcontentloaded",
  "networkidle0",
  "json",
  "lr",
  "grade8",
  "grade7",
  "grade6",
  "grade5",
  "ok"
];

const doNotCheck = w => added_words.concat(ignored_words).includes(w);
const isDirective = w => w.startsWith('@');
const isRacketAttr = w => w.startsWith('#:');
const isAsciiDocFormatting = w => 
  w.match(/^[\^|<\>]{0,1}(\.[\^|<\>]){0,1}\da{0,1}/) //table formatting;
const isCharacterCode = w => w.match(/^[a-z]&#\d+/);
const removeFormatting = w => w
  .replace(/^[\$\*\`\'\_\:\≈\&”“\#]{1}/g , "")
  .replace( /[\$\*\_\`\'\:\≈\&”“\#]{1}$/g, "")
  .replace("’", "'"); 
const isNumber = w => w.match(/^-?\d+(\.\d{1,2})?(%|in|em|ex|px){0,1}?$/) || false;

spellchecker.use(DICT);

process.stdin.setEncoding('utf8');

process.stdin.on('data', (chunk) => {

  // remove any style, script, @math{...}, or @show{...} content
  chunk = chunk.replace( /<style[^>]*>([\s\S]*?)style>/g,  "");
  chunk = chunk.replace(/<script[^>]*>([\s\S]*?)script>/g, "");
  chunk = chunk.replace(/@math{[^}]*}/g, "");
  chunk = chunk.replace(/@show{[^}]*}/g, "");

  // break the remaining text into words, and filter out 
  // stuff we shouldn't spellcheck
  const words = chunk.toString()
    .split(/\s+|[;.,!?()<>{}\[\]"=\\\/+\|\-]/);
  const uniqueWords = [...new Set(words)];
  const cleanedWords = uniqueWords
    .map(removeFormatting)
    .filter(w => w.length > 0)
    .filter(w => !(doNotCheck(w) || isDirective(w) || isRacketAttr(w) || isNumber(w)
                  || isAsciiDocFormatting(w) || isCharacterCode(w)));

  // collect all words for which the spellchecker fails
  const misspellings = cleanedWords.reduceRight( 
    (acc, w) => spellchecker.check(w)? acc : acc.concat([w]), []);

  if(misspellings.length > 0) {
    console.log('WARNING:', inputFilename, 
      'may have spelling errors in the following words: ',
      misspellings.join(", "));
  }
});
