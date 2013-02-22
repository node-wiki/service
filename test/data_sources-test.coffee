vows = require 'vows'
assert = require 'assert'

settings = require '../etc/node-wiki/testing.coffee'

base = require '../src/data_sources/base'
defaults = require '../src/data_sources/defaults'
git = require '../src/data_sources/git'

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

    'returns a data source using git': (topic) ->
      assert.doesNotThrow ->
        topic.DataSource.factory 'file://test/testing.git', settings.context
      , Error

.exportTo module

vows.describe('Git').addBatch
  'data source':
    topic: new git.DataSource

    'can create repository': (topic) ->
      topic.createRepository settings.gitTestRepo, (error) ->
        assert.equal error, 0

.exportTo module
