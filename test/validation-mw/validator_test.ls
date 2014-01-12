rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

Validator = requires.file 'middleware/validator'

profile-validator = requires.validator 'profile'
user-validator    = requires.validator 'user'

describe 'Validator' ->
  validator = null

  before ->
    validator := new Validator

  specify 'creates a validator' ->
    validator.should.have.property 'factory'
    validator.should.have.property 'validators'
    validator.should.have.property 'getFor'
    validator.should.have.property 'createFor'

describe 'Profile validator' ->
  before ->

  describe 'created' ->
    specify 'should be a Validator' ->
      profile-validator.constructor.should.eql Validator


describe 'User validator' ->
  before ->

  describe 'created' ->
    specify 'should be a Validator' ->
      user-validator.constructor.should.eql Validator

