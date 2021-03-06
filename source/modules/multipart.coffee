storage = require "../modules/storage"
C       = require "./constants"

module.exports = (type, method, parameters, callbacks = {}) ->
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

  xhr.open "POST", "#{C.HOST}api/#{method}"
  xhr.setRequestHeader "Authorization", storage()?.token or null
  xhr.send formData
  promise
