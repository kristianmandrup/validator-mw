_       = require 'prelude-ls'
lo      = require 'lodash'
LGTM    = require 'lgtm'

Debugger = require '../debugger'

module.exports = class Validator implements Debugger
    # factory doubles as default validator (with no validation rules)
    # just wrap the LGTM validator!
    @factory = ->
      LGTM.validator!
    # map, one per model name

    @getFor = (model) ->
      @@validators[model] || @@factory!.build!

    @validators = {}

    @createFor = (model, factory-meth) ->
      unless _.is-type 'String', model
        throw Error "model must be a String, was: #{model}"

      unless _.is-type 'Function', factory-meth
        throw Error "factory-meth must be a Function, was: #{factory-meth}"

      @@validators[model] = @@factory!

      validator = factory-meth.call @@validators[model]
      if validator is undefined
        @@debug "factory-meth", factory-meth
        throw Error "Validator can't be built - factory method returned undefined"

      @@validators[model] = validator.build!

lo.extend Validator, Debugger