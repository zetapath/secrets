"use strict"

Session       = require "../models/session"
GeoPosition   = require "../models/geoposition"
Secret        = require "../models/secret"
Header        = require "../components/header"
Loading       = require "../components/loading"
ListScroll    = require "../components/list.scroll"
ItemActivity  = require "../components/list.item.activity"
ItemPurchase  = require "../components/list.item.purchase"
ItemSecret    = require "../components/list.item.secret"
ItemUser      = require "../components/list.item.user"
FormProfile   = require "../components/form.profile"
request       = require "../modules/request"

module.exports = React.createClass

  # -- States & Properties
  getInitialState: ->
    secrets     : []
    purchases   : []
    discover    : []
    timeline    : []
    followers   : []
    following   : []
    loading     : true
    active      : false
    session     : Session.find()[0]
    image       : Session.find()[0]?.image
    geoposition : undefined

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
    @state.session.observe (state) => @setState image: state.object.image
    # console.info "[content] componentDidMount() -> state.context", @state.context
    GeoPosition.get().then (error, position) =>
      @_discover position.coords.latitude, position.coords.longitude unless error
    GeoPosition.observe (state) =>
      @setState geoposition: state.object.coords
    , ["update"]

  componentWillReceiveProps: (next_props) ->
    context = next_props.context
    if context in ["secrets", "purchases", "timeline", "followers", "following"]
      @_fetch context
    else if context is "discover" and @state.geoposition
      @_discover @state.geoposition[0], @state.geoposition[1]
    else if context is "profile"
      @setState active: true

  shouldComponentUpdate: (next_props, next_states) ->
    update = false
    if next_props.context isnt @state.context
      @setState context: next_props.context
      update = true
    else if @state.loading is true and next_states.loading is false
      update = true
    else if @state.image isnt next_states.image
      update = true
    update

  # -- Render
  render: ->
    <article className={@state.active} id="content">
      <Header title={@props.context} routes={@props.routes.menu} session={@state.session} subroutes={@props.routes.post} />
      { <Loading /> if @state.loading }
      {
        if @props.context in ["secrets", "purchases", "timeline", "discover", "followers", "following"]
          <ListScroll
            dataSource={@state[@props.context]}
            itemHeight={64}
            itemFactory={@_getItemRenderer()}/>
        else if @props.context is "profile"
          <FormProfile />
      }
    </article>

  # -- Private events
  _getItemRenderer: ->
    return ItemPurchase if @props.context is "discover"
    return ItemActivity if @props.context is "timeline"
    return ItemSecret if @props.context in ["secrets", "purchases"]
    return ItemUser if @props.context in ["followers", "following"]

  _fetch: (context, parameters) ->
    if @state["#{context}"].length > 0
      @setState loading: false, active: true
    else
      Model = @_getModel context
      @setState loading: true, active: false, "#{context}": []
      method = if context is "discover" then "secrets" else context
      request("GET", method, parameters).then (error, response) =>
        console.log "GET/#{method}", error, response
        if Model?
          Model.destroyAll()
          new Model item for item in response or []

        @setState "#{context}": response, loading: false, active: true

  _discover: (latitude, longitude, radius = 5000) ->
    @_fetch "discover",
      latitude  : latitude
      longitude : longitude
      radius    : radius

  _getModel: (context) ->
    return Secret if context in ["secrets", "purchases"]
