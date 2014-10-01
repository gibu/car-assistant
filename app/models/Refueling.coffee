_ = require 'lodash'
RefuelingStore = require '../stores/RefuelingStore'

Refueling =
  findAll: (query) ->
    RefuelingStore.findAll(query)

  create: (params) ->
    unless params.item_price?
      params.item_price = params.total_price / params.quantity
    if params.date
      params.date = new Date(params.date * 1000)
    RefuelingStore.create params

module.exports = Refueling