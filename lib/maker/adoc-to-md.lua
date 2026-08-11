
-- requires utils.lua

function write_adoc_as_md(text, o)
  local lines = string_split(text, '\n')
  local inside_code_p = false
  for _,l1 in ipairs(lines) do
    -- a line of exactly 4 hyphens is the code-fence delimiter; toggle
    -- code-block state on it (checked against the untouched line, before
    -- any of the substitutions below can alter it)
    if l1:match('^%-%-%-%-$') then
      inside_code_p = not inside_code_p
    end
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
    -- "--" becomes an em dash, mirroring Asciidoctor's automatic replacement
    -- (both "word -- word" and "word--word" forms). Skip this inside code
    -- blocks, where dashes should stay verbatim, and never touch runs of 3+
    -- hyphens (thematic breaks, or the code-fence marker handled above).
    if not inside_code_p then
      l1 = l1:gsub('%-%-+', function(run)
        return (#run == 2) and '—' or run
      end)
    end
    o:write(l1, '\n')
  end
end
