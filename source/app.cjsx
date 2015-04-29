"use strict"

window.App = App =
  version : "0.4.29"
  entity  : {}
  proxy   : (method, api, parameters) -> @
  session : (value) ->
    if value?
      window.localStorage.setItem "secrets", JSON.stringify value
      value
    else
      JSON.parse window.localStorage.getItem "secrets"
