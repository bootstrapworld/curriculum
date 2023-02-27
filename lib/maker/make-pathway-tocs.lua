#! /usr/bin/env lua

-- last modified 2023-02-27

-- print('doing make-pathway-tocs.lua')

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

natlang = os.getenv('NATLANG')

distr_courses = 'distribution/' .. natlang .. '/courses/'

all_courses = dofile(os.getenv 'COURSES_LIST_FILE')

do
  local tocs_file = os.getenv 'TOCS_FILE'
  local o = io.open(tocs_file, 'w+')
  o:write('var pathwayTocs = {\n')
  for _,course in ipairs(all_courses) do
    local course_dir = distr_courses .. course .. '/'
    local this_course_lessons_file = course_dir .. '.cached/.workbook-lessons.txt.kp'
    if not file_exists_p(this_course_lessons_file) then goto continue end
    local i = io.open(this_course_lessons_file)
    o:write('  \"' .. course .. '\": [')
    for lsn in i:lines() do
      o:write('\"' .. lsn .. '\", ')
    end
    o:write('],\n\n')

    ::continue::

  end
  o:write('}\n')
end
