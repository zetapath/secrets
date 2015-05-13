Loading   = require "./loading"
multipart = require "../modules/multipart"

module.exports = React.createClass

  # -- States & Properties
  propTypes:
    url       : React.PropTypes.string
    entity    : React.PropTypes.string.required
    id        : React.PropTypes.string
    step      : React.PropTypes.string
    onSuccess : React.PropTypes.function
    onFile    : React.PropTypes.function

  getInitialState: ->
    url       : @props.url
    loading   : false

  # -- Events
  onClick: (event) ->
    event.stopPropagation()
    @refs.file.getDOMNode().click()

  onFileChange: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @setState file: undefined
    file_url = event.target.files[0]
    if file_url?.type.match /image.*/
      @setState loading: true
      file_reader = new FileReader()
      file_reader.readAsDataURL file_url
      file_reader.onloadend = (event) => @setState url: event.target.result
      if @props.onSuccess
        parameters = file: file_url, entity: @props.entity, id: @props.id
        multipart("POST", "image", parameters).then (error, response) =>
          unless error
            @setState loading: false
            @props.onSuccess.call @, response
      else
        @props.onFile.call @, file_url if @props.onFile
        @setState loading: false

  # -- Render
  render: ->
    classProperty = @props.entity
    if @state.url
      styleProperty = backgroundImage: "url(#{@state.url})"
    if not @state.url and not @state.loading
      classProperty += " upload"
    <figure data-upload-image
        ref="image"
        className={classProperty}
        style={styleProperty}
        data-step={@props.step}
        onClick={@onClick}>
      <input ref="file" type="file" onChange={@onFileChange} />
      { <Loading type="relative" /> if @state.loading }
    </figure>
