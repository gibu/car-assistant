express = require('express')
app = express()
routes = require './routes'

# app.get '/', (req, res) ->
#   res.send "Car Application"

# app.get '/v1/gas_stations', (req, res) ->
#   res.send "find gas Stations"

routes(app)

port = process.env.PORT || 3000
server = app.listen port, ->
  console.log('Listening on port %d', server.address().port)