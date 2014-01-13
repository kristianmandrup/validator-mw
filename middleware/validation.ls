_           = require 'prelude-ls'
lo          = require 'lodash'

LGTM        = require 'lgtm'
middleware  = require 'middleware'

rek      = require 'rekuire'
requires = rek 'requires'

ModelRunner = middleware.ModelRunner

Validator   = requires.file 'middleware/validator'
Debugger    = requires.file 'debugger'

module.exports =  class Validation implements Debugger
  (@context) ->

  run: ->
    return undefined if _.empty @context

    @debug "collection" @collection
    @debug "model" @model

    validator = Validator.getFor @collection

    @debug "validator" validator
    # default: can be customized to be context sensitive
    validator.validate @data (err, result) ->
      # err is any Exception

      @debug "validation result" result

      # result { "valid": false, "errors": { "firstName": [ ], "lastName": ["You must enter a last name."], "age": [ ] } }

      valid   = result['valid']
      errors  = result['errors']
      errors  = localizedErrors errors if @localizeOn

      addErrors errors unless valid

  # loop through error messages and use i18n!
  localizeOn: true
  localizeErrors: (errors) ->
    # TODO
    @debug errors
  register: (name, _) ->
    @debug "registering" name

lo.extend Validator, Debugger