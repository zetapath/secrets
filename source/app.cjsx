"use strict"

window.App = App =
  version   : "0.4.30"

  api       : "http://178.62.129.192:1338/api"

  entity    : {}

  proxy     : (method, api, parameters) -> @

  multipart : (type, url, parameters, callbacks = {}) ->
    promise = new Hope.Promise()
    formData = new FormData()
    formData.append(name, value) for name, value of parameters
    xhr = new XMLHttpRequest()
    xhr.responseType = "json"
    onLoadComplete = -> promise.done null, @response
    xhr.addEventListener "load", onLoadComplete, false

    if callbacks.progress then xhr.upload.addEventListener "progress", callbacks.progress, false
    if callbacks.error    then xhr.addEventListener "error", callbacks.error, false
    if callbacks.abort    then xhr.addEventListener "abort", callbacks.abort, false

    xhr.open "POST", "#{@api}#{url}"
    xhr.send formData
    promise

  session   : (value) ->
    if value?
      window.localStorage.setItem "secrets", JSON.stringify value
      value
    else
      JSON.parse window.localStorage.getItem "secrets"
