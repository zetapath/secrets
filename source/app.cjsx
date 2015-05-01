"use strict"

window.App = App =
  version   : "0.4.30"

  host      : "http://178.62.129.192:1338/"

  token     : ""

  entity    : {}

  proxy     : (type, method, parameters) ->
    promise = new Hope.Promise()
    $$.ajax
      url         : "#{App.host}api/#{method}"
      type        : type
      data        : parameters
      contentType : "application/x-www-form-urlencoded"
      dataType    : 'json'
      headers     : "Authorization": App.token or null
      success: (response, xhr) ->
        promise.done null, response
      error: (xhr, error) =>
        error = code: error.status, message: error.response
        console.error "__.proxy [ERROR #{error.code}]: #{error.message}"
        promise.done error, null
    promise

  multipart : (method, parameters, callbacks = {}) ->
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

    xhr.open "POST", "#{App.host}api/#{method}"
    xhr.send formData
    promise

  session   : (value) ->
    if value?
      window.localStorage.setItem "secrets", JSON.stringify value
      value
    else
      JSON.parse window.localStorage.getItem "secrets"
