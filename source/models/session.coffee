"use strict"

module.exports = class Session extends Hamsa

  @define
    id            : type: String
    mail          : type: String
    token         : type: String
    username      : type: String
    name          : type: String
    bio           : type: String
    image         : type: String

    secrets       : type: Array
    purchases     : type: Array
    tips          : type: Array

    followers     : type: Number
    following     : type: Number

    updated_at    : type: Date
    created_at    : type: Date, default: new Date()
