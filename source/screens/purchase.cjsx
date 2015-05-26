
SPArouter   = require "spa-router"
# -- Models
Session     = require "../models/session"
Purchase    = require "../models/purchase"
# -- Modules
distance    = require "../modules/distance"
request     = require "../modules/request"
C           = require "../modules/constants"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean

  getDefaultProps: ->
    active        : false

  getInitialState: ->
    data          : {}
    session       : Session.instance()

  # -- Lifecycle
  componentWillReceiveProps: (next_props) ->
    id = next_props.id or @props.id
    @setState data: purchase if id? and purchase = Purchase.findBy("id", id)[0]

  componentDidMount: ->
    Session.observe (state) =>
      @setState session: state.object if state.object instanceof Session
    , ["add", "update"]

  # -- Events
  onPurchase: (event) ->
    event.preventDefault()
    button = @refs.btn_purchase.getDOMNode().classList
    button.add "loading"

    Hope.shield([ =>
      request "POST", "purchase", secret: @state.data.id
    , ->
      Session.update()
    ]).then (error, response) =>
      unless error
        button.remove "loading"
        SPArouter.path "content/purchases"

  # -- Render
  render: ->
    kms = distance @state.data.position?[1], @state.data.position?[0]
    wallet = @state.session.wallet
    <div id="purchase" data-dialog className={@props.active}>
      <div>
        <h1>{kms} km</h1>
        <p>{@state.data.text}</p>
        <img src="./assets/img/pushpin.png" />
        {
          if wallet >= 3
            <div>
              <button ref="btn_purchase" onClick={@onPurchase} className="radius transparent">
                <abbr>Buy secret with 3 coins</abbr>
              </button>
              <small>Now you have <strong>{wallet} coins</strong> in your purse.</small>
            </div>
          else
            <small>You do not have enough coins for get this secret</small>
        }
        <a href="#/" class="button">x</a>
      </div>
    </div>
