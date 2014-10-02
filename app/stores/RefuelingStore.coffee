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
  car_id:
    type: Sequelize.INTEGER,
    references: "cars",
    referenceKey: "id",
    onUpdate: "CASCADE",
    onDelete: "RESTRICT"
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

  getMonthlyCost: (mac) ->
    postgres.query("select date_trunc('month', date) as month, sum(total_price) as total_price from refuelings where mac=? group by month;", null, {raw:true}, [mac]).then (data) ->
      data

module.exports = RefuelingStore()