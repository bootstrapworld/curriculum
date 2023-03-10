-- last modified 2023-03-09

function memberp(elt, tbl)
  -- true iff tbl contains elt
  -- tbl is not required to be pure array
  for _,val in pairs(tbl) do
    if elt == val then return true end
  end
  return false
end

function file_exists_p(f)
  local h = io.open(f)
  -- open'ing a nonexistent file returns nil
  if h then h:close(); return true
  else return false
  end
end

function touch(f)
  if not file_exists_p(f) then
    local o = io.open(f, 'w')
    o:close()
  end
end

function copy_file_to_port(f, o)
  -- dump contents of file f into output port o
  -- not an error if f doesn't exist
  if not file_exists_p(f) then return end
  local i = io.open(f)
  for line in i:lines() do
    o:write(line, '\n')
  end
  i:close()
end

function head(f, num, pat)
  -- true if file f contains the pattern pat within its first num lines
  local i = io.open(f)
  if not i then return false end
  local k = 1
  local res = false
  while k <= num do
    local x = i:read()
    if not x then break end
    if x:find(pat) then res = true; break end
    k = k + 1
  end
  i:close()
  return res
end

function string_split(s, c)
  -- return table of substrings of string s separated by string c
  -- note: c is treated verbatim, not as pattern
  local r = {}
  if s then
    local start = 1
    local i
    while true do
      i = string.find(s, c, start, true)
      if not i then
        table.insert(r, string.sub(s, start, -1))
        break
      end
      table.insert(r, string.sub(s, start, i-1))
      start = i+1
    end
  end
  return r
end

function read_file_lines(f)
  -- return a table whose elements are the lines in the file
  local i = io.open(f)
  local result = {}
  for x in i:lines() do
    table.insert(result, x)
  end
  i:close()
  return result
end
