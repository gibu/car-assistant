request = require 'request'
base = "http://www.carqueryapi.com/api/0.3/"
config = require 'config-heroku'
_ = require 'lodash'

class CarQueryApi
  constructor: ()->
    @base = base

  find: (make, model, year, cb)->
    path = "?cmd=getTrims&make=#{make}&model=#{model}&year=#{year}"
    @req path, {}, cb

  getModel: (modelId, cb) ->
    path = "?cmd=getModel&model=#{modelId}"
    @req path, {}, cb

  getMakes: (year, cb) ->
    path = "?cmd=getMakes"
    if year
      path += "&year=#{year}"
    @req path, {}, cb

  getModels: (make, year, cb) ->
    path = "?cmd=getModels&make=#{make}"
    if year
      path += "&year=#{year}"
    @req path, {}, cb

  getTrims: (make, model, year, cb) ->
    path = "?cmd=getTrims&make=#{make}&model=#{model}"
    if year
      path += "&year=#{year}"
    @req path, {}, cb

  req: (path, params ,cb)->
    url = @base + path
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

module.exports = new CarQueryApi()