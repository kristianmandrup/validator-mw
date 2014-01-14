rek = require 'rekuire'
require 'sugar'
_ = require 'prelude-ls'

underscore = (items) ->
  strings = items.map (item) ->
    String(item)
  _.map (.underscore!), strings

test-level = 1
file-level = 0

test-base-path = ->
  "test"

validator-base-path = ->
  "validators"

file-base-path = ->
  "."

test-path = (...paths) ->
  upaths = underscore(...paths)
  [test-base-path!, upaths].flatten!.join '/'

validator-path = (...paths) ->
  upaths = underscore(...paths)
  [validator-base-path!, upaths].flatten!.join '/'

factory-path = (...paths) ->
  upaths = underscore(...paths)
  ['factory', upaths].flatten!.join '/'

middleware-path = (...paths) ->
  upaths = underscore(...paths)
  ['middleware', upaths].flatten!.join '/'


module.exports =
  file-lv: (lvs) ->
    file-level := lvs

  test-lv: (lvs) ->
    test-level := lvs

  test: (...paths) ->
    rek test-path(paths)

  validator: (...paths) ->
    rek validator-path(paths)

  validators: (...paths) ->
    paths.map (path) ->
      @validator path

  factory: (...paths) ->
    rek factory-path(paths)

  fac: (...paths) ->
    @factory paths

  middleware: (...paths) ->
    rek middleware-path(paths)

  # alias
  mw: (path) ->
    @middleware path

  fixture: (path) ->
    @test 'fixtures', path

  # alias
  fix: (path) ->
    @fixture path

  test-factory: (path) ->
    @test 'factories', path

  # alias
  test-fac: (path) ->
    @test-factory path

  file: (path) ->
    rek [file-base-path!, path.underscore!].join '/'

  # m - alias for module
  m: (path) ->
    @file path

  files: (...paths) ->
    paths.map (path) ->
      @file path

  fixtures: (...paths) ->
    paths.map (path) ->
      @fixture path

  tests: (...paths) ->
    paths.map (path) ->
      @test path
