#! /usr/bin/env lua

-- last modified 2023-03-08

dofile(os.getenv('TOPDIR') .. '/' .. os.getenv('MAKE_DIR') .. 'utils.lua')

index_file = 'index.adoc'
index_title_file = '.cached/.index.titletxt'

workbook_pages_og_file = 'pages/workbook-pages.txt'

workbook_pages_file = 'pages/.cached/.workbook-pages.txt.kp'
workbook_pages_ls_file = 'pages/.cached/.workbook-pages-ls.txt.kp'
notes_pages_ls_file = 'pages/.cached/.notes-pages-ls.txt.kp'

if not file_exists_p(workbook_pages_og_file) then
  touch(workbook_pages_og_file)
end

os.remove(index_title_file)

do
  if not file_exists_p(index_file) then return end
  --
  local i = io.open(index_file)
  for f in i:lines() do
    if f:find('^=%s') then
      local o = io.open(index_title_file, 'w+')
      o:write(f:gsub('^=%s+', ''))
      o:write('\n')
      o:close()
      break
    end
  end
  i:close()
end

os.remove(workbook_pages_file)
os.remove(workbook_pages_ls_file)
os.remove(notes_pages_ls_file)

do
  local i = io.open(workbook_pages_og_file)
  local o = io.open(workbook_pages_file, 'w+')
  local ol = io.open(workbook_pages_ls_file, 'w+')
  --
  for f in i:lines() do
    local g = f
    if f:find('^ *;') or f:find('^ *//') or f:find('^ *$') then --nothing
    elseif f:find('landscape') or f:find('portrait') then
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
  end
  --
  i:close()
  o:close()
  ol:close()
end
