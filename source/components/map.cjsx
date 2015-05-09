"use strict"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    center      : React.PropTypes.array
    marker      : React.PropTypes.array
    zoom        : React.PropTypes.number
    expandable  : React.PropTypes.boolean


  getDefaultProps: ->
    zoom        : 10
    expandable  : false
    center      : undefined
    marker      : undefined
    sensor      : false

  getInitialState: ->
    gmap        : undefined

  # -- Lifecycle
  componentDidMount: ->
    center = @props.center or [43.256963, -2.923441]
    @setState gmap: new google.maps.Map @getDOMNode(),
      center          : new google.maps.LatLng center
      zoom            : if @props.center then @props.zoom else 1
      mobile          : true
      sensor          : false
      disableDefaultUI: true
    @createMarker @props.marker

  componentWillReceiveProps: (next_props) ->
    center = next_props.center or @props.center
    if center?
      @state.gmap?.setCenter new google.maps.LatLng center[0], center[1]
      @state.gmap?.setZoom @props.zoom
      @createMarker next_props.marker or @props.marker

  # -- Events
  onExpand: (event) ->
    event.stopPropagation()
    @getDOMNode().classList.toggle "expanded"

  # -- Render
  render: ->
    <map data-map onClick={@onExpand if @props.expandable}>
      {@props.center}
    </map>

  # -- Private
  createMarker: (coords) ->
    if coords
      new google.maps.Marker
        map             : @state.gmap
        position        : new google.maps.LatLng coords[0], coords[1]
