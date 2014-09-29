GoogleMaps = require '../services/googleMaps'

GasStation =
  findByLatAndLon: (lat, lon, radius,  callback) ->
    GoogleMaps.findPlacesByType lat, lon, radius, 'gas_station', (err, result) ->
      if err
        return callback(err)
      else
        gasStations = result["results"]
        callback null, gasStations

module.exports = GasStation