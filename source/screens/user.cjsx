Header      = require "../components/header"
Session     = require "../models/session"
User        = require "../models/user"
request     = require "../modules/request"

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
    if id? and user = User.findBy("id", id)[0]
      following = Session.instance().following
      @setState data: user, network: if id in following then "unfollow" else "follow"
      request("GET", "timeline", user: id).then (error, response) ->
        console.log "GET/timeline", error, response

  # -- Events
  onNetwork: (event) ->
    button = @refs.button.getDOMNode().classList
    button.add "loading"
    Hope.shield([ ->
      request "POST", "network/#{@state.network}", user: @props.id
    , ->
      Session.update()
    ]).then (error, response) ->
      button.remove "loading"

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
