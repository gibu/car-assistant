express = require 'express'
bodyParser = require 'body-parser'
routes = require './routes'

app = express()

app.use(bodyParser.urlencoded({ extended: false }))

app.use(bodyParser.json())

routes(app)

port = process.env.PORT || 3000
server = app.listen port, ->
  console.log('Listening on port %d', server.address().port)