url = require 'url'

@types =
  'node-wiki/data_sources/git': (urlParts) -> /\.git$/.test urlParts.href
  'node-wiki/data_sources/mongo': (urlParts) -> /^mongodb\:\/\//.test urlParts.href
