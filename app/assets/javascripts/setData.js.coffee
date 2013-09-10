define ['moo', 'display'], (moo, display) ->
  vars = moo.getVars()
  # load the data and call 'display'
  d3.json("requests.json", display)
  console.log('display', display)
  return setDataOnVars: () -> vars.data = data
