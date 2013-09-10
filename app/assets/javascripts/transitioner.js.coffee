# ---
# Called when the chart buttons are clicked.
# Hands off the transitioning to a new chart
# to separate functions, based on which button
# was clicked. 
# ---

define ['d3'], transitionTo = (name) ->
  if name == "stream"
    streamgraph()
  if name == "stack"
    stackedAreas()
  if name == "area"
    areas()
