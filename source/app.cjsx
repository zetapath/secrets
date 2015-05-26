"use strict"

SPArouter       = require "spa-router"
# -- Models
Session         = require "./models/session"
# -- Modules
storage         = require "./modules/storage"
# -- Screens
ScreenMenu      = require "./screens/menu"
ScreenContent   = require "./screens/content"
ScreenSecret    = require "./screens/secret"
ScreenUser      = require "./screens/user"
ScreenPurchase  = require "./screens/purchase"
ScreenSession   = require "./screens/session"
ScreenHowTo     = require "./screens/howto"

App = React.createClass

  # -- States & Properties
  getInitialState: ->
    session   : null
    howto     : false
    step      : 0
    menu      : false
    secret    : false
    purchase  : false
    user      : false
    id        : null
    context   : "discover"

  # -- Lifecycle
  componentWillMount: ->
    SPArouter.listen
      "/session/:id"  : (id) => @setState session: false, context: id
      "/howto/:step"  : (step) => @setState session: @state.session, howto: true, step: step
      "/menu"         : => @setState menu: true
      "/content/:id"  : (id) => @setState menu: false, context: id, howto: false, secret: false, user: false, purchase: false
      "/secret/new"   : => @setState secret: true, id: undefined
      "/secret/:id"   : (id) => @setState secret: true, id: id, user: false
      "/purchase/:id" : (id) => @setState purchase: true, id: id
      "/user/:id"     : (id) => @setState user: true, id: id
      "/"             : => @setState menu: false, secret: false, user: false, purchase: false

    data = storage()
    if data?
      @setState howto: false, session: new Session data
    else
      SPArouter.path "session/login"

  # -- Events
  onSessionSuccess: (data) ->
    storage data
    @setState session: new Session data
    SPArouter.path "howto/0"

  # -- Render
  render: ->
    if @state.session and @state.howto is false
      <app>
        <ScreenMenu active={@state.menu}/>
        <ScreenContent context={@state.context}/>
        <ScreenSecret active={@state.secret} id={@state.id}/>
        <ScreenUser active={@state.user} id={@state.id}/>
        <ScreenPurchase active={@state.purchase} id={@state.id}/>
      </app>
    else
      <app>
        <ScreenSession context={@state.context} onSuccess={@onSessionSuccess} />
        <ScreenHowTo active={@state.howto} step={@state.step} session={@state.session} />
      </app>

React.render <App />, document.body
