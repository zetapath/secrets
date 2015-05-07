"use strict"

ModelSession  = require "../models/session"
request       = require "../modules/request"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    context       : React.PropTypes.string

  getInitialState: ->
    disabled: true

  # -- Events
  onKeyUp: (event) ->
    values = @_getFormValues()
    @setState disabled: not(values.mail and values.password)

  onSign: (event) ->
    event.preventDefault()
    button = @refs.button.getDOMNode().classList
    button.add "loading"
    request("POST", @props.context, @_getFormValues()).then (error, response) =>
      if error
        button.remove "loading"
      else
        @props.onSuccess.call @, response

  # -- Render
  render: ->
    <article id="session" className={@props.active} data-flex="vertical center">
      <h1>Secrets</h1>
      <form data-flex="vertical center">
        <input ref="mail" type="text" placeholder="mail" onKeyUp={@onKeyUp} className="transparent"/>
        <input ref="password" type="password" placeholder="password" onKeyUp={@onKeyUp} className="transparent"/>
        <button ref="button" onClick={@onSign} disabled={@state.disabled} className="radius white">
          <abbr>{ if @props.context is "login" then "Sign In" else "Sign Up"}</abbr>
        </button>
      </form>
      {
        if @props.context is "login"
          <a href="/#/session/signup">Dont have an account? <strong>Sign Up</strong></a>
        else
          <a href="/#/session/login">You have an account, <strong>Sign In</strong></a>
      }
      <small>Copyright 2015, Zetapath ltd.</small>

      <img src="./assets/img/fox.png" />
    </article>

  # -- Private methods
  _getFormValues: ->
    mail      : @refs.mail.getDOMNode().value.trim()
    password  : @refs.password.getDOMNode().value.trim()
