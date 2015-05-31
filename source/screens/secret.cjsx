Header      = require "../components/header"
Map         = require "../components/map"
FormSecret  = require "../components/form.secret"
Secret      = require "../models/secret"
request     = require "../modules/request"
C           = require "../modules/constants"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    id            : React.PropTypes.string

  getDefaultProps: ->
    routes: [
      icon: "back", back: true
    ]

  getInitialState: ->
    loading: false
    data    : {}

  # Lifecycle
  componentWillReceiveProps: (next_props) ->
    id = next_props.id or @props.id
    if id?
      secret = Secret.findBy("id", id)[0]
      if secret
        @setState data: secret
        request("GET", "secret/#{id}").then (error, response) => @setState data: response

  # -- Events
  onUser: (event) ->
    window.location = "#/user/#{@state.data.user.id}"

  # -- Render
  render: ->
    title = if @props.id then "Secret" else "New secret"
    <article id="secret" className={@props.active}>
      <Header title={title} routes={@props.routes} />
      {
        if @props.id
          <section className="scroll">
            <div data-flex="vertical center" style={backgroundImage: "url(#{@state.data.image})"}>
              <h1>{@state.data.title}</h1>
              <small>{C.TYPE_LITERAL[@state.data.type]}</small>
            </div>
            <Map center={@state.data.position} marker={@state.data.position} />
            <div className="user" onClick={@onUser}>
              <figure className="avatar" style={backgroundImage: "url(#{@state.data.user?.image})"}></figure>
              <div>
                <strong>{@state.data.user?.username}</strong>
                <small><strong>{@state.data.user?.secrets?.length}</strong> secrets</small>
              </div>
            </div>
            <div>
              <p>{@state.data.text}</p>
            </div>
            <div>
              <small>Tips</small>
              <ul>
              {
                for tip in (@state.data.tips or [])
                  <li>{tip.id}</li>
              }
              </ul>
            </div>
          </section>
        else
          <section>
            <FormSecret />
          </section>
      }
    </article>
