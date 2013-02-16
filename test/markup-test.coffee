vows = require 'vows'
assert = require 'assert'

markdown = require '../src/markup/markdown'

vows.describe('Markdown').addBatch
  'when rendering':
    topic:  markdown.render '# Example'
    
    'returns a string': (topic) ->
      assert.isString topic

    'returns a properly formatted string': (topic) ->
      assert.equal topic, '<h1>Example</h1>'

.exportTo module

