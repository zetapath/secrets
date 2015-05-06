"use strict"

ModelSession    = require "../models/session"
GeoPosition     = require "../models/geoposition"
session         = require "../modules/session"
request         = require "../modules/request"
multipart       = require "../modules/request"
UploadImage     = require "./upload.image"
Map             = require "./map"

module.exports = React.createClass

  # -- States & Properties
  getInitialState: ->
    disabled  : true
    image     : undefined
    posted    : false

  # # -- Lifecycle
  componentDidMount: ->
    GeoPosition.observe (state) =>
      @setState latitude: state.object.coords[0], longitude: state.object.coords[1]
    , ["update"]

  # # -- Events
  onImageFile: (data) ->
    @setState image: data
    setTimeout =>
      do @_validateValues
    , 100

  onKeyUp: (event) ->
    do @_validateValues

  onSave: (event) ->
    event.preventDefault()
    event.stopPropagation()

    button = @refs.btn_save.getDOMNode()
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
    <form id="secret">
      <UploadImage entity="secret" onFile={@onImageFile} />
      <Map
        zoom={15}
        center={[@state.latitude, @state.longitude]}
        marker={[@state.latitude, @state.longitude]} />
      <input type="text" ref="latitude" value={@state.latitude} hidden required/>
      <input type="text" ref="longitude" value={@state.longitude} hidden required/>
      <input type="text" ref="type" value="0" hidden required/>
      <input type="text" ref="title" placeholder="Title" className="white" onKeyUp={@onKeyUp} required/>
      <textarea ref="text" placeholder="Describe it" className="white" onKeyUp={@onKeyUp} required></textarea>
      <nav>
        <button ref="btn_save" className="radius theme" onClick={@onSave} disabled={@state.disabled}>
          <abbr>Share my secret</abbr>
        </button>
      </nav>
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
