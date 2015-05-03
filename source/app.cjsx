"use strict"

# -- Entities
EntitySession   = require "./entities/session"
# -- Modules
session         = require "./modules/session"
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
    session = session()
    if session?
      @setState session: session, howto: false
    else
      window.location = "/#/session/login"

  componentDidMount: ->
    router = Router
      "/session/:id"  : (id) => @setState session: false, context: id
      "/howto/:step"  : (step) => @setState session: @state.session, howto: true, step: step
      "/menu"         : @setState.bind @, menu: true
      "/content/:id"  : (id) => @setState menu: false, context: id, howto: false
      "/secret/new"   : @setState.bind @, secret: true, id: undefined
      "/secret/:id"   : (id) => @setState secret: true, id: id
      "/purchase/:id" : (id) => @setState purchase: true, id: id
      "/user/:id"     : (id) => @setState user: true, id: id
      "/"             : @setState.bind @, menu: false, secret: false, user: false, purchase: false
    router.init window.location.hash or "/"

    EntitySession.observe (state) =>
      @setState howto: true, session: session state.object
    , ["add"]

  # -- Render
  render: ->
    if @state.session and @state.howto is false
      <app>
        <ScreenMenu active={@state.menu} onClick={@onNavigation} session={@state.session}/>
        <ScreenContent context={@state.context} session={@state.session}/>
        <ScreenSecret active={@state.secret} id={@state.id}/>
        <ScreenUser active={@state.user} id={@state.id}/>
        <ScreenPurchase active={@state.purchase} id={@state.id}/>
      </app>
    else
      <app>
        <ScreenSession context={@state.context} />
        <ScreenHowTo active={@state.howto} step={@state.step} session={@state.session} />
      </app>

React.render <App />, document.body
