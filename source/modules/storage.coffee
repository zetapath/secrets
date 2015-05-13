module.exports = (value) ->
  if value or value is null
    window.localStorage.setItem "secrets", JSON.stringify value
    value
  else
    JSON.parse window.localStorage.getItem "secrets"
