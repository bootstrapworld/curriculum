#! /usr/bin/env lua

local lplan_file = 'index.adoc'

-- make it zlides.md for now, when completely debugged rename to slides.md
local slides_file = 'zlides.md'

function first_line(f)
  local i = io.open(f)
  if not i then return false end
  local x = i:read()
  if not x then return false end
  return x
end

local course_string = first_line('.cached/.record-superdir') or 'Default'


function make_slides_file()
  local i = io.open(lplan_file)
  if not i then return end

  local o = io.open(slides_file, 'w')

  local current_slide_title = 'default slide title'

  local start = true

  local processing_slides = false

  for L in i:lines() do
    if start then
      if L:match('^= ') then
        local title_string = L:gsub('^=%s*(.*)', '%1')
        current_slide_title = title_string
        start = false
        o:write('---\n')
        o:write('{layout="', course_string, ' Title Slide"}\n')
        o:write('# ', title_string, '\n\n')
        o:write('<!--\n')
        o:write('To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en\n')
        o:write('-->\n---\n')
      end
      goto continue
    end
    if L:match('^== ') or L:match('^=== ') or L:match('^%s*@slidebreak') then
      if not processing_slides then processing_slides = true end
      if L:match('^== ') then
        current_slide_title = L:gsub('^==%s*(.*)', '%1')
        current_slide_title = current_slide_title:gsub('@duration.*', '')
      end
      o:write('# ', current_slide_title, '\n')
    elseif processing_slides then
      o:write(L, '\n')
    end
    ::continue::
  end

  o:close()
end

make_slides_file()
