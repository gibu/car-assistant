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
},{
  underscored: true
}

RefuelingStore = () ->
  create: (params, cb) ->
    db.create(params).then (refuling) ->
      refuling.values

module.exports = RefuelingStore()