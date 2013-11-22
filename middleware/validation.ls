LGTM        = require 'lgtm'
ModelRunner = require 'model_runner'
Validator   = require 'validator'


module.exports =  ->
  run: (context) ->
    console.log "collection", @collection
    console.log "model", @model

    validator = Validator.getFor(@collection)
    # default: can be customized to be context sensitive
    validator.validate @data, (err, result) ->
      # err is any Exception

      # result { "valid": false, "errors": { "firstName": [ ], "lastName": ["You must enter a last name."], "age": [ ] } }

      valid = result['valid']
      errors = result['errors']
      errors = localizedErrors errors if @localizeOn

      addErrors errors unless valid

  # loop through error messages and use i18n!
  localizeOn: true
  localizeErrors: (errors) ->
    # TODO
    console.log errors
  register: (name, _) ->
    console.log "registering", name