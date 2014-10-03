bunyan =  require 'bunyan'
log = bunyan.createLogger(
  name: 'myapp'
  stream: process.stdout
)

module.exports = log