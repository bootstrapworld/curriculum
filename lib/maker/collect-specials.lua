#! /usr/bin/env lua

-- print('doing collect-primitives.lua')

dofile(os.getenv'MAKE_DIR' .. 'utils.lua')

do
  local lessons_dir = 'distribution/' .. os.getenv('NATLANG') .. '/lessons/'
  local lessons = read_file_lines(os.getenv 'LESSONS_LIST_FILE')
  for _,lesson in ipairs(lessons) do
    if not file_exists_p(lesson) then
      goto continue
    end
    local lesson_cache = lessons_dir .. lesson .. '/.cached/'
    local prims = {}
    local starter_files = {}
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
    ls_output = io.popen('ls ' .. lesson_cache .. '.*.starterfiles 2>/dev/null')
    seen = {}
    for sf_file in ls_output:lines() do
      local i = io.open(sf_file)
      for sf in i:lines() do
        if not seen[sf] then
          seen[sf] = true
          table.insert(starter_files, sf)
        end
      end
      i:close()
    end
    ls_output:close()
    --
    table.sort(prims)
    table.sort(starter_files)
    --
    local o = io.open(lesson_cache .. '.index-primitives.txt.kp', 'w+')
    for _,prim in ipairs(prims) do
      o:write(prim, '\n')
    end
    o:close()
    --
    o = io.open(lesson_cache .. '.index-starterfiles.txt.kp', 'w+')
    for _,sf in ipairs(starter_files) do
      o:write(sf, '\n')
    end
    o:close()
    ::continue::
  end
end
