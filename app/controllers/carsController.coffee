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

  get: (request, response) ->
    done = (car) ->
      response.status(200).json(car)
    error = (err) ->
      response.status(500).json(err)
    Car.findById(request.params.id).then done, error

  findByMac: (request, response) ->
    done = (car) ->
      response.status(200).json(car)
    error = (err) ->
      response.status(500).json(err)
    Car.findByMac(request.params.mac).then done, error

  getMakes: (request, response) ->
    done = (makes) ->
      response.status(200).json(makes)
    error = (err) ->
      response.status(500).json(err)
    Car.getMakes(request.query.year).then done, error

  getModels: (request, response) ->
    done = (makes) ->
      response.status(200).json(makes)
    error = (err) ->
      response.status(500).json(err)
    Car.getModels(request.params.make, request.query.year).then done, error

  getTrims: (request, response) ->
    done = (trims) ->
      response.status(200).json(trims)
    error = (err) ->
      response.status(500).json(err)
    Car.getTrims(request.params.make, request.params.model, request  .query.year).then done, error

module.exports = CarsController