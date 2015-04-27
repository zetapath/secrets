"use strict"

App.ItemSecret = React.createClass

  # -- States & Properties
  getDefaultProps: ->
    elements    : []

  # -- Events
  onClick: (event) ->
    window.location = "/#/secret/#{@props.model.id}"

  # -- Render
  render: ->
    <li onClick={@onClick}>
      <strong>name</strong>
      <small>description</small>
      <span>21039</span>
    </li>


module?.exports = App.ItemSecret
