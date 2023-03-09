#! /usr/bin/env lua

-- last modified 2023-03-08

dofile(os.getenv'MAKE_DIR' .. 'utils.lua')

local broken_internal_links_p = false

local flag_file = 'distribution/' .. os.getenv('NATLANG') .. '/.cached/.check-internal-links'

os.remove(flag_file)

local internal_link_list_files = {...}

for _,g in ipairs(internal_link_list_files) do
  local containing_file = g:gsub('%.internal%-links%.txt%.kp$', ''):gsub('%.cached/%.', '') .. '.adoc'
  local i = io.open(g)
  for f in i:lines() do
    if not file_exists_p(f) then
      broken_internal_links_p = true
      print('WARNING: Invalid internal link ' .. f .. ' in ' .. containing_file)
    end
  end
  i:close()
end

if broken_internal_links_p then
  touch(flag_file)
end
