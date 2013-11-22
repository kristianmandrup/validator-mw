_ = require "lodash" #

module.exports = (attributes) ->
  throw "Must be an object, was: #{attributes}" unless is-type 'Object', attributes

  _.extend {name: ''}, attributes
