"use strict"

module.exports = class EntitySession extends Hamsa

  @define
    id            : type: String
    mail          : type: String
    token         : type: String
    username      : type: String
    name          : type: String
    bio           : type: String
    image         : type: String
    updated_at    : type: Date
    created_at    : type: Date, default: new Date()
