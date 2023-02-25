#! /usr/bin/env lua

-- last modified 2023-02-25

dofile(os.getenv('TOPDIR') .. '/' .. os.getenv('MAKE_DIR') .. 'readers.lua')

read_group = make_read_group(identity, function()
  return 'Collecting images'
end)

function expand_some_directives(i, o)
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

do
  local image_files = os.getenv('IMAGE_LIST_FILE')
  local image_js_file = os.getenv('IMAGE_JS_FILE')
  local images = dofile(image_files)
  local o = io.open(image_js_file, 'w+')
  o:write('var images = {\n')
  for _,lsn_img in ipairs(images) do
    local lesson_basename = lsn_img[1]
    o:write('"' .. lesson_basename .. '": ')
    local lesson_image_file = lsn_img[2]
    local bi = io.open_buffered(lesson_image_file)
    expand_some_directives(bi, o)
    bi:close()
    o:write(',\n')
  end
  o:write('}\n')
end
