"use strict"


App.Menu = React.createClass

  # -- States & Properties
  propTypes:
    routes        : React.PropTypes.object

  getDefaultProps: ->
    routes:
      content: [
        label: "Discover", route: "/content/discover"
      ,
        label: "Activity", route: "/content/activity"
      ,
        label: "Followers", count: 12, route: "/content/followers"
      ,
        label: "Following", route: "/content/following"
      ,
        label: "Profile", route: "/content/profile"
      ]

  # -- Events

  # -- Render
  render: ->
    <aside id="menu" onClick={@onClick} className={@props.active}>
      <div>
        <figure style={backgroundImage: "url(#{@props.session.image})"}></figure>
        <strong>Name</strong>
      </div>
      <App.Navigation routes={@props.routes.content} />
    </aside>
