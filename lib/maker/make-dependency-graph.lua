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

local function read_list_of_glosses_from_file(f)
  -- print('read_list_of_glosses_from_file', f)
  local lol = read_json_file(f)
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

local function read_slidesURL(slidesId_file)
  local id = first_line(slidesId_file)
  if not id then return false end
  return 'https://docs.google.com/presentation/d/' .. id
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
  local sections_txt = ''
  local pages_txt = ''
  local optExercisePages_txt = ''
  local handoutPages_txt = ''
  local notesFiles_txt = ''
  local primitives_txt = ''
  local starterFiles_txt = ''
  local optStarterFiles_txt = ''
  local prerequisites_txt = ''
  --
  local proglang_file = lessoncache .. '.record-proglang'
  if file_exists_p(proglang_file) then
    i = io.open(proglang_file)
    proglang_txt = i:read()
    i:close()
  end
  --
  local function page_title(page_file)
    local title_file = lessonpagecache .. '.' .. page_file:gsub('%.%w+$', '') .. '.titletxt'
    local title = page_file
    if file_exists_p(title_file) then
      local title2 = first_line(title_file)
      if title2 then title = title2 end
      title = title:gsub('__(.-)__', '<em>%1</em>')
      title = title:gsub('%^(.-)%^', '<sup>%1</sup>')
      title = title:gsub('~(.-)~', '<sub>%1</sub>')
    end
    return title
  end
  --
  local title_file = lessoncache .. '.index.titletxt'
  local description_file = lessoncache .. '.index-desc.txt.kp'
  local sections_file = lessoncache .. '.lesson-sections.txt.kp'
  local pages_file = lessonpagecache .. '.workbook-pages-ls.txt.kp'
  local optExercisePages_file = lessonpagecache .. '.opt-exercise-pages-ls.txt.kp'
  local handoutPages_file = lessonpagecache .. '.handout-exercise-pages-ls.txt.kp'
  local notesFiles_file = lessonpagecache .. '.workbook-notes-pages-ls.txt.kp'
  local primitives_file = lessoncache .. '.index-primitives.txt.kp'
  local starterFiles_file = lessoncache .. '.index.starterfiles'
  local optStarterFiles_file = lessoncache .. '.index.optstarterfiles'
  local keywords_file = lessoncache .. '.lesson-keywords.json'
  local glossary_json_file = lessoncache .. '.index-glossary.json'
  local prereqs_file = lessoncache .. '.lesson-prereq.txt.kp'
  local standards_file = lessoncache .. '.lesson-standards-w-prose.txt.kp'
  local slidesId_file = lessondir .. 'slides-' .. proglang_txt .. '.id'
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
    if description_txt == '' then
      print('WARNING: Missing description for lesson ' .. lesson)
    end
  end
  --
  if file_exists_p(sections_file) then
    i = io.open(sections_file)
    for line in i:lines() do
      sections_txt = sections_txt .. line .. ', '
    end
    i:close()
  end
  --
  if file_exists_p(pages_file) then
    i = io.open(pages_file)
    for line in i:lines() do
      pages_txt = pages_txt .. '{fileName: \"' .. line .. '\", title:\"' .. page_title(line) .. '\"}, '
    end
    i:close()
  end
  --
  if file_exists_p(optExercisePages_file) then
    i = io.open(optExercisePages_file)
    for line in i:lines() do
      optExercisePages_txt = optExercisePages_txt .. '{fileName: \"' .. line .. '\", title:\"' .. page_title(line) .. '\"}, '
    end
    i:close()
  end
  --
  if file_exists_p(handoutPages_file) then
    i = io.open(handoutPages_file)
    for line in i:lines() do
      handoutPages_txt = handoutPages_txt .. '{fileName: \"' .. line .. '\", title:\"' .. page_title(line) .. '\"}, '
    end
    i:close()
  end
  --
  if file_exists_p(notesFiles_file) then
    i = io.open(notesFiles_file)
    for line in i:lines() do
      notesFiles_txt = notesFiles_txt .. '\"' .. line .. '\", '
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
  if file_exists_p(optStarterFiles_file) then
    i = io.open(optStarterFiles_file)
    for line in i:lines() do
      optStarterFiles_txt = optStarterFiles_txt .. '\"' .. line .. '\", '
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
  o:write('    sections: [' .. sections_txt .. '],\n')
  o:write('    pages: [' .. pages_txt .. '],\n')
  o:write('    optPages: [' .. optExercisePages_txt .. '],\n')
  o:write('    handouts: [' .. handoutPages_txt .. '],\n')
  o:write('    notes: [' .. notesFiles_txt .. '],\n')
  o:write('    primitives: [' .. primitives_txt .. '],\n')
  if file_exists_p(keywords_file) then
    o:write('    keywords: ' .. read_list_from_file(keywords_file) .. ',\n')
  end
  if file_exists_p(glossary_json_file) then
    o:write('    glossary: ' .. read_list_of_glosses_from_file(glossary_json_file) .. ',\n')
  end
  o:write('    prerequisites: [' .. prerequisites_txt .. '],\n')
  o:write('    starterFiles: [' .. starterFiles_txt .. '],\n')
  o:write('    optStarterFiles: [' .. optStarterFiles_txt .. '],\n')
  if file_exists_p(slidesId_file) then
    local slidesURL = read_slidesURL(slidesId_file)
    if slidesURL then
      o:write('    slides: "' .. slidesURL .. '",\n')
    end
  else
    o:write('    slides: false,\n')
  end
  copy_file_to_port(standards_file, o)
  o:write(' },\n')
end

o:write('}\n')
o:write('// if we\'re in node, provide the module exports\n')
o:write('if(typeof module !== "undefined"){\n')
o:write('  module.exports = graph;\n')
o:write('}\n')
