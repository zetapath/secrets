module.exports = React.createClass

  # -- States & Properties
  propTypes:
    type  : React.PropTypes.string

  getDefaultProps: ->
    type  : "absolute"

  # -- Render
  render: ->
    <div data-loading data-flex="vertical center" className={@props.type}>
      <div></div><div></div><div></div>
    </div>
