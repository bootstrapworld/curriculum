#! /usr/bin/env lua

dofile(os.getenv('TOPDIR') .. '/' .. os.getenv('MAKE_DIR') .. 'utils.lua')

function make_titletxt_file(f)
  -- print('doing make_titletxt_file', f)
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
      o:write((L:gsub('^=%s+', ''):gsub(',', '&#x2c;')))
      o:write('\n')
      o:close()
      break
    end
  end
  i:close()
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
  --
  for f in i:lines() do
    if f:find('^ *;') or f:find('^ *//') or f:find('^ *$') then
      goto continue
    end
    local g = f
    if f:find('landscape') or f:find('portrait') then
      o:write(f, '\n')
      g = f:gsub('^ *([^ ]+).*', '%1')
      ol:write(g, '\n')
    elseif (not f:find('%.adoc$')) or (not file_exists_p(f)) then
      o:write(f, '\n')
      ol:write(g, '\n')
    elseif head(f, 5, '^ *%[%.landscape%] *$') or head(f, 60, 'body.*landscape') then
      o:write(f .. ' landscape\n')
      ol:write(g, '\n')
    else
      o:write(f, '\n')
      ol:write(g, '\n')
    end
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
    end
  end
  ls_output:close()
end

make_workbook_page_titletxt_files('pages')
make_workbook_page_titletxt_files('solution-pages')
