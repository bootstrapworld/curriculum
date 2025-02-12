#! /usr/bin/env lua

local dict_js_file = ...

local make_dir = 'lib/maker/'

dofile(make_dir .. 'read-alignments.lua')

local o = io.open(dict_js_file, 'w+')

local function display_sublist(dictionaries)
  for _,dictionary in ipairs(dictionaries) do
    local dict_name = dictionary[1]
    local dict_fullname = dictionary[2]
    local dict_hash_tbl = dictionary[3]
    local dict_url = dictionary[4]
    o:write('    "' .. dict_name .. '": {\n')
    o:write('      "__metadata": {\n')
    o:write('         "fullname": "' .. dict_fullname .. '",\n')
    o:write('         "url": "' .. dict_url .. '"\n')
    o:write('      },\n')
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

o:write('module.exports = { dictionaries: dictionaries }')
o:close()
