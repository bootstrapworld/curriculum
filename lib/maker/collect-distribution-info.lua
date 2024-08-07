#! /usr/bin/env lua

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')

local natlang = os.getenv 'NATLANG'

local select_courses = false

do
  local course_ev = os.getenv 'COURSE'
  if course_ev and course_ev ~= '' then
    select_courses = string_split(course_ev, ',')
  end
end

local courses_dir = 'distribution/' .. natlang .. '/courses'
local lessons_dir = 'distribution/' .. natlang .. '/lessons'

function record_course_lessons(course, lo)
  local course_lessons_file = courses_dir .. '/' .. course .. '/.cached/.workbook-lessons.txt.kp'
  if not file_exists_p(course_lessons_file) then
    return
  end
  local i = io.open(course_lessons_file, 'r')
  for L in i:lines() do
    lo:write(L, '\n')
  end
end

-- collecting courses

do
  local o = io.open(os.getenv 'COURSES_LIST_FILE', 'w+')
  local lo = io.open(os.getenv 'RELEVANT_LESSONS_LIST_FILE', 'w+')
  o:write('return {\n')

  if select_courses then
    for _,course in ipairs(select_courses) do
      o:write(' \"' .. string_trim(course) .. '\",\n')
      record_course_lessons(course, lo)
    end

  else
    local ls_output = io.popen('ls ' .. courses_dir)
    for course in ls_output:lines() do
      o:write(' \"' .. course .. '\",\n')
    end
    ls_output:close()
  end

  o:write('}\n')
  o:close()
  lo:close()
end

----------------------------------------------------------------------------

-- subroutine for collecting exercises

dofile(make_dir .. 'readers.lua')

function emit_empty_string()
  return ''
end

local file_being_read = 'none-yet'

read_group = make_read_group(emit_empty_string, function()
  return file_being_read
end)

function read_first_arg(i, directive)
  local c = buf_peek_char(i)
  if c == '{' then
    i:read(1)
    local r = {}
    while true do
      c = i:read(1)
      if not c then break end
      if c == ',' or c == '}' then break end
      table.insert(r, c)
    end
    return table.concat(r)
  else
    return ''
  end
end

function scan_exercise_directives(i, proglang, workbook_pages, lesson_dir)
  local opt_exercise_files = {}
  local workbook_exercise_files = {}
  local handout_exercise_files = {}
  while true do
    local c = i:read(1)
    if not c then break end
    if c == '@' then
      local directive = read_word(i)
      if memberp(directive, { 'opt-printable-exercise', 'printable-exercise', 'handout' }) then
        local page = read_first_arg(i, directive)
        local compts = string_split(page, '/')
        local num_compts = #compts
        if 1 <= num_compts and num_compts <= 2 then
          local f = compts[num_compts]
          if directive == 'opt-printable-exercise' then
            if not memberp(f, opt_exercise_files) then
              if memberp(f, workbook_pages) then
                print('WARNING: Using workbook page ' .. f .. ' in ' .. lesson_dir .. ' as optional exercise')
              else
                table.insert(opt_exercise_files, f)
              end
            end
          elseif directive == 'printable-exercise' then
            if not memberp(f, workbook_exercise_files) then
              table.insert(workbook_exercise_files, f)
            end
          elseif directive == 'handout' then
            if not memberp(f, handout_exercise_files) then
              table.insert(handout_exercise_files, f)
            end
          end
        end
      elseif directive == 'comment' or directive == 'scrub' then
        read_group(i, directive)
      elseif directive == 'ifproglang' then
        local proglang1 = read_group(i, directive)
        if proglang1 ~= proglang then
          local xx = read_group(i, directive)
          -- print('tossing ' .. xx)
        end
      end
    end
  end
  return opt_exercise_files, workbook_exercise_files, handout_exercise_files
end

function add_aspect(f, o)
  if not file_exists_p(f) then return end
  if head(f, 5, '^ *%[%.landscape%] *$') then
    o:write(', "landscape"')
  end
end

function collect_exercise_info(lesson_dir, proglang)
  local lesson_plan_file = lesson_dir .. '/index.adoc'
  --
  if not file_exists_p(lesson_plan_file) then
    return
  end
  --
  local lesson_cache = lesson_dir .. '/pages/.cached/'
  local workbook_page_list_file = lesson_cache .. '.workbook-pages-ls.txt.kp'
  local opt_exercise_list_file = lesson_cache .. '.opt-exercise-pages-ls.txt.kp'
  local opt_exercise_asp_list_file = lesson_cache .. '.opt-exercise-pages.lua'
  local workbook_exercise_list_file = lesson_cache .. '.workbook-exercise-pages-ls.txt.kp'
  local handout_exercise_list_file = lesson_cache .. '.handout-exercise-pages-ls.txt.kp'
  local handout_exercise_asp_list_file = lesson_cache .. '.handout-exercise-pages.lua'
  --
  local workbook_pages = {}
  if file_exists_p(workbook_page_list_file) then
    workbook_pages = read_file_lines(workbook_page_list_file)
  end
  --
  local i = io.open_buffered(lesson_plan_file)
  file_being_read = lesson_plan_file
  local opt_exercise_files, workbook_exercise_files, handout_exercise_files = scan_exercise_directives(i, proglang, workbook_pages, lesson_dir)
  i:close()
  --
  local o = io.open(opt_exercise_list_file, 'w+')
  for _,f in ipairs(opt_exercise_files) do
    o:write(f, '\n')
  end
  o:close()
  --
  o = io.open(workbook_exercise_list_file, 'w+')
  for _,f in ipairs(workbook_exercise_files) do
    o:write(f, '\n')
  end
  o:close()
  --
  o = io.open(handout_exercise_list_file, 'w+')
  for _,f in ipairs(handout_exercise_files) do
    o:write(f, '\n')
  end
  o:close()
  --
  i = io.open(opt_exercise_list_file)
  o = io.open(opt_exercise_asp_list_file, 'w+')
  o:write('return {\n')
  for x in i:lines() do
    o:write('  { "', x, '"')
    add_aspect(lesson_dir .. '/pages/' .. x, o)
    o:write(' },\n')
  end
  o:write('}\n')
  --
  i = io.open(handout_exercise_list_file)
  o = io.open(handout_exercise_asp_list_file, 'w+')
  o:write('return {\n')
  for x in i:lines() do
    o:write('  { "', x, '"')
    add_aspect(lesson_dir .. '/pages/' .. x, o)
    o:write(' },\n')
  end
  o:write('}\n')
  --
end

----------------------------------------------------------------------------

-- collecting lessons

do
  -- if select_courses then
  --   goto exit_do_block
  -- end
  local ls_output = io.popen('ls ' .. lessons_dir)
  local o = io.open(os.getenv 'LESSONS_LIST_FILE', 'w+')
  for lesson in ls_output:lines() do
    local lesson_dir = lessons_dir .. '/' .. lesson
    if file_exists_p(lesson_dir .. '/.proglang-ignore') then
      goto continue
    end
    local pl = 'pyret'
    if not file_exists_p(lesson_dir .. '/.cached/.proglang-pyret') then
      local pl2, found = lesson:gsub('.*%-(%a-)$', '%1')
      if found > 0 then
        if file_exists_p(lesson_dir .. '/.cached/.proglang-' .. pl2) then
          pl = pl2
        end
      end
    end
    collect_exercise_info(lesson_dir, pl)
    o:write(lesson, '\n')
    ::continue::
  end
  ls_output:close()
  o:close()
  -- ::exit_do_block::
end

