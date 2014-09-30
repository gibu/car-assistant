Refueling = require '../models/Refueling'
RefuelingsController = {}

RefuelingsController.create = (request, response) ->
  done = (refueling) ->
    response.json refueling
  error = (err) ->
    response.json(500, err)

  Refueling.create(request.body).then done, error

module.exports = RefuelingsController