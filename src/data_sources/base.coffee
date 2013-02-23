url = require 'url'
_ = require 'underscore'

defaultContext =
  sourceTypes: require('./defaults').types

class DataSource
  constructor: (@context) ->

  retrieve: (identifier, meta, resultCallback) ->

  update: (identifier, meta, resultCallback) ->

  remove: (identifier, meta, resultCallback) ->

  @factory: (dataURL, context) ->
    context = _.extend {}, defaultContext, context or {}

    urlParts = url.parse dataURL

    for moduleName of context.sourceTypes
      parser = context.sourceTypes[moduleName]

      result = parser urlParts

      if result is true
        module = require moduleName
        
        return new module.DataSource context

    throw new Error "No data source for URL: #{dataURL}"

@DataSource = DataSource
