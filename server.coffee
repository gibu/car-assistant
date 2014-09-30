express = require 'express'
bodyParser = require 'body-parser'
routes = require './routes'

app = express()
# app.get '/', (req, res) ->
#   res.send "Car Application"

# app.get '/v1/gas_stations', (req, res) ->
#   res.send "find gas Stations"
app.use(bodyParser.urlencoded({ extended: false }))

app.use(bodyParser.json())

routes(app)

port = process.env.PORT || 3000
server = app.listen port, ->
  console.log('Listening on port %d', server.address().port)