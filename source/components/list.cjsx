module.exports = React.createClass

  # -- States & Properties
  propTypes:
    onClick: React.PropTypes.func.isRequired

  getDefaultProps: ->
    dataSource  : []
    renderRow   : "App.ItemSecret"

  # -- Events
  onSearch: (event) ->
    # event.preventDefault()
    value = @refs.search.getDOMNode().value.trim()
    console.log "[search]", value

  # -- Render
  render: ->
    <ul>
    {
      for item, index in @props.dataSource
        <li key={index}>
          {@props.itemFactory @props.dataSource[index]}
        </li>
    }
    </ul>
