"use strict"

App.ItemSecret = React.createClass

  # -- States & Properties
  propTypes:
    onClick: React.PropTypes.func.isRequired

  getDefaultProps: ->
    elements    : []

  # -- Events
  onClick: (event) ->
    event.preventDefault()
    window.location = "/#/secret/#{@props.model.id}"

  # -- Render
  render: ->
    <li rel={@props.model.id} onClick={@props.onClick.bind null, @props.model}>
      <figure></figure>
      <div>
        <strong>{@props.model.name}</strong>
        <small>{@props.model.description}</small>
      </div>
      <small>3.30 km</small>
    </li>


module?.exports = App.ItemSecret
