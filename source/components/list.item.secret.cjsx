distance    = require "../modules/distance"

module.exports = (data) ->
  <a href="#/secret/#{data.id}" data-flex="horizontal center" className="secret">
    <div data-flex="vertical" data-flex-grow="max">
      <strong>{data.title}</strong>
      <small>{data.text}</small>
    </div>
    <small>{distance data.position[1], data.position[0]}km</small>
  </a>
