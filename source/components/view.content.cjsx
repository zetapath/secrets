"use strict"

App.Content = React.createClass

  # -- States & Properties
  getInitialState: ->
    discover  : []
    activity  : []
    followers : []
    following : []
    loading   : false
    context   : undefined

  getDefaultProps: ->
    routes:
      menu  : [ icon: "menu", route: "/menu" ]
      post  : [ icon: "new", route: "/post" ]

  # -- Lifecycle
  componentWillReceiveProps: (next_props) ->
    if @state[next_props.context].length is 0 and not @state.loading
      @_fakeFetch next_props.context

  shouldComponentUpdate: (next_props, next_states) ->
    update = false
    if next_props.context isnt @state.context
      @setState context: next_props.context, loading: true
      update = true
    else if @state.loading is true and next_states.loading is false
      update = true
    update

  # -- Events
  onSecret: (data, event) ->
    console.log "onSecret", data, event

  onUser: (data, event) ->
    console.log "onUser", data, event

  # -- Render
  render: ->
    <article data-content>
      <App.Header
        title={@props.context}
        routes={@props.routes.menu}
        subroutes={@props.routes.post} />
      {
        if @state.loading
          <App.Loading />
        else if @props.context in ["discover", "followers", "following"]
          <App.List ref={@props.context} dataSource={@state[@props.context]} renderRow="App.ItemSecret" search=true />
      }
    </article>

  # -- Private events
  _fakeFetch: (context) ->
    @setState loading: true
    setTimeout =>
      values = []
      for i in (if context is "discover" then [1..10] else [1..3])
        values.push name: "Name #{i}", description: "Description #{i}", id: i
      @setState "#{context}": values, loading: false
    , 2000
