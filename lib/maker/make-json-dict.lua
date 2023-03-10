#! /usr/bin/env lua

-- last modified 2023-03-08

local dict_js_file = ...

if not dict_js_file then
  dict_js_file = 'dictionaries.js'
end

dofile('lib/maker/read-alignments.lua')

local o = io.open(dict_js_file, 'w+')

local function display_sublist(dictionaries)
  for _,dictionary in ipairs(dictionaries) do
    o:write('    "' .. dictionary[1] .. '": {\n')
    for _,entry in ipairs(dictionary[3]) do
      local desc = entry[2]:gsub('"', '\\"'):gsub('\n', '\\n')
      o:write('      "' .. entry[1] .. '": {\n')
      o:write('        "description": "' .. desc .. '",\n')
      o:write('        "lessons": [')
      for i,lesson in ipairs(entry) do
        if i <= 2 then goto continue end
        o:write('"' .. lesson .. '", ')
        ::continue::
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
