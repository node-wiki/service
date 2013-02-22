vows = require 'vows'
assert = require 'assert'

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

.exportTo module

vows.describe('Git').addBatch
  'data source':
    topic: new git.DataSource

    'can create repository': (topic) ->
      topic.createRepository 'test.git', (error) ->
        assert.equal error, 0

.exportTo module
