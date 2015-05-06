"use strict"

ModelSession  = require "../models/session"
Navigation    = require "../components/navigation"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    routes        : React.PropTypes.object

  getDefaultProps: ->
    routes:
      content: [
        label: "Discover", route: "/content/discover"
      ,
        label: "Timeline", route: "/content/timeline"
      ,
        label: "Followers", count: @props?.session?.followers.length, route: "/content/followers"
      ,
        label: "Following", route: "/content/following"
      ,
        label: "Profile", route: "/content/profile"
      ]

  getInitialState: ->
    session : ModelSession.find()[0]

  componentDidMount: ->
    @state.session.observe (state) => @setState session: state.object

  # -- Render
  render: ->
    <aside id="menu" onClick={@onClick} className={@props.active}>
      <div data-flex="horizontal grow center">
        <a href="/#/content/secrets">
          <h2>{@state.session.secrets?.length or 0}</h2>
          <small>secrets</small>
        </a>
        <div data-flex="vertical center">
          <figure style={backgroundImage: "url(#{@state.session.image})"}></figure>
          <h2>{@state.session.username}</h2>
        </div>
        <a href="/#/content/purchases">
          <h2>{@state.session.purchases?.length or 0}</h2>
          <small>purchases</small>
        </a>
      </div>
      <Navigation routes={@props.routes.content} />
    </aside>
