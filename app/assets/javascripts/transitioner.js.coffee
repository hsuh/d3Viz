# ---
# Called when the chart buttons are clicked.
# Hands off the transitioning to a new chart
# to separate functions, based on which button
# was clicked.
# ---

define ['streamgraph', 'stacked_areas', 'area'],transitionTo = (sg, sa, area) ->
  return transitionTo: (name) ->
    if name is "stream"
      sg.streamGraph()
    if name is "stack"
      sa.stackedAreas()
    if name is "area"
      area.areas()
