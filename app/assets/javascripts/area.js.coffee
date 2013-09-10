# ---
# Code to transition to Area chart.
# ---
areas = () ->
  g = svg.selectAll(".request")

  # set the starting position of the border
  # line to be on the top part of the areas.
  # then it is immediately hidden so that it
  # can fade in during the transition below
  line.y((d) -> y(d.count0 + d.count))
  g.select("path.line")
    .attr("d", (d) -> line(d.values))
    .style("stroke-opacity", 1e-6)

 
  # as there is no stacking in this chart, the maximum
  # value of the input domain is simply the maximum count value,
  # which we precomputed in the display function 
  y.domain([0, d3.max(data.map((d) -> d.maxCount))])
    .range([height, 0])

  # the baseline of this chart will always
  # be at the bottom of the display, so we
  # can set y0 to a constant.
  area.y0(height)
    .y1((d) -> y(d.count))

  line.y((d) -> y(d.count))

  t = g.transition()
    .duration(duration)

  # transition the areas to be 
  # partially transparent so that the
  # overlap is better understood.
  t.select("path.area")
    .style("fill-opacity", 0.5)
    .attr("d", (d) -> area(d.values))

  # here we finally show the line 
  # that serves as a nice border at the
  # top of our areas
  t.select("path.line")
    .style("stroke-opacity", 1)
    .attr("d", (d) -> line(d.values))
