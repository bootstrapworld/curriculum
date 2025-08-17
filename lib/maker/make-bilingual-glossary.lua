#! /usr/bin/env lua

local glossary_terms_file, glossary_adoc_file = ...

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

dofile(os.getenv'PROGDIR' .. '/defines.lua')

local glossary_list = file_exists_p(glossary_terms_file) and read_json_file(glossary_terms_file) or {}

local o = io.open(glossary_adoc_file, 'w+')

local function extract_keywords(tbl)
  local o_tbl = {}
  for _,kwds in ipairs(tbl) do
    table.insert(o_tbl, kwds[1])
  end
  return table.concat(o_tbl, ', ')
end

local function display_lang_entry(lang_entry)
  local keyword_list
  if lang_entry then
    keyword_list = extract_keywords(lang_entry.keywords)
    local mod_entry = '@glossary-entry{' .. keyword_list .. '}'
    local mod_desc = lang_entry.description:gsub('@vocab', '@vocab-link')
    o:write(mod_entry .. ' :: ' .. mod_desc .. '\n\n')
  else
    o:write '[.missing]#missing entry# :: ...\n\n'
  end
end

o:write '= Bilingual Glossary\n\n'
o:write '++++\n'
o:write '<style>\n'
o:write '.missing { font-style: italic; color: #993333; }\n'
o:write '</style>\n'
o:write '++++\n\n'

o:write(glossary_preface)

o:write '\n\n'

for _,entry in ipairs(glossary_list) do
  display_lang_entry(entry['en-us'])
  display_lang_entry(entry['es-mx'])
  o:write("'''\n\n")
end

o:close()
