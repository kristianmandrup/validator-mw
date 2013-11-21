require '../test_setup'

Validator = require '../../middleware/validator'

describe 'Validator init - no args', ->
  validator = null

  before ->
    validator := Validator()

  specify 'creates a validator', ->
    validator.should.have.property 'factory'
    validator.should.have.property 'validators'
    validator.should.have.property 'getFor'
    validator.should.have.property 'createFor'
