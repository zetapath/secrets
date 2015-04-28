"use strict"

App.Dialog = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean

  # -- Events

  # -- Render
  render: ->
    <div data-dialog className={@props.active}>
      <div>
        <h1>Jonathan Smith</h1>
        <p>has been notified you re on Your way</p>
        <img src="./assets/img/animal.png" />
        <small>123 Corey Rd.</small>
        <small>Brooklyn, Ma 02130</small>

        <button>Get Directions</button>
        <a href="/#/">Cancel and go back</a>
      </div>
    </div>
