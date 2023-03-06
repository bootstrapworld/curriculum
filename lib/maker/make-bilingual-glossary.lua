#! /usr/bin/env lua

-- last modified 2023-03-06

local glossary_terms_file, glossary_adoc_file = ...

dofile(os.getenv'MAKE_DIR' .. 'utils.lua')
dofile(os.getenv'MAKE_DIR' .. 'readers.lua')
dofile(os.getenv'MAKE_DIR' .. 'sread.lua')

local glossary_list

if file_exists_p(glossary_terms_file) then
  glossary_list = sread_file(glossary_terms_file)
else
  glossary_list = {}
end

local o = io.open(glossary_adoc_file, 'w+')

local function extract_keywords(tbl)
  local kwd1 = tbl[1]
  local other_kwds = table.remove(tbl, 1)
  local o_tbl = {}
  if type(kwd1) == 'table' then
    table.insert(o_tbl, kwd1[1])
  else
    table.insert(o_tbl, kwd1)
  end
  for _,kwd in ipairs(other_kwds) do
    if type(kwd) then 
      table.insert(o_tbl, kwd[1])
    end
  end
  return table.concat(o_tbl, ', ')
end

local function display_lang_entry(lang_entry)
  if lang_entry then
    keyword = lang_entry.keywords
    if type(keyword) == 'table' then
      keyword = extract_keywords(keyword)
    end
    o:write(keyword .. ' :: ' .. lang_entry.desc .. '\n\n')
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

for _,entry in ipairs(glossary_list) do
  local en_us_entry
  local es_mx_entry
  for _,lang_entry in ipairs(entry) do
    local lang = lang_entry[1]
    if lang == 'en-us' then
      en_us_entry = {}
      en_us_entry.keywords = lang_entry[2]
      en_us_entry.desc = lang_entry[3]
    elseif lang == 'es-mx' then
      es_mx_entry = {}
      es_mx_entry.keywords = lang_entry[2]
      es_mx_entry.desc = lang_entry[3]
    else
      print('WARNING: unknown lang ' .. lang)
    end
  end
  display_lang_entry(en_us_entry)
  display_lang_entry(es_mx_entry)
  o:write("'''\n\n")
end

o:close()
