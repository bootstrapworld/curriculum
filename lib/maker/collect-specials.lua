#! /usr/bin/env lua

-- For each lesson, scans its .cached/.*.primtxt files and writes the
-- deduplicated, sorted union to .cached/.index-primitives.txt.kp.
-- Also warns about starter files used in workbook pages but not in
-- the lesson plan.
--
-- This script does the same per-lesson work the original did, but skips
-- lessons whose inputs haven't changed since the last build. With ~200
-- lessons and only a few typically changing per build, this drops the
-- step from ~2s to ~0.2s on incremental builds.

dofile(os.getenv'MAKE_DIR' .. 'utils.lua')

local lessons_dir = 'distribution/' .. os.getenv('NATLANG') .. '/lessons/'
local lessons = read_file_lines(os.getenv 'LESSONS_LIST_FILE')

-- Discover all .primtxt files across all lessons in a single `find`,
-- replacing N per-lesson `ls` shell-outs. (-name '.*.primtxt' is required
-- because dotfiles aren't matched by '*.primtxt'.)
local primtxts_by_lesson = {}
for _, lesson in ipairs(lessons) do
  primtxts_by_lesson[lesson] = {}
end

do
  local prefix_len = #lessons_dir
  local h = io.popen('find ' .. lessons_dir .. ' -name ".*.primtxt" 2>/dev/null')
  for f in h:lines() do
    -- f is like: distribution/<NATLANG>/lessons/<lesson>/.cached/.<name>.primtxt
    -- Use plain prefix comparison: NATLANG may contain '-' (e.g. "en-us"),
    -- which is a Lua-pattern quantifier and would break string.match.
    if f:sub(1, prefix_len) == lessons_dir then
      local lesson = f:sub(prefix_len + 1):match('^([^/]+)/')
      if lesson and primtxts_by_lesson[lesson] then
        table.insert(primtxts_by_lesson[lesson], f)
      end
    end
  end
  h:close()
end

-- Gather every path we'll need to stat: inputs, outputs, and the cache
-- directories themselves. Directory mtimes catch add/remove of .primtxt
-- files (which file mtimes alone can't detect).
local lesson_info = {}
local all_paths = {}
for _, lesson in ipairs(lessons) do
  local cache = lessons_dir .. lesson .. '/.cached/'
  local output = cache .. '.index-primitives.txt.kp'
  local sf_idx  = cache .. '.index.starterfiles'
  local sf_page = cache .. '.page.starterfiles'
  local inputs = { sf_idx, sf_page }
  for _, f in ipairs(primtxts_by_lesson[lesson]) do
    table.insert(inputs, f)
  end
  lesson_info[lesson] = {
    cache  = cache,
    output = output,
    inputs = inputs,
    sf_idx  = sf_idx,
    sf_page = sf_page,
  }
  table.insert(all_paths, cache)
  table.insert(all_paths, output)
  for _, p in ipairs(inputs) do table.insert(all_paths, p) end
end

local mtimes = batch_mtimes(all_paths)

-- Returns true if this lesson's output is up-to-date wrt all its inputs
-- and its cache directory.
local function up_to_date(info)
  local out_t = mtimes[info.output]
  if not out_t then return false end
  local cache_t = mtimes[info.cache]
  if cache_t and cache_t > out_t then return false end  -- catches add/remove
  for _, inp in ipairs(info.inputs) do
    local inp_t = mtimes[inp]
    if inp_t and inp_t > out_t then return false end
  end
  return true
end

for _, lesson in ipairs(lessons) do
  local info = lesson_info[lesson]
  if not file_exists_p(info.cache) then goto continue end
  if up_to_date(info) then goto continue end
  --
  -- Build the deduplicated, sorted primitives list.
  local prims = {}
  local seen = {}
  for _, prim_file in ipairs(primtxts_by_lesson[lesson]) do
    local i = io.open(prim_file)
    if i then
      for prim in i:lines() do
        if not seen[prim] then
          seen[prim] = true
          table.insert(prims, prim)
        end
      end
      i:close()
    end
  end
  table.sort(prims)
  --
  local o = io.open(info.output, 'w+')
  for _, prim in ipairs(prims) do
    o:write(prim, '\n')
  end
  o:close()
  --
  -- Warn about starter files used in workbook pages but not in lesson plan.
  seen = {}
  seen['editor'] = true
  local lesson_plan_sf_i = io.open(info.sf_idx)
  if lesson_plan_sf_i then
    for sf in lesson_plan_sf_i:lines() do
      seen[sf] = true
    end
    lesson_plan_sf_i:close()
  end
  local lesson_wkbk_pages_sf_i = io.open(info.sf_page)
  if lesson_wkbk_pages_sf_i then
    for sf in lesson_wkbk_pages_sf_i:lines() do
      if not seen[sf] then
        print('WARNING: @starter-file{' .. sf .. '} used in ' .. lesson .. '\'s workbook page but not in lesson plan')
        seen[sf] = true -- warn only once per starter file
      end
    end
    lesson_wkbk_pages_sf_i:close()
  end
  --
  ::continue::
end
