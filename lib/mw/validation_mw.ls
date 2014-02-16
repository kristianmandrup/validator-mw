_           = require 'prelude-ls'
lo          = require 'lodash'
LGTM        = require 'lgtm'
middleware  = require 'middleware'

requires = require '../../requires'

ModelMw     = require('model-mw').mw
ModelRunner = require('model-mw').runner

Validator   = requires.fac 'validator'
Debugger    = requires.lib 'debugger'

# RSVP        = require 'rsvp'
Q           = require 'q'

LGTM.configure 'defer', Q.defer

module.exports = class ValidationMw extends ModelMw implements Debugger
  (@context) ->
    unless @context.runner?
      @context.runner = new ModelRunner @context

    super @context
    @valid = false

  run: ->
    @debug "context" @context
    return false if lo.is-empty @context

    @debug "collection" @collection
    @debug "model" @model
    @debug "data" @data

    # @debug "validator" @validator

    self = @

    # default: can be customized to be context sensitive
    promise = @validator.validate(@data).then (result) ->
        # err is any Exception

        self.debug "validation result" result

        # result {
        #   "valid": false,
        #   "errors": { "firstName": [ ], "lastName": ["You must enter a last name."], "age": [ ] }
        # }

        self.result = result.valid

        unless result.valid
          errors  = result.errors
          self.add-errors errors unless result.valid

          if @localize-on
            errors  = @localized-errors errors
            self.add-localized-errors errors

  validator: ->
    Validator.get-for @collection

  # loop through error messages and use i18n!
  localize-on: true

    # TODO
  localize-errors: (errors) ->
    errors

  register: (name, _) ->
    @debug "registering" name

lo.extend Validator, Debugger
