request = require 'request'
base = "https://api.foursquare.com/"
config = require 'config-heroku'
_ = require 'lodash'

class Foursquare
  constructor: ()->
    console.log config
    @base = base
    @client_id = config['foursquare']['client_id']
    @client_secret = config['foursquare']['client_secret']

  findByLatLonAndQuery: (lat, lon, query, cb)->
    path = "v2/venues/explore?client_id=#{@client_id}&client_secret=#{@client_secret}&ll=#{lat},#{lon}&query=#{query}&v=20140806&m=foursquare"
    @req path, {}, cb

  req: (path, params ,cb)->
    url = @base + path
    console.log url
    result = {}
    options =
      url: url
    options = _.merge options, params
    request options, (err,response, body) ->
      if err
        return cb(err)
      result.statusCode = response.statusCode
      try
        result.body  = JSON.parse(response.body)
      catch e
        result.body = body
      cb(null, result)

module.exports = new Foursquare()