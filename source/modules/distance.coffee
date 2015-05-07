"use strict"

module.exports = (lat1, lon1, lat2, lon2) ->
  dLat = degreesToRadians(lat2 - lat1)
  dLon = degreesToRadians(lon2 - lon1)

  a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(degreesToRadians(lat1)) * Math.cos(degreesToRadians(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2)
  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  distance = (parseInt (RADIUS * c) / 1000).toFixed(1)
  distance = (RADIUS * c).toFixed(1)

RADIUS = 6371

degreesToRadians = (deg) ->
  deg * Math.PI / 180
