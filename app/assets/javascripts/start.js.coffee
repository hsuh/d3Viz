define ['moo', 'display'], start = (moo, display) ->
  return start: () ->
    # load the data and call 'display'
    d3.json("requests.json", display)

