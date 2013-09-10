# ---
# Function that is called when data is loaded
# Here we will clean up the raw data as necessary
# and then call start() to create the baseline
# visualization framework.
# ---
define ['moo', 'setStack', 'legend', 'streamgraph'], (moo,stack, legend, stream) ->
  data    = null
  vars    = moo.getVars()
  stack.setStackOnVars()
  width  = vars.width
  height = vars.height
  svg    = vars.svg
  x      = vars.x
  y      = vars.y
  xAxis  = vars.xAxis
  area   = vars.area
  color  = vars.color

  display = (json) ->
    # a quick way to manually select which calls to display.
    # feel free to pick other keys and explore the less frequent call types.
    filterer = {"Heating": 1, "Damaged tree": 1, "Noise": 1, "Traffic signal condition": 1, "General construction":1, "Street light condition":1}
    data = json.filter((d) -> filterer[d.key] == 1)

    # a parser to convert our date string into a JS time object.
    parseTime = d3.time.format.utc("%x").parse

    # go through each data entry and set its
    # date and count property
    data.forEach (s) ->
      s.values.forEach (d) ->
        d.date = parseTime(d.date)
        d.count = parseFloat(d.count)

      # precompute the largest count value for each request type
      s.maxCount = d3.max(s.values, (d) -> d.count)

    data.sort((a,b) -> b.maxCount - a.maxCount)
    vars.data = data

    # first, lets setup our x scale domain
    # this assumes that the dates in our data are in order
    minDate = d3.min(data, (d) -> d.values[0].date)
    maxDate = d3.max(data, (d) -> d.values[d.values.length - 1].date)
    x.domain([minDate, maxDate])

    # D3's axis functionality usually works great
    # however, I was having some aesthetic issues
    # with the tick placement
    # here I extract out every other day - and 
    # manually specify these values as the tick 
    # values
    dates = data[0].values.map((v) -> v.date)
    index = 0
    dates = dates.filter (d) ->
      index += 1
      (index % 2) == 0

    xAxis.tickValues(dates)

    # the axis lines will go behind
    # the rest of the display, so create
    # it first
    svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)

    # I want the streamgraph to emanate from the
    # middle of the chart. 
    # we can set the area's y0 and y1 values to 
    # constants to achieve this effect.
    area.y0(height / 2)
      .y1(height / 2)

    # now we bind our data to create
    # a new group for each request type
    g = svg.selectAll(".request")
      .data(data)
      .enter()

    requests = g.append("g")
      .attr("class", "request")

    # add some paths that will
    # be used to display the lines and
    # areas that make up the charts
    requests.append("path")
      .attr("class", "area")
      .style("fill", (d) -> color(d.key))
      .attr("d", (d) -> area(d.values))

    requests.append("path")
      .attr("class", "line")
      .style("stroke-opacity", 1e-6)

    # create the legend on the side of the page
    legend.createLegend()
    stream.streamGraph()
