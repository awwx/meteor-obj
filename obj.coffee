obj = (args...) ->
  result = {}
  i = 0
  while i < args.length
    arg = args[i]
    if typeof arg is "string"
      ++i
      if i >= args.length
        throw new Error("missing value argument following key string")
      val = args[i]
      if val is undefined
        delete result[arg]
      else
        result[arg] = val
    else if not arg?
      # skip on null or undefined
    else if typeof arg isnt "object"
      throw new Error("invalid type passed to `obj`: #{arg}")
    else
      for key, val of arg
        if val is undefined
          delete result[key]
        else
          result[key] = val
    ++i
  result
