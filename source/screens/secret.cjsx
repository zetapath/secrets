"use strict"

Header      = require "../components/header"
Map         = require "../components/map"
FormSecret  = require "../components/form.secret"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    id            : React.PropTypes.string

  getDefaultProps: ->
    routes: [
      icon: "back", route: "/"
    ]

  getInitialState: ->
    loading: false

  # Lifecycle
  componentDidMount: ->
    # navigator.geolocation.getCurrentPosition @onGPS, @onUnableGPS unless @props.id

  # -- Events
  onGPS: (data) ->
    console.log "onGPS", data.coords.latitude, data.coords.longitude

  onUnableGPS: (error) ->
    console.log "onUnableGPS", error

  # -- Render
  render: ->
    title = if @props.id then "Secret" else "New secret"

    <article id="secret" className={@props.active}>
      <Header title={title} routes={@props.routes} />
      <section>
      {
        if @props.id
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
          <h2>Tips</h2>
          <ul />
        else
          <FormSecret />
      }
      </section>
    </article>
