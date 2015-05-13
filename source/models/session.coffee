request = require "../modules/request"
storage = require "../modules/storage"

module.exports = class Session extends Hamsa

  @define
    id            : type: String
    mail          : type: String
    token         : type: String
    username      : type: String
    name          : type: String
    bio           : type: String
    image         : type: String
    wallet        : type: Number

    secrets       : type: Array
    purchases     : type: Array
    tips          : type: Array

    followers     : type: Array
    following     : type: Array

    updated_at    : type: Date
    created_at    : type: Date, default: new Date()

  @update = ->
    promise = new Hope.Promise()
    @destroyAll()
    request("GET", "profile").then (error, response) =>
      return promise.done error = true if error
      storage response
      promise.done false, new @ response
    promise

  @instance = -> @find()[0]
