Validator = require 'middleware/validator'

Validator.createFor('user')
  .validates('username').using( (username) ->
    $.getJSON('/check-username', username: username)
      .then(
        (username) ->
          !username.taken;
      )
  )
.build
