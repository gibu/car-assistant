Refueling = require '../models/Refueling'
RefuelingsController = {}

RefuelingsController =
  index: (request, response) ->
    query = {}
    done = (refuelings) ->
      response.status(200).json(refuelings)
    error = (err) ->
      response.status(500).json(err)
    if request.query.mac?
      query.mac = request.query.mac
    Refueling.findAll(query).then done, error

  create: (request, response) ->
    done = (refueling) ->
      response.status(200).json(refueling)
    error = (err) ->
      response.status(500).json(err)

    Refueling.create(request.body).then done, error

  getMonthlyChart: (request, response) ->
    done = (refueling) ->
      response.status(200).json(refueling)
    error = (err) ->
      response.status(500).json(err)
    Refueling.getMonthlyCost(request.params.mac).then done, error

module.exports = RefuelingsController