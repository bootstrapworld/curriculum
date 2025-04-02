#! /usr/bin/env lua

-- reads from the stdin,
-- removes leading pluses,
-- removes stuff enclosed in backticks,
-- converts newlines to spaces,
-- writes to stdout

local function skip_non_natlang(x)
  x = x:gsub('\n%+', ' ')
  x = x:gsub('\n', ' ')
  x = x:gsub('```.-```', '')
  x = x:gsub('``.-``', '')
  x = x:gsub('`.-`', '')
  return x
end

io.write(skip_non_natlang(io.read('*a')))
