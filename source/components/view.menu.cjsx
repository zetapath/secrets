"use strict"


App.Menu = React.createClass

  # -- States & Properties
  propTypes:
    routes        : React.PropTypes.object

  getDefaultProps: ->
    routes:
      content: [
        label: "Discover", route: "/"
      ,
        label: "Activity", route: "/activity"
      ,
        label: "Followers", count: 12, route: "/followers"
      ,
        label: "Following", route: "/following"
      ,
        label: "Profile", route: "/profile"
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
