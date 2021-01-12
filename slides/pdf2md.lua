#! /usr/bin/env lua

-- created 2021-01-11
-- last modified 2021-01-12

function probe_file(f)
  local h = io.open(f)
  if h then io.close(h); return f
  else return false
  end
end

function ensure_file_deleted(f)
  local h = io.open(f)
  if h then io.close(h); --os.remove(f);
  end
end

function file_extension(f)
  local slash = string.find(f, '/[^/]*$')
  local dot = string.find(f, '%.[^.]*$')
  if dot and dot ~= 0 and
    (not slash or ((slash+1) < dot)) then
    return string.sub(f, dot)
  else return ''
  end
end

local pdff = ...

if file_extension(pdff) ~= '.pdf' then
  print('File ' .. pdff .. ' not a PDF file')
  os.exit()
end

if not probe_file(pdff) then
  print('File ' .. pdff .. ' not found')
  os.exit()
end

local fbase = string.gsub(pdff, "%.pdf$", "")

os.execute('convert ' .. pdff .. ' ' .. fbase .. '-%04d.png')

local i = -1

local mdf = fbase .. '.md'

ensure_file_deleted(mdf)

local mdo = io.open(mdf, 'w')

while true do
  i = i + 1
  local f = string.format('%s-%04d.png', fbase, i)
  if not probe_file(f) then break end
  mdo:write('#\n\n')
  mdo:write(string.format('![%s](%s)\n\n', f, f))
end

mdo:close()

