Route = require '../models/Route'
RoutesController = {}

RoutesController =
  index: (request, response) ->
    done = (car) ->
      response.status(200).json(car)
    error = (err) ->
      response.status(500).json(err)
    query = {}
    if request.query.mac
      query.mac = request.query.mac
    Route.findAll(query).then done, error

  create: (request, response) ->
    done = (route) ->
      response.status(200).json(route)
    error = (err) ->
      response.status(500).json(err)

    Route.create(request.body).then done, error

  getMonthlyStats: (request, response) ->
    done = (route) ->
      response.status(200).json(route)
    error = (err) ->
      response.status(500).json(err)
    Route.getMonthlyCharts(request.params.mac).then done, error

module.exports = RoutesController