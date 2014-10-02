moment = require 'moment'
Q = require 'q'
RouteStore = require '../stores/RouteStore'
CarStore = require '../stores/CarStore'
Plotly = require '../services/plotly'

Route =
  findAll: (query) ->
    RouteStore.findAll(query)

  create: (params) ->
    query = {}
    if params.mac
      query = {mac: params.mac}
    else
      query = {car_id: params.car_id}
    params.date = if params.date then new Date(params.date * 1000) else new Date()
    CarStore.find(query).then((car) ->
      params.car_id = car.id
      RouteStore.create params
    )

  getMonthlyCharts: (mac) ->
    RouteStore.getMonthlyData(mac).then (data) ->
      console.log data
      x = []
      y = []
      data.forEach (d) ->
        x.push moment(d.month).format('MMM YY')
        y.push d.total_length
      graphData = [{x: x, y: y, type: 'bar', marker: {color: "#e3c94d"}}]
      graphOptions = {fileopt : "extend", filename : "#{mac}_monthly_route"}
      Q.ninvoke(Plotly, 'plot', graphData, graphOptions, 600, 600).then (url) ->
        {url}

module.exports = Route