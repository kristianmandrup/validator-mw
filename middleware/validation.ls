LGTM        = require 'lgtm'
middleware  = require 'middleware'

ModelRunner = middleware.ModelRunner
Validator   = require './validator'

Debugger = require '../debugger'

module.exports =  class Validation implements Debugger
  (@context) ->

  run: ->
    console.log "collection" @collection
    console.log "model" @model

    validator = Validator.getFor @collection
    # default: can be customized to be context sensitive
    validator.validate @data (err, result) ->
      # err is any Exception

      # result { "valid": false, "errors": { "firstName": [ ], "lastName": ["You must enter a last name."], "age": [ ] } }

      valid   = result['valid']
      errors  = result['errors']
      errors  = localizedErrors errors if @localizeOn

      addErrors errors unless valid

  # loop through error messages and use i18n!
  localizeOn: true
  localizeErrors: (errors) ->
    # TODO
    console.log errors
  register: (name, _) ->
    console.log "registering" name