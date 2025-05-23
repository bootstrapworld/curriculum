#! /usr/bin/env lua

-- print('doing make-slides.lua in ' .. os.getenv'PWD')

local make_dir = os.getenv'TOPDIR' .. '/' .. os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')
dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'adoc-to-md.lua')

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

if lesson_superdir == 'Data-Science' then
  course_string = 'DS'
elseif lesson_superdir == 'Algebra' or lesson_superdir == 'Algebra2' or lesson_superdir == 'Expressions-and-Equations' then
  course_string = 'Math'
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
  "Core Title and Body",
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
    section = false,
    containsoptblock = false,
    preparation = false,
  }
end

-- Note: we're counting levels using the AsciiDoc convention. It's -1+ the number of ='s

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
  local curr_slide_header = ''
  local curr_slide_level = 0
  local curr_slide_section = false
  local curr_slide_style = ''
  local curr_slide_preparation = false
  local writing_curr_slide_text_p = true

  local function set_current_slide()
    -- add curr_slide, if valid, to list of slides
    local n = #slides
    local txt = curr_slide and curr_slide.text or ''
    if n == 0 then txt = 'keep-title-slide' end
    if txt == '' or (n == 0 and curr_slide_header == '') or not txt:match('%S') then
      -- print('discarding empty slide in ' .. errmsg_file_context())
      return false
    end
    curr_slide.header = curr_slide_header
    curr_slide.level = curr_slide_level
    curr_slide.section = curr_slide_section
    curr_slide.style = curr_slide_style
    if n == 0 and curr_slide_preparation then
      curr_slide.preparation = curr_slide_preparation
      curr_slide_preparation = false
    end
    slides[n + 1] = curr_slide
    return true
  end

  local function insert_slide_break()
    set_current_slide()
    curr_slide = newslide()
    curr_slide_level = 2
    curr_slide_section = 'Repeat'
    writing_curr_slide_text_p = true
    return curr_slide
  end

  local function update_curr_slide_text(str)
    if writing_curr_slide_text_p then
      curr_slide.text = curr_slide.text .. str
    end
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
          update_curr_slide_text(c)
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
              update_curr_slide_text('@autogen-image{coe' .. coeIdx .. '}{images/AUTOGEN-COE' .. coeIdx .. '.png}')
            end
          else
            if not inside_table_p then
              update_curr_slide_text(c .. directive .. '{' .. arg .. '}')
            end
          end
        elseif directive == 'image' or directive == 'centered-image' then
          local arg = read_group(i, directive)
          imgIdx = imgIdx + 1
          if not inside_table_p then
            update_curr_slide_text('@autogen-image{img' .. imgIdx .. '}{images/AUTOGEN-IMAGE' .. imgIdx .. '.png}')
          end
        elseif inside_table_p then
          if directive == 'preparation' and #slides == 0 then
            curr_slide_preparation = read_group(i, directive, not 'scheme', 'multiline')
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
          txt2, n = txt2:gsub('@centered%-image{', 'z')
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
          update_curr_slide_text(nicer_case(proglang))
        elseif directive == 'star' then
          update_curr_slide_text('★')
        elseif directive == 'ifslide' then
          local txt = read_group(i, directive, not 'scheme', 'multiline')
          scan_directives(io.open_buffered(false, txt), directive, dont_count_image_p)
        elseif directive == 'teacher' or directive == 'QandA' then
          local txt = read_group(i, directive, not 'scheme', 'multiline')
          update_curr_slide_text('@' .. directive .. '{')
          scan_directives(io.open_buffered(false, txt), directive, dont_count_image_p)
          update_curr_slide_text('}')
        elseif directive == 'ifpathway' then
          local pwys = read_group(i, directive)
          ignore_spaces(i)
          local text = read_group(i, directive, not 'scheme', 'multiline')
          update_curr_slide_text('@teacher{\nIF PATHWAY IS ' .. pwys .. '\n' .. text .. '}\n')
        elseif directive == 'lesson-instruction' then
          inside_lesson_instruction = true
          update_curr_slide_text(c .. directive)
        elseif directive == 'starter-file' then
          update_curr_slide_text(c .. directive)
        elseif directive == 'lesson-roleplay' then
          update_curr_slide_text(c .. directive)
        elseif directive == 'slidebreak' then
          if nested_in and (nested_in ~= 'ifproglang' and nested_in ~= 'ifpdslide' and nested_in ~= 'ifslide') then
            terror('@slidebreak inside @' .. nested_in)
          end
          insert_slide_break()
          local c2 = buf_peek_char(i)
          if c2 == '{' then
            curr_slide_style = read_group(i, directive)
          elseif nested_in == 'ifpdslide' then
            curr_slide_style = course_string .. ' Title and Body'
          end
        elseif directive == 'slideoverride' then
          curr_slide_style = read_group(i, directive)
        elseif directive == 'A' then
          if not nested_in or nested_in ~= 'QandA' then
            terror('@A outside @QandA')
          end
          local arg = read_group(i, directive, not 'scheme', 'multiline')
          update_curr_slide_text(c .. directive .. '{')
          scan_directives(io.open_buffered(false, arg), directive, 'dont count images')
          update_curr_slide_text('}')
        elseif directive == 'ifpdslide' then
          local arg2 = read_group(i, directive, not 'scheme', 'multiline')
          update_curr_slide_text(c .. directive .. '{')
          scan_directives(io.open_buffered(false, arg2), directive, dont_count_image_p)
          update_curr_slide_text('}')
        elseif directive == 'strategy-basic' then
          if nested_in ~= 'ifpdslide' then
            terror('@strategy outside @ifpdslide')
          end
          local arg1 = read_group(i, directive)
          local arg2 = read_group(i, directive, not 'scheme', 'multiline')
          update_curr_slide_text(c .. directive .. '{' .. arg1 .. '}{')
          scan_directives(io.open_buffered(false, arg2), directive, dont_count_image_p)
          update_curr_slide_text('}')
        elseif directive == 'pd-slide' then
          local arg = read_group(i, directive, not 'scheme', 'multiline')
          arg = '@ifpdslide{@slidebreak\n' .. arg .. '}\n'
          scan_directives(io.open_buffered(false, arg), directive, dont_count_image_p)
        elseif directive == 'strategy' then
          local arg1 = read_group(i, directive)
          local arg2 = read_group(i, directive, not 'scheme', 'multiline')
          arg = '@ifpdslide{@slidebreak\n@strategy-basic{' .. arg1 .. '}{' .. arg2 .. '}}\n'
          scan_directives(io.open_buffered(false, arg), directive, dont_count_image_p)
        else
          if directive == 'opt-block' then
            if writing_curr_slide_text_p then
              curr_slide.containsoptblock = true
            end
          end
          update_curr_slide_text(c .. directive)
        end
      elseif beginning_of_line_p then
        beginning_of_line_p = false
        if c == '+' and read_if_poss(i, '+++') then
          inside_css_p = not inside_css_p
        elseif c == '+' and inside_css_p and read_if_poss(i, '+++') then
          inside_css_p = false
        elseif c == '-' and read_if_poss(i, '---') then
          update_curr_slide_text('----')
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
            update_curr_slide_text(c)
            set_current_slide()
            break
          else
            if nested_in and nested_in ~= 'ifproglang' then
              terror('\"=' .. L .. '\" inside @' .. nested_in)
            end
            local new_level = ((L:match('^ ') and 0) or (L:match('^= ') and 1) or (L:match('^== ') and 2) or 3)
            local new_header = L:gsub('^=*%s*(.*)', '%1'):gsub('@duration.*', '')
            if (new_level == 3) then
              update_curr_slide_text('\n\n**' .. new_header .. '**\n\n')
              -- insert_slide_break()
            elseif ((curr_slide_level == 2) and (curr_slide_header == "Common Misconceptions") and (new_level == 2)) then
              if (new_header == 'Synthesize') then
                curr_slide_header = new_header
                if writing_curr_slide_text_p then
                  curr_slide.text = '@teacher{\n' .. curr_slide.text .. '}\n'
                end
                curr_slide_section = true
              else
                terror("Saw 'Common Misconceptions' that was not immediately followed by 'Synthesize'")
              end
            else
              local old_slide_substantial_p
              if new_level ~= 0 then
                old_slide_substantial_p = set_current_slide()
                curr_slide = false
                writing_curr_slide_text_p = false
              end
              curr_slide_level = new_level
              -- curr_slide.level = curr_slide_level

              curr_slide_section = ((curr_slide_level == 2) and
              (new_header:match('Launch') or
              new_header:match('Investigate') or
              new_header:match('Synthesize')))
              -- curr_slide.section = curr_slide_section

              if new_header == 'Overview' and not old_slide_substantial_p then
                -- keep existing curr_slide_header
              elseif new_level > 1 then
                -- keep existing curr_slide_header
              else
                curr_slide_header = new_header
              end
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
            update_curr_slide_text('@autogen-image{table' .. tableIdx .. '}{images/AUTOGEN-TABLE' .. tableIdx .. '.png}')
          end
        elseif inside_table_p then
          --noop
        else
          update_curr_slide_text(c)
        end
      elseif inside_css_p or inside_table_p then
        --noop
      else
          update_curr_slide_text(c)
      end
    end
    i:close()
  end

  scan_directives(io.open_buffered(lsn_plan_adoc_file))

  local n = #slides
  if n > 1 then
    local last_slide = slides[n]
    if not last_slide.section and (last_slide.header == "Additional Exercises") then
      last_slide.section = true
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
  local curr_section = 'notsetyetI'
  local o = io.open(slides_file, 'w')

  for k,slide in ipairs(slides) do
    --print('doing slide ' .. k .. ' of level ' .. slide.level)
    if k == 1 then
      if slide.header then
        o:write('@slidebreak\n')
        o:write('{layout="', course_string, ' Title Slide"}\n')
        o:write('# ', slide.header, '\n\n')
        o:write('<!--\n')
        o:write('\n\nThis is the **'..proglang..'** version of this lesson. Make sure you are using the right software tool (WeScheme, Pyret, CODAP, etc...')
        o:write('\n\nTo learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en')
        if slide.preparation then
          o:write('\n\nPreparation:\n')
          o:write(slide.preparation)
          o:write('\n')
        end
        o:write('\n\n-->\n')
      end
    else -- k >= 2
      -- print('outputting slide', slide.section, slide.level, slide.header)
      if slide.section == 'Repeat' then slide.section = curr_section end
      if slide.section then curr_section = slide.section end
      curr_header = slide.header
      if slide.containsoptblock then
        curr_header = 'Optional: ' .. curr_header
      end
      if (slide.level == 2 and slide.section) then
        local curr_layout = slide.style
        if not memberp(curr_layout, allowed_slide_layouts) then
          print('WARNING: Probably empty slide! Unknown slide template ' .. curr_layout .. ' in '
            .. os.getenv('PWD'))
          curr_layout = "Bogus-layout"
        end
        o:write('@slidebreak\n')
        o:write('{layout="', curr_layout, '"}\n')
        o:write('# ', curr_header, '\n\n')
        write_adoc_as_md(slide.text, o)
      end
    end
  end
  o:close()
end

make_slides_file(lplan_file, slides_file)
