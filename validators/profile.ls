# middleware project needs index.ls file which exports Validator for this to work I think
Validator = require 'middleware'.Validator

Validator.createFor('profile')
  .validates('firstName')
    .required("You must enter a first name.")
  .validates('lastName')
    .when(-> lastNameRequired)
    .required("You must enter a last name.")
  .validates('age')
    .optional()
    .using(
      (age) ->
          age > 18
      ,
      "You must be over 18."
    )
.build()
