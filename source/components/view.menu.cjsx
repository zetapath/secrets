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
    <aside onClick={@onClick} className={@props.active} data-menu>
      <div>
        <figure></figure>
        <strong>Name</strong>
      </div>
      <App.Navigation routes={@props.routes.content} />
    </aside>
