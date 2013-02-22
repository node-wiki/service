vows = require 'vows'
assert = require 'assert'

markdown = require '../src/markup/markdown'
defaults = require '../src/markup/defaults'

vows.describe('Markup').addBatch
  'default modules':
    topic: defaults.renderers

    exist: (topic) ->
      for extension of topic
        # Slicing pulls the 'node-wiki/' out of the modulename
        moduleName = '../src/' + topic[extension][10..]

        assert.doesNotThrow ->
          require moduleName
        , Error

  'markdown rendering':
    topic:  markdown.render '# Example'
    
    'returns a string': (topic) ->
      assert.isString topic

    'returns a properly formatted string': (topic) ->
      assert.equal topic, '<h1>Example</h1>'

.exportTo module

