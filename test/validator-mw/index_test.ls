requires = require '../../requires'

validation-mw = requires.file 'index'

requires.test 'test_setup'

expect = require('chai').expect

describe 'index' ->
  specify 'exports validator' ->
    expect(validation-mw.validator).to.not.equal void

  specify 'exports validation-mw' ->
    expect(validation-mw.validation-mw).to.not.equal void
