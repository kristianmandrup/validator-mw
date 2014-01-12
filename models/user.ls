lo = require "lodash"

module.exports = class User
  (@attributes) ->
    unless is-type 'Object', attributes
      throw Error "Must be an object, was: #{attributes}"

    lo.extend @, attributes
