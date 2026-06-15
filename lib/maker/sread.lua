-- last modified 2023-03-12

-- sread(i) reads an s-expression from buffered input port i
--
-- sread_file(f) reads the first s-expression from file f
--
-- requires readers.lua to be loaded first

local function sread_line(i)
  while true do
    local c = i:read(1)
    if c == nil or c == '\r' or c == '\n' then  -- nil == EOF
      break
    end
  end
end

local function sread_block_comment(i)
  while true do
    local c = i:read(1)
    if c == nil then  -- EOF inside an unterminated block comment
      break
    elseif c == '|' then
      c = i:read(1)
      if c == '#' then
        break
      elseif c == '|' then
        buf_toss_back_char(c, i)
      end
    end
  end
end

local function sread_ignorespaces(i)
  while true do
    local c = buf_peek_char(i)
    if c == ' ' or c == '\t' or c == '\n' or c == '\r' then
      i:read(1)
    elseif c == ';' then
      i:read(1)
      sread_line(i)
    elseif c == '#' then
      i:read(1)
      c = buf_peek_char(i)
      if c == '|' then
        i:read(1)
        sread_block_comment(i)
      else
        buf_toss_back_char('#', i)
        break
      end
    else break
    end
  end
end

local function sread_atom(i)
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
    elseif c == nil or c == ' ' or c == '\t' or c == '\n' or c == '\r' or c == '(' or c == '[' or c == ')' or c == ']' or c == ';' then
      break  -- nil == EOF terminates the atom
    else
      i:read(1)
      table.insert(result, c)
    end
  end
  result = table.concat(result)
  local n = tonumber(result)
  return (n or result)
end

local function sread_list(i)
  local c
  local result = {}
  while true do
    local x = sread(i)
    if x then
      table.insert(result, x)
    else
      break
    end
  end
  return result
end

local function sread_string(i)
  local result = {}
  local in_escape_p = false
  while true do
    local c = i:read(1)
    if c == nil then  -- EOF inside an unterminated string
      break
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
  return table.concat(result)
end

function sread(i)
  sread_ignorespaces(i)
  local c = buf_peek_char(i)
  local result = false
  if c == nil then  -- EOF: no s-expression to read (empty/exhausted input)
    result = false
  elseif c == '(' or c == '[' then
    i:read(1)
    result = sread_list(i)
  elseif c == ')' or c == ']' then
    i:read(1)
  elseif c == '"' then
    i:read(1)
    result = sread_string(i)
  else
    result = sread_atom(i)
  end
  --
  return result
end

function sread_file(f)
  local i = io.open_buffered(f)
  local result = sread(i)
  i:close()
  return result
end
