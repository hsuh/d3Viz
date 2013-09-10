define ['moo', 'display', 'transitioner'], start = (moo, display, transition) ->
  return start: () ->
    # load the data and call 'display'
    d3.json("requests.json", display)

    # code to trigger a transition when one of the chart
    # buttons is clicked
    d3.selectAll(".switch").on "click", (d) ->
      d3.event.preventDefault()
      id = d3.select(this).attr("id")
      transition.transitionTo(id)
