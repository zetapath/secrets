"use strict"

App.Session = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    context       : React.PropTypes.string

  getDefaultProps: ->
    routes: [
      icon: "back", route: "/"
    ]

  getInitialState: ->
    disabled: true

  # -- Events
  onKeyDown: (event) ->
    values = @_getFormValues()
    @setState disabled: not(values.mail and values.password)

  onSign: (event) ->
    event.preventDefault()
    App.proxy("POST", @props.context, @_getFormValues()).then (error, response) =>
      return new App.entity.Session response unless error

  # -- Render
  render: ->
    <article id="session" className={@props.active}>
      <h1>Secrets</h1>
      <form>
        <input ref="mail" type="text" placeholder="mail" onKeyDown={@onKeyDown} />
        <input ref="password" type="password" placeholder="password" onKeyDown={@onKeyDown} />
        {
          if @props.context is "login"
            <button onClick={@onSign} disabled={@state.disabled}>Sign In</button>
          else
            <button onClick={@onSign} disabled={@state.disabled}>Sign Up</button>
        }
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
