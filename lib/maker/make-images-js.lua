#! /usr/bin/env lua

-- last modified 2023-03-06

-- print('doing make-images-js.lua')

local image_js_file = ...

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

dofile(os.getenv('MAKE_DIR') .. 'readers.lua')

local read_group = make_read_group(identity, function()
  return 'Collecting images'
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
        o:write('< href="' .. link .. '">' .. text .. '</a>')
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
local lessons = dofile(os.getenv 'LESSONS_LIST_FILE')
local o = io.open(image_js_file, 'w+')

o:write('var images = {\n')

for _,lesson in ipairs(lessons) do
  local lesson_image_file = lessons_dir .. lesson .. '/images/lesson-images.json'
  if not file_exists_p(lesson_image_file) then goto continue end
  -- print('lesson_image_file is ' .. lesson_image_file)
  o:write('"' .. lesson .. '": ')
  local bi = io.open_buffered(lesson_image_file)
  expand_some_directives(bi, o)
  bi:close()
  o:write(',\n')
  ::continue::
end

o:write('}\n')
