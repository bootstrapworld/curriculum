#! /usr/bin/env lua

local make_dir = 'lib/maker/'

dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

-- reads from the stdin,
-- removes leading pluses,
-- removes stuff enclosed in backticks,
-- converts newlines to spaces,
-- writes to stdout

local natlang = os.getenv('NATLANG')

local added_words = {}
local ignored_words = {}

if natlang == 'en-us' then
  added_words = read_json_file('shared/langs/en-us/hunspell/added-words.json')
  ignored_words = read_json_file('shared/langs/en-us/hunspell/ignored-words.json')
end

local function skip_non_natlang(x)
  x = x:gsub('\n%+', ' ')
  x = x:gsub('\n', ' ')
  x = x:gsub('```.-```', '')
  x = x:gsub('``.-``', '')
  x = x:gsub('`.-`', '')
  for _,w in ipairs(added_words) do
    x = x:gsub(w, '')
  end
  for _,w in ipairs(ignored_words) do
    x = x:gsub(w, '')
  end
  return x
end

io.write(skip_non_natlang(io.read('*a')))
