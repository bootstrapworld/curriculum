#! /usr/bin/env lua

-- last modified 2025-04-28

local inf, outf, pl = ...

local i = io.open(inf, 'r')
local o = io.open(outf, 'w')

local current_unit = 'NO_UNIT'
local current_unit_lessons = {}

local function write_unit()
  if #current_unit_lessons > 0 then
    o:write('( "' .. current_unit .. '"\n')
    for _,y in ipairs(current_unit_lessons) do
      o:write('    "' .. y .. '"\n')
    end
    o:write(')\n')
  end
end

local proglang = ''

if pl ~= 'pyret' and pl ~= 'none' then
  proglang = '-' .. pl
end

o:write('(\n')

for x in i:lines() do
  x = x:gsub('^%s+', '')
  x = x:gsub(';.*', '')
  x = x:gsub('%s+$', '')
  if x == '' then goto continue end
  if x:find('^%[') then
    x = x:gsub('%[%s*(.-)%s*%]', '%1')
    write_unit()
    current_unit = x
    current_unit_lessons = {}
  else
    x = x .. proglang
    table.insert(current_unit_lessons, x)
  end
  ::continue::
end
write_unit()

o:write(')\n')

i:close()
o:close()
