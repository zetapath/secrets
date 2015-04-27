"use strict"


App.Menu = React.createClass

  # -- States & Properties
  propTypes:
    routes        : React.PropTypes.object

  getDefaultProps: ->
    routes:
      header: [
        label: "back", icon: "1", route: "/"
      ]
      content: [
        label: "Discover", icon: "1", route: "/"
      ,
        label: "Followers", icon: "1", count: 12, route: "/followers"
      ,
        label: "Following", icon: "1", route: "/following"
      ,
        label: "Profile", icon: "1", route: "/profile"
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
