rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

ValidationMw  = requires.middleware 'validation-mw'

ModelRunner   = require('model-mw').runner
Middleware    = require('middleware').Middleware

class User
  (@name) ->

class Project
  (@title) ->

describe 'Middleware' ->
  var subject, result

  users         = {}
  projects      = {}
  validations   = {}
  contexts      = {}

  middleware = (name, ctx) ->
    new Middleware name, ctx

  validation-mw = (ctx) ->
    new ValidationMw ctx

  project = (title) ->
    new Project title

  user = (name) ->
    new User name

  before ->
    users.kris         := user 'kris'
    projects.base      := project 'kris'

    contexts.proj      :=
      data: projects.base

    contexts.user      :=
      data: users.kris

    validations.proj   := validation-mw contexts.proj
    validations.user   := validation-mw contexts.user

  describe 'validation' ->
    var subject, mware

    context "abort validation since data.name is 'kris'" ->
      before ->
        Middleware.register model: ModelRunner

        validations.user.debug-on!

        validations.user.run = ->
          # console.log 'data', @data
          @abort! if @data.name is 'kris'
          true

        mware = middleware('model', data: users.kris).use(validations.user)

        subject := validations.user
        mware.run!

      specify 'is Validation instance' ->
        subject.constructor.should.eql ValidationMw

      describe 'success' ->
        specify 'is false' ->
          subject.runner.success.should.be.false

      describe 'aborted' ->
        specify 'is true' ->
          subject.runner.aborted.should.be.true

    context "Don't abort validation since data.name is not 'emily'" ->
      before ->
        Middleware.register model: ModelRunner

        validations.user.debug-on!

        validations.user.run = ->
          # console.log 'data', @data
          @abort! if @data.name is 'emily'
          true

        mware = middleware('model', data: users.kris).use(validations.user)

        subject := validations.user
        result := mware.run!

      specify 'is Validation instance' ->
        subject.constructor.should.eql ValidationMw

      describe 'success' ->
        specify 'is true' ->
          subject.runner.success.should.be.true

      describe 'aborted' ->
        specify 'is false' ->
          subject.runner.aborted.should.be.false

      describe 'result' ->
        describe 'success' ->
          specify 'is true' ->
            result.success.should.be.true

        describe 'errors' ->
          specify 'is empty' ->
            result.errors.should.be.empty

        describe 'results for ValidationMw' ->
          specify 'is true' ->
            result.results['ValidationMw'].should.be.true