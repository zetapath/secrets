"use strict"

App.Session = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean

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

  onSignin: (event) ->
    event.preventDefault()
    new App.entity.Session @_getFormValues()

  # -- Render
  render: ->
    <article id="session" className={@props.active}>
      <h1>Secrets</h1>
      <form>
        <input ref="mail" type="text" placeholder="mail" onKeyDown={@onKeyDown} />
        <input ref="password" type="password" placeholder="password" onKeyDown={@onKeyDown} />
        <button ref="signin" onClick={@onSignin} disabled={@state.disabled}>Sign In</button>
      </form>
      <a href="/#/session/signup">Dont have an account? <strong>Sign Up</strong></a>
      <small>Copyright 2015, Zetapath ltd.</small>
    </article>

  # -- Private methods
  _getFormValues: ->
    mail      : @refs.mail.getDOMNode().value.trim()
    password  : @refs.password.getDOMNode().value.trim()
