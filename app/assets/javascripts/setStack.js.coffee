define ['moo'], (moo) ->
  vars  = moo.getVars()
  paddingBottom = 20
  width    = 880
  height   = 600 - paddingBottom
  duration = 750

  svg = d3.select("#viz").append("svg").attr("width", width)
        .attr("height", height + paddingBottom)
  color = d3.scale.category10()
  x     = d3.time.scale().range([0, width])
  y     = d3.scale.linear().range([height, 0])
  area  = d3.svg.area().interpolate("basis").x((d) -> x(d.date))
  stack = d3.layout.stack().values((d) -> d.values)
          .x((d) -> d.date).y((d) -> d.count)
          .out((d,y0,y) -> d.count0 = y0)
          .order("reverse")
  line  = d3.svg.line().interpolate("basis").x((d) -> x(d.date))
  xAxis = d3.svg.axis().scale(x)
          .tickSize(-height)
          .tickFormat(d3.time.format('%a %d'))

  return setStackOnVars: () ->
    vars.stack  = stack
    vars.x      = x
    vars.y      = y
    vars.xAxis  = xAxis
    vars.svg    = svg
    vars.height = height
    vars.width  = width
    vars.area   = area
    vars.line   = line
    vars.color  = color
