#
# Sandbox NodeJS express application
#

express = require 'express'
glob = require 'glob'

config = require './config/main'

models = glob.sync(config.root + '/application/models/*.coffee')
models.forEach (model) ->
  require(model)

app = express()
require('./config/express')(app, config)

app.listen config.port, (err)->
  if (err) then throw err
  console.log 'Server listening at %s', config.port