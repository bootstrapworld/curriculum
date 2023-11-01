#! /usr/bin/env lua

local courses_list_file = ...

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

local natlang = os.getenv('NATLANG')

local distr_courses = 'distribution/' .. natlang .. '/courses/'

local makemasterPDFs = os.getenv('MASTERWORKBOOK')

---------------------------------------------------------------------------

function write_page1(lesson_dir, page, aspect, pageno, o, ol, oe)
  local x = '{ lessondir = "' .. lesson_dir .. '",' ..
             ' page = "' .. page .. '",' ..
             ' aspect = "' .. aspect .. '",' ..
             ' pageno = ' .. pageno .. ' },\n'
  o:write(x)
  ol:write(x)
end

function write_pages_info(lesson_dir, o, ol, oe, skip_pageno)
  -- by default, don't skip pageno
  --
  local workbook_pages_file = lesson_dir .. '/pages/.cached/.workbook-pages.txt.kp'
  if file_exists_p(workbook_pages_file) then
    -- print('workbook_pages_file is ', workbook_pages_file, file_exists_p(workbook_pages_file))
    local i = io.open(workbook_pages_file)
    for line in i:lines() do
      local file = line:gsub('^ *([^ ]*).*', '%1')
      local aspect = line:match('^ *[^ ]+ +([^ ]+).*') or 'portrait'
      local this_skip_pageno = line:match('^ *[^ ]+ +[^ ]+ +([^ ]+).*') or skip_pageno
      local pageno = tostring(not this_skip_pageno)
      --
      write_page1(lesson_dir, file, aspect, pageno, o, ol, oe)
    end
    i:close()
  end
  --
  local exercise_pages_file = lesson_dir .. '/pages/.cached/.exercise-pages.lua'
  -- print('exercise_pages_file is ', exercise_pages_file, file_exists_p(exercise_pages_file))
  if file_exists_p(exercise_pages_file) then
    -- print('ex pg file', exercise_pages_file, 'exists!')
    local exercise_pages = dofile(exercise_pages_file)
    for _,page in ipairs(exercise_pages) do
      local file = page[1]
      local aspect = page[2] or 'portrait'
      local this_pageno = false
      local x = '{ lessondir = "' .. lesson_dir .. '", ' .. 'page = "' .. file .. '", ' .. 'aspect = "' .. aspect .. '", ' .. 'pageno = false },\n'
      ol:write(x)
      oe:write(x)
    end
  end
end

local all_courses = dofile(courses_list_file)

do
  local distr_lessons = 'distribution/' .. natlang .. '/lessons/'
  for _,course in ipairs(all_courses) do
    local course_dir = distr_courses .. course
    local course_cache = course_dir .. '/.cached/'

    local o = io.open(course_cache .. '.workbook-page-index.lua', 'w+')
    local ol = io.open(course_cache .. '.workbook-long-page-index.lua', 'w+')
    local oe = io.open(course_cache .. '.opt-exercises-index.lua', 'w+')

    o:write('return {\n')
    ol:write('return {\n')
    oe:write('return {\n')

    write_pages_info(course_dir .. '/front-matter', o, ol, oe, 'skip_pageno')
    local workbook_lessons_file = course_cache .. '.workbook-lessons.txt.kp'
    -- print('workbook_lessons_file is ', workbook_lessons_file, ' ', file_exists_p(workbook_lessons_file))
    local w = io.open(workbook_lessons_file)
    for lsn in w:lines() do
      write_pages_info(distr_lessons .. lsn, o, ol, oe)
    end
    w:close()

    write_pages_info(course_dir .. '/back-matter', o, ol, oe, 'skip_pageno')

    local resources_dir = 'distribution/' .. natlang .. '/courses/' .. course .. '/resources'
    if file_exists_p(resources_dir .. '/pages/Contracts.pdf') then
      write_page1(resources_dir, 'Contracts.pdf', 'portrait', 'false', o, ol, oe)
    end

    local backpages_dir = course_dir .. '/back-matter'
    if file_exists_p(backpages_dir .. '/pages/back-cover.adoc') then
      write_page1(backpages_dir, 'back-cover.adoc', 'portrait', 'false', o, ol, oe)
    end

    o:write('}\n'); o:close()
    ol:write('}\n'); ol:close()
    oe:write('}\n'); oe:close()

  end
end

---------------------------------------------------------------------------

