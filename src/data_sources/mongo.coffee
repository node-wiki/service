base = require './base'
mongo = require 'mongodb'
url = require 'url'

class MongoDataSource extends base.DataSource
  initialize: (callback) ->
    sourceInfo = url.parse @context.sourcePath

    server = new mongo.Server sourceInfo.hostname, sourceInfo.port or 27017, {}
    client = new mongo.Db sourceInfo.path[1..], server, w: 1

    client.open (err, p_client) =>
      if err
        callback err
      else
        @client = p_client
        callback err, p_client

  retrieve: (identifier, meta, resultCallback) ->
    @client.collection 'documents', (err, collection) ->
      collection.findOne
        identifier: identifier
      , resultCallback

  update: (identifier, content, meta, resultCallback) ->
    document =
      _id: identifier
      content: content
      meta: meta
  
    @client.collection 'documents', (err, collection) ->
      collection.save document, safe: true, resultCallback

  delete: (identifier, meta, resultCallback) ->
    @client.collection 'documents', (err, collection) ->
      collection.findAndModify
        _id: identifier
      , []
      , {}
      , remove: true
      , resultCallback

@DataSource = MongoDataSource
