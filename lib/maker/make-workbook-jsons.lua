#! /usr/bin/env lua

-- print('doing make-workbook-jsons.lua')

local courses_list_file = ...

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')

dofile(make_dir .. 'sread.lua')

local natlang = os.getenv('NATLANG')

local distr_courses = 'distribution/' .. natlang .. '/courses/'

local makemasterPDFs = os.getenv('MASTERWORKBOOK')
---------------------------------------------------------------------------

local all_courses = dofile(courses_list_file)

function write_enclosing_matter(course_dir, enclosing_matter, o)
  -- print('doing write_enclosing_matter', course_dir, enclosing_matter)
  local enclosing_matter_dir = course_dir .. '/' .. enclosing_matter
  local enclosing_matter_workbook_pages_file = enclosing_matter_dir .. '/pages/.cached/.workbook-pages.txt.kp'

  local i = io.open(enclosing_matter_workbook_pages_file)
  local first_p = true
  for line in i:lines() do
    local file = line:gsub('^ *([^ ]*).*', '%1')
    -- what are we doing with aspect info?
    -- local aspect = line:match('^ *[^ ]+ +([^ ]+).*') or 'portrait'
    -- local landscape = false
    -- if aspect == 'landscape' then landscape = true end
    if first_p then
      first_p = false
      o:write('   ')
    else
      o:write('  ,')
    end
    o:write('  "', enclosing_matter_dir, '/pages/', file, '"\n')
  end
  i:close()
  return not first_p
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

    local front_matter_workbook_pages_file = course_dir .. '/front-matter/pages/.cached/.workbook-pages.txt.kp'
    if file_exists_p(front_matter_workbook_pages_file) then
      o:write('  "front-matter": [\n')
      write_enclosing_matter(course_dir, 'front-matter', o)
      o:write('  ],\n')
    else
      --print(course, 'front-matter not found')
    end

    o:write('  "lessons": [\n')
    local workbook_lessons_file = course_cache .. '.workbook-lessons.rkt.kp'
    local lesson_units = sread_file(workbook_lessons_file)
    local first_p = true
    for _,lunit in ipairs(lesson_units) do
      for i=2,#lunit do
        if first_p then
          first_p = false
          o:write('    ')
        else
          o:write('  , ')
        end
        o:write(' "', lunit[i], '"\n')
      end
    end
    o:write('  ],\n')

    local back_matter_workbook_pages_file = course_dir .. '/back-matter/pages/.cached/.workbook-pages.txt.kp'
    local contracts_pdf_file = course_dir .. '/resources/pages/Contracts.pdf'
    local back_cover_file = course_dir .. '/back-matter/pages/back-cover.adoc'
    if file_exists_p(back_matter_workbook_pages_file) or file_exists_p(contracts_pdf_file) or file_exists_p(back_cover_file) then
      o:write('  "back-matter": [\n')
      local prev_matter_p = false
      if file_exists_p(back_matter_workbook_pages_file) then
        prev_matter_p = write_enclosing_matter(course_dir, 'back-matter', o)
      end
      if file_exists_p(contracts_pdf_file) then
        if prev_matter_p then o:write('  ,  ')
        else                  o:write('     ')
          prev_matter_p = true
        end
        o:write('"', contracts_pdf_file, '"\n')
      end
      if file_exists_p(back_cover_file) then
        if prev_matter_p then o:write('  ,  ')
        else                  o:write('     ')
          prev_matter_p = true
        end
        o:write('"', back_cover_file, '"\n')
      end
      o:write('  ],\n')
    else
      print(course, 'back-matter not found')
    end

    o:write('  "outputPath" : "', course_dir, '/workbook/"\n')
    o:write('}\n')
    o:close()
  end
end
