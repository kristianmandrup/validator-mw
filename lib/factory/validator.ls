_       = require 'prelude-ls'
lo      = require 'lodash'
LGTM    = require 'lgtm'

requires = require '../../requires'

Debugger = requires.lib 'debugger'

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

      @@debug "factory-meth", factory-meth

      unless _.is-type 'Function', factory-meth
        throw Error "factory-meth must be a Function, was: #{factory-meth}"

      @@validators[model] = @@factory!

      validator-factory = factory-meth.call @@validators[model]

      @@debug 'validator-factory', validator-factory
      if validator-factory is undefined
        throw Error "Validator factory is undefined"

      unless validator-factory.build
        throw Error "Validator can't be built - has no build() method"

      validator = validator-factory.build!

      @@debug 'validator', validator

      @@validators[model] = validator
      validator

lo.extend Validator, Debugger