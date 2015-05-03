"use strict"


App.Menu = React.createClass

  # -- States & Properties
  propTypes:
    routes        : React.PropTypes.object
    session       : React.PropTypes.object.required

  getDefaultProps: ->
    routes:
      content: [
        label: "Discover", route: "/content/discover"
      ,
        label: "Activity", route: "/content/activity"
      ,
        label: "Followers", count: @props?.session?.followers.length, route: "/content/followers"
      ,
        label: "Following", route: "/content/following"
      ,
        label: "Profile", route: "/content/profile"
      ]

  # -- Render
  render: ->
    <aside id="menu" onClick={@onClick} className={@props.active}>
      <div data-flex="horizontal grow center">
        <div>
          <h2>{@props.session.secrets.length or 0}</h2>
          <small>secrets</small>
        </div>
        <div data-flex="vertical center">
          <figure style={backgroundImage: "url(#{@props.session.image})"}></figure>
          <h2>{@props.session.username}</h2>
        </div>
        <div>
          <h2>{@props.session.purchases?.length or 0}</h2>
          <small>discovers</small>
        </div>
      </div>
      <App.Navigation routes={@props.routes.content} />
    </aside>
