# middleware project needs index.ls file which exports Validator for this to work I think
Validator = require 'middleware'.Validator

Validator.createFor('user')
  .validates('username').using( (username) ->
    $.getJSON('/check-username', username: username)
      .then(
        (username) ->
          !username.taken;
      )
  )
.build
