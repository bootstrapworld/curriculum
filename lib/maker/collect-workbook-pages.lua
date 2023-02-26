#! /usr/bin/env lua

dofile(os.getenv('TOPDIR') .. '/' .. os.getenv('MAKE_DIR') .. 'utils.lua')

function touch(f)
  if not file_exists_p(f) then
    local o = io.open(f, 'w')
    o:close()
  end
end


workbook_pages_repo_file = 'pages/workbook-pages.txt'

workbook_pages_file = 'pages/.cached/.workbook-pages.txt.kp'
workbook_pages_ls_file = 'pages/.cached/.workbook-pages-ls.txt.kp'
notes_pages_ls_file = 'pages/.cached/.notes-pages-ls.txt.kp'

if not file_exists_p(workbook_pages_repo_file) then
  touch(workbook_pages_repo_file)
end

os.remove(workbook_pages_file)
os.remove(workbook_pages_ls_file)
os.remove(notes_pages_ls_file)

if not file_exists_p(workbook_pages_ls_file) then
  touch(workbook_pages_ls_file)
end

do
  local i = io.open(workbook_pages_repo_file)
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
