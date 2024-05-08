#! /usr/bin/env lua

-- print('doing make-slides.lua in ' .. os.getenv'PWD')

local make_dir = os.getenv'TOPDIR' .. '/' .. os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')

local file_being_read = 'noneyet'

local function errmsg_file_context()
  return os.getenv('PWD') .. '/' .. file_being_read
end

local read_group = make_read_group(identity, errmsg_file_context)

-- terror == Terminate with ERROR
local terror = make_error_function(errmsg_file_context)

local lplan_file = 'index.adoc'


-- make it zlides.md for now, when completely debugged rename to slides.md
local slides_file = 'zlides.md'

local function nicer_case(s)
  if s == '' then return s
  elseif s == 'codap' then return 'CODAP'
  elseif s == 'wescheme' then return 'WeScheme'
  else
    return string.upper(s:sub(1,1)) .. s:sub(2)
  end
end

local proglang = first_line('.cached/.record-proglang') or 'pyret'

local slides_id_file = 'slides-' .. proglang .. '.id'

if not file_exists_p(slides_id_file) then
  print('WARNING: Lesson ' .. os.getenv('PWD') .. ' missing ' .. slides_id_file)
end

local lesson_superdir = first_line('.cached/.record-superdir') or 'Core'

local course_string = 'Core'

if lesson_superdir == 'Data-Science' or lesson_superdir == 'Algebra2' then
  course_string = 'DS'
elseif lesson_superdir == 'Algebra' then
  course_string = 'A'
