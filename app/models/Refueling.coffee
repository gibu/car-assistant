_ = require 'lodash'
RefuelingStore = require '../stores/RefuelingStore'

Refueling =
  find: (query) ->
    RefuelingStore.find(query)

  create: (params) ->
    unless params.item_price?
      params.item_price = params.total_price / params.quantity
    RefuelingStore.create params

module.exports = Refueling