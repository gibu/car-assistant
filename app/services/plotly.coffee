config = require 'config-heroku'
plotly = require('plotly')(config.plotly.username, config.plotly.apiKey)

class Plotly
  constructor: ->
  # exports.places = function(latlng, radius, key, callback, sensor, types, lang, name, rankby, pagetoken)
  plot: (data, options, width = 600, height = 600, cb) ->
    plotly.plot(data, options, (err, msg) ->
      if err
        return cb err
      url = msg.url + ".embed?width=#{width}&height=#{height}"
      cb null, url
    )

# https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyCpJM-0pN4_ZuXyY6LzO6xozuGOEe1w8WQ&location=49.8841068,19.49527&radius=1000&types=gas_station
module.exports = new Plotly()