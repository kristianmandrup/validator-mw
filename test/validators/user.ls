rek      = require 'rekuire'
requires = rek 'requires'

Validator = requires.factory 'validator'

module.exports = Validator.createFor 'user' ->
  @validates('username').required("You must have a user name.")
