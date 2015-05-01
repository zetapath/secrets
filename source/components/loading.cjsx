"use strict"

App.Loading = React.createClass

  # -- States & Properties

  # -- Events

  # -- Render
  render: ->
    <div data-loading className={@props.type}>
      <div></div><div></div><div></div>
    </div>

    # loader-inner ball-scale-multiple


module?.exports = App.Loading
