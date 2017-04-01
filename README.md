# Validation middleware

[![Greenkeeper badge](https://badges.greenkeeper.io/kristianmandrup/validator-mw.svg)](https://greenkeeper.io/)

Middleware components to enable flexible validation on client or server js environments.

Dependencies:  

* [model-mw](https://github.com/kristianmandrup/model-mw) 
* [LGTM](https://github.com/square/lgtm/wiki) wiki - core validation engine

It should be easy to substitute the validation engine to any other engine or write your own ;)

Works well with other mw-components for the *middleware* project

* [middleware](https://github.com/kristianmandrup/middleware)
* [model-mw](https://github.com/kristianmandrup/model-mw)
* [authorize-mw](https://github.com/kristianmandrup/authorize-mw)
* [decorator-mw](https://github.com/kristianmandrup/decorator-mw)
* [marshaller-mw](https://github.com/kristianmandrup/marshaller-mw)
* [racer-mw](https://github.com/kristianmandrup/racer-mw)

## Usage

Validator factory is a thin wrapper around [LGTM](https://github.com/square/lgtm)

Creatin a validator

```LiveScript
# very simple examples
profile-validator = Validator.createFor 'profile' ->
  @validates('firstName').required("You must enter a first name.")

user-validator = Validator.createFor 'user' ->
  @validates('username').required("You must have a user name.")

# validate a user

user.validator.validate(user).then (results) ->
  # handle results Object (via valid: and errors: keys)
```

The default ValidatorMw `run` method detects the validator to use based on the collection
  which is always set accordingly by `ModelMw` (which `ValidatorMw` inherits from).

```LiveScript
  run: ->
    # ...
    validator = Validator.get-for @collection
    self = @
    promise = validator.validate(@data).then (result) ->
      # alternative way to return result of run method
      self.result = result.valid
      
      # handle errors
      self.add-errors result.errors unless result.valid

```

The result returned by `then(result) ->` is of the following format:

```json
{
  "valid" : false,
  "errors": { "firstName": [ ], "lastName": ["You must enter a last name."] }
}
```

### Validation Mw example:

Rolling your own **custom validation*** logic

```LiveScript
User = require 'models/user'

user = (name) ->
  new User name

middleware (name, ctx) ->
  new Middleware name, ctx

users.kris = user 'kris'

# return true if valid
validations.user.run = ->
  @abort! if @data.state is 'bad'
  true

validator = middleware('model', data: users.kris).use(validations.user)
```

## Handling errors

Simply call `@error(msg)` (or `add-error`) from ValidatorMw promise resolved (results) handler to add and signal the error (note: be aware of `this` in scope).

Call `abort` or return false if not valid. You can also use `add-errors` to add validation errors for the validation.
Any error added will also make the result of the run false. Then `is-failure()` will be true and `is-success()` false for that Mw-component.

### Localized errors

By setting `validator.locale-on = true` and implementing `localize-errors: (errors) ->` in your ValidatorMw class or instance you can map the errors into localized errors. These errors will be available separately as `localized-errors` for the result set of the validator mw-component on the runner (use f.ex `results-of(name)` - see middleware).

Example: `middleware.runner.results-of 'validator'` should provide an Object with all the results of the validator registered with the name `'validator'`. This will include both `errors` and `localized-errors`.

## Sample Validators

The [validators](https://github.com/kristianmandrup/validator-mw/tree/master/test/validators) folder contains some sample validators:

* profile validator
* user validator

See the [LGTM](https://github.com/square/lgtm/wiki) wiki for more info on that particular API.

## Testing

Run all tests via mocha

`$ mocha`

Run specific test

`$ mocha test/validation-mw/validation_test.js`

## Contribution

Please help improve this project ;)

## License

MIT
Copyright 2014 Kristian Mandrup
