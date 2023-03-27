#! /usr/bin/env lua

-- last modified 2023-03-27

local graph_file = ...

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

local lessons_dir = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/lessons/'

local lessons = read_file_lines(os.getenv 'LESSONS_LIST_FILE')

local function read_list_from_file(f)
  return ('"' .. table.concat(read_json_file(f), '", "') .. '"')
end

local o = io.open(graph_file, 'w+')

o:write('var graph = {\n')

for _,lesson in ipairs(lessons) do
  local lessondir = lessons_dir .. lesson .. '/'
  local lessoncache = lessondir .. '.cached/'
  local lessonpagecache = lessondir .. 'pages/.cached/'
  --
  local title_txt = ''
  local description_txt = ''
  local proglang_txt = 'pyret'
  local pages_txt = ''
  local exercisePages_txt = ''
  local primitives_txt = ''
  local starterFiles_txt = ''
  local prerequisites_txt = ''
  --
  local title_file = lessoncache .. '.index.titletxt'
  local description_file = lessoncache .. '.index-desc.txt.kp'
  local proglang_file = lessoncache .. '.record-proglang'
  local pages_file = lessonpagecache .. '.workbook-pages-ls.txt.kp'
  local exercisePages_file = lessonpagecache .. '.exercise-pages-ls.txt.kp'
  local primitives_file = lessoncache .. '.index-primitives.txt.kp'
  local starterFiles_file = lessoncache .. '.index-starterfiles.txt.kp'
  local keywords_file = lessoncache .. '.lesson-keywords.json'
  local glossary_file = lessoncache .. '.lesson-glossary.json'
  local prereqs_file = lessoncache .. '.lesson-prereq.txt.kp'
  local standards_file = lessoncache .. '.lesson-standards-w-prose.txt.kp'
  --
  local i
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
  if file_exists_p(proglang_file) then
    i = io.open(proglang_file)
    proglang_txt = i:read()
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
  o:write('    proglang: \"' .. proglang_txt .. '\",\n')
  o:write('    pages: [' .. pages_txt .. '],\n')
  o:write('    exercisePages: [' .. exercisePages_txt .. '],\n')
  o:write('    primitives: [' .. primitives_txt .. '],\n')
  if file_exists_p(keywords_file) then
    o:write('    keywords: [' .. read_list_from_file(keywords_file) .. ']\n')
  end
  if file_exists_p(glossary_file) then
    o:write('    glossary: [' .. read_list_from_file(glossary_file) .. '],\n')
  end
  o:write('    prerequisites: [' .. prerequisites_txt .. '],\n')
  o:write('    starterFiles: [' .. starterFiles_txt .. '],\n')
  copy_file_to_port(standards_file, o)
  o:write(' },\n')
end

o:write('}\n')
