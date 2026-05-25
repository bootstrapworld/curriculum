#! /usr/bin/env lua

-- print('doing collect-specials.lua')

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
    local seen = {}
    for _,prim_file in ipairs(shell_output('ls ' .. lesson_cache .. '.*.primtxt 2>/dev/null')) do
      local i = io.open(prim_file)
      for prim in i:lines() do
        if not seen[prim] then
          seen[prim] = true
          table.insert(prims, prim)
        end
      end
      i:close()
    end
    --
    table.sort(prims)
    --
    local o = io.open(lesson_cache .. '.index-primitives.txt.kp', 'w+')
    for _,prim in ipairs(prims) do
      o:write(prim, '\n')
    end
    o:close()
    --
    seen = {}
    seen['editor'] = true
    local lesson_plan_sf_i = io.open(lesson_cache .. '.index.starterfiles')
    if lesson_plan_sf_i then
      for sf in lesson_plan_sf_i:lines() do
        if not seen[sf] then
          seen[sf] = true
        end
      end
      lesson_plan_sf_i:close()
    end
    --
    local lesson_wkbk_pages_sf_i = io.open(lesson_cache .. '.page.starterfiles')
    if lesson_wkbk_pages_sf_i then
      for sf in lesson_wkbk_pages_sf_i:lines() do
        if not seen[sf] then
          print('WARNING: @starter-file{' .. sf .. '} used in ' .. lesson .. '\'s workbook page but not in lesson plan')
          seen[sf] = true -- warn only once per starter file
        end
      end
      lesson_wkbk_pages_sf_i:close()
    end
    --
    ::continue::
  end
end
