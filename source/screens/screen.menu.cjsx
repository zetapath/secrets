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
      <div data-flex="vertical center">
        <figure style={backgroundImage: "url(#{@props.session.image})"}></figure>
        <strong>{@props.session.username}</strong>
      </div>
      <App.Navigation routes={@props.routes.content} />
    </aside>
