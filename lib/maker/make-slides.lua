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

local lesson_superdir = first_line('.cached/.record-superdir') or 'Default'

local course_string = 'Default'

if lesson_superdir == 'Data-Science' or lesson_superdir == 'Algebra2' then
  course_string = 'DS'
elseif lesson_superdir == 'Algebra' or lesson_superdir == 'Early-Math' then
  course_string = 'A'
end

function get_segments(lplan_file)
  local i = io.open(lplan_file)
  local segments = {}
  local current_segment = false
  --
  for L in i:lines() do
    if L:match('^=') or L:match('^%s*@slidebreak') then
      if current_segment then
        segments[#segments + 1] = current_segment
      end
      current_segment = {}
    end
    if current_segment then
      current_segment[#current_segment + 1] = L
    end
  end
  --
  i:close()
  --
  return segments
end

function type_of_slide(segment)
  local L1 = segment[1]
  if not L1 then
    return 2
  elseif L1:match('^= ') then
    return 0
  elseif L1:match('^== ') then
    return 1
  else
    return 2
  end
end

function find_segment_title(segment)
  local L = segment[1]
  if not L then
    return nil
  elseif L:match('^=') then
    local heading = L:gsub('^=+%s*(.*)', '%1')
    heading = heading:gsub('@duration.*', '')
    return heading
  else
    return nil
  end
end

function number_of_images(segment)
  local n = 0
  for _,L in ipairs(segment) do
    if L:match('@image') then
      n = n + 1
    end
  end
  return n
end

function find_section(segment)
  return 'Launch'
end

function contains_center(segment)
  for _,L in ipairs(segment) do
    if L:match('@center') then
      return true
    end
  end
  return false
end

function find_image_orientation(segment, default)
  default = default or 'R'
  local centered = contains_center(segment)
  if centered then
    return 'C'
  else
    local n = number_of_images(segment)
    if n == 1 then
      return 'R'
    else
      return default
    end
  end
end

function find_suffix(segment)
  for _,L in ipairs(segment) do
    if L:match('%[%.lesson%-instruction%]') then
      return '-DN'
    end
  end
  return ''
end

function make_slides_file(lplan_file, slides_file)

  local segments = get_segments(lplan_file)

  local segments_last_index = #segments

  local o = io.open(slides_file, 'w')

  local current_title = 'not_yet_set'

  for k,current_segment in ipairs(segments) do
    local section
    if k == segments_last_index then
      section = 'Supplemental'
    else
      section = find_section(current_segment)
    end
    local image_orientation = find_image_orientation(current_segment)
    local suffix = find_suffix(current_segment)
    local level = type_of_slide(current_segment)
    if level <= 1 then
      current_title = find_segment_title(current_segment)
    end
    if k == 1 then
      o:write('---\n')
      o:write('{layout="', course_string, ' Title Slide"}\n')
      o:write('# ', current_title, '\n\n')
      o:write('<!--\n')
      o:write('To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en\n')
      o:write('-->\n')
    elseif level ~= 1 then
      o:write('---\n')
      o:write('{layout="', section, image_orientation, suffix, '"}\n')
      o:write('# ', current_title, '\n\n')
      for j,L in ipairs(current_segment) do
        if j ~= 1 then
          o:write(L, '\n')
        end
      end
    end
  end
end

make_slides_file(lplan_file, slides_file)
