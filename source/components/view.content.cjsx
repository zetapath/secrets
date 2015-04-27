"use strict"

App.Content = React.createClass

  # -- States & Properties
  getInitialState: ->
    discover  : []

  getDefaultProps: ->
    routes:
      menu  : [ label: "menu", route: "/menu" ]
      post  : [ label: "new", route: "/post" ]

  # -- Lifecycle
  # componentWillMount: ->
  #   console.log "07-lifecycle -> componentWillMount"
  #
  # componentDidMount: ->
  #   console.log "07-lifecycle -> componentDidMount"
  #
  # componentWillReceiveProps: (next_props) ->
  #   console.log "07-lifecycle -> componentWillReceiveProps -> ", next_props
  #
  # componentWillUpdate: (next_props, next_states) ->
  #   console.log "07-lifecycle -> componentWillUpdate -> ", next_props, next_states
  #
  # componentDidUpdate: (prev_props, prev_states) ->
  #   @setState discover: @_discoverSecrets()
  #   console.log "07-lifecycle -> componentDidUpdate -> ", prev_props, prev_states
  # componentWillUnmount: ->
  #   console.log "07-lifecycle -> componentWillUnmount"
  #
  # shouldComponentUpdate: (next_props, next_states) ->
  #   console.log "07-lifecycle -> shouldComponentUpdate -> ", next_props, next_states
  #   return true

  # -- Events

  # -- Render
  render: ->
    <article data-content>
      <App.Header
        title={@props.context}
        routes={@props.routes.menu}
        subroutes={@props.routes.post} />
      {
        if @props.context is "discover"
          <App.List ref="discover" elements={@_discoverSecrets()} />
      }
    </article>

  # -- Private events
  _discoverSecrets: ->
    secrets = []
    for i in [1..10]
      secrets.push name: "Name #{i}", description: "Description #{i}", id: i
    secrets
