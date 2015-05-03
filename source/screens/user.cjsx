"use strict"

Header      = require "../components/header"

module.exports = React.createClass

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
      <Header title="User Item" routes={@props.routes} />
    </article>
