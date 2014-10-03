moment = require 'moment'
Q = require 'q'
RouteStore = require '../stores/RouteStore'
CarStore = require '../stores/CarStore'
Plotly = require '../services/plotly'
Car = require './Car'


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
      if car
        params.car_id = car.id
        return RouteStore.create params
      else
        carParams =
          mac: params.mac
          model: params.model
          make: params.make
          year: params.year
        return Car.fetchInformationAndcreate(carParams).then((car) ->
          params.car_id = car.id
          return RouteStore.create params
        )
    )

  getMonthlyCharts: (mac, width, height) ->
    width = if width? then width else 600
    height = if height? then height else 600
    RouteStore.getMonthlyData(mac).then (data) ->
      x = []
      y = []
      data.forEach (d) ->
        x.push moment(d.month).format('MMM YY')
        y.push d.total_length / 1000
      graphData = [{x: x, y: y, type: 'bar', marker: {color: "#e3c94d"}}]
      graphOptions = {fileopt : "extend", filename : "#{mac}_monthly_route"}
      Q.ninvoke(Plotly, 'plot', graphData, graphOptions, width, height).then (url) ->
        {url}

  getMonthlyChartAverageSpeed: (mac, width, height) ->
    width = if width? then width else 600
    height = if height? then height else 600
    RouteStore.getMonthlyData(mac).then (data) ->
      x = []
      y = []
      data.forEach (d) ->
        console.log d.total_length
        console.log d.total_duration
        x.push moment(d.month).format('MMM YY')
        y.push ((d.total_length / 1000) / (d.total_duration / 3600))
      console.log data
      graphData = [{x: x, y: y, type: 'bar', marker: {color: "#e3c94d"}}]
      graphOptions = {fileopt : "extend", filename : "#{mac}_monthly_average_speed"}
      Q.ninvoke(Plotly, 'plot', graphData, graphOptions, width, height).then (url) ->
        {url}

module.exports = Route