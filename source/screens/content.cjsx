"use strict"

Header      = require "../components/header"
Loading     = require "../components/loading"
ListScroll  = require "../components/list.scroll"

module.exports = React.createClass

  # -- States & Properties
  getInitialState: ->
    discover  : []
    activity  : []
    followers : []
    following : []
    loading   : false
    context   : undefined
    active    : false

  getDefaultProps: ->
    routes  :
      menu  : [ icon: "menu", route: "/menu" ]
      post  : [
        label: "Create a new secret", route: "/secret/new"
      ,
        label: "Edit my profile", route: "/content/profile"
      ]

  # -- Lifecycle
  componentDidMount: ->
    setTimeout (=> @setState active: true), 450

  componentWillReceiveProps: (next_props) ->
    if @state[next_props.context].length is 0 and not @state.loading
      @_fakeFetch next_props.context

  shouldComponentUpdate: (next_props, next_states) ->
    update = false
    if next_props.context isnt @state.context
      @setState context: next_props.context
      update = true
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
    <article className={@state.active} id="content">
      <Header title={@props.context} routes={@props.routes.menu} session={@props.session} subroutes={@props.routes.post} />
      { <Loading /> if @state.loading }
      {
        if @props.context in ["discover", "followers", "following"]
          <ListScroll
            dataSource={@state[@props.context]}
            itemHeight={64}
            itemFactory={@_getItemRenderer()}/>
      }
    </article>

  renderSecretItem: (data) ->
    <div data-flex="horizontal center" onClick={@onSecret.bind @, data} className="secret">
      <figure></figure>
      <div data-flex="vertical" data-flex-grow="max">
        <strong>{data.name}</strong>
        <small>{data.description}</small>
      </div>
      <small>{data.id} meters</small>
    </div>

  renderUserItem: (data) ->
    <div data-flex="horizontal center" onClick={@onUser.bind @, data} className="user">
      <figure></figure>
      <strong data-flex-grow="max">{data.name}</strong>
    </div>

  # -- Private events
  _getItemRenderer: ->
    renderer = @renderSecretItem if @props.context is "discover"
    renderer = @renderUserItem if @props.context in ["followers", "following"]
    renderer

  _fakeFetch: (context) ->
    @setState loading: true, active: false, "#{context}": []
    setTimeout =>
      values = []
      for i in (if context is "discover" then [1..100] else [1..3])
        values.push name: "Name #{i}", description: "Description #{i}", id: i
      @setState "#{context}": values, loading: false, active: true
    , 1500
