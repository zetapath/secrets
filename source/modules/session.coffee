"use strict"

module.exports = (value) ->
  if value?
    window.localStorage.setItem "secrets", JSON.stringify value
    value
  else
    JSON.parse window.localStorage.getItem "secrets"
