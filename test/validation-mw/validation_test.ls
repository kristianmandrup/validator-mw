rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

Validation = requires.file 'middleware/validation'

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
