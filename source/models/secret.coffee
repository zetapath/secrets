module.exports = class Secret extends Hamsa

  @define
    id            : type: String
    user          : type: Object
    image         : type: String
    text          : type: String
    title         : type: String
    type          : type: Number
    position      : type: Array
    tips          : type: Array
    created_at    : type: Date, default: new Date()
