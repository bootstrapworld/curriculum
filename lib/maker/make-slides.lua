#! /usr/bin/env lua

-- print('doing make-slides.lua in ' .. os.getenv'PWD')

local make_dir = os.getenv'TOPDIR' .. '/' .. os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')

local file_being_read = 'noneyet'

local read_group = make_read_group(identity, function()
  return file_being_read
end)

local lplan_file = 'index.adoc'

-- make it zlides.md for now, when completely debugged rename to slides.md
local slides_file = 'zlides.md'

local function first_line(f)
  local i = io.open(f)
  if not i then return false end
  local x = i:read()
  if not x then return false end
  return x
end

local lesson_superdir = first_line('.cached/.record-superdir') or 'Core'

local course_string = 'Core'

if lesson_superdir == 'Data-Science' or lesson_superdir == 'Algebra2' then
  course_string = 'DS'
elseif lesson_superdir == 'Algebra' or lesson_superdir == 'Early-Math' then
  course_string = 'A'
end

local function read_if_poss(i, xxx)
  for k=1,#xxx do
    local c = i:read(1)
    if c ~= xxx:sub(k,k) then
      buf_toss_back_char(c, i)
      buf_toss_back_string(xxx:sub(1,k-1), i)
      return false
    end
  end
  return true
end

local allowed_slide_layouts = {
  "Core Title Slide",
  "Math Title Slide",
  "Math Title and Body",
  "DS Title Slide",
  "DS Title and Body",
  "LegendSlide",
  "Launch",
  "LaunchR",
  "LaunchC",
  "Launch-RP",
  "Launch-DN",
  "LaunchC-DN",
  "Investigate",
  "InvestigateR",
  "InvestigateC",
  "Investigate-DN",
  "Investigate-K",
  "Investigate-R",
  "Investigate2",
  "InvestigateC-DN",
  "InvestigateR-DN",
  "Synthesize",
  "SynthesizeR",
  "SynthesizeC",
  "Supplemental"
}

local function newslide()
  return {
    text = '',
    level = 2,
    header = '',
    numimages = 0,
    section = false,
    suffix = '',
    containscenter = false,
    imageorientation = 'R',
  }
end

local function set_imageorientation(slide)
  slide.imageorientation = ((slide.numimages == 2) and '') or 
    ((slide.containscenter and 'C') or 
    ((slide.numimages == 0) and '') or 
    'R')
end

