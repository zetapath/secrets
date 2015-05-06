"use strict"

module.exports = (data) ->
  <a href="/#/secret/#{data.id}" data-flex="horizontal center" className="secret">
    <figure style={backgroundImage: "url(#{data.image})"}></figure>
    <div data-flex="vertical" data-flex-grow="max">
      <strong>{data.title}</strong>
      <small>{data.text}</small>
    </div>
    <small>?? meters</small>
  </a>
