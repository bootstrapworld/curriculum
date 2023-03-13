#! /usr/bin/env lua

-- last modified 2023-03-13

local graph_file = ...

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

local lessons_dir = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/lessons/'

local lessons = read_file_lines(os.getenv 'LESSONS_LIST_FILE')

local o = io.open(graph_file, 'w+')

o:write('var graph = {\n')

for _,lesson in ipairs(lessons) do
  local i
  local titletxt = ''
  local desctxt = ''
  local pagestxt = ''
  local exerpagestxt = ''
  local primstxt = ''
  local prereqstxt = ''
  local lessondir = lessons_dir .. lesson .. '/'
  local lessoncache = lessondir .. '.cached/'
  local lessonpagecache = lessondir .. 'pages/.cached/'
  local titletxt_file = lessoncache .. '.index.titletxt'
  local desctxt_file = lessoncache .. '.index-desc.txt.kp'
  local pagestxt_file = lessonpagecache .. '.workbook-pages-ls.txt.kp'
  local exerpagestxt_file = lessonpagecache .. '.exercise-pages-ls.txt.kp'
  local primstxt_file = lessoncache .. '.index-primitives.txt.kp'
  local keywords_file = lessoncache .. '.lesson-keywords.txt.kp'
  local prereqs_file = lessoncache .. '.lesson-prereq.txt.kp'
  local standards_file = lessoncache .. '.lesson-standards-w-prose.txt.kp'
  --
  if file_exists_p(titletxt_file) then
    i = io.open(titletxt_file)
    titletxt = i:read():gsub('"', '\\"')
    i:close()
  end
  --
  if file_exists_p(desctxt_file) then
    i = io.open(desctxt_file)
    desctxt = i:read():gsub('"', '\\"')
    i:close()
  end
  --
  if file_exists_p(pagestxt_file) then
    i = io.open(pagestxt_file)
    for line in i:lines() do
      pagestxt = pagestxt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  if file_exists_p(exerpagestxt_file) then
    i = io.open(exerpagestxt_file)
    for line in i:lines() do
      exerpagestxt = exerpagestxt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  if file_exists_p(primstxt_file) then
    i = io.open(primstxt_file)
    for line in i:lines() do
      primstxt = primstxt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  if file_exists_p(prereqs_file) then
    i = io.open(prereqs_file)
    for line in i:lines() do
      prereqstxt = prereqstxt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  o:write('  \"' .. lesson .. '\" : {\n')
  o:write('    title: \"' .. titletxt .. '\",\n')
  o:write('    description: \"' .. desctxt .. '\",\n')
  o:write('    pages: [' .. pagestxt .. '],\n')
  o:write('    exercisePages: [' .. exerpagestxt .. '],\n')
  o:write('    primitives: [' .. primstxt .. '],\n')
  copy_file_to_port(keywords_file, o)
  o:write('    prerequisites: [' .. prereqstxt .. '],\n')
  copy_file_to_port(standards_file, o)
  o:write(' },\n')
end

o:write('}\n')
