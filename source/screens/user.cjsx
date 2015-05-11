"use strict"

Header      = require "../components/header"
User        = require "../models/user"
request     = require "../modules/request"
session     = require "../modules/session"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean

  getDefaultProps: ->
    routes: [
      icon: "back", back: true
    ]

  getInitialState: ->
    data    : {}
    network : "follow"

  # -- Lifecycle
  componentWillReceiveProps: (next_props) ->
    id = next_props.id or @props.id
    if id?
      user = User.findBy("id", id)[0]
      if user
        @setState data: user, network: if id in session().following then "unfollow" else "follow"

  # -- Events
  onNetwork: (event) ->
    button = @refs.button.getDOMNode().classList
    button.add "loading"
    request("POST", "network/#{@state.network}", user: @props.id).then (error, response) =>
      button.remove "loading"
      console.log "POST/network/#{@state.network}", error, response

  # -- Render
  render: ->
    <article id="user" className={@props.active}>
      <Header title={@state.data.username} routes={@props.routes} />
      <section>
        <div>
        <figure style={backgroundImage: "url(#{@state.data.image})"}/>
          <p>{@state.data.bio}</p>
          <nav>
            <button ref="button" onClick={@onNetwork} data-action={@state.network} className="theme radius">
              <abbr>{@state.network}</abbr>
            </button>
          </nav>
        </div>
      </section>
    </article>
