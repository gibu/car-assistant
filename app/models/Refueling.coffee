_ = require 'lodash'
Q = require 'q'
RefuelingStore = require '../stores/RefuelingStore'
# CarQueryApi = require '../services/carQueryApi'
CarStore = require '../stores/CarStore'
Car = require './Car'
Plotly = require '../services/plotly'
moment = require 'moment'

Refueling =
  findAll: (query) ->
    RefuelingStore.findAll(query)

  getMonthlyCost: (mac, width, height) ->
    width = if width? then width else 600
    height = if height? then height else 600
    RefuelingStore.getMonthlyCost(mac).then (data) ->
      x = []
      y = []
      data.forEach (d) ->
        x.push moment(d.month).format('MMM YY')
        y.push d.total_price
      graphData = [{x: x, y: y, type: 'bar', marker: {color: "#e3c94d"}}]
      graphOptions = {fileopt : "extend", filename : "#{mac}_month_refueling"}
      Q.ninvoke(Plotly, 'plot', graphData, graphOptions, width, height).then (url) ->
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
      if car
        params.car_id = car.id
        return RefuelingStore.create params
      else
        carParams =
          mac: params.mac
          model: params.model
          make: params.make
          year: params.year
        return Car.fetchInformationAndcreate(carParams).then((car) ->
          params.car_id = car.id
          return RefuelingStore.create params
        )
    )


# {"mac": "test", "make": "citroen", "model": "c4", "year": 2005}
module.exports = Refueling