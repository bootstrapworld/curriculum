#! /usr/bin/env lua

-- print('doing make-images-js.lua')

local image_js_file = ...

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

local file_being_read = 'none-yet'

local read_group = make_read_group(identity, function()
  return file_being_read
end)

local function expand_some_directives(i, o)
  while true do
    local c = i:read(1)
    if not c then break end
    if c == '@' then
      local directive = read_word(i)
      if directive == 'link' then
        local args = read_commaed_group(i, directive, read_group)
        local link = args[1]
        table.remove(args, 1)
        local text = table.concat(args, ', ')
        o:write('<a href=\'' .. link .. '\'>' .. text .. '</a>')
      else
        o:write('@' .. directive)
      end
    else
      o:write(c)
    end
  end
end

local dist_dir = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/'
local lessons_dir = dist_dir .. 'lessons/'
local lessons = read_file_lines(os.getenv 'LESSONS_LIST_FILE')
local o = io.open(image_js_file, 'w+')

o:write('var images = {\n')

local function report_missing_images(logf, image_json_file)
  if not file_exists_p(logf) then return end
  local files = read_file_lines(logf)
  local already_read = {}
  local res = {}
  for _,file in ipairs(files) do
    if not already_read[file] then
      already_read[file] = true
      table.insert(res, file)
    end
  end
  for _,file in ipairs(res) do
    print('WARNING: Image file ' .. file .. ' referenced in ' .. image_json_file .. ' not found')
  end
end

for _,lesson in ipairs(lessons) do
  local lesson_image_list_file = lessons_dir .. lesson .. '/images/.cached/.image-list.txt.kp'
  local missing_image_logf = lessons_dir .. lesson .. '/.cached/.missing-image-files.txt'
  report_missing_images(missing_image_logf, lesson_image_list_file)
  if not file_exists_p(lesson_image_list_file) then goto continue end
  o:write('"' .. lesson .. '": {\n')
  local fi = io.open(lesson_image_list_file)
  for image_file in fi:lines() do
    local lesson_image_file = lessons_dir .. lesson .. '/images/' .. image_file
    file_being_read = lesson_image_file
    local j_obj = read_json_file(lesson_image_file)
    local j_keys = j_obj.__json_keys
    for i,k in ipairs(j_keys) do
      o:write('"' .. k .. '": ')
      local v = j_obj[k]
      local bi = io.open_buffered(false, json_hash_stringify(v))
      expand_some_directives(bi, o)
      bi:close()
      o:write(',\n')
    end
  end
  fi:close()
  o:write('},\n')
  ::continue::
end

o:write('}\n')
