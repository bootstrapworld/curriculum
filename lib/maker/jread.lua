-- requires readers.lua to be loaded first

-- read_json_file(f) reads the (single) JSON object from f

local function json_ignorespaces(i)
  while true do
    local c = buf_peek_char(i)
    if c == ' ' or c == '\t' or c == '\n' or c == '\r' or c == ',' or c == ':' then
      i:read(1)
    else break
    end
  end
end

local current_json_file = 'none'

local json_read -- function defined below

local function json_read_hashtable(i)
  local result = { __json_keys = {} }
  while true do
    local key = json_read(i)
    if not key then break end
    local value = json_read(i)
    -- print('key=', key, 'value=', value)
    assert(value, 'bad JSON file ' .. current_json_file)
    table.insert(result.__json_keys, key)
    result[key] = value
  end
  -- print('json_read_hashtable retd', result)
  return result
end

local function json_read_array(i)
  local result = {}
  while true do
    local elt = json_read(i)
    if not elt then break end
    table.insert(result, elt)
  end
  -- print('json_read_array retd', result)
  return result
end

local function json_read_string(i)
  local result = {}
  local in_escape_p = false
  while true do
    local c = i:read(1)
    if not c then
      error 'Bad JSON string'; break
    elseif in_escape_p then
      in_escape_p = false
      table.insert(result, c)
    elseif c == '\\' then
      in_escape_p = true
      -- table.insert(result, c)
    elseif c == '"' then
      break
    else
      table.insert(result, c)
    end
  end
  local s = table.concat(result)
  -- print('json_read_string retd', s)
  return s
end

local function json_read_atom(i)
  local c 
  local result = {}
  local in_escape_p = false
  while true do
    c = buf_peek_char(i)
    if in_escape_p then
      in_escape_p = false
      i:read(1)
      table.insert(result, c)
    elseif c == '\\' then
      in_escape_p = true
      i:read(1)
      table.insert(result, c)
    elseif c == ' ' or c == '\t' or c == '\n' or c == '\r' or c == ',' or c == ':' or c == '"' or c == '{' or c == '[' then
      break
    else
      i:read(1)
      table.insert(result, c)
    end
  end
  result = table.concat(result)
  local n = tonumber(result)
  -- print('json_read_atom retd', result)
  return (n or result)
end

-- local
function json_read(i)
  json_ignorespaces(i)
  local c = buf_peek_char(i)
  -- print('c =', c)
  local result = false
  if not c then
    do end
  elseif c == '{' then
    i:read(1)
    json_ignorespaces(i)
    result = json_read_hashtable(i)
  elseif c == '[' then
    i:read(1)
    json_ignorespaces(i)
    result = json_read_array(i)
  elseif c == '}' or c == ']' then
    i:read(1)
  elseif c == '"' then
    i:read(1)
    result = json_read_string(i)
  else
    result = json_read_atom(i)
  end
  -- print('json_read retd', result)
  return result
end

function read_json_file(f)
  current_json_file = f
  local i = io.open_buffered(f)
  local status, result = pcall(json_read, i)
  i:close()
  if status then
    -- print('read_json_file retd', result)
    return result
  else
    error(result .. ' in ' .. f)
  end
end

function json_hash_stringify(j)
  local j_type = type(j)
  if j_type == 'table' then
    local kees = j.__json_keys
    if kees then
      local result = '{\n'
      local last_index = #kees
      for i,k in ipairs(kees) do
        local v = j[k]
        result = result .. '"' .. k .. '": ' .. json_hash_stringify(v) .. ((i == last_index) and '\n' or ',\n')
      end
      local result = result .. '}'
      return result
    else
      return 'ERROR'
    end
  elseif j_type == 'string' then
    local j2 = j:gsub('"', '\\"')
    return '"' .. j2 .. '"'
  else
    return 'ERROR'
  end
end

