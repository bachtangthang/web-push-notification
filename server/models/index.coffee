{ SubscriptionModel } = require "./subscriptionModel.coffee"
client = require "../config/database.coffee"

subscriptionModel = new SubscriptionModel(client, "notification", "notification_id", "notification_id, message", "notification_id")

module.exports = subscriptionModel: subscriptionModel