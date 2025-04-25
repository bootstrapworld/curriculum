#! /usr/bin/env lua

-- last modified 2025-04-25

-- print('doing make-pathway-tocs.lua')

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')
dofile(os.getenv('MAKE_DIR') .. 'readers.lua')
dofile(os.getenv('MAKE_DIR') .. 'sread.lua')

local dist_dir = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/'

local distr_courses = dist_dir .. 'courses/'

local all_courses = dofile(os.getenv 'COURSES_LIST_FILE')

local tocs_file = dist_dir .. 'pathway-tocs.js'
local o = io.open(tocs_file, 'w+')

o:write('var pathwayTocs = {\n')

for _,course in ipairs(all_courses) do
  local course_dir = distr_courses .. course .. '/'
  local this_course_lessons_file = course_dir .. '.cached/.workbook-lessons.rkt.kp'
  if not file_exists_p(this_course_lessons_file) then goto continue end
  local lesson_categories = sread_file(this_course_lessons_file)
  o:write('  \"' .. course .. '\": [\n')
  for _,categ in ipairs(lesson_categories) do
    for _,lsn in ipairs(categ) do
      o:write('     \"' .. lsn .. '\",\n')
    end
  end
  o:write('  ],\n')
  ::continue::
end

o:write('}\n')
o:close()
