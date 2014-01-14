rek      = require 'rekuire'
requires = rek 'requires'

Validator = requires.factory 'validator'

module.exports = Validator.createFor 'profile' ->
  @validates('firstName').required("You must enter a first name.")
