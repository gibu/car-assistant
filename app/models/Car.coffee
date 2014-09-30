Q = require 'q'
CarStore = require '../stores/CarStore'
CarQueryApi = require '../services/carQueryApi'


Car =
  fetchInformation: (make, model, year) ->
    # CarQueryApi
    Q.ninvoke(CarQueryApi, 'find', make, model, year).then (response) ->
      cars = response.body.Trims
      cars
  fetchInformationAndcreate: (params) ->
    @fetchInformation(params.make, params.model, params.year).then (cars) =>
      # console.log params
      car = cars[0]
      carParams = params
      carParams.engine = car.model_trim
      carParams.fuel_consumption = car.model_lkm_mixed
      carParams.fuel_capacity = car.model_fuel_cap_l
      carParams.fuel = car.model_engine_fuel
      # console.log carParams
      CarStore.create(carParams)
    # console.log params
    # Q({test: 'create'})

module.exports = Car