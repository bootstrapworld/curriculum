#! /usr/bin/env lua

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

abysspdf = 'distribution/' .. os.getenv('NATLANG') .. '/lib/' .. os.getenv('ABYSS') .. '.pdf'

workbook_inputs = { 'workbook', 'bm-contracts', 'bm-contracts-sols', 'workbook-sols', 'workbook-long', 'workbook-long-sols', 'opt-exercises', 'opt-exercises-sols' }

function file_is_directory_p(d)
  local i = io.open(d, 'r')
  local a,b,c = i:read(1)
  i:close()
  return c == 21
end

function make_workbook_json_1(course_dir, tgt)
  local workbook_input = course_dir .. '/.cached/.filelist'
  local workbook_index_file

  if memberp(tgt, { 'bm-contracts', 'bm-contracts-sols' }) then
    workbook_index_file = course_dir .. '/.cached/.back-matter-contracts-index.rkt'
  elseif memberp(tgt, { 'workbook', 'workbook-sols' }) then
    workbook_index_file = course_dir .. '/.cached/.workbook-page-index.rkt'
  elseif memberp(tgt, { 'opt-exercises', 'opt-exercises-sols' }) then
    workbook_index_file = course_dir .. '/.cached/.opt-exercises-index.rkt'
  else
    workbook_index_file = course_dir .. '/.cached/.workbook-long-page-index.rkt'
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

  for line in i:lines() do
    if not (line:find('lessons') or line:find('front-matter') or line:find('back-matter')) then
      goto continue
    end
    local lessondir = line:gsub('^%("(.[^"]*)".*', '%1')
    local workbookpage = line:gsub('^%(".[^"]*" *"(.[^"]*)".*', '%1')
    local aspect = line:gsub('^%(".[^"]*" *".[^"]*" *"(.[^"]*)".*', '%1')
    local pageno = line:gsub('^%(".[^"]*" *".[^"]*" *".[^"]*" *"?([^"]*).*', '%1')

    if memberp(pageno, { 'no', 'No', 'NO' }) then
      pageno = 'false'
    end

    if pageno ~= 'false' then
      pageno = 'true'
    end

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
    o:write('", "paginate": ', pageno, ' }\n')

    ::continue::
  end

  o:write('] }\n')

end

function make_workbook_jsons(course_dir)
  for _,wbf in ipairs(workbook_inputs) do
    make_workbook_json_1(course_dir, wbf)
  end
end

all_courses = {}

do
  distr_courses = 'distribution/' .. os.getenv('NATLANG') .. '/courses'
  local i = io.popen('ls ' .. distr_courses)
  while true do
    local x = i:read()
    if not x then break end
    x = distr_courses .. '/' .. x
    if file_is_directory_p(x) then
      table.insert(all_courses, x)
    end
  end
  i:close()
end

for _,course_dir in ipairs(all_courses) do
  make_workbook_jsons(course_dir)
end
