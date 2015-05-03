"use strict"

Header      = require "../components/header"
Map         = require "../components/map"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    id            : React.PropTypes.string

  getDefaultProps: ->
    routes: [
      icon: "back", route: "/"
    ]

  # -- Events
  onUser: (data) ->

  # -- Render
  render: ->
    title = if @props.id then "Secret" else "New secret"

    <article id="secret" className={@props.active}>
      <Header title={title} routes={@props.routes} />
      <section >
        <div data-flex="vertical center">
          <h1>Name of secret</h1>
          <small>type</small>
        </div>
        <Map />
        <div className="user">
          <figure className="avatar"></figure>
          <div>
            <strong>Javi Jimenez</strong>
            <small>123 checkins</small>
          </div>
        </div>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit...
        </p>
        {
          if @props.id
            <h2>Tips</h2>
            <ul>
            </ul>
        }
        <nav data-flex="horizontal center grow">
          <button className="radius theme"><abbr>Save secret</abbr></button>
          <button className="radius secondary"><abbr>Add to favorite</abbr></button>
        </nav>
      </section>
    </article>
