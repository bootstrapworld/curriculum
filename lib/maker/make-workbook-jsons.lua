#! /usr/bin/env lua

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

natlang = os.getenv('NATLANG')

distr_courses = 'distribution/' .. natlang .. '/courses/'

abysspdf = 'distribution/' .. natlang .. '/lib/' .. os.getenv('ABYSS') .. '.pdf'

workbook_inputs = { 'workbook', 'bm-contracts', 'bm-contracts-sols', 'workbook-sols', 'workbook-long', 'workbook-long-sols', 'opt-exercises', 'opt-exercises-sols' }

function make_workbook_json_1(course_dir, tgt)
  local workbook_input = course_dir .. '/.cached/.filelist'
  local workbook_index_file

  if memberp(tgt, { 'bm-contracts', 'bm-contracts-sols' }) then
    workbook_index_file = course_dir .. '/.cached/.back-matter-contracts-index.lua'
  elseif memberp(tgt, { 'workbook', 'workbook-sols' }) then
    workbook_index_file = course_dir .. '/.cached/.workbook-page-index.lua'
  elseif memberp(tgt, { 'opt-exercises', 'opt-exercises-sols' }) then
    workbook_index_file = course_dir .. '/.cached/.opt-exercises-index.lua'
  else
    workbook_index_file = course_dir .. '/.cached/.workbook-long-page-index.lua'
  end

  local includesolutions = false

  if memberp(tgt, { 'workbook-sols', 'bm-contracts-sols', 'workbook-long-sols', 'opt-exercises-sols' }) then
    includesolutions = true
  end

  local includeoptexercises = false

  if memberp(tgt, { 'workbook-long', 'workbook-long-sols', 'opt-exercises', 'opt-exercises-sols' }) then
    includeoptexercises = true
  end

  local i = io.open(workbook_index_file, 'r')
  local o = io.open(workbook_input .. '-' .. tgt .. '.json', 'w+')

  o:write('{ "fileList": [ "ignoreElement" ')

  local currlesson

  local lynes = dofile(workbook_index_file)

  for _,line in ipairs(lynes) do
    local lessondir = line.lessondir

    if not (lessondir:find('lessons') or lessondir:find('front%-matter') or lessondir:find('back%-matter')) then
      goto continue
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
      docfile = currlesson .. '/index.shtml'
      --fixme: not really using this?
    end

    docfile = lessondir .. '/' .. (includesolutions and 'solution-pages' or 'pages') .. '/' .. workbookpage

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

        o:write(localpdffile)  --, '", "paginate": ', pageno, '}\n')
      else
        o:write(abysspdf)
      end

    elseif not file_exists_p(docfile) then
      o:write(abysspdf)

    else
      o:write(docfile)
    end
    o:write('", "paginate": ', tostring(pageno), ' }\n')

    ::continue::
  end

  o:write('] }\n')

end

do
  local i = io.open(os.getenv('COURSE_INPUT'))
  for course in i:lines() do
    local course_dir = distr_courses .. course
    for _,wbf in ipairs(workbook_inputs) do
      make_workbook_json_1(course_dir, wbf)
    end
  end
  i:close()
end
