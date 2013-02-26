vows = require 'vows'
assert = require 'assert'

settings = require '../etc/node-wiki/testing.coffee'

base = require '../src/data_sources/base'
defaults = require '../src/data_sources/defaults'
mongo = require '../src/data_sources/mongo'

genericTests =
  update: (source, callback) ->
    source.update 'test.md', '# Example content', {}, callback

  retrieve: (source, callback) ->
    source.retrieve 'test.md', {}, callback

  remove: (source, callback) ->
    source.remove 'test.md', {}, callback

vows.describe('Data sources').addBatch
  'default modules':
    topic: defaults.types

    exist: (topic) ->
      for moduleName of topic
        moduleName = '../src/' + moduleName[10..]

        assert.doesNotThrow ->
          require moduleName
        , Error

  'factory':
    topic: base

    'returns a data source using mongo': (topic) ->
      assert.doesNotThrow ->
        topic.DataSource.factory 'mongodb://localhost/test', settings.context
      , Error

  'mongo data source':
    topic: ->
      source = new mongo.DataSource settings.context
      source.initialize @callback

    'can update document': (err, topic) ->
      genericTests.update topic, (err, document) ->
        assert.equal err, 0

    'can retrieve document': (err, topic) ->
      genericTests.update topic, (err, document) ->
        genericTests.retrieve topic, (err, document) ->
          assert.equal err, 0

    'can remove document': (err, topic) ->
      genericTests.update topic, (err, callback) ->
        genericTests.remove topic, (err, document) ->
          assert.equal err, 0

.exportTo module
