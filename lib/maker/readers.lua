-- requires utils.lua to be loaded before

-- metatable for buffered input ports
-- NOTE: any field not found in an object is searched for in its metatable's .__index
local buffered_input_port_metatable = {
  __index = {}
}

function io.open_buffered(file, str)
  -- creates a buffered input port
  local o = {
    port = false,
    buffer = {}
  }
  if file then o.port = io.open(file) end
  if str then o.buffer = string_to_table(str) end
  setmetatable(o, buffered_input_port_metatable)
  return o
end

function buffered_input_port_metatable.__index:close()
  -- :close() works on buffered input ports
  if self.port then self.port:close() end
end

function buffered_input_port_metatable.__index:read_char()
  -- :read(1) works on buffered input ports
  -- arg is assumed to be 1. We don't need anything else
  local buf = self.buffer
  if #buf > 0 then return table.remove(buf, 1) end
  if self.port then return self.port:read(1) end
  return nil
end

function buffered_input_port_metatable.__index:read_line()
  local buf = self.buffer
  local s = ''
  if #buf > 0 then
    for k=1,#buf do
      local c = table.remove(buf, 1)
      if c == '\n' then return s end
      s = s .. c
    end
  end
  local s_extra = false
  if self.port then s_extra = self.port:read() end
  if s_extra then
    return s .. s_extra
  elseif s == '' then
    return nil
  else
    return s
  end
end

function buffered_input_port_metatable.__index:read(arg)
  if not arg then
    return self:read_line()
  elseif arg == 1 then
    return self:read_char()
  else
    print('Buffered input port .read: ' .. errmsg_file_context() .. ': Bad argument ' .. arg)
    error 'crash and burn'; return
  end
end

function buf_peek_char(bp)
  -- find next character in port without actually reading it
  local buf = bp.buffer
  if #buf > 0 then return buf[1] end
  local c = false
  if bp.port then c = bp.port:read(1) end
  if c then table.insert(buf, c) end
  return c
end

function buf_toss_back_char(c, bp)
  table.insert(bp.buffer, 1, c)
end

function buf_toss_back_string(s, bp)
  local k = #s
  if k == 0 then return end
  for j=k,1,-1 do
    buf_toss_back_char(s:sub(j,j), bp)
  end
end

local function string_trim_quotes(s)
  -- if string s is in double quotes, remove them
  return (string.gsub(s, '^"(.-)"$', '%1'))
end

local function table_insert_string(tbl, s)
  -- add string s to end of table tbl
  for i = 1,#s do
    table.insert(tbl, s[i])
  end
end

function identity(x)
  -- d'oh
  return x
end

function read_word(i)
  -- where word is made up of alphas and hyphens only
  -- this is enough to match our preproc directives
  local w = {}
  while true do
    local c = buf_peek_char(i)
    if not c then break
    elseif c:match('^%a') or c == '-' then
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

function ignore_spaces(i)
  while true do
    local c = buf_peek_char(i)
    if c == ' ' or c == '\t' or c == '\n' then
      i:read(1)
    else
      break
    end
  end
end

function make_read_group(code, errmsg_file_context)
  local function read_group (i, directive, scheme_p, multiline_p)
    -- reads braced input, without the braces
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
        print('read_group: ' .. errmsg_file_context() .. ': Runaway directive @' .. directive)
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
      elseif scheme_p and c == '"' then
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
  -- reads a braced group, returning its comma-separated constituents as a table
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
