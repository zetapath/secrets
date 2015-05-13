storage = require "../modules/storage"
C       = require "./constants"

module.exports = (type, method, parameters) ->
  promise = new Hope.Promise()
  $$.ajax
    url         : "#{C.HOST}api/#{method}"
    type        : type
    data        : parameters
    contentType : "application/x-www-form-urlencoded"
    dataType    : 'json'
    headers     : "Authorization": storage()?.token or null
    success: (response, xhr) ->
      if xhr.response.trim() is ""
        promise.done error = true
      else
        promise.done null, response
    error: (xhr, error) =>
      error = code: error.status, message: error.response
      console.error "request [ERROR #{error.code}]: #{error.message}"
      promise.done error, null
  promise