elseif lesson_superdir == 'Reactive' then
  course_string = 'R'
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
  "R Title Slide",
  "R Title and Body",
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
  local coeIdx = 0
  local imgIdx = 0
  local curr_slide

  local function set_current_slide()
    local n = #slides
    if curr_slide.text == '' or
      (n == 0 and curr_slide.header == '') then
      return
    end
    set_imageorientation(curr_slide)
    slides[n + 1] = curr_slide
  end

  local function scan_directives (i, nested_in, dont_count_image_p)
    if not nested_in then curr_slide = newslide() end
    while true do
      local c = i:read(1)
      if not c then
        if not nested_in then
          set_current_slide()
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
        if directive == 'show' then
          local arg = read_group(i, directive, 'scheme', 'multiline')
          if arg:match('%(coe') then
            coeIdx = coeIdx + 1
            if not inside_table_p then
              if not dont_count_image_p then
                curr_slide.numimages = curr_slide.numimages + 1
              end
              curr_slide.text = curr_slide.text .. '@autogen-image{coe' .. coeIdx .. '}{images/AUTOGEN-COE' .. coeIdx .. '.png}'
            end
          else
            if not inside_table_p then
              curr_slide.text = curr_slide.text .. c .. directive .. '{' .. arg .. '}'
            end
          end
        elseif directive == 'image' or directive == 'centered-image' then
          local arg = read_group(i, directive)
          imgIdx = imgIdx + 1
          if not inside_table_p then
            if (not dont_count_image_p) and directive == 'image' then
              curr_slide.numimages = curr_slide.numimages + 1
            end
            curr_slide.text = curr_slide.text .. '@autogen-image{img' .. imgIdx .. '}{images/AUTOGEN-IMAGE' .. imgIdx .. '.png}'
          end
        elseif inside_table_p then
          if directive == 'preparation' and #slides == 0 then
            curr_slide.preparation = read_group(i, directive, not 'scheme', 'multiline')
          end
        elseif directive == 'clear' then
          --noop
        elseif directive == 'scrub' or
          directive == 'pathway-only' or
          directive == 'vspace' or
          directive == 'comment' then
          --
          read_group(i, directive)
        elseif directive == 'include' then
          if #slides > 1 then
            local arg = read_group(i, directive)
            print('WARNING: Found @include{' .. arg .. '} outside @ifnotslide in ' .. errmsg_file_context())
          end
        elseif directive == 'ifnotslide' then
          local txt = read_group(i, directive)
          local txt2, n = txt:gsub('|===.-|===', 'z')
          tableIdx = tableIdx + n
          _, n = txt:gsub('@show{%(coe', 'z')
          coeIdx = coeIdx + n
          txt2, n = txt2:gsub('@image{', 'z')
          imgIdx = imgIdx + n
          txt2, n = txt2:gsub('@centered-image{', 'z')
          imgIdx = imgIdx + n
        elseif directive == 'ifproglang' then
          local pls = read_group(i, directive)
          if not pls:match(proglang) then
            read_group(i, directive)
          else
            local txt = read_group(i, directive, not 'scheme', 'multiline')
            scan_directives(io.open_buffered(false, txt), nested_in or directive, dont_count_image_p)
          end
        elseif directive == 'proglang' then
          curr_slide.text = curr_slide.text .. nicer_case(proglang)
        elseif directive == 'star' then
          curr_slide.text = curr_slide.text .. '★'
        elseif directive == 'ifslide' then
          local txt = read_group(i, directive, not 'scheme', 'multiline')
          scan_directives(io.open_buffered(false, txt), directive, dont_count_image_p)
        elseif directive == 'teacher' or directive == 'QandA' then
          local txt = read_group(i, directive, not 'scheme', 'multiline')
          curr_slide.text = curr_slide.text .. '@' .. directive .. '{'
          scan_directives(io.open_buffered(false, txt), directive, dont_count_image_p)
          curr_slide.text = curr_slide.text .. '}'
        elseif directive == 'ifpathway' then
          local pwys = read_group(i, directive)
          ignore_spaces(i)
          local text = read_group(i, directive, not 'scheme', 'multiline')
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
          if nested_in and nested_in ~= 'ifproglang' then
            terror('@slidebreak inside @' .. nested_in)
          end
          set_current_slide()
          local c2 = buf_peek_char(i)
          curr_slide = newslide()
          curr_slide.section = 'Repeat'
          curr_slide.header = 'SLIDE BREAK'
          if c2 == '{' then
            curr_slide.style = read_group(i, directive)
          end
        elseif directive == 'slidestyle' then
          curr_slide.style = read_group(i, directive)
        elseif directive == 'A' then
          if not nested_in or nested_in ~= 'QandA' then
            terror('@A outside @QandA')
          end
          local arg = read_group(i, directive, not 'scheme', 'multiline')
          curr_slide.text = curr_slide.text .. c .. directive .. '{'
          scan_directives(io.open_buffered(false, arg), directive, 'dont count images')
          curr_slide.text = curr_slide.text .. '}'
        elseif directive == 'strategy' then
          local arg1 = read_group(i, directive)
          ignore_spaces(i)
          local arg2 = read_group(i, directive, not 'scheme', 'multiline')
          curr_slide.text = curr_slide.text .. c .. directive .. '{' .. arg1 .. '}{'
          scan_directives(io.open_buffered(false, arg2), directive, dont_count_image_p)
          curr_slide.text = curr_slide.text .. '}'
        else
          if directive == 'image' then
            -- dead?
            if not inside_table_p and not dont_count_image_p then
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
          i:read()
          beginning_of_line_p = true
        elseif inside_css_p then
          --noop
        elseif c == '=' then
          local L = i:read()
          beginning_of_line_p = true
          -- print('L = ' .. L)
          if not L then
            curr_slide.text = curr_slide.text .. c
            set_current_slide()
            break
          else
            if nested_in and nested_in ~= 'ifproglang' then
              terror('\"=' .. L .. '\" inside @' .. nested_in)
            end
            new_level = ((L:match('^ ') and 0) or (L:match('^= ') and 1) or 2)
            new_header = L:gsub('^=*%s*(.*)', '%1'):gsub('@duration.*', '')
            if ((curr_slide.level == 2) and (curr_slide.header == "Common Misconceptions") and (new_level == 2)) then
              if (new_header == 'Synthesize') then
                curr_slide.header = new_header
                curr_slide.text = '@teacher{\n' .. curr_slide.text .. '}\n'
                curr_slide.section = 'Synthesize'
              else
                terror("Saw 'Common Misconceptions' that was not immediately followed by 'Synthesize'")
              end
            else
              set_current_slide()
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
          local L = i:read()
          if not L then break
          else
            beginning_of_line_p = true
          end
        elseif c == '|' and read_if_poss(i, '===') then
          i:read()
          inside_table_p = not inside_table_p
          beginning_of_line_p = true
          if inside_table_p then
            tableIdx = tableIdx + 1
            curr_slide.text = curr_slide.text .. '@autogen-image{table' .. tableIdx .. '}{images/AUTOGEN-TABLE' .. tableIdx .. '.png}'
          end
        elseif inside_table_p then
          --noop
        else
          curr_slide.text = curr_slide.text .. c
        end
      elseif inside_css_p or inside_table_p then
        --noop
      else
          curr_slide.text = curr_slide.text .. c
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
            .. ' in ' .. os.getenv('PWD') .. '.\n'
            .. 'Falling back to ' .. curr_section .. slide.imageorientation)
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
          l1 = l1:gsub('{empty}', '')
          o:write(l1, '\n')
        end
      end
    end
  end
  o:close()
end

make_slides_file(lplan_file, slides_file)
