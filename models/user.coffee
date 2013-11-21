$ = require "jquery"
type = require "../util/type"


module.exports = (attributes) ->
  throw "Must be an object, was: #{attributes}" unless type(attributes) == 'object'

  $.extend {
    name: ''
  }, attributes
