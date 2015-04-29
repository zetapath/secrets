"use strict"

App.Secrets = React.createClass

  # -- States & Properties
  getInitialState: ->
    menu      : false
    secret    : false
    purchase  : false
    user      : false
    id        : undefined
    context   : 'discover'

  # -- Lifecycle
  componentDidMount: ->
    router = Router
      '/menu'         : @setState.bind @, menu: true
      '/content/:id'  : (id) => @setState menu: false, context: id
      '/secret/new'   : @setState.bind @, secret: true, id: undefined
      '/secret/:id'   : (id) => @setState secret: true, id: id
      '/purchase/:id' : (id) => @setState purchase: true, id: id
      '/user/:id'     : (id) => @setState user: true, id: id
      '/'             : @setState.bind @, menu: false, secret: false, user: false, purchase: false
    router.init window.location.hash or "/"

  # -- Render
  render: ->
    <div>
      <App.Menu active={@state.menu} onClick={@onNavigation}/>
      <App.Content context={@state.context} />
      <App.Secret active={@state.secret} id={@state.id} />
      <App.User active={@state.user} id={@state.id}/>
      <App.Dialog active={@state.purchase} id={@state.id}/>
    </div>

React.render <App.Secrets />, document.body
