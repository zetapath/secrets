"use strict"

App.List = React.createClass

  # -- States & Properties
  getDefaultProps: ->
    elements    : []

  # -- Events

  # -- Render
  render: ->
    <ul>
      {
        for element, index in @props.elements
          <App.ItemSecret model={element} />
      }
    </ul>


module?.exports = App.List
