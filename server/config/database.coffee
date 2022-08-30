pq = require "pg"
{ Client }      = require('pg')
fibrous 				= require "fibrous"

client = new Client(
  user: 'postgres'
  host: '127.0.0.1'
  database: 'postgres'
  password: '12345'
  schema: 'push notification'
  port: 5432)
        
client.connect (err) ->
  if err
    throw err
  console.log 'Connected!'
        

module.exports = client