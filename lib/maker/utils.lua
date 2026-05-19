-- Detect stat syntax once at load time (macOS vs Linux)
local _stat_cmd
do
  local h = io.popen('uname -s')
  local os_name = h:read()
  h:close()
  _stat_cmd = (os_name == 'Darwin')
    and "stat -f '%m\t%N'"   -- macOS
    or  "stat -c '%Y\t%n'"   -- Linux/GNU
end

-- Returns a table mapping filepath -> mtime (integer).
-- Uses a single xargs invocation for the whole list.
local function batch_mtimes(files)
  if #files == 0 then return {} end
  local tmp = os.tmpname()
  local fh = io.open(tmp, 'w')
  for _, f in ipairs(files) do fh:write(f, '\0') end
  fh:close()
  local mtimes = {}
  local h = io.popen('xargs -0 ' .. _stat_cmd .. ' < ' .. tmp .. ' 2>/dev/null')
  for line in h:lines() do
    local t, f = line:match('^(%d+)\t(.+)$')
    if t then mtimes[f] = tonumber(t) end
  end
  h:close()
  os.remove(tmp)
  return mtimes
end

-- Returns only the adoc files whose .asc is missing or older than the .adoc.
function filter_stale(adoc_list)
  if #adoc_list == 0 then return {} end
  local asc_of = {}
  local asc_list = {}
  for _, adoc in ipairs(adoc_list) do
    if adoc == '' then goto continue end          -- skip blank lines
    local dir, base = adoc:match('^(.*)/([^/]+)$')
    if not dir then goto continue end             -- skip anything with no slash
    local asc = dir .. '/.cached/.' .. base:gsub('%.adoc$', '.asc')
    asc_of[adoc] = asc
    table.insert(asc_list, asc)
    ::continue::
  end
  local adoc_mtimes = batch_mtimes(adoc_list)
  local asc_mtimes  = batch_mtimes(asc_list)
  local stale = {}
  for _, adoc in ipairs(adoc_list) do
    if not asc_of[adoc] then goto continue end    -- skip entries we couldn't parse
    local asc_t  = asc_mtimes[asc_of[adoc]]
    local adoc_t = adoc_mtimes[adoc]
    if not asc_t or (adoc_t and adoc_t > asc_t) then
      table.insert(stale, adoc)
    end
    ::continue::
  end
  return stale
end

-- Reads a plain text file of one path per line from the env var's path.
function read_adoc_list(envvar)
  local path = os.getenv(envvar)
  if not path or not file_exists_p(path) then return {} end
  local result = {}
  for _, line in ipairs(read_file_lines(path)) do
    if line ~= '' then
      table.insert(result, line)
    end
  end
  return result
end

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
  if h then h:close(); return true end
  return false
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

function lua_copy(src, dst)
  local i = io.open(src, 'rb')
  local data = i:read('*all')
  i:close()
  local o = io.open(dst, 'wb')
  o:write(data)
  o:close()
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

function string_trim(s)
  -- remove flanking blanks of string s
  return (string.gsub(s, '^%s*(.-)%s*$', '%1'))
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

function string_to_table(s)
  -- return a table whose elements are the characters in the string
  local t = {}
  for i=1,#s do
    t[i] = string.sub(s, i, i)
  end
  return t
end

function string_titlecase(s)
  return s:gsub('(%w)(%w+)', function(a, b) return string.upper(a) .. b end)
end

function read_file_string(f)
  -- return contents of file f as string
  local i = io.open(f)
  local str = i:read('*all')
  i:close()
  return str
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

function make_error_function(errmsg_file_context)
  -- return an error function that adds context info
  return function (s)
    error('ERROR in ' .. errmsg_file_context() .. ':\n' .. s)
  end
end

function first_line(f)
  local i = io.open(f)
  if not i then return false end
  local x = i:read()
  i:close()
  return x
end

function shell_output(cmd)
  local result = {}
  local o = io.popen(cmd)
  for L in o:lines() do
    table.insert(result, L)
  end
  o:close()
  return result
end

function anonymize_filename(f0)
  local f = f0
  local dir = ''
  local ext = ''
  if f:match('/') then
    dir = f:gsub('(.*/).*', '%1')
    f = f:gsub('.*/(.*)', '%1')
  end
  if f:match('%.') then
    ext = f:gsub('.*(%..*)', '%1')
    f = f:gsub('(.*)%..*', '%1')
  end
  local fa = shell_output('printf "%s" ' .. f .. '|sha1sum|sed -e "s/^\\(.\\{16\\}\\).*/\\1/"')[1]
  return dir .. fa .. ext
end
