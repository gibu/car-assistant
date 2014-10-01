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

  fetchInformation: (make, model, year) ->
    Q.ninvoke(CarQueryApi, 'find', make, model, year).then (response) ->
      response.body.Trims

  fetchInformationAndcreate: (params) ->
    @fetchInformation(params.make, params.model, params.year).then (cars) =>
      car = cars[0]
      carParams = params
      carParams.engine = car.model_trim
      carParams.fuel_consumption = car.model_lkm_mixed
      carParams.fuel_capacity = car.model_fuel_cap_l
      carParams.fuel = car.model_engine_fuel
      CarStore.create(carParams)

module.exports = Car