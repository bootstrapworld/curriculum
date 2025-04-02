#! /usr/bin/env lua

local make_dir = 'lib/maker/'

dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

local natlang = os.getenv('NATLANG')

local added_words = {}
local ignored_words = {}

if natlang == 'en-us' then
  added_words = read_json_file('shared/langs/en-us/hunspell/added-words.json')
  ignored_words = read_json_file('shared/langs/en-us/hunspell/ignored-words.json')
end

local function skip_non_natlang(x)
  x = x:gsub('\n%+', ' ') -- remove leading pluses (from git diff)
  x = x:gsub('\n', ' ') -- converts newlines to spaces for easier matching
  x = x:gsub('<style>.-</style>', '')
  x = x:gsub('~%S+', '') -- remove roughnums
  x = x:gsub('@link{.-}', '')
  x = x:gsub('@math{.-}', '')
  x = x:gsub('@show{.-}', '')
  x = x:gsub('@showsoln{.-}', '')
  x = x:gsub('```.-```', '') -- remove code displays
  x = x:gsub('``.-``', '') -- remove in-text code
  x = x:gsub('`.-`', '') -- ditto
  for _,w in ipairs(added_words) do
    x = x:gsub(w, '')
  end
  for _,w in ipairs(ignored_words) do
    x = x:gsub(w, '')
  end
  return x
end

-- read from stdin, weed out fluff, and write to stdout

io.write(skip_non_natlang(io.read('*a')))
