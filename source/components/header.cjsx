Navigation = require './navigation'

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    routes      : React.PropTypes.array.required
    title       : React.PropTypes.string.required
    session     : React.PropTypes.object
    subroutes   : React.PropTypes.array

  getDefaultProps: ->
    routes      : []
    title       : undefined
    session     : undefined
    subroutes   : []

  # -- Lifecycle
  componentDidUpdate: (nextProps) ->
    @refs.header.getDOMNode().classList.remove "expanded"

  # -- Events
  onProfile: (event) ->
    event.preventDefault()
    @refs.header.getDOMNode().classList.toggle "expanded"

  # -- Render
  render: ->
    <header ref="header" data-header>
      { <Navigation routes={@props.routes}/> if @props.routes }
      { <h1>{@props.title}</h1> if @props.title }
      { <figure onClick={@onProfile} style={backgroundImage: "url(#{@props.session.image})"}/> if @props.session }
      { <Navigation routes={@props.subroutes}/> if @props.subroutes }
    </header>
