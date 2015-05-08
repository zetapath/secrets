"use strict"

ModelSession    = require "../models/session"
GeoPosition     = require "../models/geoposition"
session         = require "../modules/session"
request         = require "../modules/request"
multipart       = require "../modules/multipart"
UploadImage     = require "./upload.image"
Map             = require "./map"

module.exports = React.createClass

  # -- States & Properties
  getInitialState: ->
    disabled  : true
    image     : undefined
    type      : 1

  # -- Lifecycle
  componentDidMount: ->
    GeoPosition.observe (state) =>
      @setState latitude: state.object.coords[0], longitude: state.object.coords[1]
    , ["update"]

  componentWillReceiveProps: (next_props) ->
    position = GeoPosition.current()
    @setState latitude: position.coords[0], longitude: position.coords[1]

  # # -- Events
  onImageFile: (data) ->
    @setState image: data
    setTimeout =>
      do @_validateValues
    , 100

  onKeyUp: (event) ->
    do @_validateValues

  onType: (event) ->
    for child in @refs.types.getDOMNode().childNodes
      child.classList.remove "active"
    el = event.target
    @setState type: el.getAttribute "value"
    el.classList.add "active"

  onSave: (event) ->
    event.preventDefault()
    event.stopPropagation()

    button = @refs.button.getDOMNode()
    button.classList.add "loading"
    values = @_validateValues()
    request("POST", "secret", values).then (error, response) =>
      button.classList.remove "loading"
      unless error
        parameters = file: @state.image, entity: "secret", id: response.id
        console.log parameters
        multipart("POST", "image", parameters).then (error, response) =>
          console.log "POST/image", error, response
          window.location = "/#/" unless error

  # -- Render
  render: ->
    <form id="secret" className="scroll">
      <UploadImage entity="secret" onFile={@onImageFile} />
      <nav ref="types" className="types" data-flex="horizontal grow">
        <figure className="type-01 active" value="1" onClick={@onType}>
          <abbr>stay</abbr></figure>
        <figure className="type-02" value="2" onClick={@onType}>
          <abbr>drink</abbr></figure>
        <figure className="type-03" value="3" onClick={@onType}>
          <abbr>eat</abbr></figure>
        <figure className="type-04" value="4" onClick={@onType}>
          <abbr>listen</abbr></figure>
        <figure className="type-05" value="5" onClick={@onType}>
          <abbr>view</abbr></figure>
      </nav>
      <Map
        zoom={15}
        center={[@state.latitude, @state.longitude]}
        marker={[@state.latitude, @state.longitude]} />
      <input type="text" ref="latitude" value={@state.latitude} hidden required/>
      <input type="text" ref="longitude" value={@state.longitude} hidden required/>
      <input type="text" ref="type" value={@state.type} hidden required/>
      <input type="text" ref="title" placeholder="Title" className="white" onKeyUp={@onKeyUp} required/>
      <textarea ref="text" placeholder="Describe it" className="white" onKeyUp={@onKeyUp} required></textarea>
      <button ref="button" className="radius theme lo-ading" onClick={@onSave} disabled={@state.disabled}>
        <abbr>Share my secret</abbr>
      </button>
    </form>

  # -- Private methods
  _validateValues: ->
    required = ["latitude", "longitude", "type", "title", "text"]
    disabled = false
    values = {}
    for key, input of @refs when key in required
      values[key] = input.getDOMNode().value.trim()
      if values[key] is ""
        disabled = true
        break
    @setState disabled: not(@state.image? and disabled is false)
    values
