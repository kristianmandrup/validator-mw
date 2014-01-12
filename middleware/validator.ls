LGTM = require 'lgtm'

Debugger = require '../debugger'

module.exports = class Validator implements Debugger
    # factory doubles as default validator (with no validation rules)
    # just wrap the LGTM validator!
    factory: ->
      LGTM.validator()
    # map, one per model name
    validators: {}
    getFor: (model) ->
      @validators[model] || @factory().build()
    createFor: (model, _) ->
      @validators[model] = @factory()
      @validators[model] = _.call(@validators[model]).build()

