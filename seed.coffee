Car = require './app/models/Car'
Refueling = require './app/models/Refueling'
Routes = require './app/models/Route'
Q = require 'q'
moment = require 'moment'

mac = 'test22'
carParams =
  mac: mac
  model_id: 58021

done = (car) ->
  car
  process.exit()

Car.fetchInformationAndcreate(carParams).then done, done

generate = () ->
  params =
    days: Math.round(Math.random() * 365)
    total_price: 100 + Math.round(Math.random() * 100)
    item_price: 4.5 + (+ Math.random().toPrecision(2))
    length: 5000 + Math.round(Math.random()* 100000)
  params.duration = params.length / (10 + Math.round(Math.random() * 20))
  params
data = (generate() for num in [100..1])

creations = []
data.forEach (d) ->
  params =
    mac:  mac
    total_price: d.total_price
    item_price: d.item_price
    type: 'PB95'
    duration: d.duration
    length: d.length
    date: Math.round((moment().subtract(d.days, 'days').valueOf() /1000))
  console.log params
  creations.push Routes.create(params)

done = (result) ->
  console.log result
  process.exit(-1)


Q.all(creations).then done, done
