require ['jquery', 'jquery_ujs', 'turbolinks', 'bootstrap', 'd3', 'start'], ($,jujs,turbo,boots,d3,start) ->
  $ ->
    transitionTo = (name) ->
      if name == "stream"
        streamgraph()
      if name == "stack"
        stackedAreas()
      if name == "area"
        areas()

    start.start()
