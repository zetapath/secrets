"use strict"

module.exports = (data) ->
  <div data-flex="horizontal center" className="activity">
    <figure style={backgroundImage: "url(#{data.user.image})"}></figure>
    <div data-flex="vertical" data-flex-grow="max">
      <strong data-flex-grow="max">{data.user.username}</strong>
      <small>{data.type}</small>
    </div>
    <small>{data.created_at}</small>
  </div>
