config = require 'config-heroku'
{database, host, port, username, password} = config.postgres
pg = require 'pg'
Sequelize = require("sequelize")
postgres = new Sequelize(database, username, password, {dialect: "postgres", host: host, port: port, native: true})

postgres.ERRORS =
  FOREIGN_KEY_NOT_PRESENT: '23503'
module.exports = postgres