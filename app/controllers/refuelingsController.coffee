Refueling = require '../models/Refueling'
RefuelingsController = {}
log = require '../services/log'

RefuelingsController =
  index: (request, response) ->
    query = {}
    done = (refuelings) ->
      log.info query, "Get refuelings"
      response.status(200).json(refuelings)
    error = (err) ->
      log.info err, log.info
      response.status(500).json(err)
    if request.query.mac?
      query.mac = request.query.mac
    Refueling.findAll(query).then done, error

  create: (request, response) ->
    done = (refueling) ->
      log.info request.body, "Add new refuelings"
      response.status(200).json(refueling)
    error = (err) ->
      log.info request.body, err
      response.status(500).json(err)

    Refueling.create(request.body).then done, error

  getMonthlyChart: (request, response) ->
    done = (refueling) ->
      response.status(200).json(refueling)
    error = (err) ->
      log.info request.params, request.query, err
      response.status(500).json(err)
    Refueling.getMonthlyCost(request.params.mac, request.query.width, request.query.height).then done, error

module.exports = RefuelingsController