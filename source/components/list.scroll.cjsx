module.exports = React.createClass

  # -- States & Properties
  propTypes:
    itemCount     : React.PropTypes.number.isRequired
    itemHeight    : React.PropTypes.number.isRequired
    itemFactory   : React.PropTypes.func.isRequired
    dataSource    : React.PropTypes.array.isRequired
    topBoundary   : React.PropTypes.number
    bottomBoundary: React.PropTypes.number

  getDefaultProps: ->
    itemHeight    : 0
    itemFactory   : (index) -> <div key={index}></div>
    dataSource    : []
    topBoundary   : null
    bottomBoundary: null

  getInitialState: ->
    clientHeight  : null
    scrollTop     : 0

  # -- Lifecycle
  componentDidMount: ->
    @setState clientHeight: @getDOMNode().clientHeight

  # -- Events
  onScroll: ->
    @setState scrollTop: @getDOMNode().scrollTop

  # -- Render
  render: ->
    <section data-list-scroll onScroll={@onScroll} onClick={@props.onClick}>
      <ul style={height: "#{@props.dataSource.length * @props.itemHeight}px"}>
      {
        if @props.dataSource.length > 0
          for index in [@_topRenderBoundary()...@_bottomRenderBoundary()]
            <li key={index} style={@_transform 0, index * @props.itemHeight}>
              {@props.itemFactory @props.dataSource[index]}
            </li>
      }
      </ul>
    </section>

  # -- Private methods
  _topRenderBoundary: ->
    Math.floor (@props.topBoundary or @state.scrollTop) / @props.itemHeight

  _bottomRenderBoundary: ->
    boundary = @props.bottomBoundary or @state.scrollTop + @state.clientHeight
    maxBoundary = @props.itemHeight * @props.dataSource.length
    boundary = maxBoundary if boundary > maxBoundary
    Math.ceil boundary / @props.itemHeight

  _transform: (x, y) ->
    style = {}
    if supports3D
      style[transformProp] = "translate3d(#{x}px, #{y}px, 0)"
    else if supports2D
      style[transformProp] = "translate(#{x}px, #{y}px)"
    else
      style.top = "#{y}px"
      style.left = "#{x}px"
    style

###
Taken from emberjs/list-view
###

el = document.createElement 'div'
style = el.style

propPrefixes = ['Webkit', 'Moz', 'O', 'ms']

testProp = (prop) ->
  return prop if prop of style
  uppercaseProp = prop.charAt(0).toUpperCase() + prop[1...]
  for i in [0...propPrefixes.length]
    prefixedProp = propPrefixes[i] + uppercaseProp
    return prefixedProp if prefixedProp of style
  null

transformProp = testProp 'transform'
perspectiveProp = testProp 'perspective'

supports2D = transformProp?
supports3D = perspectiveProp?
