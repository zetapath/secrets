"use strict"

App.Secrets = React.createClass

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
    session = App.session()
    if session?
      App.token = session.token
      @setState session: session, howto: true
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

    App.entity.Session.observe (state) =>
      @setState howto: true, session: App.session state.object
      App.token = state.object.token
    , ["add"]

  # -- Render
  render: ->
    if @state.session and @state.howto is false
      <div>
        <App.Menu active={@state.menu} onClick={@onNavigation} session={@state.session}/>
        <App.Content context={@state.context} session={@state.session}/>
        <App.Secret active={@state.secret} id={@state.id}/>
        <App.User active={@state.user} id={@state.id}/>
        <App.Dialog active={@state.purchase} id={@state.id}/>
      </div>
    else
      <div>
        <App.Session context={@state.context} />
        <App.HowTo active={@state.howto} step={@state.step} session={@state.session} />
      </div>

React.render <App.Secrets />, document.body
