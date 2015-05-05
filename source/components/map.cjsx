"use strict"

module.exports = React.createClass

  # -- States & Properties
  # propTypes:

  getDefaultProps: ->
    center    : []
    marker    : []
    zoom      : 10

  getInitialState: ->
    loading   : false

  componentDidUpdate: ->
    map = new google.maps.Map @getDOMNode(),
      center          : new google.maps.LatLng @props.center[0], @props.center[1]
      zoom            : @props.zoom
      mobile          : true
      sensor          : false
      disableDefaultUI: true
    marker = new google.maps.Marker
      map             : map
      position        : new google.maps.LatLng @props.marker[0], @props.marker[1]

  # -- Events

  # -- Lifecycle
  onClick: (event) ->
    event.stopPropagation()
    @getDOMNode().classList.toggle "expanded"

  # -- Render
  render: ->
    <map data-map onClick={@onClick} />
