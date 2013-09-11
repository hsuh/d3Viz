# ---
# Code to transition to streamgraph.
#
# For each of these chart transition functions,
# we first reset any shared scales and layouts,
# then recompute any variables that might get
# modified in other charts. Finally, we create
# the transition that switches the visualization
# to the new display.
# ---
define ['moo'], stream = (moo) ->
  return streamGraph: () ->
    vars  = moo.getVars()
    stack = vars.stack
    data  = vars.data
    y     = vars.y
    height = vars.height
    line   = vars.line
    area   = vars.area
    svg    = vars.svg
    duration = 750

    # 'wiggle' is the offset to use 
    # for streamgraphs.
    stack.offset("wiggle")

    # the stack layout will set the count0 attribute
    # of our data
    stack(data)

    # reset our y domain and range so that it 
    # accommodates the highest value + offset
    y.domain([0, d3.max(data[0].values.map((d) -> d.count0 + d.count))])
      .range([height, 0])

    # the line will be placed along the 
    # baseline of the streams, but will
    # be faded away by the transition below.
    # this positioning is just for smooth transitioning
    # from the area chart
    line.y((d) -> y(d.count0))

    # setup the area generator to utilize
    # the count0 values created from the stack
    # layout
    area.y0((d) -> y(d.count0))
      .y1((d) -> y(d.count0 + d.count))

    # here we create the transition
    # and modify the area and line for
    # each request group through postselection
    t = svg.selectAll(".request")
      .transition()
      .duration(duration)

    # D3 will take care of the details of transitioning
    # between the current state of the elements and
    # this new line path and opacity.
    t.select("path.area")
      .style("fill-opacity", 1.0)
      .attr("d", (d) -> area(d.values))

    # 1e-6 is the smallest number in JS that
    # won't get converted to scientific notation. 
    # as scientific notation is not supported by CSS,
    # we need to use this as the low value so that the 
    # line doesn't reappear due to an invalid number.
    t.select("path.line")
      .style("stroke-opacity", 1e-6)
      .attr("d", (d) -> line(d.values))
