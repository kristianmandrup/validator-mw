rek      = require 'rekuire'
requires = rek 'requires'

Validator = requires.file 'middleware/validator'

Validator.createFor 'user', ->
  @validates('username').required("You must have a user name.")
