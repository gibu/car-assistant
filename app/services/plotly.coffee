config = require 'config-heroku'
plotly = require('plotly')(config.plotly.username, config.plotly.apiKey)

class Plotly
  plot: (data, options, width = 600, height = 600, cb) ->
    options.fileopt = "overwrite"
    plotly.plot(data, options, (err, msg) ->
      if err
        return cb err
      url = msg.url + ".embed?width=#{width}&height=#{height}"
      cb null, url
    )

module.exports = new Plotly()