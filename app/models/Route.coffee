RouteStore = require '../stores/RouteStore'
CarStore = require '../stores/CarStore'

Route =
  findAll: (query) ->
    RouteStore.findAll(query)

  create: (params) ->
    query = {}
    if params.mac
      query = {mac: params.mac}
    else
      query = {car_id: params.car_id}
    params.date = if params.date then new Date(params.date * 1000) else new Date()
    CarStore.find(query).then((car) ->
      params.car_id = car.id
      RouteStore.create params
    )

module.exports = Route