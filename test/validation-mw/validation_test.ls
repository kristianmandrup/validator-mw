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

  context 'validation' ->
    context 'empty context' ->
      before ->
        contexts.empty      := {}
        validations.empty   := validation contexts.empty
        validations.empty.debug-on!

        subject := validations.empty

      specify 'is Validation instance' ->
        subject.constructor.should.eql Validation

      specify 'sets the context obj' ->
        subject.context.should.eql contexts.empty

      describe 'run' ->
        specify 'should return false' ->
          expect(subject.run!).to.be.undefined

    context 'model Book in context' ->
      before ->
        contexts.book       :=
          model: 'Book'

        validations.book   := validation contexts.book
        validations.book.debug-on!

        subject := validations.book

      specify 'is Validation instance' ->
        subject.constructor.should.eql Validation

      describe 'collection' ->
        specify 'is Book' ->
          subject.collection.should.eql 'Book'
