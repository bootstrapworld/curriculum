#! /usr/bin/env lua

-- print('doing make-workbook-jsons-2.lua')

local courses_list_file = ...

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')

-- dofile('lib/maker/utils.lua')

local natlang = os.getenv('NATLANG')

-- local natlang = 'en-us'

local distr_courses = 'distribution/' .. natlang .. '/courses/'

---------------------------------------------------------------------------

local all_courses = dofile(courses_list_file)

function write_enclosing_matter(course_dir, enclosing_matter, o)
  -- print('doing write_enclosing_matter', course_dir, enclosing_matter)
  local enclosing_matter_dir = course_dir .. '/' .. enclosing_matter
  local enclosing_matter_workbook_pages_file = enclosing_matter_dir .. '/pages/.cached/.workbook-pages.txt.kp'

  if file_exists_p(enclosing_matter_workbook_pages_file) then
    local i = io.open(enclosing_matter_workbook_pages_file)
    local first_p = true
    o:write('  "', enclosing_matter, '": [\n')
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
      o:write('  "', enclosing_matter_dir, '/pages/', file, '"\n')
    end
    i:close()
    o:write('  ],\n')
  else
    print(enclosing_matter_workbook_pages_file, 'not found')
  end
end

do
  local distr_lessons = 'distribution/' .. natlang .. '/lessons/'
  for _,course in ipairs(all_courses) do
    local course_dir = distr_courses .. course
    local course_cache = course_dir .. '/.cached/'

    local course_title_file = course_cache .. '.index.titletxt'

    local course_title = course
    if file_exists_p(course_title_file) then
      course_title = first_line(course_title_file)

    end

    local o = io.open(course_cache .. '.new-workbook-page-index.json', 'w+')

    o:write('{\n')

    o:write('  "courseName": "', course_title, '",\n')
    o:write('  "courseFolder": "courses/', course, '",\n')

    write_enclosing_matter(course_dir, 'front-matter', o)

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
    w:close()
    o:write('  ],\n')

    write_enclosing_matter(course_dir, 'back-matter', o)

    o:write('  "outputPath" : "', course_dir, '/workbook/"\n')
    o:write('}\n')
    o:close()
  end
end

-- print('done make-workbook-jsons-2.lua')
