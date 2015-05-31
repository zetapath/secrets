Leaflet   = require "react-leaflet"
Map       = Leaflet.Map
TileLayer = Leaflet.TileLayer
Marker    = Leaflet.Marker
Popup     = Leaflet.Popup

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    center      : React.PropTypes.array
    marker      : React.PropTypes.array
    zoom        : React.PropTypes.number
    expandable  : React.PropTypes.boolean

  getDefaultProps: ->
    zoom        : 16
    expandable  : false
    center      : undefined
    marker      : undefined

  # -- Lifecycle
  shouldComponentUpdate: (next_props, next_states) ->
    if next_props.center and next_props.marker then true else false

  # -- Events
  onExpand: (event) ->
    event.stopPropagation()
    @getDOMNode().classList.toggle "expanded"

  # -- Render
  render: ->
    <Map center={@props.center} zoom={@props.zoom} onClick={@onExpand if @props.expandable}>
      <TileLayer
        url="http://{s}.tile.osm.org/{z}/{x}/{y}.png"
        attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      />
      <Marker position={@props.center}>
      </Marker>
    </Map>
