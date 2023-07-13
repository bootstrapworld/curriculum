#! /usr/bin/env lua

local graph_file = ...

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

local lessons_dir = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/lessons/'

local lessons = read_file_lines(os.getenv 'LESSONS_LIST_FILE')

local function read_list_from_file(f)
  local l = read_json_file(f)
  if #l <= 0 then return '[]' end
  return ('[ "' .. table.concat(read_json_file(f), '", "') .. '" ]')
end

local function create_glossary_html_json(html_file, json_file)
  local i = io.open(html_file)
  local o = io.open(json_file, 'w+')
  local first = true
  local writing = false
  for line in i:lines() do
    if not writing then
      if line:match('<dl>') then
        writing = true
        o:write('[ \n')
      end
      goto continue
    end
    if line:match('</dl>') then
      o:write('] \n')
      break
    end
    line = line:gsub('"', '\\"')
    if line:match('</dt>') then
      line = line:gsub('</dt>', '", ')
    end
    if line:match('<p>') then
      line = line:gsub('<p>', ' "')
    end
    if line:match('</p>') then
      line = line:gsub('</p>', '" ]\n')
    end
    line = line:gsub('<dd>', '')
    line = line:gsub('</dd>', '')
    if line:match('<dt.->') then
      if first then
        first = false
        line = line:gsub('<dt.->', '[ "')
      else
        line = line:gsub('<dt.->', ', [ "')
      end
    end
    o:write(line)
    ::continue::
  end
  i:close()
  o:close()
end

local function read_list_of_glosses_from_file(f, g)
  -- print('read_list_of_glosses_from_file', f, g)
  create_glossary_html_json(f, g)
  local lol = read_json_file(g)
  if not lol then return '[]' end
  if #lol <= 0 then return '[]' end
  local tbl = {}
  for _,tuple in ipairs(lol) do
    local vocab = tuple[1]
    local description = tuple[2]:gsub('"', '\\"')
    table.insert(tbl, '      { vocab: "' .. vocab .. '", description: "' .. description .. '" }')
  end
  return ('[\n' .. table.concat(tbl, ',\n') .. '\n    ]')
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
  local glossary_file = lessoncache .. '.index-glossary.html'
  local glossary_html_file = lessoncache .. '.index-glossary.json'
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
    o:write('    keywords: ' .. read_list_from_file(keywords_file) .. ',\n')
  end
  if file_exists_p(glossary_file) then
    o:write('    glossary: ' .. read_list_of_glosses_from_file(glossary_file, glossary_html_file) .. ',\n')
  end
  o:write('    prerequisites: [' .. prerequisites_txt .. '],\n')
  o:write('    starterFiles: [' .. starterFiles_txt .. '],\n')
  copy_file_to_port(standards_file, o)
  o:write(' },\n')
end

o:write('}\n')
