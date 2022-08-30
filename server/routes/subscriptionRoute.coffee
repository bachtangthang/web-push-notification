express = require "express"
router = express.Router()
subscriptionController = require "../controllers/subscriptionController.coffee"

router.post '/subscription', subscriptionController.post
router.get '/sendNotification', subscriptionController.sendLastest

module.exports = router
