$ = require "jquery"

Decoration =
  decorators: {}
  decorate: (obj, model, context) ->
    decorator = decorators[model](context)
    decoratedObj = $.extend {}, obj, decorator.blueprint
    $.extend decoratedObj, decorator.customizeFor(context)
  add: (objDecorator) ->
    decorators[objDecorator.model] = objDecorator

ObjectDecorator = (model, context) ->
  blueprint: {}
  customizeFor: (context) ->
