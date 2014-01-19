rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

ValidationMw = requires.middleware 'validation-mw'

class User
  (@name) ->

class Project
  (@title) ->

describe 'Middleware', ->
  var subject

  users         = {}
  projects      = {}
  validations   = {}
  contexts      = {}

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
      data: user.kris

    validations.proj   := validation-mw contexts.proj
    validations.user   := validation-mw contexts.user

  describe 'validation' ->
    context 'user context' ->
      before ->
        validations.user.debug-on!

        validations.user.run = ->
          @abort! if @data = {}
          true

        subject := validations.user

      specify 'is Validation instance' ->
        subject.constructor.should.eql ValidationMw

      # TODO: abort should always set success to true (fix in middleware project)
      describe 'abort run' ->
        subject.success.should.be.false

      describe 'abort run' ->
        subject.aborted.should.be.true