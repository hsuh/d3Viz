# ---
# Code to transition to Stacked Area chart.
#
# Again, like in the streamgraph function,
# we use the stack layout to manage
# the layout details.
# ---
define ['moo'], stacked = (moo) ->
  return stackedAreas: () ->
    vars  = moo.getVars()
    stack = vars.stack
    data  = vars.data
    y     = vars.y
    height = vars.height
    line   = vars.line
    area   = vars.area
    svg    = vars.svg
    duration = 750

    # the offset is the only thing we need to 
    # change on our stack layout to have a completely
    # different type of chart!
    stack.offset("zero")
    # re-run the layout on the data to modify the count0
    # values
    stack(data)

    # the rest of this is the same as the streamgraph - but
    # because the count0 values are now set for stacking, 
    # we will get a Stacked Area chart.
    y.domain([0, d3.max(data[0].values.map((d) -> d.count0 + d.count))])
      .range([height, 0])

    line.y((d) -> y(d.count0))

    area.y0((d) -> y(d.count0))
      .y1((d) -> y(d.count0 + d.count))

    t = svg.selectAll(".request")
      .transition()
      .duration(duration)

    t.select("path.area")
      .style("fill-opacity", 1.0)
      .attr("d", (d) -> area(d.values))

    t.select("path.line")
      .style("stroke-opacity", 1e-6)
      .attr("d", (d) -> line(d.values))
