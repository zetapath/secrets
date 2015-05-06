"use strict"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    center    : React.PropTypes.array
    marker    : React.PropTypes.array
    zoom      : React.PropTypes.number

  getDefaultProps: ->
    center    : []
    marker    : []
    zoom      : 10

  getInitialState: ->
    loading   : false
    gmap       : undefined

  # -- Lifecycle
  # componentDidMount: ->
  #   console.log "componentDidMount"

  # componentDidUpdate: ->
  #   gmap =  new google.maps.Map @getDOMNode(),
  #     center          : new google.maps.LatLng @props.center[0], @props.center[1]
  #     zoom            : @props.zoom
  #     mobile          : true
  #     sensor          : false
  #     disableDefaultUI: true
  #
  #   marker = new google.maps.Marker
  #     map             : gmap
  #     position        : new google.maps.LatLng @props.marker[0], @props.marker[1]

  # shouldComponentUpdate: (next_props, next_states) ->
  #   if @state.gmap then false else true

  # -- Events
  onClick: (event) ->
    event.stopPropagation()
    @getDOMNode().classList.toggle "expanded"

  # -- Render
  render: ->
    <map data-map onClick={@onClick} data-flex="horizontal center">
      <span>{@props.center[0]}</span> - <span>{@props.center[1]}</span>
    </map>
