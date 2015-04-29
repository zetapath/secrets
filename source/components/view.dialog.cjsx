"use strict"

App.Dialog = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    title         : React.PropTypes.string.required
    description   : React.PropTypes.string
    image         : React.PropTypes.string.required
    info          : React.PropTypes.string
    button        : React.PropTypes.string.required
    onClick       : React.PropTypes.function
    closable      : React.PropTypes.boolean

  getDefaultProps: ->
    active        : false
    id            : undefined
    title         : "title"
    description   : "description"
    image         : "./assets/img/animal.png"
    info          : "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    button        : "button"
    closable      : true

  # -- Events
  onClick: ->

  # -- Render
  render: ->
    <div id="purchase" data-dialog className={@props.active}>
      <div>
        <h1>{@props.title} {@props.id}</h1>
        { <p>{@props.description}</p> if @props.description }
        <img src={@props.image} />
        { <small>{@props.info}</small> if @props.info }
        <button onClick={@props.onClick?.bind null}>{@props.button}</button>
        { <a href="/#/">x</a> if @props.closable }
      </div>
    </div>
