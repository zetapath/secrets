"use strict"

App.User = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean

  getDefaultProps: ->
    routes: [
      icon: "back", route: "/"
    ]

  # -- Events

  # -- Render
  render: ->
    <article id="user" className={@props.active}>
      <App.Header title="User Item" routes={@props.routes} />
    </article>
