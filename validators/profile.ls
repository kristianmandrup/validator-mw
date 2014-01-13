rek      = require 'rekuire'
requires = rek 'requires'

Validator = requires.file 'middleware/validator'

Validator.createFor 'profile',
  ->
    console.log 'lgtm validator', @
    @validates('firstName').required("You must enter a first name.")
