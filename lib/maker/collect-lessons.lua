#! /usr/bin/env lua

-- last modified 2023-02-27

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

do
  local natlang = os.getenv 'NATLANG'
  local lessons_dir = 'distribution/' .. natlang .. '/lessons'
  local ls_output = io.popen('ls ' .. lessons_dir)
  local o = io.open(os.getenv 'LESSONS_LIST_FILE', 'w+')
  o:write('return {\n')
  for lesson in ls_output:lines() do
    if lesson:find('%-wescheme$') then goto continue end
    if file_exists_p(lessons_dir .. '/' .. lesson .. '/.proglang-ignore') then goto continue end
    o:write('  \"' .. lesson .. '\",\n')
    ::continue::
  end
  o:write('}\n')
  ls_output:close()
  o:close()
end
