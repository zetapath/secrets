"use strict"

App.Header = React.createClass

  # -- States & Properties
  propTypes:
    routes     : React.PropTypes.array
    subroutes  : React.PropTypes.array

  getDefaultProps: ->
    routes     : []
    subroutes  : []

  # -- Events

  # -- Render
  render: ->
    <header data-header>
      { <App.Navigation routes={@props.routes}/> if @props.routes }
      { <h1>{@props.title}</h1> if @props.title }
      { <App.Navigation routes={@props.subroutes}/> if @props.subroutes }
    </header>
