rek         = require 'rekuire'
requires    = rek 'requires'

requires.test 'test_setup'

Validator         = requires.fac 'validator'

# Validator.debug-on!

profile-validator = requires.validator 'profile'
user-validator    = requires.validator 'user'

describe 'Validator' ->
  specify 'creates a validator' ->
    Validator.should.have.property 'factory'
    Validator.should.have.property 'validators'
    Validator.should.have.property 'getFor'
    Validator.should.have.property 'createFor'

  users     = {}
  profiles  = {}

  describe 'Profile validator' ->
    describe 'created' ->
      specify 'should be a Validator with a validate method' ->
        profile-validator.should.have.property 'validate'

    # do actual test of validation via LGTM
    describe 'validate' ->
      context 'invalid profile: no firstName' ->
        before ->
          profiles.invalid :=
            first: ''

        specify 'should return false' ->
          profile-validator.validate(profiles.invalid).should.be.false

      context 'valid profile' ->
        before ->
          profiles.valid :=
            first-name: 'yeah'

        specify 'should return false' ->
          profile-validator.validate(profiles.valid).should.be.true

  describe 'User validator' ->
    describe 'created' ->
      specify 'should be a Validator with a validate method' ->
        user-validator.should.have.property 'validate'

    # do actual test of validation via LGTM
    describe 'validate' ->
      context 'invalid user: has no username' ->
        before ->
          users.valid :=
            name: 'oops!'

        specify 'should return false' ->
          profile-validator.validate(profiles.invalid).should.be.true

      context 'valid user: has username' ->
        before ->
          users.valid :=
            username: 'goodie :)'

        specify 'should return false' ->
          profile-validator.validate(users.valid).should.be.true