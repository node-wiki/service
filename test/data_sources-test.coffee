vows = require 'vows'
assert = require 'assert'

defaults = require '../src/data_sources/defaults'

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

