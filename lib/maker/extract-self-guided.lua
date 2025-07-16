#! /usr/bin/env lua

local hfile, jfile = ...

local i = io.open(hfile, 'r')
local o = io.open(jfile, 'w')

local writing_p = false

local skip_one_more_line_p = false


o:write('export const selfGuidedBookBits = [\n')

local counter = 0

for x in i:lines() do
  if writing_p then
    if skip_one_more_line_p then
      skip_one_more_line_p = false
    elseif x:match('stop_slide') or x:match('end_all_slides') then
      o:write('</div>`\n},\n')
      writing_p = false
      if x:match('end_all_slides') then
        break
      end
    else
      o:write(x, '\n')
    end
  elseif x:match('start_slide') then
    writing_p = true
    skip_one_more_line_p = true
    counter = counter + 1
    print('counter=', counter)
    o:write('{\neditorCode: EDITOR_CODE_', tostring(counter), ',\nlessonText: `\n')
  else
    --noop
  end
end

o:write(']\n')

i:close()
o:close()
