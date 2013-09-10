# ---
# Helper function that creates the 
# legend sidebar.
# ---
define ['moo'], legend = (moo) ->
  return createLegend: () ->
    vars = moo.getVars()
    data = vars.data
    legendWidth = 200
    legendHeight = 245
    showLegend = (d,i) ->
      d3.select("#legend svg g.panel")
        .transition()
        .duration(500)
        .attr("transform", "translate(0,0)")
    hideLegend = (d,i) ->
      d3.select("#legend svg g.panel")
        .transition()
        .duration(500)
        .attr("transform", "translate(165,0)")
    legend = d3.select("#legend").append("svg")
      .attr("width", legendWidth)
      .attr("height", legendHeight)

    legendG = legend.append("g")
      .attr("transform", "translate(165,0)")
      .attr("class", "panel")

    legendG.append("rect")
      .attr("width", legendWidth)
      .attr("height", legendHeight)
      .attr("rx", 4)
      .attr("ry", 4)
      .attr("fill-opacity", 0.5)
      .attr("fill", "white")

    legendG.on("mouseover", showLegend)
      .on("mouseout", hideLegend)

    keys = legendG.selectAll("g")
      .data(data)
      .enter().append("g")
      .attr("transform", (d,i) -> "translate(#{5},#{10 + 40 * (i + 0)})")

    keys.append("rect")
      .attr("width", 30)
      .attr("height", 30)
      .attr("rx", 4)
      .attr("ry", 4)
      .attr("fill", (d) -> color(d.key))

    keys.append("text")
      .text((d) -> d.key)
      .attr("text-anchor", "left")
      .attr("dx", "2.3em")
      .attr("dy", "1.3em")
