express = require('express')
app = express()

app.get '/', (req, res) ->
  res.send "Car Application"

port = process.env.PORT || 3000
server = app.listen port, ->
  console.log('Listening on port %d', server.address().port)