var webpack = require('webpack');

module.exports = {
  entry: './web/static/js/app.js',
  output: {
    path: './priv/static/js',
    filename: 'bundle.js'
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin(),
  ],
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loaders: ['babel-loader'],
      },
      {
        test: /\.css$/,
        loader: 'style!css'
      }
    ]
  }
};
