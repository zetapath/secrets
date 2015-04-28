"use strict"

App.Navigation = React.createClass

  # -- States & Properties
  propTypes:
    routes     : React.PropTypes.array

  getDefaultProps: ->
    routes     : []

  # -- Events
  # onClick: (event) ->
  #   console.log "target", event.target

  # -- Render
  render: ->
    <nav>
    {
      for route, index in @props.routes
        <a href={"/#" + route.route} key={index} onClick={@onClick}>
          <span className={"icon " + route.icon}></span>
          <strong>{route.label}</strong>
          <small>{route.count}</small>
        </a>
    }
    </nav>

module?.exports = App.Navigation
