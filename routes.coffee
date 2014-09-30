GasStationsController = require './app/controllers/gasStationsController'
RefuelingsController = require './app/controllers/refuelingsController'
CarsController = require './app/controllers/carsController'

module.exports = (app) ->
  app.get '/', (req, res) ->
    # res.send "Car Application22"

  app.get '/v1/gas_stations', GasStationsController.findByLatAndLon
  app.get '/v1/refuelings/', RefuelingsController.index
  app.post '/v1/refuelings', RefuelingsController.create
  app.get '/v1/cars', CarsController.index
  app.post '/v1/cars', CarsController.create
  app.get '/v1/cars/find_by_mac/:mac', CarsController.findByMac