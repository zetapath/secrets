"use strict"

ModelSession  = require "../models/session"
multipart     = require "../modules/multipart"
request       = require "../modules/request"
session       = require "../modules/session"
UploadImage   = require "../components/upload.image"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    step          : React.PropTypes.number.required
    session       : React.PropTypes.object.required

  getDefaultProps: ->
    active        : false
    step          : 0
    session       : {}

  getInitialState: ->
    username      : false
    file          : undefined

  # -- Events
  onSuccessUpload: (url) -> @

  onSaveProfile: (event) ->
    event.preventDefault()
    button = @refs.btnSaveProfile.getDOMNode().classList
    button.add "loading"

    parameters = username: @refs.username.getDOMNode().value.trim()
    request("PUT", "profile", parameters).then (error, response) =>
      if error
        button.remove "loading"
      unless error
        session response
        @props.session.username = response.username
        @props.session.image = response.image
        window.location = "/#/howto/#{parseInt(@props.step) + 1}"
        setTimeout (-> window.location = "/#/content/discover"), 450

  # -- Render
  render: ->
    image = @props.session?.image or "./assets/img/avatar.jpg"
    <article id="howto" className={@props.active} data-step={@props.step}>
      <section className="scene">
        <h1 data-step="1">Welcome to Secrets</h1>
        <h1 data-step="2">You are not alone</h1>
        <h1 data-step="3">Complete your profile</h1>
        <h1 data-step="4">Choose your avatar</h1>

        <img data-step="1" src="./assets/img/fox.png" className="fox" />

        <img data-step="2" src="./assets/img/rabbit.png" className="rabbit" />
        <img data-step="2" src="./assets/img/dog.png" className="dog" />
        <img data-step="2" src="./assets/img/bear.png" className="bear" />
        <img data-step="2" src="./assets/img/raccoon.png" className="raccoon" />
        <img data-step="2" src="./assets/img/pig.png" className="pig" />

        <UploadImage step="3" url={image} entity="user" id={@props.session?.id} onSuccess={@onSuccessUpload}/>
        <input ref="username" data-step="3" type="text" placeholder="username" value={@props.session?.username} className="transparent"/>
      </section>
      <section className="text">
        <p data-step="1">
          Secrets is a new way to share all those sites that conceal something special. From the cafe that has those delicious donuts to the park where you can practice yoga. Start playing right now...
        </p>
        <p data-step="2">
          You can discover and share secrets with your friends, but also you will meet other players like you. Play to get the highest number of secret spots or helps full filling the information.
        </p>
        <p data-step="3">
          Fill out your profile with a cool picture and choose a username that best identifies you.
        </p>

        <a data-step="0" href="#/howto/1" className="button theme radius">Let is start...</a>
        <a data-step="1" href="#/howto/2" className="button theme radius">Okay, understand</a>
        <a data-step="2" href="#/howto/3" className="button theme radius">Cool, show me more</a>
        <a ref="btnSaveProfile" data-step="3" href="#" onClick={@onSaveProfile} className="button theme radius">
          <abbr>Save my profile and start</abbr></a>
      </section>
    </article>
