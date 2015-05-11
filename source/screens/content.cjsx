"use strict"

# -- Components
Header        = require "../components/header"
Loading       = require "../components/loading"
ListScroll    = require "../components/list.scroll"
ItemActivity  = require "../components/list.item.activity"
ItemPurchase  = require "../components/list.item.purchase"
ItemSecret    = require "../components/list.item.secret"
ItemUser      = require "../components/list.item.user"
FormProfile   = require "../components/form.profile"
# -- Models
Session       = require "../models/session"
GeoPosition   = require "../models/geoposition"
Secret        = require "../models/secret"
Purchase      = require "../models/purchase"
User          = require "../models/user"
# -- Modules
request       = require "../modules/request"
C             = require "../modules/constants"

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
    session     : Session.instance()
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
    Session.observe (state) =>
      @setState session: state.object
    , ["add", "update"]
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
    else if next_states.session? and @state.session.image isnt next_states.session.image
      update = true
    update


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
          for item in response or []
            item_cached = Model.findBy("id", item.id)[0]
            if item_cached
              item_cached[field] = item[field] for field of item_cached.fields()
            else
              new Model item
        @setState "#{context}": response, loading: false, active: true

  _discover: (latitude, longitude, radius = 5000) ->
    @_fetch "discover",
      latitude  : latitude
      longitude : longitude
      radius    : radius

  _getModel: (context) ->
    return Secret if context in ["secrets", "purchases"]
    return Purchase if context is "discover"
    return User if context in ["following", "followers"]

  # -- Render
  render: ->
    <article className={@state.active} id="content">
      <Header title={@props.context} routes={@props.routes.menu} session={@state.session} subroutes={@props.routes.post} />
      { <Loading /> if @state.loading }
      {
        if @props.context in ["secrets", "purchases", "timeline", "discover", "followers", "following"]
          <ListScroll
            dataSource={@state[@props.context]}
            itemHeight={C.LI_HEIGHT}
            itemFactory={@_getItemRenderer()}/>
        else if @props.context is "profile"
          <FormProfile />
      }
    </article>
