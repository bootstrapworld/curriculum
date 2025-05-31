
-- requires utils.lua

function write_adoc_as_md(text, o)
  local lines = string_split(text, '\n')
  for _,l1 in ipairs(lines) do
    -- escape leading # so it doesn't become md comment
    l1 = l1:gsub('^(%s+)#', '%1\\#')
    -- four hyphens becomes four backticks
    l1 = l1:gsub('^%-%-%-%-$', '````')
    -- __stuff__ becomes _stuff_
    l1 = l1:gsub('__(.-)__', '_%1_')
    -- leading unicode_bullet<space> becomes md item
    l1 = l1:gsub('^%s*•%s',        '- ')
    -- ^ ** becomes md subitem
    l1 = l1:gsub('^%s*%*%*%s',     '  - ')
    -- ^ *** becomes md subsubitem
    l1 = l1:gsub('^%s*%*%*%*%s',   '    - ')
    -- ^ **** becomes md subsubsubitem
    l1 = l1:gsub('^%s*%*%*%*%*%s', '      - ')
    -- adoc-style autonumbered item ^. becomes md-style autonumbered item
    l1 = l1:gsub('^%.%s', '1. ')
    -- **stuff** becomes *stuff*
    l1 = l1:gsub('%*%*(.-)%*%*', '*%1*')
    -- *stuffwnospace* becomes __stuffwnospace__
    l1 = l1:gsub('%*([^* ].-%S)%*', '__%1__')
    -- *onenonspace* becomes __onenonspace__
    l1 = l1:gsub('%*(%S)%*', '__%1__')
    -- snip trailing space
    l1 = l1:gsub(' %+$', '') -- would <br> work here?
    -- snip trailing +
    l1 = l1:gsub('^%+$', '') -- ditto
    -- resolve variables
    l1 = l1:gsub('{two%-colons}', '::')
    l1 = l1:gsub('{empty}', '')
    l1 = l1:gsub('{plus}', '+')
    o:write(l1, '\n')
  end
end
