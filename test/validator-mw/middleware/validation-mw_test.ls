rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

ValidationMw = requires.middleware 'validation-mw'

class User
  (@name)

describe 'Validation', ->
  var subject

  users       = {}
  validations = {}
  contexts    = {}

  validation = (ctx) ->
    new ValidationMw ctx

  context 'validation' ->
    context 'user context' ->
      before ->
        users.kris         := new User 'kris'
        contexts.user      :=
          data: users.kris

        validations.user   := validation contexts.user
        validations.user.debug-on!

        subject := validations.user

      specify 'is Validation instance' ->
        subject.constructor.should.eql ValidationMw

      specify 'sets the context obj' ->
        subject.context.should.eql contexts.user

      describe 'run' ->
        var run-res

        before ->
          run-res = subject.run!

        specify 'should return void' ->
          expect(run-res).to.be.void

        specify 'should set result to validation result - true' ->
          expect(subject.result).to.be.true

    context 'model Book in context' ->
      var data

      before ->
        data            := {title: 'a book'}
        contexts.book   :=
          model: 'Book'
          data: data

        validations.book   := validation contexts.book
        validations.book.debug-on!

        subject := validations.book

      specify 'is Validation instance' ->
        subject.constructor.should.eql ValidationMw

      describe 'data' ->
        specify 'is set' ->
          subject.data.should.eql data

        specify 'has title' ->
          subject.data.title.should.eql data.title

      describe 'model' ->
        specify 'is book' ->
          subject.model.should.eql 'book'

      describe 'collection' ->
        specify 'is Book' ->
          subject.collection.should.eql 'books'
