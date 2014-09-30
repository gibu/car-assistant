Car = require '../models/Car'
CarsController = {}

CarsController =
  create: (request, response) ->
    console.log request.body
    done = (car) ->
      response.status(200).json(car)
    error = (err) ->
      response.status(500).json(err)
    # done({})
    Car.fetchInformationAndcreate(request.body).then done, error

module.exports = CarsController