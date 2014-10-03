GoogleMaps = require '../services/googleMaps'
geolib = require 'geolib'

GasStation =
  findByLatAndLon: (lat, lon, radius,  callback) ->
    if @nearEstimote(lat, lon)
      callback null, ESTIMOTE_RESPONSE
    else
      GoogleMaps.findPlacesByType lat, lon, radius, 'gas_station', (err, result) ->
        if err
          return callback(err)
        else
          gasStations = result["results"]
          callback null, gasStations

  nearEstimote: (latitude, longitude) ->
    geolib.getDistance({latitude,longitude}, ESTIMOTE_LOCATION) < 100

ESTIMOTE_LOCATION =
  latitude: 50.044529
  longitude: 19.9520142

ESTIMOTE_RESPONSE = [
  {
    "geometry": {
      "location": {
        "lat": 50.044529,
        "lng": 19.9520142
      }
    },
    "icon": "http://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png",
    "id": "3d504e18ddc144f7f9a3b65467e9e98ebdea3cf2",
    "name": "Ajsmont Gas",
    "opening_hours": {
      "open_now": true
    },
    "place_id": "ChIJWWgKxkBbFkcR0URMo72qI8I",
    "reference": "CnRoAAAAOgza-Pf43e5ySaSLEAmj5RoQQt7fn1aeOGj1r0Tzh4WPtx1XkfyTL9O1ryTJODkN1QpUDfOGLDv8rDZSa5EWabShyn0SqfKX6CDhJ1eHttbVAndqxxVn_cYCLF5IHCycGNBYvn4oON7YOKYtjE3HLBIQIWUpJ000n8wc25xSqk0O1xoUhoMGxTqESs5778bLuHCZhaylTdc",
    "scope": "GOOGLE",
    "types": [
      "gas_station",
      "establishment"
    ],
    "vicinity": "Krakusa 11, Krakow"
  }
]

module.exports = GasStation