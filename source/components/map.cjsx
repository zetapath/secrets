"use strict"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    latitude  : React.PropTypes.number
    longitude : React.PropTypes.number

  getDefaultProps: ->
    latitude  : undefined
    longitude : undefined

  getInitialState: ->
    loading   : false

  # -- Events

  # -- Lifecycle
  onClick: (event) ->
    event.stopPropagation()
    @getDOMNode().classList.toggle "expanded"

  # -- Render
  render: ->
    <map data-map onClick={@onClick} data-flex="vertical center">
    {
      <p>{@props.latitude} - {@props.longitude}</p>
    }
    </map>
