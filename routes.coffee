GasStationsController = require './app/controllers/gasStationsController'

module.exports = (app) ->
  app.get '/', (req, res) ->
    # res.send "Car Application22"

  app.get '/v1/gas_stations', GasStationsController.findByLatAndLon