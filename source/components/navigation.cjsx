module.exports = React.createClass

  # -- States & Properties
  propTypes:
    routes     : React.PropTypes.array

  getDefaultProps: ->
    routes     : []

  # -- Events
  onBack: (event) ->
    event.preventDefault()
    event.stopPropagation()
    window.history.back()

  # -- Render
  render: ->
    <nav>
    {
      for route, index in @props.routes
        method = if route.back is true then @onBack
        <a href={"#" + route.route} key={index} onClick={method}>
          <span className={"icon " + route.icon}></span>
          <strong>{route.label}</strong>
          <small>{route.count}</small>
        </a>
    }
    </nav>
