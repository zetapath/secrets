"use strict"

App.Secrets = React.createClass

  # -- States & Properties
  getInitialState: ->
    menu      : false
    secret    : false
    post      : false
    dialog    : false
    context   : "discover"

  # -- Lifecycle
  componentDidMount: ->
    router = Router
      '/menu'       : @setState.bind @, menu: true
      '/profile'    : [@hideMenu, => @content 'profile']
      '/followers'  : [@hideMenu, => @content 'followers']
      '/following'  : [@hideMenu, => @content 'following']
      '/activity'   : [@hideMenu, => @content 'activity']
      '/post'       : @setState.bind @, post: true
      '/secret/:id' : @setState.bind @, dialog: true, id: '?'
      '/'           : [@hideAll, => @content 'discover']
    router.init '/'

  # -- Events

  # -- Private
  hideMenu: ->
    @setState menu: false

  hideAll: ->
    @setState menu: false, secret: false, post: false, dialog: false

  content: (value) ->
    @setState context: value

  # -- Render
  render: ->
    <div>
      <App.Menu active={@state.menu} onClick={@onNavigation}/>
      <App.Content context={@state.context} />
      <App.Secret active={@state.secret} id={@state.id}/>
      <App.Post active={@state.post}/>
      <App.Dialog active={@state.dialog} />
    </div>

React.render <App.Secrets />, document.body
