distance    = require "../modules/distance"

module.exports = (data) ->
  <a href="/#/purchase/#{data.id}" data-flex="horizontal center" className="purchase">
    <figure className="type-0#{data.type}"></figure>
    <div data-flex="vertical" data-flex-grow="max">
      <strong>{distance data.position[1], data.position[0]}km</strong>
      <small>{data.text}</small>
    </div>
  </a>
