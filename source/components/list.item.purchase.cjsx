"use strict"

Geoposition = require "../models/geoposition"
distance    = require "../modules/distance"

module.exports = (data) ->
  gps = Geoposition.current().coords

  <a href="/#/purchase/#{data.id}" data-flex="horizontal center" className="secret">
    <figure></figure>
    <div data-flex="vertical" data-flex-grow="max">
      <strong>{data.title}</strong>
      <small>{data.text}</small>
    </div>
    <small>{distance data.position[1], data.position[0], gps[0], gps[1]}km</small>
  </a>
