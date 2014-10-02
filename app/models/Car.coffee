Q = require 'q'
CarStore = require '../stores/CarStore'
RefuelingStore = require '../stores/RefuelingStore'
RouteStore = require '../stores/RouteStore'
CarQueryApi = require '../services/carQueryApi'

Car =
  findAll: (query) ->
    CarStore.findAll(query)

  findByMac: (mac) ->
    CarStore.find({mac}).then((car) ->
      unless car
        return {}
      getRefuelings = RefuelingStore.findAll(mac: car.mac)
      getRoutes = RouteStore.findAll(mac: car.mac)
      Q.all([getRefuelings, getRoutes]).then((result) ->
        car.refulings = result[0]
        car.routes = result[1]
        car
      )
    )

  getModelFromCarQueryApi: (modelId) ->
    Q.ninvoke(CarQueryApi, 'getModel', modelId).then (response) ->
      response.body

  fetchInformation: (make, model, year) ->
    Q.ninvoke(CarQueryApi, 'find', make, model, year).then (response) ->
      response.body.Trims

  fetchInformationAndcreate: (params) ->
    getCarInformation = null
    if params.model_id
      getCarInformation = @getModelFromCarQueryApi(params.model_id)
    else
      getCarInformation = @fetchInformation(params.make, params.model, params.year)

    getCarInformation.then (cars) =>
      car = cars[0]
      carParams = {}
      carParams.make = car.model_make_id
      carParams.model = car.model_name
      carParams.year = car.model_year
      carParams.engine = car.model_trim
      carParams.fuel_consumption = car.model_lkm_mixed
      carParams.fuel_capacity = car.model_fuel_cap_l
      carParams.fuel = car.model_engine_fuel
      CarStore.create(carParams)

  getMakes: (year) ->
    Q.ninvoke(CarQueryApi, 'getMakes', year).then (response) ->
      response.body.Makes

  getModels: (make, year) ->
    Q.ninvoke(CarQueryApi, 'getModels', make, year).then (response) ->
      response.body.Models

  getTrims: (make, model, year) ->
    Q.ninvoke(CarQueryApi, 'getTrims', make, model, year).then (response) ->
      response.body.Trims

module.exports = Car