require 'sugar'

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

lib-path = (...paths) ->
  full-path 'lib', ...paths


module.exports =
  test: (...paths) ->
    require test-path(...paths)

  runner: (...paths) ->
    require runner-path(...paths)

  validator: (...paths) ->
    @test 'validators', ...paths

  fixture: (path) ->
    @test 'fixtures', path

  # alias
  fix: (path) ->
    @fixture path

  factory: (path) ->
    @lib 'factory', path

  fac: (path) ->
    @factory path

  middleware: (path) ->
    @lib 'mw', path

  # alias
  mw: (path) ->
    @middleware path

  lib: (...paths) ->
    require lib-path(paths)

  file: (path) ->
    require full-path(path)

  # m - alias for module
  m: (path) ->
    @file path

  files: (...paths) ->
    self = @
    paths.flatten!.map (path) ->
      self.file path

  fixtures: (...paths) ->
    self = @
    paths.flatten!.map (path) ->
      self.fixture path

  tests: (...paths) ->
    self = @
    paths.flatten!.map (path) ->
      self.test path

  validators: (...paths) ->
    self = @
    paths.map (path) ->
      self.validator path
