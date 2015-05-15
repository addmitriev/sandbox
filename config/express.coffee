express = require 'express'
expressSession = require 'express-session'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
compress = require 'compression'
methodOverride = require 'method-override'
glob = require 'glob'
stylus = require 'stylus'
i18n = require 'i18next'
coffeeMiddleware = require 'coffee-middleware'
nib = require 'nib'

module.exports = (app, config)->
  app.set 'views', config.root + '/application/views'
  app.set 'view engine', 'jade'

  env = process.env.NODE_ENV || 'development'
  app.locals.ENV = env;
  app.locals.ENV_DEVELOPMENT = env == 'development'

  app.use bodyParser.json()
  app.use bodyParser.urlencoded(
    extended: true
  )
  app.use cookieParser()
  app.use compress()
  app.use methodOverride()

  i18n.init
    saveMissing: true
    resGetPath: config.root + '/application/locales/__lng__/__ns__.json'
    lngWhitelist: ['en', 'dev']

  i18n.serveClientScript(app)
      .serveDynamicResources(app)
      .serveMissingKeyRoute(app)

  app.use i18n.handle

  i18n.registerAppHelper(app)


  app.use require("connect-assets")(
    paths: [config.root + '/bower_components', config.root + '/application/assets']
    servePath: 'public',
    build: true
  )

  controllers = glob.sync config.root + '/application/controllers/**/*.coffee'
  controllers.forEach (controller) ->
    require(controller)(app)
