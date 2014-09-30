done = ()->
  console.log "done"
Sequelize = require 'sequelize'
config = require 'config-heroku'
{database, host, port, username, password} = config.postgres
sequelize = new Sequelize(database, username, password, {dialect: "postgres", host: host, port: port, native: yes, coffee: on})
migrator = sequelize.getMigrator
  path: process.cwd() + '/migrations'
  filesFilter: /\.coffee$/
migrator.migrate().error(console.log).success () ->
  done()