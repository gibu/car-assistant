Sequelize = require("sequelize")
# Q = require 'q'
postgres = require '../services/postgres'
_ = require 'lodash'
# EstimoteError = require '../errors/estimoteError'

db = postgres.define "cars", {
  id:
    type: Sequelize.INTEGER
    primaryKey: yes
    autoIncrement: yes
  mac: Sequelize.STRING
  make: Sequelize.STRING
  model: Sequelize.STRING
  year: Sequelize.INTEGER
  engine: Sequelize.STRING
  fuel: Sequelize.FLOAT
  fuel_capacity: Sequelize.FLOAT
  fuel_consumption: Sequelize.FLOAT
},{
  underscored: true
}

CarStore =
  find: (query = {}) ->
    db.find(where: query).then (car) ->
      car?.values

  findAll: (query = {}) ->
    db.findAll(where: query).then (cars) ->
      cars.map (car) ->
        car.values

  create: (params) ->
    db.create(params).then (car) ->
      car?.values

module.exports = CarStore