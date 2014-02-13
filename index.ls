requires = require './requires'

module.exports =
  validator:  requires.fac 'validator'
  validation-mw: requires.mw  'validation_mw'
