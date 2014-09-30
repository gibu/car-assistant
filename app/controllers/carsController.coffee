Car = require '../models/Car'
CarsController = {}

CarsController =
  index: (request, response) ->
    done = (car) ->
      response.status(200).json(car)
    error = (err) ->
      response.status(500).json(err)
    query = {}
    if request.query.mac
      query.mac = request.query.mac
    Car.findAll(query).then done, error

  create: (request, response) ->
    done = (car) ->
      response.status(200).json(car)
    error = (err) ->
      response.status(500).json(err)
    # done({})
    Car.fetchInformationAndcreate(request.body).then done, error

  findByMac: (request, response) ->
    done = (car) ->
      response.status(200).json(car)
    error = (err) ->
      response.status(500).json(err)
    Car.findByMac(request.params.mac).then done, error

module.exports = CarsController