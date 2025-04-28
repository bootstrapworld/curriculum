#! /usr/bin/env lua

local inf, outf, pl = ...

local i = io.open(inf, 'r')
local o = io.open(outf, 'w')

local current_category = ''
local current_category_lessons = {}

local function write_category()
  if #current_category_lessons > 0 then
    o:write('( "' .. current_category .. '"\n')
    for _,y in ipairs(current_category_lessons) do
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
    write_category()
    current_category = x
    current_category_lessons = {}
  else
    x = x .. proglang
    table.insert(current_category_lessons, x)
  end
  ::continue::
end
write_category()

o:write(')\n')

i:close()
o:close()
