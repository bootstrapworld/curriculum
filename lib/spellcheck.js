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

const { added_words } = require('../shared/langs/en-us/hunspell/added-words.js');

const { ignored_words } = require('../shared/langs/en-us/hunspell/ignored-words.js');

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
    .split(/\s+|[;.,!?()<>{}\[\]"=\\\/+\|\-\:]/);
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
