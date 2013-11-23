require! '../test_setup'

Validation = require '../../middleware/validation'

describe 'Validation', ->
  var validation, context

  before ->
    context = {}
    validation := new Validation context

  specify 'creates a Validation instance' ->
    validation.constructor.should.eql Validation

  specify 'creates a validation obj' ->
    validation.should.have.a.property 'context'

  specify 'creates a validation obj' ->
    validation.context.should.eql {}
