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
      "/session/:id"  : (param) => @setState session: false, context: param.id
      "/howto/:step"  : (param) => @setState session: @state.session, howto: true, step: param.step
      "/menu"         : @setState.bind @, menu: true
      "/content/:id"  : (param) => @setState menu: false, context: param.id, howto: false, secret: false, user: false
      "/secret/new"   : @setState.bind @, secret: true, id: undefined
      "/secret/:id"   : (param) => @setState secret: true, id: param.id, user: false
      "/purchase/:id" : (param) => @setState purchase: true, id: param.id
      "/user/:id"     : (param) => @setState user: true, id: param.id
      "/"             : @setState.bind @, menu: false, secret: false, user: false, purchase: false

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
        <ScreenMenu active={@state.menu} onClick={@onNavigation}/>
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
