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
  "Schoology",
  "viewport",
  "domcontentloaded",
  "networkidle0",
  "json",
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
];

const doNotCheck = [...added_words, ignored_words];

spellchecker.use(DICT);

process.stdin.setEncoding('utf8');

process.stdin.on('data', (chunk) => {
  // break the text into words, and filter out words we shouldn't check
  const words = chunk.toString()
    .split(/\s+|[;.,!?()<>{}\[\]'"=\\\/+\|]/).filter((x) => x !== '')
    .filter(w => !doNotCheck.includes(w));

  // if some remaining word fails to spellcheck, warn the user
  if (words.some( w => !spellchecker.check(w))) {
    console.log('WARNING:', inputFilename, 'may have spelling errors');
  }
});


