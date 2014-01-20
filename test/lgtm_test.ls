rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

LGTM = require 'lgtm'

validator =
  LGTM.validator!.
    validates('firstName')
    .required("You must enter a first name.")
    .validates('lastName')
    .required("You must enter a last name.")
    .build!

describe 'LGTM validator' ->
  var valid

  persons = {}

  before ->
    persons.invalid =
      first-name : 'Brian'
      last-name  : null
      age       : 30

    persons.valid =
      first-name : 'Brian'
      last-name  : 'Jerkovich'
      age       : 29


  context 'invalid person' ->
    before ->
      # { "valid": false, "errors": { "firstName": [ ], "lastName": ["You must enter a last name."], "age": [ ] } }
      validator.validate(persons.invalid).then (result) ->
        valid := result.valid

    describe 'validate' ->
      specify 'is not valid' ->
        valid.should.be.false

  context 'valid person' ->
    before ->
      # { "valid": false, "errors": { "firstName": [ ], "lastName": ["You must enter a last name."], "age": [ ] } }
      validator.validate(persons.valid).then (result) ->
        valid := result.valid

    describe 'validate' ->
      specify 'is valid' ->
        valid.should.be.true