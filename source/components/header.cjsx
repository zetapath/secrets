"use strict"

App.Header = React.createClass

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

  getInitialState: ->
    expanded    : @props.expanded

  # -- Lifecycle
  componentDidUpdate: (nextProps) ->
    $$(@refs.header.getDOMNode()).removeClass "expanded"

  # -- Events
  onProfile: (event) ->
    event.preventDefault()
    $$(@refs.header.getDOMNode()).toggleClass "expanded"

  # -- Render
  render: ->
    <header ref="header" data-header>
      { <App.Navigation routes={@props.routes}/> if @props.routes }
      { <h1>{@props.title}</h1> if @props.title }
      { <img onClick={@onProfile} src={@props.session.image} /> if @props.session }
      { <App.Navigation routes={@props.subroutes}/> if @props.subroutes }
    </header>
