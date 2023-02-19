-- last modified 2023-02-18

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
