# Validations middleware

The middleware components to enable flexile validation on client or server js environments.

## TODO

Most of middleware folder (except the validator + validation files) should be moved
to its own project called simply middleware (for now)!

Then this project (and other -mw projects) should reference the middleware with base functionality, such as runner.

The middlware/authorization should be moved to the authorize-mw project and refactored + tested.

The test folder currently only tests the validator middleware

The middleware index and config files should be removed...

## Middleware

The middlewares are currently split into Runner and -Mw components.
The idea is that a mw-runner can be defined (using base-runner as the "base") and will run a list of middlewares (-mw)
in succession.

## Validators

Currently the validators folder contains two validators, each for specific model (see models folder)

## ???


