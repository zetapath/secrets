Navigation  = require "../components/navigation"
Session     = require "../models/session"

module.exports = React.createClass

  # -- States & Properties
  getInitialState: ->
    session : Session.instance()

  # -- Lifecycle
  componentDidMount: ->
    Session.observe (state) =>
      @setState session: state.object if state.object instanceof Session
    , ["add", "update"]

  # -- Render
  render: ->
    session = @state.session
    routes = [
      icon: "search", label: "Discover", route: "/content/discover"
    ,
      icon: "timeline", label: "Timeline", route: "/content/timeline"
    ]
    for attr in ["following", "followers"] when session[attr]?.length > 0
      routes.push icon: attr, label: attr, count: session[attr].length, route: "/content/#{attr}"
    routes.push icon: "profile", label: "Profile", route: "/content/profile"

    <aside id="menu" onClick={@onClick} className={@props.active}>
      <div data-flex="horizontal grow center">
        <a href="/#/content/secrets">
          <h2>{session.secrets?.length or 0}</h2>
          <small>secrets</small>
        </a>
        <div data-flex="vertical center">
          <h2>{session.wallet}</h2>
          <small>coins</small>
          <figure style={backgroundImage: "url(#{session.image})"}></figure>
          <h2>{session.username}</h2>
        </div>
        <a href="/#/content/purchases">
          <h2>{session.purchases?.length or 0}</h2>
          <small>purchases</small>
        </a>
      </div>
      <Navigation routes={routes} />
    </aside>
