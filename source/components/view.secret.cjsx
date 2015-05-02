"use strict"

App.Secret = React.createClass

  # -- States & Properties
  propTypes:
    active        : React.PropTypes.boolean
    id            : React.PropTypes.string

  getDefaultProps: ->
    routes: [
      icon: "back", route: "/"
    ]

  # -- Events

  # -- Render
  render: ->
    title = if @props.id then "Secret" #else "New secret"

    <article id="secret" className={@props.active}>
      <App.Header title={title} routes={@props.routes} />
      <section>
        <div>
          <h1>Nombre de local</h1>
          <small>tipo</small>
        </div>
        <App.Map />
        <div className="user">
          <figure className="avatar"></figure>
          <div>
            <strong>Javi Jimenez</strong>
            <small>123 checkins</small>
          </div>
        </div>

        <p>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit...
        </p>
        {
          if @props.id
            <h2>Tips</h2>
            <ul>
            </ul>
        }

        <nav>
          <button><abbr>Save secret</abbr></button>
          <button><abbr>Add to favorite</abbr></button>
        </nav>
      </section>
    </article>
