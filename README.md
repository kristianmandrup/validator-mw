# Validation middleware

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

```LiveScript
# very simple examples
Validator.createFor 'profile' ->
  @validates('firstName').required("You must enter a first name.")

Validator.createFor 'user' ->
  @validates('username').required("You must have a user name.")
```

The default ValidatorMw run method detects the validator to use based on the collection
  which is always set accordingly by `ModelMw` (which `ValidatorMw` inherits from).

```LiveScript
  run: ->
    # ...
    validator = Validator.get-for @collection

    promise = validator.validate(@data).then (result) ->
      self.result = result.valid
      self.add-errors result.errors unless result.valid

```

The result returned by `then(result) ->` is of the following format:

```json
{
  "valid" : false,
  "errors": { "firstName": [ ], "lastName": ["You must enter a last name."] }
}
```


### Localized errors

By setting `validator.locale-on = true` and implementing `localize-errors: (errors) ->` to map the errors into localized errors, you can ensure that the client sees localized errors. These will be available separately as `localized-errors` for the result set of the validator mw-component on the runner.

Example: `middleware.runner.results['validator']` should provide all the results of the validator registered with the name `'validator'`.

Validation Mw example, rolling your own custom validation logic

```LiveScript
User = require 'models/user'

user = (name) ->
  new User name

middleware (name, ctx) ->
  new Middleware name, ctx

users.kris = user 'kris'

# return true if valid
# abort or return false if not valid
# you can also use add-error to add validation errors for the validation ;)
validations.user.run = ->
  @abort! if @data.state is 'bad'
  true

validator = middleware('model', data: users.kris).use(validations.user)
```

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
