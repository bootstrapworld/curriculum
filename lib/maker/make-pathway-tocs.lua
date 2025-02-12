#! /usr/bin/env lua

-- last modified 2025-02-07

-- print('doing make-pathway-tocs.lua')

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

local dist_dir = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/'

local distr_courses = dist_dir .. 'courses/'

local all_courses = dofile(os.getenv 'COURSES_LIST_FILE')

local tocs_file = dist_dir .. 'lib/pathway-tocs.js'
local o = io.open(tocs_file, 'w+')

o:write('var pathwayTocs = {\n')

for _,course in ipairs(all_courses) do
  local course_dir = distr_courses .. course .. '/'
  local this_course_lessons_file = course_dir .. '.cached/.workbook-lessons.txt.kp'
  if not file_exists_p(this_course_lessons_file) then goto continue end
  local i = io.open(this_course_lessons_file)
  o:write('  \"' .. course .. '\": [\n')
  for lsn in i:lines() do
    o:write('     \"' .. lsn .. '\",\n')
  end
  o:write('  ],\n')
  ::continue::
end

o:write('}\n')

o:write('export default pathwayTocs')