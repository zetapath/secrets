module.exports = React.createClass

  # -- States & Properties
  propTypes:
    onClick: React.PropTypes.func.isRequired

  getDefaultProps: ->
    dataSource  : []
    renderRow   : "App.ItemSecret"
    search      : false

  # -- Events
  onSearch: (event) ->
    # event.preventDefault()
    value = @refs.search.getDOMNode().value.trim()
    console.log "[search]", value

  # -- Render
  render: ->
    <ul>
      {
        if @props.search
          <input ref="search" type="search" placeholder="search" onSearch={@onSearch} autofocus />
      }
      {
        <App.ItemSecret model={item} onClick={@props.onClick} /> for item, index in @props.dataSource
      }
    </ul>
