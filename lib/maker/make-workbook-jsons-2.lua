#! /usr/bin/env lua

print('doing make-workbook-jsons-2.lua')

local courses_list_file = ...

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

-- dofile('lib/maker/utils.lua')

local natlang = os.getenv('NATLANG')

-- local natlang = 'en-us'

local distr_courses = 'distribution/' .. natlang .. '/courses/'

---------------------------------------------------------------------------

local all_courses = dofile(courses_list_file)

function write_end_matter(course_dir, end_matter, o)
  -- print('doing write_end_matter', course_dir, end_matter)
  local end_matter_dir = course_dir .. '/' .. end_matter
  local end_matter_workbook_pages_file = end_matter_dir .. '/pages/.cached/.workbook-pages.txt.kp'

  if file_exists_p(end_matter_workbook_pages_file) then
    local i = io.open(end_matter_workbook_pages_file)
    local first_p = true
    o:write('  "', end_matter, '": [\n')
    for line in i:lines() do
      local file = line:gsub('^ *([^ ]*).*', '%1')
      local aspect = line:match('^ *[^ ]+ +([^ ]+).*') or 'portrait'
      local landscape = false
      if aspect == 'landscape' then landscape = true end
      if first_p then 
        first_p = false
        o:write('   ')
      else
        o:write('  ,') 
      end
      o:write('  "', end_matter_dir, '/pages/', file, '"\n')
    end
    o:write('  ],\n')
  else
    print(end_matter_workbook_pages_file, 'not found')
  end
end

do
  local distr_lessons = 'distribution/' .. natlang .. '/lessons/'
  for _,course in ipairs(all_courses) do
    local course_dir = distr_courses .. course
    local course_cache = course_dir .. '/.cached/'

    local o = io.open(course_cache .. '.new-workbook-page-index.json', 'w+')

    o:write('{\n')

    write_end_matter(course_dir, 'front-matter', o)

    o:write('  "lessons": [\n')
    local workbook_lessons_file = course_cache .. '.workbook-lessons.txt.kp'
    local w = io.open(workbook_lessons_file)
    local first_p = true
    for lsn in w:lines() do
      if first_p then 
        first_p = false
        o:write('    ')
      else
        o:write('  , ') 
      end
      o:write(' "', lsn, '"\n')
    end
    o:write('  ],\n')

    write_end_matter(course_dir, 'back-matter', o)

    o:write('  "outputPath" : "', course_dir, '/workbook/"\n')
    o:write('}\n')
  end
end

