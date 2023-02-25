-- last modified 2023-02-25

function memberp(elt, tbl)
  for _,val in pairs(tbl) do
    if elt == val then return true end
  end
  return false
end

function file_exists_p(f)
  -- print('doing file_exists_p', f)
  local h = io.open(f)
  if h then h:close(); return true
  else return false
  end
end

function copy_file_to_port(f, o)
  if not file_exists_p(f) then return end
  local i = io.open(f)
  for line in i:lines() do
    o:write(line, '\n')
  end
  i:close()
end

function head(f, num, pat)
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
