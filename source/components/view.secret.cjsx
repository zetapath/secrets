"use strict"

App.Secret = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    id            : React.PropTypes.string

  getDefaultProps: ->
    routes: [
      icon: "back", route: "/"
    ]

  # -- Events

  # -- Render
  render: ->
    <article id="secret" className={@props.active}>
      <App.Header title="Secret #{@props.id}" routes={@props.routes} />
    </article>
