GasStationsController = require './app/controllers/gasStationsController'
RefuelingsController = require './app/controllers/refuelingsController'

module.exports = (app) ->
  app.get '/', (req, res) ->
    # res.send "Car Application22"

  app.get '/v1/gas_stations', GasStationsController.findByLatAndLon
  app.post '/v1/refuelings', RefuelingsController.create