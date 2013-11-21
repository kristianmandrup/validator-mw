LGTM = require 'lgtm'

User = require('../models/user')

Validator = require('../middleware/validator')()

# ModelRunner = require '../middleware/model_runner'

# Validation = require '../middleware/validation'

user = User name: 'kristian'

Validator.createFor 'user', ->
  @validates('name')
    .required()
    .minLength(10, "Must be at least 10 chars")

validator = Validator.getFor('user')

validator.validate user, (err, result) ->
  console.log err
  console.log result

ModelRunner = require '../middleware/model_runner'

simpleMw = require('../middleware/simple_mw')()

MwModel = require('../middleware/model_mw')

modelMw = new MwModel('kris')

modelRunner = new ModelRunner().runner model: 'user', data: user

modelRunner.use simpleMw

console.log "modelMw", modelMw

console.log "modelRunner", modelRunner

modelRunner.run()

# Validation.run model: user


exports.list = (req, res) ->
  res.send "respond with a user: #{user.name}"
