"use strict"

App.HowTo = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    step          : React.PropTypes.number.required

  getDefaultProps: ->
    active        : false
    step          : 0

  getInitialState: ->
    image         : @props.session?.image
    username      : false

  # -- Events
  onSaveProfile: (event) ->
    event.preventDefault()
    button = $$(@refs.btnSaveProfile.getDOMNode()).toggleClass "loading"
    # return
    parameters =
      username : @refs.username.getDOMNode().value.trim()
    App.proxy("PUT", "profile", parameters).then (error, response) =>
      App.session response unless error
      button.removeClass "loading"
      window.location = "/#/howto/#{parseInt(@props.step) + 1}"
      setTimeout (-> window.location = "/#/content/discover"), 2000

  onImage: (event) ->
    event.preventDefault()
    @refs.file.getDOMNode().click()

  onFileChange: (event) ->
    event.stopPropagation()
    event.preventDefault()
    file_url = event.target.files[0]
    if file_url.type.match /image.*/
      file_reader = new FileReader()
      file_reader.readAsDataURL file_url
      file_reader.onloadend = (event) => @setState image: event.target.result

      callbacks =
        progress: (progress) =>
          console.log progress
        error: =>
          alert "upload error!!"
        abort: =>
          alert "upload aborted"

      parameters =
        file  : file_url
        id    : App.session().id
        entity: "user"
      console.log parameters
      App.multipart("POST", "image", parameters, callbacks).then (error, file) =>
        console.log "POST/image", error, file

  # -- Render
  render: ->
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

        <figure ref="image" data-step="3" onClick={@onImage} style={backgroundImage: "url(#{@state.image})"}></figure>
        <input ref="file" type="file" onChange={@onFileChange} />
        <input ref="username" data-step="3" type="text" placeholder="username" value={@props.session?.username}/>
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

        <a data-step="0" href="#/howto/1">Let is start...</a>
        <a data-step="1" href="#/howto/2">Okay, understand</a>
        <a data-step="2" href="#/howto/3">Cool, show me more</a>
        <a ref="btnSaveProfile" data-step="3" href="#" onClick={@onSaveProfile} className="button">
          <abbr>Save my profile and start</abbr></a>
      </section>
    </article>
