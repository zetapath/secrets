"use strict"

class App.entity.Session extends Hamsa

  @define
    id            : type: String
    mail          : type: String
    username      : type: String
    name          : type: String
    avatar        : type: String, default: "./assets/image/avatar.jpg"
    updated_at    : type: Date
    created_at    : type: Date, default: new Date()
