client                      = require('../config/database')
fibrous                     = require "fibrous"

class SubscriptionModel
  constructor: (@client, @table, @tablePrimaryKey, @default_columns, @default_sort) ->

  create: (payload, callback) =>
    try
      columns             = []
      args                = []
      valueParameter      = []
      Object.keys(payload).forEach (key, index) ->
        columns.push key
        args.push payload[key]
        valueParameter.push "$#{index + 1}"
      columns             = columns.join(', ')
      valueParameter      = valueParameter.join(', ')
      console.log columns
      console.log valueParameter
      console.log args
      args.push args[2]
      args1 = []
      args1.push args[0]
      args1.push args[1]
      args1.push args[2]?.p256dh
      args1.push args[2]?.auth

      query = "insert into #{@table} ( endpoint, expirationTime, keys_p256dh, keys_auth ) values ( $1, $2, $3, $4 ) returning *"
      console.log query

      fibrous.run () =>
        result = @client.sync.query query, args1
        return result.rows[0]
      , (err, rs) ->
        if err?
          console.log err
          callback err, null
        else
          console.log rs
          callback null, rs
    catch err
      console.log err
      return callback err, null
  
  getByUserId: (id, callback) =>
    try
      query = "select endpoint, expirationtime, keys_p256dh, keys_auth from #{@table} where userId = #{id}"
      fibrous.run () =>
        result = @client.sync.query query
        return result.rows[0]
      , (err, rs) ->
        if err?
          console.log err
          callback err, null
        else
          console.log rs
          callback null, rs
    catch err
      console.log err
      return callback err, null

  getLastest: (callback) =>
    try
      query = "select endpoint, expirationtime, keys_p256dh, keys_auth from #{@table} order by notification_id desc limit 1"
      fibrous.run () =>
        result = @client.sync.query query
        return result.rows[0]
      , (err, rs) ->
        if err?
          console.log "err: ",
          callback err, null
        else
          console.log rs
          callback null, rs
    catch err
      console.log err
      return callback err, null


module.exports =  SubscriptionModel : SubscriptionModel