notfoundpdf = 'distribution/' .. natlang .. '/lib/page-not-found.pdf'

function make_workbook_json_1(course_dir, tgt)
  -- print('doing make_workbook_json_1 ' .. course_dir .. ', ' .. tgt)
  local workbook_input = course_dir .. '/.cached/.filelist'
  local workbook_index_file

  if memberp(tgt, { 'workbook', 'workbook-sols' }) then
    workbook_index_file = course_dir .. '/.cached/.workbook-page-index.lua'
  elseif memberp(tgt, { 'opt-exercises', 'opt-exercises-sols' }) then
    workbook_index_file = course_dir .. '/.cached/.opt-exercises-index.lua'
  else
    workbook_index_file = course_dir .. '/.cached/.workbook-long-page-index.lua'
  end

  local includesolutions = false

  if memberp(tgt, { 'workbook-sols', 'workbook-long-sols', 'opt-exercises-sols', 'pd-workbook' }) then
    includesolutions = true
  end

  local includeoptexercises = false

  if memberp(tgt, { 'workbook-long', 'workbook-long-sols', 'opt-exercises', 'opt-exercises-sols' }) then
    includeoptexercises = true
  end

  local includelessons = false

  if memberp(tgt, { 'pd-workbook' }) then
    includelessons = true
  end

  local o = io.open(workbook_input .. '-' .. tgt .. '.json', 'w+')

  o:write('{ "fileList": [ "ignoreElement" ')

  local currlesson

  local lynes = dofile(workbook_index_file)

  for _,line in ipairs(lynes) do
    local lessondir = line.lessondir

    local docrootp = true

    if lessondir:find('/lessons/') or lessondir:find('/front%-matter$') or lessondir:find('/back%-matter$') or lessondir:find('/resources$') then
      docrootp = false
    end

    local workbookpage = line.page
    local aspect = line.aspect
    local pageno = line.pageno

    local freshlesson = false

    if lessondir ~= currlesson then
      freshlesson = true
    end

    local docfile

    if freshlesson then
      currlesson = lessondir
      if includelessons then
        pdffile = currlesson .. '/index.pdf'
        if file_exists_p(pdffile) then
          os.execute('rm -f pg_*.pdf')
          os.execute('cd ' .. currlesson .. '; pdftk index.pdf burst')
          local ls_output = io.popen('ls ' .. currlesson .. '/pg_*.pdf')
          for smallpdffile in ls_output:lines() do
            o:write(', { "file": "')
            o:write(smallpdffile)
            o:write('", "paginate": false }\n')
          end
        end
      end
    end

    local docfile = lessondir .. '/'

    if docrootp then
      docfile = docfile .. workbookpage
    elseif includesolutions then
      docfile = docfile .. 'solution-pages/' .. workbookpage
    else
      docfile = docfile .. 'pages/' .. workbookpage
    end

    local docfileext = docfile:gsub('.*%.([^.]*)$', '%1')

    if docfileext == 'adoc' then
      docfile = docfile:gsub('(.*)%.adoc$', '%1') .. '.html'
      docfileext = 'html'
    elseif docfileext == 'pdf' then
      local htmlfile = docfile:gsub('(.*)%.pdf$', '%1') .. '.html'
      if file_exists_p(htmlfile) then
        docfile = htmlfile
        docfileext = 'html'
      end
    end
    o:write(', { "file": "')

    if docfileext == 'html' then
      if file_exists_p(docfile) then
        local localpdffile = docfile:gsub('(.*)%.html$', '%1') .. '.pdf'

        o:write(localpdffile)
      else
        o:write(notfoundpdf)
      end

    elseif not file_exists_p(docfile) then
      o:write(notfoundpdf)

    else
      o:write(docfile)
    end
    o:write('", "paginate": ', tostring(pageno), ' }\n')

  end

  o:write('] }\n')
  o:close()

end

do
  local workbook_inputs = { 'workbook', 'workbook-sols', 'workbook-long', 'workbook-long-sols', 'opt-exercises', 'opt-exercises-sols' }
  --
  if makemasterPDFs then
    table.insert(workbook_inputs, 'pd-workbook')
  end
  --
  for _,course in ipairs(all_courses) do
    local course_dir = distr_courses .. course
    for _,wbf in ipairs(workbook_inputs) do
      make_workbook_json_1(course_dir, wbf)
    end
  end
end
