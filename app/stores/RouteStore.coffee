Sequelize = require("sequelize")
postgres = require '../services/postgres'
_ = require 'lodash'

db = postgres.define "routes", {
  id:
    type: Sequelize.INTEGER
    primaryKey: yes
    autoIncrement: yes
  mac: Sequelize.STRING
  duration: Sequelize.FLOAT
  length: Sequelize.FLOAT
  date: Sequelize.DATE
},{
  underscored: true
}

RouteStore =
  find: (query = {}) ->
    db.find(where: query).then (route) ->
      route.values

  findAll: (query = {}) ->
    db.findAll(where: query).then (routes) ->
      routes.map (route) ->
        route.values

  create: (params) ->
    db.create(params).then (route) ->
      route.values

module.exports = RouteStore