#! /usr/bin/env lua

-- last modified 2023-02-26

-- print('doing collect-primitives.lua')

do
  local lessons_dir = 'distribution/' .. os.getenv('NATLANG') .. '/lessons/'
  local lessons = dofile(os.getenv 'LESSONS_LIST_FILE')
  for _,lesson in ipairs(lessons) do
    local lesson_cache = lessons_dir .. lesson .. '/.cached/'
    local prims = {}
    --
    local ls_output = io.popen('ls ' .. lesson_cache .. '.*.primtxt 2>/dev/null')
    for prim_file in ls_output:lines() do
      local i = io.open(prim_file)
      for prim in i:lines() do
        table.insert(prims, prim)
      end
      i:close()
    end
    ls_output:close()
    --
    table.sort(prims)
    --
    local seen = {}
    for idx,prim in ipairs(prims) do
      if seen[prim] then
        table.remove(prims, idx)
      else
        seen[prim] = true
      end
    end
    --
    local o = io.open(lesson_cache .. '.index-primitives.txt.kp', 'w+')
    for _,prim in ipairs(prims) do
      o:write(prim, '\n')
    end
    o:close()
  end
end
