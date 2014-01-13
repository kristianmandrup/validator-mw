rek      = require 'rekuire'
requires = rek 'requires'

requires.test 'test_setup'

Validator = requires.file 'middleware/validator'

# Validator.debug-on!

profile-validator = requires.validator 'profile'
user-validator    = requires.validator 'user'

describe 'Validator' ->
  validator = null

  specify 'creates a validator' ->
    Validator.should.have.property 'factory'
    Validator.should.have.property 'validators'
    Validator.should.have.property 'getFor'
    Validator.should.have.property 'createFor'

describe 'Profile validator' ->
  describe 'created' ->
    specify 'should be a Validator with a validate method' ->
      profile-validator.should.have.property 'validate'


describe 'User validator' ->
  describe 'created' ->
    specify 'should be a Validator with a validate method' ->
      user-validator.should.have.property 'validate'

