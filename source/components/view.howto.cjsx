"use strict"

App.HowTo = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    step          : React.PropTypes.number

  getDefaultProps: ->
    active        : false
    step          : 0

  # -- Render
  render: ->
    <article id="howto" className={@props.active} data-step={@props.step}>
      <section className="scene">
        <h1 data-step="1">Welcome to secrets</h1>
        <h1 data-step="2">funciona</h1>
        <h1 data-step="4">Choose your avatar</h1>
        <h1 data-step="3">Choose your avatar</h1>

        <img data-step="1" src="./assets/img/fox.png" className="fox" />

        <img data-step="2" src="./assets/img/rabbit.png" className="rabbit" />
        <img data-step="2" src="./assets/img/dog.png" className="dog" />
        <img data-step="2" src="./assets/img/bear.png" className="bear" />
        <img data-step="2" src="./assets/img/raccoon.png" className="raccoon" />
        <img data-step="2" src="./assets/img/pig.png" className="pig" />

        <figure data-step="3"></figure>
        <input data-step="3" type="text" placeholder="username" />
      </section>
      <section className="text">
        <p data-step="1">
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        </p>
        <p data-step="2">
          Tempor incididunt ut labore et dolore magna aliqua.
        </p>
        <p data-step="3">
          If you want have a better experience  necesasy
        </p>

        <a data-step="0" href="#" onClick={@props.onClick}>Let start...</a>
        <a data-step="1" href="#" onClick={@props.onClick}>Okay, show me</a>
        <a data-step="2" href="#" onClick={@props.onClick}>Okay, show me</a>
        <a data-step="3" href="#" onClick={@props.onClick}>Save my profile  start</a>
      </section>
    </article>
