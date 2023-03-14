#! /usr/bin/env lua

-- last modified 2023-03-14

local graph_file = ...

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

local lessons_dir = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/lessons/'

local lessons = read_file_lines(os.getenv 'LESSONS_LIST_FILE')

local o = io.open(graph_file, 'w+')

o:write('var graph = {\n')

for _,lesson in ipairs(lessons) do
  local i
  local title_txt = ''
  local description_txt = ''
  local pages_txt = ''
  local exercisePages_txt = ''
  local primitives_txt = ''
  local starterFiles_txt = ''
  local prerequisites_txt = ''
  local lessondir = lessons_dir .. lesson .. '/'
  local lessoncache = lessondir .. '.cached/'
  local lessonpagecache = lessondir .. 'pages/.cached/'
  local title_file = lessoncache .. '.index.titletxt'
  local description_file = lessoncache .. '.index-desc.txt.kp'
  local pages_file = lessonpagecache .. '.workbook-pages-ls.txt.kp'
  local exercisePages_file = lessonpagecache .. '.exercise-pages-ls.txt.kp'
  local primitives_file = lessoncache .. '.index-primitives.txt.kp'
  local starterFiles_file = lessoncache .. '.index-starterfiles.txt.kp'
  local keywords_file = lessoncache .. '.lesson-keywords.txt.kp'
  local prereqs_file = lessoncache .. '.lesson-prereq.txt.kp'
  local standards_file = lessoncache .. '.lesson-standards-w-prose.txt.kp'
  --
  if file_exists_p(title_file) then
    i = io.open(title_file)
    title_txt = i:read():gsub('"', '\\"')
    i:close()
  end
  --
  if file_exists_p(description_file) then
    i = io.open(description_file)
    description_txt = i:read():gsub('"', '\\"')
    i:close()
  end
  --
  if file_exists_p(pages_file) then
    i = io.open(pages_file)
    for line in i:lines() do
      pages_txt = pages_txt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  if file_exists_p(exercisePages_file) then
    i = io.open(exercisePages_file)
    for line in i:lines() do
      exercisePages_txt = exercisePages_txt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  if file_exists_p(primitives_file) then
    i = io.open(primitives_file)
    for line in i:lines() do
      primitives_txt = primitives_txt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  if file_exists_p(starterFiles_file) then
    i = io.open(starterFiles_file)
    for line in i:lines() do
      starterFiles_txt = starterFiles_txt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  if file_exists_p(prereqs_file) then
    i = io.open(prereqs_file)
    for line in i:lines() do
      prerequisites_txt = prerequisites_txt .. '\"' .. line .. '\", '
    end
    i:close()
  end
  --
  o:write('  \"' .. lesson .. '\" : {\n')
  o:write('    title: \"' .. title_txt .. '\",\n')
  o:write('    description: \"' .. description_txt .. '\",\n')
  o:write('    pages: [' .. pages_txt .. '],\n')
  o:write('    exercisePages: [' .. exercisePages_txt .. '],\n')
  o:write('    primitives: [' .. primitives_txt .. '],\n')
  copy_file_to_port(keywords_file, o)
  o:write('    prerequisites: [' .. prerequisites_txt .. '],\n')
  o:write('    starterFiles: [' .. starterFiles_txt .. '],\n')
  copy_file_to_port(standards_file, o)
  o:write(' },\n')
end

o:write('}\n')
