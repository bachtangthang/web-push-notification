express = require "express"
bodyParser = require "body-parser"
path = require "path"
router = require "./routes/subscriptionRoute.coffee"
webpush = require "web-push"
require('dotenv').config()


cors                = require "cors"

app = express()
app.use cors()
app.use(express.static(path.join(__dirname, '../client')))
app.use bodyParser.json()

webpush.setVapidDetails(
  "mailto:test@test.com",
  process.env.PUBLIC_VAPIDKEY,
  process.env.PRIVATE_VAPIDKEY
)

app.listen process.env.PORT, () ->
  console.log "Server is running on port #{process.env.PORT}"

app.use '/', router
