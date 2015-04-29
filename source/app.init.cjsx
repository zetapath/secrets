"use strict"

App.Secrets = React.createClass

  # -- States & Properties
  getInitialState: ->
    session   : null
    howto     : false

    menu      : false
    secret    : false
    purchase  : false
    user      : false
    id        : null
    context   : "discover"

  # -- Lifecycle
  componentWillMount: ->
    session = App.session()
    @setState session: session, howto: session?
    App.entity.Session.observe (state) =>
      @setState howto: true, session: App.session state
    , ["add"]

  componentDidMount: ->
    router = Router
      "/session/:id"  : (id) => @setState session: false, context: id
      "/menu"         : @setState.bind @, menu: true
      "/content/:id"  : (id) => @setState menu: false, context: id
      "/secret/new"   : @setState.bind @, secret: true, id: undefined
      "/secret/:id"   : (id) => @setState secret: true, id: id
      "/purchase/:id" : (id) => @setState purchase: true, id: id
      "/user/:id"     : (id) => @setState user: true, id: id
      "/"             : @setState.bind @, menu: false, secret: false, user: false, purchase: false
    router.init window.location.hash or "/"

  # -- Render
  render: ->
    if @state.session and @state.howto is false
      <div>
        <App.Menu active={@state.menu} onClick={@onNavigation}/>
        <App.Content context={@state.context} />
        <App.Secret active={@state.secret} id={@state.id} />
        <App.User active={@state.user} id={@state.id}/>
        <App.Dialog active={@state.purchase} id={@state.id}/>
      </div>
    else
      <div>
        <App.Session context={@state.context} />
        <App.HowTo active={@state.howto} />
      </div>

React.render <App.Secrets />, document.body
