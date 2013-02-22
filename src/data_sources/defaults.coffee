url = require 'url'

@types =
  'node-wiki/data_sources/git': (urlParts) -> /\.git$/.test urlParts.path

