_ = require 'underscore'

sourceTypes = require '../../src/data_sources/defaults'

@context =
  sourceTypes: {}

# Remap default data sources to source directory
for key of sourceTypes.types
  value = sourceTypes.types[key]

  if key.indexOf 'node-wiki/data-sources/' == 0
    newKey = './' + key[23..]

    @context.sourceTypes[newKey] = value
