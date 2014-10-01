Sequelize = require("sequelize")
# Q = require 'q'
postgres = require '../services/postgres'
_ = require 'lodash'
# EstimoteError = require '../errors/estimoteError'

db = postgres.define "refuelings", {
  id:
    type: Sequelize.INTEGER
    primaryKey: yes
    autoIncrement: yes
  mac: Sequelize.STRING
  total_price: Sequelize.FLOAT
  item_price: Sequelize.FLOAT
  quantity: Sequelize.FLOAT
  type: Sequelize.STRING
  date: Sequelize.DATE
},{
  underscored: true
}

RefuelingStore = () ->
  findAll: (query = {}) ->
    db.findAll(where: query).then (refulings) ->
      refulings.map (refuling) ->
        refuling.values

  create: (params) ->
    db.create(params).then (refuling) ->
      refuling.values

module.exports = RefuelingStore()