#! /usr/bin/env lua

-- print('doing make-slides.lua in ' .. os.getenv'PWD')

local make_dir = os.getenv'TOPDIR' .. '/' .. os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')

local file_being_read = 'noneyet'

local read_group = make_read_group(identity, function()
  return file_being_read .. ' in ' .. os.getenv('PWD')
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

local proglang = first_line('.cached/.record-proglang') or 'pyret'

local lesson_superdir = first_line('.cached/.record-superdir') or 'Core'

local course_string = 'Core'

if lesson_superdir == 'Data-Science' or lesson_superdir == 'Algebra2' then
  course_string = 'DS'
elseif lesson_superdir == 'Algebra' then
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
  "Investigate-RP",
  "Investigate2",
  "InvestigateC-DN",
  "InvestigateR-DN",
  "Investigate2T",
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
    preparation = false,
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
  file_being_read = lsn_plan_adoc_file
  local slides = {}
  local inside_table_p = false
  local inside_code_display_p = false
  local inside_css_p = false
  local inside_lesson_instruction = false
  local beginning_of_line_p = true
  local tableIdx = -1 -- to skip the preamble table
  local curr_slide = newslide()

  local function scan_directives (i, nested)
    while true do
      local c = i:read(1)
      if not c then
        if not nested then
          set_current_slide(slides, curr_slide)
        end
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
        if inside_table_p then
          if directive == 'preparation' then
            curr_slide.preparation = read_group(i, directive, false, true)
          end
        elseif directive == 'scrub' then
          read_group(i, directive)
        elseif directive == 'ifnotslide' then
          local txt = read_group(i, directive)
          local _, n = txt:gsub('|===', 'z')
          n = math.floor(n / 2)
          tableIdx = tableIdx + n
        elseif directive == 'ifproglang' then
          local pls = read_group(i, directive)
          if not pls:match(proglang) then
            read_group(i, directive)
          else
            local txt = read_group(i, directive, false, true)
            scan_directives(io.open_buffered(false, txt), true)
          end
        elseif directive == 'ifpathway' then
          local pwys = read_group(i, directive)
          ignore_spaces(i)
          local text = read_group(i, directive, false, true)
          curr_slide.text = curr_slide.text .. '@teacher{\nIF PATHWAY IS ' .. pwys .. '\n' .. text .. '}\n'
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
          local c2 = buf_peek_char(i)
          curr_slide = newslide()
          curr_slide.section = 'Repeat'
          curr_slide.header = 'SLIDE BREAK'
          if c2 == '{' then
            curr_slide.style = read_group(i, directive)
          end
        elseif directive == 'A' then
          local arg = read_group(i, directive)
          curr_slide.text = curr_slide.text .. c .. directive .. '{' .. arg .. '}'
        elseif directive == 'strategy' then
          local arg1 = read_group(i, directive)
          ignore_spaces(i)
          local arg2 = read_group(i, directive)
          curr_slide.text = curr_slide.text .. c .. directive .. '{' .. arg1 .. '}{' .. arg2 .. '}'
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
        if c == '+' and read_if_poss(i, '+++') then
          inside_css_p = not inside_css_p
        elseif c == '+' and inside_css_p and read_if_poss(i, '+++') then
          inside_css_p = false
        elseif c == '-' and read_if_poss(i, '---') then
          curr_slide.text = curr_slide.text .. '----'
          inside_code_display_p = not inside_code_display_p
        elseif c == '/' and (not inside_code_display_p) and read_if_poss(i, '/') then
          i:read_line()
          beginning_of_line_p = true
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
            if ((curr_slide.level == 2) and (curr_slide.header == "Common Misconceptions") and (new_level == 2)) then
              if (new_header == 'Synthesize') then
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
          local L = i:read_line()
          if not L then break
          elseif L:match('cols=[%d"\']') or L:match('sideways%-pyret%-table') then
            beginning_of_line_p = true
          else
            curr_slide.text = curr_slide.text .. '['
            buf_toss_back_char('\n', i)
            buf_toss_back_string(L, i)
          end
        elseif c == '|' and read_if_poss(i, '===') then
          i:read_line()
          inside_table_p = not inside_table_p
          beginning_of_line_p = true
          if inside_table_p then
            tableIdx = tableIdx + 1
            curr_slide.text = curr_slide.text .. '@table{' .. tableIdx
            curr_slide.text = curr_slide.text .. '}\n'
          end
        else
          if not inside_table_p then
            curr_slide.text = curr_slide.text .. c
          end
        end
      elseif inside_css_p then
        --noop
      else
        if not inside_table_p then
          curr_slide.text = curr_slide.text .. c
        end
      end
    end
    i:close()
  end

  scan_directives(io.open_buffered(lsn_plan_adoc_file))

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
        if slide.preparation then
          o:write('\nPreparation:\n')
          o:write(slide.preparation)
          o:write('\n')
        end
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
        elseif curr_section == 'Launch' then
          if slide.imageorientation == 'R' then
            if slide.suffix ~= '' then slide.suffix = '' end
          end
        elseif curr_section == 'Synthesize' then
          if slide.suffix ~= '' then
            slide.suffix = ''
          end
        end
        local curr_layout = slide.style or (curr_section .. slide.imageorientation .. slide.suffix)
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
          l1 = l1:gsub('^(%s+)#', '%1\\#')
          l1 = l1:gsub('^%-%-%-%-$', '````')
          l1 = l1:gsub('__(.-)__', '_%1_')
          l1 = l1:gsub('%*%*(.-)%*%*', '*%1*')
          l1 = l1:gsub('%*([^* ].-%S)%*', '__%1__')
          l1 = l1:gsub('%*(%S)%*', '__%1__')
          l1 = l1:gsub(' %+$', '\n')
          l1 = l1:gsub('^%+$', '\n')
          l1 = l1:gsub('{two%-colons}', '::')
          o:write(l1, '\n')
        end
      end
    end
  end
  o:close()
end

make_slides_file(lplan_file, slides_file)
