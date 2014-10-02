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
  car_id:
    type: Sequelize.INTEGER,
    references: "cars",
    referenceKey: "id",
    onUpdate: "CASCADE",
    onDelete: "RESTRICT"
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

  findByMacAndGroupByDate: (mac) ->
    postgres.query("select date_trunc('day', date) as day, sum(duration) as duration, sum(length) as length from routes where mac=? group by date_trunc('day',date);",null, {raw: true}, [mac])
      .then (data) ->
        data

  getMonthlyData: (mac) ->
    postgres.query("select date_trunc('month', date) as month, sum(duration) as total_duration, sum(length) as total_length from routes where mac=? group by month;", null, {raw: true}, [mac])

module.exports = RouteStore