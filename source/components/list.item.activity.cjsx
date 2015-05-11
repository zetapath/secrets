"use strict"

moment  = require "moment"
C       = require "../modules/constants"

module.exports = (data) ->
  <div data-flex="horizontal center" className="activity">
    <figure style={backgroundImage: "url(#{data.user.image})"}>
      <figure style={backgroundImage: "url(#{data.reference.image})"} />
    </figure>
    <div data-flex="vertical" data-flex-grow="max">
      <strong data-flex-grow="max">{data.user.username}</strong>
      <small>{C.ACTIVITIES[data.type.toString()]}</small>
    </div>
    <small>{moment(data.created_at).fromNow()}</small>
  </div>
