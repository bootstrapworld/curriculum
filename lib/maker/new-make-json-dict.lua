#! /usr/bin/env lua

-- last modified 2023-03-11

local dict_js_file = ...

if not dict_js_file then
  dict_js_file = 'dictionaries.js'
end

dofile('lib/maker/read-alignments.lua')

local o = io.open(dict_js_file, 'w+')

local function display_sublist(dictionaries)
  for _,dictionary in ipairs(dictionaries) do
    local dict_name = dictionary[1]
    local dict_hash_tbl = dictionary[3]
    o:write('    "' .. dict_name .. '": {\n')
    for _,lbl in ipairs(dict_hash_tbl.__json_keys) do
      local entry = dict_hash_tbl[lbl]
      local desc = entry.description:gsub('"', '\\"'):gsub('\n', '\\n')
      o:write('      "' .. lbl .. '": {\n')
      o:write('        "description": "' .. desc .. '",\n')
      o:write('        "lessons": [')
      for _,lsn in ipairs(entry.lessons) do
        o:write('"' .. lsn .. '", ')
      end
      o:write(']\n')
      o:write('      },\n')
    end
    o:write('    },\n')
  end
end

o:write('let dictionaries = {\n')

o:write('  "standards": {\n')
display_sublist(standards_list)
o:write('  },\n')

o:write('  "textbooks": {\n')
display_sublist(textbooks_list)
o:write('  },\n')

o:write('  "practices": {\n')
display_sublist(practices_list)
o:write('  }\n')

o:write('};\n')

o:close()
