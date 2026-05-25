#! /usr/bin/env lua
-- Usage: collect-stale-adocs.lua <setup-file> < <adoc-list>
-- Reads .adoc paths (whitespace-separated) from stdin,
-- and appends those whose .asc is missing or older as quoted Lua
-- list entries (e.g. `"path/to/foo.adoc",`) to <setup-file>.
--
-- Replaces the per-file `$(call asc-file,$1): $1; @echo "$<", >> SETUP`
-- pattern-rule generators in Makefile.phase2 with a single batched call.

dofile(os.getenv'TOPDIR' .. '/' .. os.getenv'MAKE_DIR' .. 'utils.lua')

local setup_file = arg[1]
if not setup_file then
  io.stderr:write('usage: collect-stale-adocs.lua <setup-file>\n')
  os.exit(1)
end

local adocs = {}
for f in (io.stdin:read('*all') or ''):gmatch('%S+') do
  table.insert(adocs, f)
end

local out = io.open(setup_file, 'a')
for _, adoc in ipairs(filter_stale(adocs)) do
  out:write('"', adoc, '",\n')
end
out:close()
