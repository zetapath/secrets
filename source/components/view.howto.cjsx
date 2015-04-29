"use strict"

App.HowTo = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean

  getDefaultProps: ->
    active        : false

  getInitialState: ->
    step          : 0

  # -- Events
  componentDidMount: ->
    router = Router
      "/howto/:step"  : (step) => @setState step: step
    router.init window.location.hash or "/"

  onStep: (event) ->
    event.preventDefault()
    step = parseInt(@state.step) + 1
    window.location = "/#/howto/#{step}"

  # -- Render
  render: ->
    <article id="howto" className={@props.active} data-step={@state.step}>
      <section className="scene">
        <h1 data-step="1">Welcome to secrets</h1>
        <h1 data-step="2">funciona</h1>
        <h1 data-step="3">Choose your avatar</h1>

        <img data-step="1" src="./assets/img/animal.png" />
        <img data-step="2" src="./assets/img/an.png" />
        <img data-step="3" class="./assets/img" />
      </section>
      <section className="text">
        <p data-step="1">
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        </p>
        <a data-step={@state.step} href="#" onClick={@onStep}>Okay, show me</a>
      </section>
    </article>
