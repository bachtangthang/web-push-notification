{ subscriptionModel } =  require "../models/index.coffee"
{ modifyNotificationToPush } = require "../utils/modifyNotificationToPush"
webpush = require "web-push"
fibrous = require "fibrous"


post = (req, res) ->
  try
    subscription = req.body
    console.log "subscription: ", subscription
    fibrous.run () ->
      result = subscriptionModel.sync.create subscription
      return result
    , (err, rs) ->
      if err?
        console.log "error: ", err
        res.status(500).json err
      else
        console.log "success result", rs
        res.status(200).json rs
  catch err
    data  =
      success: false
      message: err.messages
    res.status(500).json data

sendByUserId = (req, res) ->
  try
    message = { title: "Hello from the other side"}##sepecify message depend on use case
    userId = 1 ## get from somewhere depend on use case
    fibrous.run () ->
      subscription = subscriptionModel.sync.getByUserId userId
      newSub = modifyNotificationToPush subscription
      webpush.sendNotification(newSub, JSON.stringify(message))
      return true
    , (err, rs) ->
      if err?
        console.log "error: ", err
        res.status(500).json err
      else
        console.log "success result", rs
        res.status(200)
  catch err
    data  =
      success: false
      message: err.messages
    res.status(500).json data

sendLastest = (req, res) ->
  try
    message = { title: "Hello from the other side"}##sepecify message depend on use case
    # message = "{'notification': {'title': 'my title','body': 'my body',}}"
    fibrous.run () ->
      subscription = subscriptionModel.sync.getLastest()
      return subscription
    , (err, rs) ->
      if err?
        console.log "error: ", err
        res.status(500).json err
      else
        newSub = modifyNotificationToPush rs

        console.log "success result:::::::::::::::::::::::::::::", newSub
        webpush.sendNotification(newSub, JSON.stringify(message)).then((rs) -> console.log rs).catch((err)-> console.log err)
        res.status(200).json({})
  catch err
    data  =
      success: false
      message: err.messages
    res.status(500).json data

module.exports =
  post: post
  sendByUserId: sendByUserId
  sendLastest: sendLastest