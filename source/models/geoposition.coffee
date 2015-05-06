"use strict"

module.exports = class EntityGeoposition extends Hamsa

  @define
    coords        : type: Number, default: [0, 0]
    created_at    : type: Date, default: new Date()

  @current: ->
    @find()[0] or new @

  @get: ->
    promise = new Hope.Promise()
    navigator.geolocation.getCurrentPosition (position) =>
      @current().coords = [position.coords.latitude, position.coords.longitude]
      promise.done null, position
    , (error) ->
      promise.done error
    promise
