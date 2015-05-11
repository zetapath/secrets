"use strict"

Session     = require "../models/session"
Purchase    = require "../models/purchase"
distance    = require "../modules/distance"
request     = require "../modules/request"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean

  getDefaultProps: ->
    active        : false

  getInitialState: ->
    data          : {}

  # -- Lifecycle
  componentWillReceiveProps: (next_props) ->
    id = next_props.id or @props.id
    @setState data: purchase if id? and purchase = Purchase.findBy("id", id)[0]

  # -- Events
  onPurchase: (event) ->
    event.preventDefault()
    button = @refs.btn_purchase.getDOMNode().classList
    button.add "loading"

    Hope.shield([ ->
      request "POST", "purchase", secret: @state.data.id
    , ->
      Session.update()
    ]).then (error, response) =>
      button.remove "loading"
      console.log "POST/purchase", error, response

  # -- Render
  render: ->
    kms = distance @state.data.position?[1], @state.data.position?[0]
    <div id="purchase" data-dialog className={@props.active}>
      <div>
        <h1>{kms} km</h1>
        <p>{@state.data.text}</p>
        <img src="./assets/img/pushpin.png" />
        <small>loelrk</small>
        <button ref="btn_purchase" onClick={@onPurchase} className="radius transparent">
          <abbr>Purchase 3 coins</abbr>
        </button>
        <a href="/#/">x</a>
      </div>
    </div>
