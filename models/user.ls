_ = require "lodash"

# TODO: Use class User?

module.exports = (attributes) ->
  throw "Must be an object, was: #{attributes}" unless is-type 'Object', attributes

  _.extend {name: ''}, attributes
