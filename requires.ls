require 'sugar'

rek = require 'rekuire'
_   = require 'prelude-ls'

underscore = (...items) ->
  items = items.flatten!
  strings = items.map (item) ->
    String(item)
  _.map (.underscore!), strings

full-path = (base, ...paths) ->
  upaths = underscore(...paths)
  ['.', base, upaths].flatten!.join '/'

test-path = (...paths) ->
  full-path 'test', ...paths

validator-path = (...paths) ->
  upaths = underscore(...paths)
  ['.', 'validators', upaths].flatten!.join '/'

factory-path = (...paths) ->
  upaths = underscore(...paths)
  ['.', 'factory', upaths].flatten!.join '/'

middleware-path = (...paths) ->
  upaths = underscore(...paths)
  ['.', 'middleware', upaths].flatten!.join '/'


module.exports =
  test: (...paths) ->
    require test-path(...paths)

  runner: (...paths) ->
    require runner-path(...paths)

  validator: (...paths) ->
    require validator-path(...paths)

  validators: (...paths) ->
    paths.map (path) ->
      @validator path

  fixture: (path) ->
    @test 'fixtures', path

  # alias
  fix: (path) ->
    @fixture path

  factory: (...paths) ->
    require factory-path(paths)

  fac: (...paths) ->
    @factory paths

  middleware: (...paths) ->
    require middleware-path(paths)

  # alias
  mw: (path) ->
    @middleware path

  file: (path) ->
    require full-path('.', path)

  # m - alias for module
  m: (path) ->
    @file path

  files: (...paths) ->
    paths.flatten!.map (path) ->
      @file path

  fixtures: (...paths) ->
    paths.flatten!.map (path) ->
      @fixture path

  tests: (...paths) ->
    paths.flatten!.map (path) ->
      @test path





