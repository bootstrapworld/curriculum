#! /usr/bin/env lua

-- last modified 2023-03-03

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

dofile(os.getenv('MAKE_DIR') .. 'readers.lua')

local natlang = os.getenv 'NATLANG'

function emit_empty_string()
  return ''
end

read_group = make_read_group(emit_empty_string, function()
  return 'Collecting exercises'
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

function scan_exercise_directives(i, proglang, workbook_pages, lesson)
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
                print('WARNING: Using workbook page ' .. f .. ' in ' .. lesson .. ' as optional exercise')
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
      elseif directive == 'scrub' then
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
  local i = io.open(f)
  return head(f, 5, '^ *%[%.landscape%] *$')
end

do
  local f = os.getenv 'EXERCISE_COLLECTOR_INPUT'
  local lessons_w_proglang = dofile(f)
  for _,lwp in ipairs(lessons_w_proglang) do
    local lesson = lwp[1]
    -- print('scanning ' .. lesson)
    local proglang = lwp[2]
    local lesson_dir = 'distribution/' .. natlang .. '/lessons/' .. lesson .. '/'
    local lesson_cache = lesson_dir .. 'pages/.cached/'
    local workbook_page_list_file = lesson_cache .. '.workbook-pages-ls.txt.kp'
    local opt_exercise_list_file = lesson_cache .. '.exercise-pages-ls.txt.kp'
    local opt_exercise_asp_list_file = lesson_cache .. '.exercise-pages.lua'
    local workbook_exercise_list_file = lesson_cache .. '.workbook-exercise-pages-ls.txt.kp'
    local handout_exercise_list_file = lesson_cache .. '.handout-exercise-pages-ls.txt.kp'
    local lesson_plan_file = lesson_dir .. 'index.adoc'
    --
    local workbook_pages = {}
    if file_exists_p(workbook_page_list_file) then
      local i = io.open(workbook_page_list_file)
      for line in i:lines() do
        table.insert(workbook_pages, line)
      end
      i:close()
    end
    --
    local i = io.open_buffered(lesson_plan_file)
    local opt_exercise_files, workbook_exercise_files, handout_exercise_files = scan_exercise_directives(i, proglang, workbook_pages, lesson)
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
      add_aspect(lesson_dir .. 'pages/' .. x, lesson, o)
      o:write(' },\n')
    end
    o:write('}\n')
  end
end
