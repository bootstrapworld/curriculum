const path = require('path');
const HtmlWebpackPlugin = require("html-webpack-plugin");

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
           'webpack/hot/dev-server',
         ],
  mode: 'development',
  output: {
    path: path.join(__dirname, 'distribution/en-us/lib/'),
    filename: 'bundle.js',
    clean: false,
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'distribution/en-us/'),
    },
    open: ['./courses'],
    hot: true,
    port:8080,
    liveReload: true,
    watchFiles: {
      paths: ['distribution/**/*.shtml', 'distribution/**/*.js'],
      options: {
        usePolling: true,
      }
    }
  },
  watchOptions: {
    aggregateTimeout: 600,
    ignored: '**/node_modules',
    poll: 1000
  },
  target: ["web"],
  //plugins: [new HtmlWebpackPlugin()],
};


