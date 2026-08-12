#! /usr/bin/env lua

-- last modified 2026-06-15

local inf, outf, pl = ...

local current_unit = 'NO_UNIT'
local current_unit_lessons = {}

local function write_unit(o)
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

local function get_all_lines(inf)
  local the_lines = {}
  for L in io.lines(inf) do
    table.insert(the_lines, L)
  end
  return the_lines
end

local function write_all_units(inf, outf)
  local the_lines = get_all_lines(inf)
  local o = io.open(outf, 'w')

  o:write('(\n')

  for _,x0 in ipairs(the_lines) do
    local x = x0
    x = x:gsub('^%s+', '')
    x = x:gsub(';.*', '')
    x = x:gsub('%s+$', '')
    if x == '' then goto continue end
    if x:find('^%[') then
      x = x:gsub('%[%s*(.-)%s*%]', '%1')
      write_unit(o)
      current_unit = x
      current_unit_lessons = {}
    else
      x = x .. proglang
      table.insert(current_unit_lessons, x)
    end
    ::continue::
  end
  write_unit(o)

  o:write(')\n')

  o:close()
end

write_all_units(inf, outf)
