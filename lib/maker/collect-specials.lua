#! /usr/bin/env lua

-- print('doing collect-primitives.lua')

dofile(os.getenv'MAKE_DIR' .. 'utils.lua')

do
  local lessons_dir = 'distribution/' .. os.getenv('NATLANG') .. '/lessons/'
  local lessons = read_file_lines(os.getenv 'LESSONS_LIST_FILE')
  for _,lesson in ipairs(lessons) do
    local lesson_cache = lessons_dir .. lesson .. '/.cached/'
    if not file_exists_p(lesson_cache) then
      goto continue
    end
    local prims = {}
    --
    local ls_output = io.popen('ls ' .. lesson_cache .. '.*.primtxt 2>/dev/null')
    local seen = {}
    for prim_file in ls_output:lines() do
      local i = io.open(prim_file)
      for prim in i:lines() do
        if not seen[prim] then
          seen[prim] = true
          table.insert(prims, prim)
        end
      end
      i:close()
    end
    ls_output:close()
    --
    table.sort(prims)
    --
    local o = io.open(lesson_cache .. '.index-primitives.txt.kp', 'w+')
    for _,prim in ipairs(prims) do
      o:write(prim, '\n')
    end
    o:close()
    --
    ::continue::
  end
end
