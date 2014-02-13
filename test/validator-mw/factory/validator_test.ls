requires = require '../../../requires'

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

  var valid

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

          profile-validator.validate(profiles.invalid).then (result) ->
            valid := result.valid

        specify 'should return false' ->
          valid.should.be.false

      context 'valid profile' ->
        before ->
          profiles.valid :=
            first-name: 'yeah'

          profile-validator.validate(profiles.valid).then (result) ->
            valid := result.valid

        specify 'should return true' ->
          valid.should.be.true

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

          profile-validator.validate(users.valid).then (result) ->
            valid := result.valid

        specify 'should return false' ->
          valid.should.be.false

      context 'valid user: has username' ->
        before ->
          users.valid :=
            username: 'goodie :)'

          user-validator.validate(users.valid).then (result) ->
            valid := result.valid

        specify 'should return true' ->
          valid.should.be.true