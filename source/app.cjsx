"use strict"

App.Secrets = React.createClass

  # -- States & Properties
  getInitialState: ->
    menu      : false
    secret    : false
    post      : false
    dialog    : false
    user      : false
    context   : 'discover'

  # -- Lifecycle
  componentDidMount: ->
    router = Router
      '/menu'       : @setState.bind @, menu: true
      '/profile'    : [@_hideMenu, => @_content 'profile']
      '/followers'  : [@_hideMenu, => @_content 'followers']
      '/following'  : [@_hideMenu, => @_content 'following']
      '/activity'   : [@_hideMenu, => @_content 'activity']
      '/post'       : @setState.bind @, post: true
      '/secret/:id' : @setState.bind @, dialog: true, id: '?'
      '/user/:id'   : @setState.bind @, user: true, id: '?'
      '/'           : [@_hideAll, => @_content 'discover']
    router.init window.location.hash or "/"

  # -- Private Methods
  _hideMenu: ->
    @setState menu: false

  _hideAll: ->
    @setState menu: false, secret: false, user: false, post: false, dialog: false

  _content: (value) ->
    @setState context: value

  # -- Render
  render: ->
    <div>
      <App.Menu active={@state.menu} onClick={@onNavigation}/>
      <App.Content context={@state.context} />
      <App.Secret active={@state.secret} id={@state.id}/>
      <App.User active={@state.user} id={@state.id}/>
      <App.Post active={@state.post}/>
      <App.Dialog active={@state.dialog} />
    </div>

React.render <App.Secrets />, document.body
