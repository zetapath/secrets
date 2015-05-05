"use strict"

ModelSession  = require "../models/session"
session       = require "../modules/session"
request       = require "../modules/request"
UploadImage   = require "./upload.image"

module.exports = React.createClass

  # -- States & Properties
  getInitialState: ->
    session : ModelSession.find()[0]

  # -- Lifecycle
  componentDidUpdate: (nextProps) ->
    @state.session.observe (state) => @setState session: state.object

  # -- Events
  onUploadSuccess: (url) ->
    @state.session.image = url

  onSave: (event) ->
    event.preventDefault()
    values = {}
    values[key] = input.getDOMNode().value.trim() for key, input of @refs
    button = $$(@refs.btn_save.getDOMNode()).addClass "loading"
    request("PUT", "profile", values).then (error, response) ->
      button.removeClass "loading"
      session response unless error

  onLogout: (event) ->
    event.preventDefault()
    session null
    window.location.reload()

  # -- Render
  render: ->
    <form id="profile">
      <UploadImage url={@state.session.image} entity="user" id={@state.session.id} onSuccess={@onUploadSuccess} />
      <strong>{@state.session.mail}</strong>
      <input type="text" ref="username" placeholder="username" className="white" value={@state.session.username} required/>
      <input type="text" ref="name" placeholder="name" className="white" value={@state.session.name} />
      <textarea ref="bio" placeholder="bio" className="white">{@state.session.bio}</textarea>
      <nav data-flex="horizontal grow">
        <button ref="btn_save" className="radius theme" onClick={@onSave}><abbr>save</abbr></button>
        <button className="radius secondary" onClick={@onLogout}><abbr>logout</abbr></button>
      </nav>
    </form>