local function set_current_slide(slides, curr_slide)
  if curr_slide.text ~= '' then
    set_imageorientation(curr_slide)
    slides[#slides + 1] = curr_slide
  end
end


local function get_slides(lsn_plan_adoc_file)
  if not file_exists_p(lsn_plan_adoc_file) then return end
  local i = io.open_buffered(lsn_plan_adoc_file)
  local slides = {}
  local inside_table_p = false
  local curr_slide = newslide()
  local inside_css_p = false
  local beginning_of_line_p = true
  local inside_lesson_instruction = false
  file_being_read = lsn_plan_adoc_file
  while true do
    local c = i:read(1)
    if not c then
      set_current_slide(slides, curr_slide)
      break
    elseif c == '\n' then
      if not inside_css_p and
        (not inside_table_p or not beginning_of_line_p) then
        curr_slide.text = curr_slide.text .. c
      end
      beginning_of_line_p = true
    elseif c == '@' and not inside_css_p then
      beginning_of_line_p = false
      local directive = read_word(i)
      if directive == 'scrub' or directive == 'ifnotslide' then
        read_group(i, directive)
      elseif directive == 'lesson-instruction' then
        inside_lesson_instruction = true
        curr_slide.text = curr_slide.text .. c .. directive
      elseif directive == 'starter-file' then
        curr_slide.suffix = '-DN'
        curr_slide.text = curr_slide.text .. c .. directive
      elseif directive == 'lesson-roleplay' then
        curr_slide.suffix = '-RP'
        curr_slide.text = curr_slide.text .. c .. directive
      elseif directive == 'slidebreak' then
        set_current_slide(slides, curr_slide)
        curr_slide = newslide()
        curr_slide.section = 'Repeat'
        curr_slide.header = 'SLIDE BREAK'
      else
        if directive == 'image' then
          if not inside_table_p then
            curr_slide.numimages = curr_slide.numimages + 1
          end
        elseif directive == 'center' then
          if not inside_table_p then
            curr_slide.containscenter = true
          end
        end
        curr_slide.text = curr_slide.text .. c .. directive
      end
    elseif beginning_of_line_p then
      beginning_of_line_p = false
      if c == '+' and (not inside_css_p) and read_if_poss(i, '+++') then
        inside_css_p = true
      elseif c == '+' and inside_css_p and read_if_poss(i, '+++') then
        inside_css_p = false
      elseif inside_css_p then
        --noop
      elseif c == '=' then
        local L = i:read_line()
        beginning_of_line_p = true
        -- print('L = ' .. L)
        if not L then
          curr_slide.text = curr_slide.text .. c
          set_imageorientation(curr_slide)
          slides[#slides + 1] = curr_slide
          break
        else
          new_level = ((L:match('^ ') and 0) or (L:match('^= ') and 1) or 2)
          new_header = L:gsub('^=*%s*(.*)', '%1'):gsub('@duration.*', '')
          if ((curr_slide.level == 2) and 
              (curr_slide.header == "Common Misconceptions") and 
              (new_level == 2)) then
            if (new_header == 'Synthesize')
            then
              curr_slide.header = new_header
              curr_slide.text = '@teacher{\n' .. curr_slide.text .. '}\n'
              curr_slide.section = 'Synthesize'
            else
              error("ERROR: Saw 'Common Misconceptions' that was not immediately followed by 'Synthesize' in " .. os.getenv('PWD'))
              break
            end
          else
            set_current_slide(slides, curr_slide)
            curr_slide = newslide()
            curr_slide.level = new_level
            curr_slide.header = new_header

            -- print('curr slide header = ' .. curr_slide.header)
            curr_slide.section = ((curr_slide.level == 2) and
              ((curr_slide.header:match('Launch') and 'Launch') or
              (curr_slide.header:match('Investigate') and 'Investigate') or
              (curr_slide.header:match('Synthesize') and 'Synthesize')))
          end
        end
      elseif c == '[' then
        local table_numcols = 0
        local table_header = false
        local L = i:read_line()
        if not L then break
        elseif L:match('cols=[%d"\']') then
          if L:match('header') then table_header = true end
          if L:match('cols=(%d+)') then
            table_numcols = tonumber(L:gsub('.-cols=(%d+).*', '%1'))
          else
            local table_cols = L:gsub('.-cols=["\'](.-)["\'].*', '%1')
            _, table_numcols = table_cols:gsub(',', 'x')
          end
          beginning_of_line_p = true
          curr_slide.text = curr_slide.text .. '@table{' .. (table_numcols + 1)
          if table_header then
            curr_slide.text = curr_slide.text .. ',header'
          end
          curr_slide.text = curr_slide.text .. '}\n'
        else
          curr_slide.text = curr_slide.text .. '['
          buf_toss_back_char('\n', i)
          buf_toss_back_string(L, i)
        end
      elseif c == '|' and read_if_poss(i, '===') then
        i:read_line()
        curr_slide.text = curr_slide.text .. (inside_table_p and '}' or '{')
        inside_table_p = not inside_table_p
        beginning_of_line_p = true
      else
        curr_slide.text = curr_slide.text .. c
      end
    elseif inside_css_p then
      --noop
    else
      curr_slide.text = curr_slide.text .. c
    end
  end
  i:close()
  local n = #slides
  if n > 1 then
    local last_slide = slides[n]
    if not last_slide.section and (last_slide.header == "Additional Exercises") then
      last_slide.section = 'Supplemental'
      last_slide.level = 2 -- knock down to level 2 so the slide contents will be printed in make_slides_file
    end
  end
  return slides
end

local function make_slides_file(lplan_file, slides_file)
  if not file_exists_p(lplan_file) then return end
  local slides = get_slides(lplan_file)
  --print('got ' .. #slides .. ' slides')
  local slides_last_idx = #slides
  local curr_header = 'notsetyet'
  local curr_section = 'notsetyet'
  local o = io.open(slides_file, 'w')

  for k,slide in ipairs(slides) do
    --print('doing slide ' .. k .. ' of level ' .. slide.level)
    if k == 1 then
      if slide.header then
        o:write('@slidebreak\n')
        o:write('{layout="', course_string, ' Title Slide"}\n')
        o:write('# ', slide.header, '\n\n')
        o:write('<!--\n')
        o:write('To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en\n')
        o:write('-->\n')
      end
    else
      if slide.section == 'Repeat' then slide.section = curr_section end
      if slide.section then curr_section = slide.section end
      if slide.level <= 1 then curr_header = slide.header
      elseif (slide.level == 2 and slide.section) then
        if slide.numimages == 2 then slide.imageorientation = '' end
        if curr_section == 'Investigate' then
          if slide.numimages == 2 then slide.suffix = '2' end
          if slide.suffix ~= '2' then
            slide.suffix = ''
          end
        elseif curr_section == 'Launch' then
          if slide.imageorientation == 'R' then
            if slide.suffix ~= '' then slide.suffix = '' end
          end
        elseif curr_section == 'Synthesize' then
          if slide.suffix ~= '' then
            slide.suffix = ''
          end
        end
        local curr_layout = curr_section .. slide.imageorientation .. slide.suffix
        if not memberp(curr_layout, allowed_slide_layouts) then
          print('WARNING: Unknown slide template: ' .. curr_layout
            .. ' in ' .. os.getenv('PWD') .. "\n"
            .. '. Falling back to ' .. curr_section .. slide.imageorientation)
          slide.suffix = ''
          curr_layout = curr_section .. slide.imageorientation
        end
        o:write('@slidebreak\n')
        o:write('{layout="', curr_layout, '"}\n')
        o:write('# ', curr_header, '\n\n')
        local slide_lines = string_split(slide.text, '\n')
        for _,l1 in ipairs(slide_lines) do
          l1 = l1:gsub('__(.-)__', '_%1_')
          l1 = l1:gsub('%*%*(.-)%*%*', '*%1*')
          l1 = l1:gsub('%*(%S.-%S)%*', '__%1__')
          l1 = l1:gsub('%*(%S)%*', '__%1__')
          l1 = l1:gsub(' %+$', '\n')
          l1 = l1:gsub('^%+$', '\n')
          o:write(l1, '\n')
        end
      end
    end
  end
  o:close()
end

make_slides_file(lplan_file, slides_file)
