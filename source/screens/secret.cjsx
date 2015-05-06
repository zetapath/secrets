"use strict"

Header      = require "../components/header"
Map         = require "../components/map"
FormSecret  = require "../components/form.secret"
request     = require "../modules/request"

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
    data    : {}

  # Lifecycle
  componentWillReceiveProps: (next_props) ->
    console.log "componentWillReceiveProps", next_props.id,
    id = @props.id or next_props.id
    request("GET", "secret/#{id}").then (error, response) =>
      console.log "GET/secret/#{id}", error, response
      @setState data: response

  # -- Render
  render: ->
    title = if @props.id then "Secret" else "New secret"
    <article id="secret" className={@props.active}>
      <Header title={title} routes={@props.routes} />
      {
        if @props.id
          <section className="scroll">
            <div data-flex="vertical center">
              <h1>{@state.data.title}</h1>
              <small>{@state.data.type}</small>
            </div>
            <Map center={@state.data.position} />
            <div className="user">
              <figure className="avatar" style={backgroundImage: "url(#{@state.data.user?.image})"}></figure>
              <div>
                <strong>{@state.data.user?.username}</strong>
                <small><strong>?</strong> checkins</small>
              </div>
            </div>
            <p>{@state.data.text}</p>
            <small>?? Tips</small>
            <ul />
          </section>
        else
          <section>
            <FormSecret />
          </section>
      }
    </article>
