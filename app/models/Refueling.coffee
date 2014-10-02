_ = require 'lodash'
RefuelingStore = require '../stores/RefuelingStore'
CarStore = require '../stores/CarStore'

Refueling =
  findAll: (query) ->
    RefuelingStore.findAll(query)

  create: (params) ->
    query = {}
    if params.mac
      query = {mac: params.mac}
    else
      query = {car_id: params.car_id}
    unless params.item_price?
      params.item_price = params.total_price / params.quantity
    unless params.quantity
      params.quantity = params.total_price / params.item_price
    params.date = if params.date then new Date(params.date * 1000) else new Date()
    CarStore.find(query).then((car) ->
      params.car_id = car.id
      RefuelingStore.create params
    )

module.exports = Refueling