gm = require('googlemaps')
config = require 'config-heroku'

class GoogleMaps
  constructor: ()->
    @key = config["google_maps"]["api"]

  # exports.places = function(latlng, radius, key, callback, sensor, types, lang, name, rankby, pagetoken)
  findPlacesByType: (lat, lon, radius, types, callback) ->
    gm.places "#{lat},#{lon}", radius, @key, callback, '', types

# https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyCpJM-0pN4_ZuXyY6LzO6xozuGOEe1w8WQ&location=49.8841068,19.49527&radius=1000&types=gas_station
module.exports = new GoogleMaps()