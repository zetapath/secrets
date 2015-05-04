"use strict"

Loading   = require "./loading"
multipart = require "../modules/multipart"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    url     : React.PropTypes.string.required
    entity  : React.PropTypes.string.required
    id      : React.PropTypes.string.required
    step    : React.PropTypes.string

  getInitialState: ->
    url     : @props.url
    loading : false

  # -- Events
  onClick: (event) ->
    event.stopPropagation()
    @refs.file.getDOMNode().click()

  onFileChange: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @setState file: undefined, loading: true
    file_url = event.target.files[0]
    if file_url.type.match /image.*/
      file_reader = new FileReader()
      file_reader.readAsDataURL file_url
      file_reader.onloadend = (event) => @setState url: event.target.result
      parameters = file: file_url, entity: @props.entity, id: @props.id
      multipart("POST", "image", parameters).then (error, response) =>
        unless error
          @setState loading: false
          @props.onSuccess.call @, response

  # -- Render
  render: ->
    <figure data-upload-image
        ref="image"
        className={@props.entity}
        onClick={@onClick}
        style={backgroundImage: "url(#{@state.url})"}
        data-step={@props.step}>
      <input ref="file" type="file" onChange={@onFileChange} />
      { <Loading type="relative" /> if @state.loading }
    </figure>
