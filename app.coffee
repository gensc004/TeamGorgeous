
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")
mongoose = require 'mongoose'

app = express()
app.set 'layout', 'layout/main'

mongoose.connect 'mongodb://localhost/test'
db = mongoose.connection
db.on 'error', console.error.bind(console, 'connection error:')
db.once 'open', ->
  console.log 'DB connection opened'

app.set 'partials',
  head: 'partials/head',
  navbar: 'partials/navbar',
  scripts: 'partials/scripts'
  register: 'partials/register'
# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "views")
app.engine "html", require("hogan-express")
app.enable 'view cache'
app.configure ->
  app.set "view engine", "html"
  app.use express.favicon()
  app.set 'views', __dirname + '/views'
  app.use express.logger("dev")
  app.use express.json()
  app.use express.urlencoded()
  app.use express.methodOverride()
  app.use express.cookieParser('your secret here')
  app.use express.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))
  app.use express.static(path.join(__dirname, 'bower_components'))


# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.get "/", routes.index
app.get "/users", user.list
http.createServer(app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get("port")
return

