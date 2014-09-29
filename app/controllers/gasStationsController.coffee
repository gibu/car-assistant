GasStation = require '../models/GasStation'
GasStationsController = {}

GasStationsController.findByLatAndLon = (request, response) ->
  lat = request.query.lat
  lon = request.query.lon
  radius = if request.query.radius then request.query.radius else 1000
  GasStation.findByLatAndLon lat, lon, radius,  (err, gasStations) ->
    if err
      return response.send 500
    response.json gasStations

module.exports = GasStationsController