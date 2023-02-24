-- last modified 2023-02-24

buffered_input_port_metatable = {
  __index = {}
}

function io.open_buffered(f)
  local o = {
    port = io.open(f),
    buffer = {}
  }
  setmetatable(o, buffered_input_port_metatable)
  return o
end

function buffered_input_port_metatable.__index.close (self)
  self.port:close()
end

function buffered_input_port_metatable.__index.read (self, arg)
  -- arg must be 1
  local buf = self.buffer
  if #buf > 0 then return table.remove(buf, 1) end
  return self.port:read(1)
end

function buf_peek_char(bp)
  local buf = bp.buffer
  if #buf > 0 then return buf[1] end
  local c = bp.port:read(1)
  if c then table.insert(buf, c) end
  return c
end

function string_trim(s)
  local res = string.gsub(s, '^%s*(.-)%s*$', '%1')
  -- to avoid multiple values
  return res
end

function string_trim_quotes(s)
  local res = string.gsub(s, '^"(.-)"$', '%1')
  return res
end

function table_insert_string(tbl, s)
  for i = 1,#s do
    table.insert(tbl, s[i])
  end
end

function identity(x)
  return x
end

function read_word(i)
  local w = {}
  while true do
    local c = buf_peek_char(i)
    if c:match('^%a') or c == '-' then
      c = i:read(1)
      table.insert(w, c)
    else
      if #w == 0 then
        if c == '@' then
          i:read(1)
          table.insert(w, c)
        end
      end
      break
    end
  end
  return table.concat(w)
end

function make_read_group(code, errmsg_file_context)
  local function read_group (i, directive, scheme_p, multiline_p)
    local c = buf_peek_char(i)
    if c ~= '{' then
      print('WARNING: Ill-formed metadata directive in ' .. errmsg_file_context() .. ': @' .. directive .. '\n')
      return ''
    end
    --
    c = i:read(1)
    local r = {}
    local in_space_p = true -- if scheme_p or multiline_p, in_space_p is irrelevant
    local nesting = 0
    local in_string_p = false
    local in_escape_p = false
    while true do
      c = i:read(1)
      if not c then
        print('read_group: Runaway directive @' .. directive)
        print('Read so far: ' .. table.concat(r))
        error 'crash and burn'; break
      end
      -- print('c=' .. c .. ' e=' .. tostring(in_escape_p) .. ' s=' .. tostring(in_string_p) .. ' n=' .. nesting)
      if in_escape_p then
        table.insert(r, c)
        in_space_p = false
        in_escape_p = false
      elseif c == '\\' then
        table.insert(r, c)
        in_space_p = false
        in_escape_p = true
      elseif in_string_p then
        table.insert(r, c)
        in_space_p = false
        if c == '"' then
          -- print('ending string')
          in_string_p = false
        end
      elseif scheme_p and c == '@' then
        local directive = read_word(i)
        local gp = read_group(i, directive, scheme_p)
        if directive == 'code' then
          gp = code(gp)
        end
        table_insert_string(r, gp)
        in_space_p = false
      elseif c == '"' then
        -- print('starting string')
        table.insert(r, c)
        in_space_p = false
        in_string_p = true
      elseif c == ' ' or c == '\t' or c == '\n' or c == '\r' then
        if scheme_p or multiline_p then
          table.insert(r, c)
        elseif not in_space_p then
          table.insert(r, ' ')
        end
        in_space_p = true
      elseif c == '{' then
        table.insert(r, c)
        in_space_p = false
        nesting = nesting + 1
      elseif c == '}' then
        -- print('deduct nesting')
        if nesting == 0 then break end
        table.insert(r, c)
        in_space_p = false
        nesting = nesting - 1
      else
        table.insert(r, c)
        in_space_p = false
      end
    end
    local s = table.concat(r)
    if not multiline_p then s = string_trim(s) end
    return s
  end
  return read_group
end

function read_commaed_group(ip, directive, read_group)
  local g = read_group(ip, directive)
  local r = {}
  local i = 1
  local n = #g
  while true do
    if i > n then break end
    local j = i
    local in_string_p = false
    local in_escape_p = false
    while true do
      if j > n then
        table.insert(r, g:sub(i,n))
        i = j
        break
      end
      local c = g:sub(j,j)
      -- assert(c, 'read_commaed_group: shouldn\'t happen')
      if in_escape_p then
        in_escape_p = false
        j = j + 1
      elseif c == '\\' then
        in_escape_p = true
        j = j + 1
      elseif in_string_p then
        in_string_p = (c == '"') and false or true
        j = j + 1
      elseif c == '"' then
        in_string_p = true
        j = j + 1
      elseif c == ',' then
        table.insert(r, g:sub(i, j-1))
        i = j + 1
        break
      else
        j = j + 1
      end
    end
  end
  for i,s in ipairs(r) do
    r[i] = string_trim_quotes(string_trim(s))
  end
  return r
end
