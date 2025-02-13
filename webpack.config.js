const path = require('path');
const WebpackShellPluginNext = require('webpack-shell-plugin-next');
const WatchExternalFilesPlugin = require('webpack-watch-external-files-plugin');
const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
  mode: 'development',
  devtool: 'source-map',
  optimization: {
    minimize: true,
    moduleIds: 'named',
    minimizer: [
      new TerserPlugin({
        // TODO(consider options)
      })
    ],
  },

  // The only file we should be worrying about is bootstraplesson.js
  // It will need to be rewritten to use proper module syntax
  entry: { 
    printing: './distribution/en-us/lib/makeWorkbook.js',
    main: './distribution/en-us/lib/bootstraplesson.js',
  },

  // When compiled, the output should go to distribution/en-us/lib/
  output: {
    path: path.join(__dirname, 'distribution/en-us/lib/'),
    filename: '[name].bundle.js',
    clean: false,
    libraryTarget: 'var',
    library: ['Bootstrap', '[name]']
  },

  // Run the devServer on distribution/en-us/, and open the browser to the courses folder
  devServer: {
    static: {
      directory: path.join(__dirname, 'distribution/en-us'),
    },
    open: ['./courses'],
    port:8080,
  },
  target: "web",

  // Watch any of our src files for changes, and run make before webpack-ing
  plugins: [
    new WatchExternalFilesPlugin({
      files: ['./lessons/**/*.adoc', './pathways/**/*.adoc', './shared/**/*.json'],
    }),
    new WebpackShellPluginNext({
      //onBeforeCompile: {scripts: ['make'], blocking: true },
    }),
  ],
};


