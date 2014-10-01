RouteStore = require '../stores/RouteStore'

Route =
  findAll: (query) ->
    RouteStore.findAll(query)

  create: (params) ->
    if params.date
      params.date = new Date(params.date * 1000)
    RouteStore.create params

module.exports = Route