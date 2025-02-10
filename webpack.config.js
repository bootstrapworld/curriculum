const path = require('path');

module.exports = {
  entry: [ './distribution/en-us/lib/assessments.js',
           './distribution/en-us/lib/bootstraplesson.js',
           './distribution/en-us/lib/citations.js',
           './distribution/en-us/lib/codemirror.js',
           './distribution/en-us/lib/dependency-graph.js',
           './distribution/en-us/lib/images.js',
           './distribution/en-us/lib/langtable.js',
           './distribution/en-us/lib/learningObjectives.js',
           './distribution/en-us/lib/pathway-tocs.js',
           './distribution/en-us/lib/pyret-mode.js',
           './distribution/en-us/lib/runmode.js',
           './distribution/en-us/lib/scheme2.js',
           './distribution/en-us/lib/starterFiles.js',
           // './distribution/en-us/lib/callAdoc.js',
           // './distribution/en-us/lib/html2pdf.js',
           // './distribution/en-us/lib/makeWorkbook.js',
           // './distribution/en-us/lib/spellcheck.js',
         ],
  mode: 'development',
  output: {
    clean: true
  },
  devServer: {
    static: './dist',
    open: true
  },
  watch: true,
  watchOptions: {
    aggregateTimeout: 600,
    ignored: '**/node_modules',
    poll: 1000
  }
};
