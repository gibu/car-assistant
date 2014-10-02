_ = require 'lodash'
Q = require 'q'
RefuelingStore = require '../stores/RefuelingStore'
CarStore = require '../stores/CarStore'
Plotly = require '../services/plotly'
moment = require 'moment'

Refueling =
  findAll: (query) ->
    RefuelingStore.findAll(query)

  getMonthlyCost: (mac) ->
    RefuelingStore.getMonthlyCost(mac).then (data) ->
      x = []
      y = []
      data.forEach (d) ->
        x.push moment(d.month).format('MMM YY')
        y.push d.total_price
      graphData = [{x: x, y: y, type: 'bar', marker: {color: "#e3c94d"}}]
      graphOptions = {fileopt : "extend", filename : "#{mac}_month_1"}
      Q.ninvoke(Plotly, 'plot', graphData, graphOptions, 600, 600).then (url) ->
        {url}

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