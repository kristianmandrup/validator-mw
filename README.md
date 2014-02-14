# Validation middleware

Middleware components to enable flexible validation on client or server js environments.

Dependencies:  

* [model-mw](https://github.com/kristianmandrup/model-mw) 
* [LGTM](https://github.com/square/lgtm)  - core validation engine

It should be easy to substitute the validation engine to any other engine or write your own ;)

Works well with other mw-components for the *middleware* project

* [middleware](https://github.com/kristianmandrup/middleware)
* [model-mw](https://github.com/kristianmandrup/model-mw)
* [authorize-mw](https://github.com/kristianmandrup/authorize-mw)
* [decorator-mw](https://github.com/kristianmandrup/decorator-mw)
* [marshaller-mw](https://github.com/kristianmandrup/marshaller-mw)
* [racer-mw](https://github.com/kristianmandrup/racer-mw)

## Usage

Validation Mw example, validating a user

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

The `test/fixtures/validators` folder contains some sample validators:

* profile validator
* user validator

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
