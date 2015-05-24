# -- Components
Header        = require "../components/header"
ItemActivity  = require "../components/list.item.activity"
List          = require "../components/list"
# -- Models
Session       = require "../models/session"
User          = require "../models/user"
# -- Modules
request       = require "../modules/request"
C             = require "../modules/constants"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean

  getDefaultProps: ->
    routes: [
      icon: "back", back: true
    ]

  getInitialState: ->
    data      : {}
    network   : "follow"
    timeline  : []

  # -- Lifecycle
  componentWillReceiveProps: (next_props) ->
    id = next_props.id or @props.id
    if id? and user = User.findBy("id", id)[0]
      following = Session.instance().following
      @setState data: user, network: if id in following then "unfollow" else "follow"
      request("GET", "timeline", user: id).then (error, response) =>
        @setState timeline: response or []

  # -- Events
  onNetwork: (event) ->
    button = @refs.button.getDOMNode().classList
    button.add "loading"
    Hope.shield([ =>
      request "POST", "network/#{@state.network}", user: @props.id
    , ->
      Session.update()
    ]).then (error, response) ->
      button.remove "loading"

  # -- Render
  render: ->
    <article id="user" className={@props.active}>
      <Header title={@state.data.username} routes={@props.routes} />
      <section data-list-scroll>
        <div>
          <figure style={backgroundImage: "url(#{@state.data.image})"}/>
          <p>{@state.data.bio}</p>
          <nav>
            <button ref="button" onClick={@onNetwork} data-action={@state.network} className="theme radius">
              <abbr>{@state.network}</abbr>
            </button>
          </nav>
          <p>Last activity</p>
          <List dataSource={@state.timeline} itemFactory={ItemActivity}/>
        </div>
      </section>
    </article>
