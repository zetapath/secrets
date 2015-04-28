"use strict"

App.Post = React.createClass

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
    <article data-post className={@props.active}>
      <App.Header title="New Secret" routes={@props.routes} />
    </article>
