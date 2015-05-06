"use strict"

module.exports = (data) ->
  <a href="/#/user/#{data.id}" data-flex="horizontal center" className="user">
    <figure></figure>
    <strong data-flex-grow="max">{data.name}</strong>
  </a>
