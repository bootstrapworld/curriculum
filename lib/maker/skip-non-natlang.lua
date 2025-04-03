#! /usr/bin/env lua

local make_dir = 'lib/maker/'

dofile(make_dir .. 'readers.lua')
dofile(make_dir .. 'jread.lua')

local natlang = os.getenv('NATLANG') or 'en-us'

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
  x = ' ' .. x .. ' '
  x = x:gsub('\n%+', '\n') -- remove leading pluses (from git diff)
  x = x:gsub('\n%[.-\n', '') -- remove block-config lines
  x = x:gsub('\n', ' ') -- converts newlines to spaces for easier matching
  x = x:gsub('\\text{.-}', ' ') -- do not check text inside mathjax textboxes
  x = x:gsub('\\textit{.-}', ' ') -- or italic textboxes
  x = x:gsub('\\textb{.-}', ' ') -- or bold textboxes
  x = x:gsub('\\%w+', ' ') -- remove mathjax tex control sequences
  x = x:gsub('https://.-%[', '[') -- remove raw URLs
  x = x:gsub('<style.->.-</style>', ' ')
  x = x:gsub('<script.->.-</script>', ' ')
  x = x:gsub('@link{.-}', ' ')
  x = x:gsub('@define{.-}', ' ')
  x = x:gsub('@math{.-}', ' ')
  x = x:gsub('@do{.-}', ' ')
  x = x:gsub('@show{.-}', ' ')
  x = x:gsub('@showsoln{.-}', ' ')
  x = x:gsub('@image{.-}', ' ')
  x = x:gsub('@centered%-image{.-}', ' ')
  x = x:gsub('@design%-recipe%-exercise{.-}', ' ')
  x = x:gsub('@slidebreak{.-}', ' ')
  x = x:gsub('@add%-to%-lang{.-}', ' ')
  x = x:gsub('@objective{.-}', ' ')
  x = x:gsub('@ifproglang{.-}', ' ')
  x = x:gsub('@lesson%-prereqs{.-}', ' ')
  x = x:gsub('@[hv]space{.-}', ' ')
  x = x:gsub('@handout{.-[,}]', ' ')
  x = x:gsub('@printable%-exercise{.-[,}]', ' ')
  x = x:gsub('@opt%-printable%-exercise{.-[,}]', ' ')
  x = x:gsub('@online%-exercise{.-[,}]', ' ')
  x = x:gsub('@opt%-online%-exercise{.-[,}]', ' ')
  x = x:gsub('@starter%-file{.-[,}]', ' ')
  x = x:gsub('@opt%-starter%-file{.-[,}]', ' ')
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
  x = x:gsub('“', "") -- left double quote
  x = x:gsub('”', "") -- right double quote
  x = x:gsub("[^%w']+", ' ') -- remove anything that isn't alphanum or single quote
  x = x:gsub('%dst ', ' ') -- ordinals
  x = x:gsub('%dnd ', ' ')
  x = x:gsub('%dth ', ' ')
  x = x:gsub('[%d]+', ' ') -- remove digits
  x = x:gsub("(%w)' ", '%1 ') -- remove ' at word end
  x = x:gsub("(%w)'s ", '%1 ') -- remove 's
  --
  for _,wordlist in ipairs({added_words, ignored_words}) do
    for _,w in ipairs(wordlist) do
      x = x:gsub('%s' .. w .. '%s', ' ')
      -- also check if its other-title-cased form is in the text
      local wT = false
      local w1 = w:sub(1,1)
      if w1:match('%l') then
        wC = w1:upper() .. w:sub(2)
      elseif w1:match('%u') then
        wC = w1:lower() .. w:sub(2)
      end
      if wC then
        x = x:gsub('%s' .. wC .. '%s', ' ')
      end
    end
  end
  --
  return x
end

-- read from stdin, weed out fluff, and write to stdout

io.write(skip_non_natlang(io.read('*a')))
