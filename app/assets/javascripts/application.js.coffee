require ['jquery', 'jquery_ujs', 'turbolinks', 'bootstrap', 'd3', 'start'], ($,jujs,turbo,boots,d3,start) ->
  $ ->
    transitionTo = (name) ->
      if name == "stream"
        streamgraph()
      if name == "stack"
        stackedAreas()
      if name == "area"
        areas()

    # code to trigger a transition when one of the chart
    # buttons is clicked
    #d3.selectAll(".switch").on "click", (d) ->
      #d3.event.preventDefault()
      #id = d3.select(this).attr("id")
      #transitionTo(id)

    start.start()
