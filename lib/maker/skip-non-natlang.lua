#! /usr/bin/env lua

local make_dir = 'lib/maker/'

dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

local natlang = os.getenv('NATLANG')

local added_words = {}
local ignored_words = {}

if natlang == 'en-us' then

  -- In Sublime settings, the list of added_words and ignored_words
  -- are used to mean different things. In this context, however, they
  -- mean the same thing (i.e., words to ignore). To make it easy to
  -- copy/paste back and forth between this file and sublime, they are
  -- kept separate here

  added_words = read_json_file('shared/langs/en-us/hunspell/added-words.json')
  ignored_words = read_json_file('shared/langs/en-us/hunspell/ignored-words.json')
end

local function skip_non_natlang(x)
  x = x:gsub('\n%+', '\n') -- remove leading pluses (from git diff)
  x = x:gsub('\n%[.-\n', '') -- remove block-config lines
  x = x:gsub('\n', ' ') -- converts newlines to spaces for easier matching
  x = x:gsub('<style.->.-</style>', ' ')
  x = x:gsub('<script.->.-</script>', ' ')
  x = x:gsub('@link{.-}', ' ')
  x = x:gsub('@math{.-}', ' ')
  x = x:gsub('@show{.-}', ' ')
  x = x:gsub('@showsoln{.-}', ' ')
  x = x:gsub('@handout{.-[,}]', ' ')
  x = x:gsub('@printable%-exercise{.-[,}]', ' ')
  x = x:gsub('@opt%-printable%-exercise{.-[,}]', ' ')
  x = x:gsub('@lesson%-link{.-[,}]', ' ')
  x = x:gsub('@dist%-link{.-[,}]', ' ')
  x = x:gsub('@link{.-[,}]', ' ')
  x = x:gsub('@[%w%-]+', ' ')
  x = x:gsub('```.-```', ' ') --  code displays
  x = x:gsub('``.-``', ' ') -- ``in-text code``
  x = x:gsub('`.-`', ' ') -- `in-text code`
  x = x:gsub('~%S+', ' ') -- roughnums
  x = x:gsub('‘', "'") -- left single quote
  x = x:gsub('’', "'") -- right single quote
  x = x:gsub('“', "'") -- left double quote
  x = x:gsub('”', "'") -- right double quote
  x = x:gsub("[^%w']+", ' ') -- remove anything that isn't alphanum or single quote
  x = x:gsub('[%d]+', ' ') -- remove digits

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
