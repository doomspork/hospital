var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: ['./web/static/js/app.js', './web/static/css/app.css'],
  output: {
    path: './priv/static',
    filename: 'js/app.js'
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin(),
    new ExtractTextPlugin('css/app.css')
  ],
  module: {
    loaders: [
      {
        test: /\.png$/,
        loader: "url-loader?limit=100000"
      },
      {
        test: /\.jpg$/,
        loader: "file-loader"
      },
      {
        test   : /\.woff|\.woff2|\.svg|.eot|\.ttf/,
        loader : 'url?prefix=font/&limit=10000'
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loaders: ['babel-loader']
      }, {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract('css')
      }
    ]
  }
};
