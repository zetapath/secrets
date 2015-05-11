"use strict"

module.exports = class User extends Hamsa

  @define
    id            : type: String
    username      : type: String
    name          : type: String
    bio           : type: String
    image         : type: String
    followers     : type: Number
    following     : type: Number
