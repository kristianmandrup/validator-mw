rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

Validation = requires.file 'middleware/validation'

describe 'Validation', ->
  var subject

  validations = {}
  contexts    = {}

  validation = (ctx) ->
    new Validation ctx

  before ->
    contexts.empty      := {}
    validations.empty   := validation contexts.empty

    validations.empty.debug-on!

  context 'validation with empty context' ->
    before ->
      subject := validations.empty

    specify 'is Validation instance' ->
      subject.constructor.should.eql Validation

    specify 'sets the context obj' ->
      subject.context.should.eql contexts.empty

    describe 'run' ->
      specify 'should return false' ->
        expect(subject.run!).to.be.undefined