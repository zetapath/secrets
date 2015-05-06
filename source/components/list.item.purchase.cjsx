"use strict"

module.exports = (data) ->
  <a href="/#/purchase/#{data.id}" data-flex="horizontal center" className="secret">
    <figure></figure>
    <div data-flex="vertical" data-flex-grow="max">
      <strong>{data.title}</strong>
      <small>{data.text}</small>
    </div>
    <small>?? m</small>
  </a>
