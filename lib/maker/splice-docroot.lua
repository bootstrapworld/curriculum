#! /usr/bin/env lua

-- Splices the site chrome (header/nav/footer) into the static docroot
-- .shtml pages (Glossary, Contracts, etc.), which -- unlike every other
-- page in the build -- aren't generated from .adoc, so do-postproc.lua
-- never sees them. Those pages carry a bare %PROLOGUE% / %EPILOGUE%
-- placeholder in place of the chrome; this fills them in from the same
-- lib/wp-adaptors/{prologue,epilogue}.txt do-postproc.lua uses for every
-- other page, so there's exactly one copy of that HTML to maintain.
--
-- Reads straight from the source templates in shared/langs/.../docroot/
-- (which always still have the placeholder -- they're never mutated) and
-- writes distribution/'s copy fresh every run, rather than trying to
-- detect whether distribution/'s copy still needs it. There are only a
-- handful of these pages, each a few hundred lines, so redoing all of
-- them every build is cheap; it also means a prologue.txt/epilogue.txt-only
-- change (the docroot template itself untouched) still always propagates,
-- with no staleness bookkeeping to get out of sync.

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')

local topdir  = os.getenv'TOPDIR'
local natlang = os.getenv'NATLANG'

local wp_prologue = read_file_string(topdir .. '/lib/wp-adaptors/prologue.txt')
local wp_epilogue = read_file_string(topdir .. '/lib/wp-adaptors/epilogue.txt')
local wp_epilogue_expanded = wp_epilogue:gsub(
  'SEMESTER_YEAR', os.getenv'SEMESTER' .. ' ' .. os.getenv'YEAR')
local wp_prologue_escaped = wp_prologue:gsub('%%', '%%%%')
local wp_epilogue_escaped = wp_epilogue_expanded:gsub('%%', '%%%%')

-- basename -> source path; a natlang-specific template overrides en-us's,
-- matching the order the two cp -upr calls in Makefile.phase1 run in.
local docroot_dirs = { topdir .. '/shared/langs/en-us/docroot' }
if natlang ~= 'en-us' then
  table.insert(docroot_dirs, topdir .. '/shared/langs/' .. natlang .. '/docroot')
end

local templates = {}
for _, dir in ipairs(docroot_dirs) do
  for _, f in ipairs(shell_output('ls ' .. dir .. '/*.shtml 2>/dev/null')) do
    local x = read_file_string(f)
    if x:find('%PROLOGUE%', 1, true) or x:find('%EPILOGUE%', 1, true) then
      templates[f:gsub('.*/', '')] = f
    end
  end
end

local dist_dir = topdir .. '/distribution/' .. natlang
for base, src in pairs(templates) do
  local x = read_file_string(src)
  x = x:gsub('%%PROLOGUE%%', wp_prologue_escaped)
  x = x:gsub('%%EPILOGUE%%', wp_epilogue_escaped)
  local o = io.open(dist_dir .. '/' .. base, 'w')
  o:write(x)
  o:close()
end
