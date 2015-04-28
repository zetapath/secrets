"use strict"

App.Secret = React.createClass

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
    <article data-secret className={@props.active}>
      <App.Header title="Secret Item" routes={@props.routes} />
    </article>
