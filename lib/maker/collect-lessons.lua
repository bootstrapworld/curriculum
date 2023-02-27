#! /usr/bin/env lua

-- last modified 2023-02-25

do
  local ls_output = io.popen('ls distribution/' .. os.getenv('NATLANG') .. '/lessons')
  local o = io.open(os.getenv 'LESSONS_LIST_FILE', 'w+')
  o:write('return {\n')
  for lesson in ls_output:lines() do
    if not lesson:find('%-wescheme$') then
      o:write('  \"' .. lesson .. '\",\n')
    end
  end
  o:write('}\n')
  ls_output:close()
  o:close()
end
