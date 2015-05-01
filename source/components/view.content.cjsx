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
      post  : [
        label: "Create a new secret", route: "/secret/new"
      ,
        label: "Edit my profile", route: "/content/profile"
      ]

  # -- Lifecycle
  componentWillReceiveProps: (next_props) ->
    if @state[next_props.context].length is 0 and not @state.loading
      @_fakeFetch next_props.context

  shouldComponentUpdate: (next_props, next_states) ->
    update = false
    if next_props.context isnt @state.context
      @setState context: next_props.context, loading: true
      update = true
    # else if next_props.context is @state.context and @state[@state.context].length > 0
    #   update = true
    else if @state.loading is true and next_states.loading is false
      update = true
    update

  # -- Events
  onSecret: (data, event) ->
    window.location = "/#/purchase/#{data.id}"

  onUser: (data, event) ->
    window.location = "/#/user/#{data.id}"

  # -- Render
  render: ->
    context = @props.context
    search = context is "discover"
    on_click = if context is "discover" then "onSecret" else "onUser"

    <article id="content">
      <App.Header title={context} routes={@props.routes.menu} session={@props.session} subroutes={@props.routes.post} />
      {
        if @state.loading
          <App.Loading />
        else if context in ["discover", "followers", "following"]
          <App.List dataSource={@state[context]} search={search} onClick={@[on_click]} />
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
