module.exports = (data) ->
  <a href="#/user/#{data.id}" data-flex="horizontal center" className="user">
    <figure style={backgroundImage: "url(#{data.image})"}></figure>
    <strong data-flex-grow="max">{data.name}</strong>
  </a>
