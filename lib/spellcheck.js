var fs = require('fs');
var Spellchecker = require('hunspell-spellchecker');
var spellchecker = new Spellchecker();

var inputFilename = process.argv[2];

var DICT = spellchecker.parse({
  aff: fs.readFileSync('./shared/langs/en-us/hunspell/index.aff'),
  dic: fs.readFileSync('./shared/langs/en-us/hunspell/index.dic')
});

spellchecker.use(DICT);

process.stdin.setEncoding('utf8');

process.stdin.on('data', (chunk) => {
  const words = chunk.toString().split(/\s+|[;.,!?()<>{}\[\]'"=\\\/+\|]/).filter((x) => x !== '');
    if (words.some( w => !spellchecker.check(w))) {
      console.log('WARNING:', inputFilename, 'may have spelling errors');
    }
});

