#! /usr/bin/env lua

dofile(os.getenv('TOPDIR') .. '/' .. os.getenv('MAKE_DIR') .. 'utils.lua')

function make_titletxt_file(f)
  -- print('doing make_titletxt_file', f, os.getenv'PWD')
  if not file_exists_p(f) then return end
  local dir = ''
  local base = f
  if f:find('/') then
    dir = f:gsub('(.*/).*', '%1')
    base = f:gsub('.*/(.*)', '%1')
  end
  base = base:gsub('%..*', '')
  local titletxt_file = dir .. '.cached/.' .. base .. '.titletxt'
  local i = io.open(f)
  for L in i:lines() do
    if L:find('^=%s') then
      local o = io.open(titletxt_file, 'w+')
      L = L:gsub('^=%s+', ''):gsub(',', '&#x2c;'):gsub('{nbsp}', ' ')
      o:write(L, '\n')
      o:close()
      break
    end
  end
  i:close()
end

function make_titletxt_pdf_file(f)
  -- print('doing make_titletxt_pdf_file', f)
  local dir = ''
  local base = f
  if f:find('/') then
    dir = f:gsub('(.*/).*', '%1')
    base = f:gsub('.*/(.*)', '%1')
  end
  base = base:gsub('%..*', '')
  local titletxt_file = dir .. '.cached/.' .. base .. '.titletxt'
  local title = base:gsub('%-', ' ')
  title = string_titlecase(title)
  local o = io.open(titletxt_file, 'w+')
  o:write(title)
  o:write('\n')
  o:close()
end

index_file = 'index.adoc'

make_titletxt_file(index_file)

workbook_pages_og_file = 'pages/workbook-pages.txt'

workbook_pages_file = 'pages/.cached/.workbook-pages.txt.kp'
workbook_pages_ls_file = 'pages/.cached/.workbook-pages-ls.txt.kp'
notes_pages_ls_file = 'pages/.cached/.workbook-notes-pages-ls.txt.kp'

if not file_exists_p(workbook_pages_og_file) then
  touch(workbook_pages_og_file)
end

os.remove(workbook_pages_file)
os.remove(workbook_pages_ls_file)
os.remove(notes_pages_ls_file)

do
  local i = io.open(workbook_pages_og_file)
  local o = io.open(workbook_pages_file, 'w+')
  local ol = io.open(workbook_pages_ls_file, 'w+')
  local on = io.open(notes_pages_ls_file, 'w+')
  local pwd = os.getenv('PWD')
  --
  for f in i:lines() do
    if f:find('^ *;') or f:find('^ *//') or f:find('^ *$') then
      goto continue
    end
    f = f:gsub('%s+$', '') -- remove any non-Unix \r
    local g = f
    if f:find('landscape') or f:find('portrait') then
      g = f:gsub('^ *([^ ]+).*', '%1')
    end
    local actual_g = pwd .. '/pages/' .. g
    if not g:find('%.adoc$') then
      ;
    elseif not file_exists_p(actual_g) then
      print('WARNING: ' .. pwd .. '/' .. workbook_pages_og_file .. ' mentions non-existent file ' .. f)
    elseif f == g and (head(actual_g, 5, '^ *%[%.landscape%] *$') or head(actual_g, 60, 'body.*landscape')) then
      f = f .. ' landscape'
    end
    o:write(f, '\n')
    ol:write(g, '\n')
    if g:find('^notes%-') then
      on:write(g, '\n')
    end
    ::continue::
  end
  --
  i:close()
  o:close()
  ol:close()
  on:close()
end

function make_workbook_page_titletxt_files(dir)
  local ls_output = io.popen('ls ' .. dir)
  for f in ls_output:lines() do
    if f:find('%.adoc$') then
      make_titletxt_file(dir .. '/' .. f)
    elseif f:find('%.pdf$') then
      -- print('found a pdf file', f)
      local f_adoc = dir .. '/' .. f:gsub('(.*)%.pdf', '%1.adoc')
      -- print('f_adoc is', f_adoc)
      if not file_exists_p(f_adoc) then
        -- print('f_adoc', f, 'doesnt exist')
        make_titletxt_pdf_file(dir .. '/' .. f)
      end
    end
  end
  ls_output:close()
end

make_workbook_page_titletxt_files('pages')
make_workbook_page_titletxt_files('solution-pages')
