"use strict"

module.exports = (data) ->
  <a href="/#/purchase/#{data.id}" data-flex="horizontal center" className="secret">
    <figure></figure>
    <div data-flex="vertical" data-flex-grow="max">
      <strong>{data.name}</strong>
      <small>{data.description}</small>
    </div>
    <small>{data.id} meters</small>
  </a>
