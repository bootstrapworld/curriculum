var fs = require('fs');
var Spellchecker = require('hunspell-spellchecker');
var spellchecker = new Spellchecker();

var inputFilename = process.argv[2];

var DICT = spellchecker.parse({
  aff: fs.readFileSync('./shared/langs/en-us/hunspell/index.aff'),
  dic: fs.readFileSync('./shared/langs/en-us/hunspell/index.dic')
});

const isRacketAttr = w => w.startsWith('#:');
const removeFormatting = w => w
  .replace(/^[\']/g , "")
  .replace( /[\']$/g, "");
const isNumber = w => w.match(/^-?\d+(\.\d{1,2})?(%|in|em|ex|px){0,1}?$/) || false;

spellchecker.use(DICT);

process.stdin.setEncoding('utf8');
process.stdin.pause();
let corpus = "";

process.stdin.on('readable', (chunk) => {
  while ((chunk = process.stdin.read()) !== null) {
    corpus += chunk;
  }
});

process.stdin.on('end', () => {
  // break the remaining text into words, and filter out 
  // stuff we shouldn't spellcheck
  const words = corpus.toString()
    .split(/\s+|[;.,!?()<>{}\[\]"=\\\/+\|\-\:]/);
  const uniqueWords = [...new Set(words)];
  const cleanedWords = uniqueWords
    .map(removeFormatting)
    .filter(w => w.length > 0)
    .filter(w => !isNumber(w))

  // console.log('@cleaned words', JSON.stringify(cleanedWords))
  // collect all words for which the spellchecker fails
  misspellings = cleanedWords.reduceRight( 
    (acc, w) => spellchecker.check(w)? acc : acc.concat([w]), []);
  if(misspellings.length > 0) {
    console.log('WARNING:', inputFilename, 
      'may have spelling errors in the following words: ',
      [...new Set(misspellings)].sort().join(", "));
  }
});
