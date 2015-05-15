#
# Application configuration
#

path = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    port: process.env.PORT || 5000

  production:
    root: rootPath
    port: process.env.PORT || 5000

module.exports = config[env]