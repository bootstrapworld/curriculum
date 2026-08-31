#! /usr/bin/env lua

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')

local pathwayindependent_batchf =  os.getenv'ADOC_POSTPROC_PATHWAYINDEPENDENT_INPUT'
local workbookpage_batchf =  os.getenv'ADOC_POSTPROC_WORKBOOKPAGE_INPUT'
local lessonplan_batchf =  os.getenv'ADOC_POSTPROC_LESSONPLAN_INPUT'
local pathwaynarrative_batchf =  os.getenv'ADOC_POSTPROC_PATHWAYNARRATIVE_INPUT'
local pathwayresource_batchf =  os.getenv'ADOC_POSTPROC_PATHWAYRESOURCE_INPUT'

local gtm_file = os.getenv'TOPDIR' .. '/lib/gtm.txt'
local gtm_noscript_file = os.getenv'TOPDIR' .. '/lib/gtm-noscript.txt'

local wp_prologue_file = os.getenv'TOPDIR' .. '/lib/wp-adaptors/prologue.txt'
local wp_epilogue_file = os.getenv'TOPDIR' .. '/lib/wp-adaptors/epilogue.txt'

-- Read these files once, not thousands of times
local wp_prologue    = read_file_string(wp_prologue_file)
local wp_epilogue    = read_file_string(wp_epilogue_file)
local wp_epilogue_expanded = wp_epilogue:gsub(
  'SEMESTER_YEAR', os.getenv'SEMESTER' .. ' ' .. os.getenv'YEAR')
local gtm_content    = read_file_string(gtm_file)
local gtm_noscript_content = read_file_string(gtm_noscript_file)

local function calculate_dist_root_dir(fhtml_cached)
  local f = fhtml_cached:gsub('^%./', '')
  f = f:gsub('/%./', '/')
  f = f:gsub('[^/]', '')
  f = f:gsub('^/', '')
  f = f:gsub('/', '../')
  f = f:gsub('^%.%./%.%./', '')
  return f
end

local function get_proglang(fhtml_cached)
  local f = false
  if fhtml_cached:match('/courses/') then
    f = fhtml_cached:gsub('(distribution/[^/]+/courses/[^/]+)/.*', '%1/.cached/.record-proglang')
  elseif fhtml_cached:match('/lessons/') then
    f = fhtml_cached:gsub('(distribution/[^/]+/lessons/[^/]+)/.*', '%1/.cached/.record-proglang')
  else
    -- noop
  end
  if f and file_exists_p(f) then return first_line(f)
  else return 'pyret'
  end
end

-- Narrative/resource pages live under distribution/<lang>/courses/<pathway>/...;
-- pull the <pathway> segment out of the path. Returns nil for lesson plans and
-- other pages that aren't tied to a single pathway.
local function get_pathway(fhtml_cached)
  return fhtml_cached:match('/courses/([^/]+)/')
end

local function postproc(fhtml_cached, tipe)
  -- pre-compute tipe flags once
  local is_shtml       = tipe == 'lessonplan' or tipe == 'pathwaynarrative' or tipe == 'pathwayresource'
  local adds_analytics = tipe == 'lessonplan' or tipe == 'pathwaynarrative'
  local strips_title   = tipe == 'lessonplan' or tipe == 'pathwayresource'
  local adds_links     = tipe == 'lessonplan' or tipe == 'workbookpage'

  -- declare our globals
  local read_end_sidebar_p = false
  local num_of_lines_past_end_sidebar = 0

  local page_title = ''
  -- print('doing postproc', fhtml_cached, tipe)
  if not file_exists_p(fhtml_cached) then return end
  local local_dist_root_dir = calculate_dist_root_dir(fhtml_cached)
  -- print('local_dist_root_dir is', local_dist_root_dir)
  local fdir = fhtml_cached:gsub('/%.cached/[^/]*html$', '')
  -- print('fdir is', fdir)
  local fbase = fhtml_cached:gsub('^.*/%.([^/]*html)$', '%1')
  if is_shtml then
    fbase = fbase:gsub('%.html$', '.shtml')
  end
  -- print('fbase is', fbase)
  local fhtml = fdir .. '/' .. fbase
  -- print('fhtml is', fhtml)
  local code_lang = 'pyret'
  local proglang = get_proglang(fhtml_cached)
  if proglang == 'wescheme' then
    code_lang = 'racket'
  end
  local pre_open  = '<pre><code class="' .. code_lang .. '">'
  local code_open = '<code class="' .. code_lang .. '">'
  local f_mathjax_file = fhtml_cached:gsub('%.html$', '.asc.uses-mathjax')
  local f_codemirror_file = fhtml_cached:gsub('%.html$', '.asc.uses-codemirror')
  --
  local i = io.open(fhtml_cached, 'r')
  local o = io.open(fhtml, 'w')
  --
  local add_analytics_p = false
  local add_bootstrap_lesson_p = false
  local add_mathjax_p = false
  local add_codemirror_p = false
  local add_body_id_p = false
  local add_landscape_p = false
  local add_can_be_longer_p = false
  local add_end_body_id_p = false
  local delete_line_p = false
  local openblock_attribs = false
  local pending_li_p = false
  --
  for x0 in i:lines() do
    local x = x0
    if read_end_sidebar_p then
      if num_of_lines_past_end_sidebar == 3 then
        read_end_sidebar_p = false
      else
        num_of_lines_past_end_sidebar = num_of_lines_past_end_sidebar + 1
        goto continue
      end
    elseif x:find('%%ENDSIDEBARCONTENT%%') then
      read_end_sidebar_p = true
      num_of_lines_past_end_sidebar = 0
      goto continue
    end
    --
    if x:find('^<body') then
      if x:find('landscape') then
        x = x:gsub('landscape', '')
        add_landscape_p = true
      end
      -- An authored [.canBeLongerThanAPage] role lands on <body>; copy it onto
      -- the #body div, where the `div#body.canBeLongerThanAPage` CSS lives. Leave
      -- it on <body> too, since html2pdf.js keys off `body.canBeLongerThanAPage`.
      if x:find('canBeLongerThanAPage') then
        add_can_be_longer_p = true
      end
      --
      add_body_id_p = true
      add_end_body_id_p = true
      --
      if adds_analytics then
        add_analytics_p = true
      end
      --
      --fixme datasheetpage?
      --
    end
    --
    if x:find('</body>') then
      if add_end_body_id_p then
        add_end_body_id_p = false
        x = x:gsub('</body>', '</div>\n%0')
      end
      x = x:gsub('</body>', wp_epilogue_expanded)
    end
    --
    if x:find('^<link.*curriculum%.css') then
      x = x:gsub('^<link.*curriculum%.css', '<link rel="stylesheet" href="' .. local_dist_root_dir .. 'lib/curriculum.css')
      -- Fire the WordPress login-status check as early as possible: a
      -- plain blocking (non-deferred) script, written here rather than
      -- alongside page-render.js et al below, so it runs before those
      -- deferred scripts finish downloading -- some of them are large,
      -- externally-hosted (unpkg.com), and would otherwise queue the
      -- login check behind themselves for no functional reason.
      o:write('<script src="' .. local_dist_root_dir .. 'lib/early-login-check.js"></script>\n')
      add_bootstrap_lesson_p = true
      if file_exists_p(f_codemirror_file) or tipe == 'pathwaynarrative' then
        add_codemirror_p = true
      end
      if file_exists_p(f_mathjax_file) then
        add_mathjax_p = true
      end
    end
    --
    if x:find('%%BEGINOPENBLOCKATTRIBS%%') then
      openblock_attribs = x:gsub('.-%%BEGINOPENBLOCKATTRIBS%%(.*)%%ENDOPENBLOCKATTRIBS%%.*', '%1')
      if openblock_attribs == "" then
        openblock_attribs = false
      end
      goto continue
    end
    --
    if x:find('<pre>', 1, true)    then x = x:gsub('<pre>', pre_open)              end
    if x:find('</pre>', 1, true)   then x = x:gsub('</pre>', '</code></pre>')       end
    if x:find('<code>', 1, true)   then x = x:gsub('<code>', code_open)             end
    if x:find('<p> </p>', 1, true) then x = x:gsub('<p> </p>', '<p></p>')           end
    --
    -- A bare <li> is deferred (not written) until we see what's inside it,
    -- so we know whether it's an @A{} answer -- which gets class="ablockitem"
    -- so self-guided's CSS can hide it -- or anything else. @Q{} is legal
    -- without a matching @A{} (e.g. open discussion questions), so a <li>
    -- can't be assumed to be an answer just because it's the next one after
    -- some earlier @Q{}'s end marker; that assumption is what let the flag
    -- leak forward and hide unrelated, unlucky <li> content downstream.
    if pending_li_p then
      pending_li_p = false
      if x:find('<p>%%BEGINABLOCKITEM%%') then
        o:write('<li class="ablockitem">\n')
      else
        o:write('<li>\n')
      end
    end
    --
    if x:find('<p>%%BEGINQBLOCKITEM%%') then
      x = x:gsub('<p>%%BEGINQBLOCKITEM%%', '<p class="qblock">')
    end
    --
    if x:find('<p>%%BEGINABLOCKITEM%%') then
      x = x:gsub('<p>%%BEGINABLOCKITEM%%', '<p class="ablock">')
    end
    --
    if x:find('%%END[QA]BLOCKITEM%%') then
      x = x:gsub('%%END[QA]BLOCKITEM%%', '')
    end
    --
    if x:find('<li>') then
      pending_li_p = true
      goto continue
    end
    --
    if x:find('actually%-openblock') then
      if x:find('class="exampleblock .-actually%-openblock ') and openblock_attribs then
        x = x:gsub('class=".-"', '%0' .. openblock_attribs)
        openblock_attribs = false
      end
      x = x:gsub('class="exampleblock (.-)actually%-openblock ', 'class="openblock %1')
    end
    --
    if x:find('%%') then
      x = x:gsub('%%CURRICULUMMATHJAXMARKER%%', '$$')
      --
      x = x:gsub('%%CURRICULUMCOMMENTSTART%%', '<!--')
      x = x:gsub('%%CURRICULUMCOMMENTSTOP%%', '-->')
      --
      x = x:gsub('%%CURRICULUMLT%%', '<')
      x = x:gsub('%%CURRICULUMGT%%', '>')
      --
      x = x:gsub('%%CURRICULUM([^%%]*)%%', '<%1')
      x = x:gsub('%%BEGINCURRICULUM([^%%]*)%%', '>')
      x = x:gsub('%%ENDCURRICULUM([^%%]*)%%', '</%1>')
    end
    --
    if x:find('&#') then
      x = x:gsub('&#8656;', '&lt;=')
      x = x:gsub('&#8594;', '-&gt;')
    end
    --
    if x:find('id="preamble"', 1, true) then
      x = x:gsub('^(<div id="preamble)">', '%1_disabled" class="lessonSummary">')
    end
    --
    if x:find('<figure class="image"', 1, true) then
      x = x:gsub('<span class="([^"]+)">(<figure class="image")', '%2 style="text-align: %1"')
    end
    if x:find('</figure></span>', 1, true) then
      x = x:gsub('(</figure>)</span>', '%1')
    end
    --
    if x:find('BOGUSACKNOWLEDGMENTSECTIONHEADER') then
      delete_line_p = true
    end
    --
    if x:find('</head>') then
      local adoc_file = fhtml:gsub('%.s?html', '.adoc')
      -- print('adoc_file is', adoc_file)
      if file_exists_p(adoc_file) then
        -- print('adoc_file exists')
        local i2 = io.open(adoc_file, 'r')
        page_title = i2:read('*line') or ''
        -- print('page_title is', page_title)
        page_title = page_title:gsub('^= *', '')
        page_title = page_title:gsub(' *$', '')
        i2:close()
      end
      if page_title == '' then
        page_title = fbase:gsub('%.s?html', '')
      end
      page_title = page_title:gsub('[“”]', '"')
      --
      local y = x:gsub('(.*)</head>.*', '%1')
      o:write(y)
      local z = x:gsub('.*(</head>.*)', '%1')
      o:write([[
      <script>
      window.status = window.status || 'ready_to_print';
      window.___gcfg = {
        parsetags: 'explicit'
      };
      </script>
      <script src="https://apis.google.com/js/platform.js" async defer></script>
      ]])
      -- added for DesignHammer
      o:write('<link rel="stylesheet" type="text/css" href="' .. local_dist_root_dir .. 'lib/wp-adaptors/style-bsw.css">\n')
      o:write('<script defer src="' ..local_dist_root_dir .. 'lib/wp-adaptors/script.js"></script>\n')
      --
      o:write(z, '\n')
      --
      delete_line_p = true
    end
    --
    if strips_title then
      if x:find('^<title>') then
        x = x:gsub('</?span[^>]*>', '')
      end
    end
    --
    if adds_links then
      if x:find('^<h[1-6] id') then
        -- tags to ignore inside section titles when making id=
        for _,tag in ipairs{'span', 'code', 'i', 'sup', 'sub'} do
          x = x:gsub('begincurriculum' .. tag, '$ZZ$')
          x = x:gsub('endcurriculum' .. tag, '$ZZ$')
          x = x:gsub('curriculum' .. tag, '$ZZ$')
        end
        x = x:gsub('_class[a-z]+', '$ZZ$')
        x = x:gsub('%$ZZ%$', '')
        if x:find('^h2') and tipe == 'lessonplan' then
          x = x:gsub('^<h2 id="([^>]*)>(.*)</h2>', '<h2 id="%1><span class="section-link"><a href="#%1 title="Direct link to this part of the lesson"><span class="section-link-symbol">&#128279;</span></a></span>%2</h2>')
        end
      end
    end

    --

    if delete_line_p then delete_line_p = false
    else o:write(x, '\n')
    end
    --
    if add_analytics_p then
      add_analytics_p = false
        o:write(gtm_noscript_content)
    end
    --
    if add_body_id_p then
      add_body_id_p = false
        local y = wp_prologue
        o:write(y)
        local klass = proglang
        if tipe == 'workbookpage' then
          klass = klass .. ' workbookpage'
          if fbase:find('^notes%-') then
            klass = klass .. ' LessonNotes'
          end
          if fhtml_cached:match('/solution%-pages/') then
            klass = klass .. ' solution-page'
          end
        elseif tipe == 'pathwayindependent' then
          if fhtml_cached:match('/pages/') or fhtml_cached:match('/textbooks/') then
            klass = klass .. ' workbookpage'
          else
            klass = klass .. ' narrativepage'
          end
          if fhtml_cached:find('/courses/[^/]-/back%-matter/') then
            klass = klass .. ' back-matter'
          elseif fbase:find('^notes%-') then
            klass = klass .. ' LessonNotes'
          end
        elseif tipe == 'lessonplan' then
          klass = klass .. ' LessonPlan'
        elseif not memberp(tipe, {'datasheetpage'}) then
          if tipe == 'pathwayresource' then
            klass = klass .. ' TeacherResources'
          end
          klass = klass .. ' narrativepage'
        else
          -- noop
        end
        if add_landscape_p then
          add_landscape_p = false
          klass = klass .. ' landscape'
        end
        if add_can_be_longer_p then
          add_can_be_longer_p = false
          klass = klass .. ' canBeLongerThanAPage'
        end
        --
        o:write('<div id="body" class="' .. klass .. '">\n')
    --
    end
    --
    if add_codemirror_p then
      add_codemirror_p = false
      o:write('<link rel="stylesheet" href="' .. local_dist_root_dir .. 'lib/codemirror.css" />\n')
      o:write(gtm_content)
      --o:write('<script defer src="' ..local_dist_root_dir .. 'lib/codemirror.js"></script>\n')
      o:write('<script defer src="' ..local_dist_root_dir .. 'lib/runmode-standalone.js"></script>\n')
      o:write('<script defer src="' ..local_dist_root_dir .. 'lib/scheme2.js"></script>\n')
      o:write('<script defer src="' ..local_dist_root_dir .. 'lib/pyret-mode.js"></script>\n')

    end
    --
    if add_bootstrap_lesson_p then
      add_bootstrap_lesson_p = false
      if tipe ~= 'workbookpage' then
        o:write('<!-- Load PDF and Download modules -->\n')
        o:write('<script async defer src="https://unpkg.com/pdf-lib@1.4.0"></script>\n')
        o:write('<script async defer src="https://unpkg.com/@pdf-lib/fontkit/dist/fontkit.umd.min.js"></script>\n')
        o:write('<script async defer src="https://unpkg.com/downloadjs@1.4.7"></script>\n')
        o:write('<script defer src="' ..local_dist_root_dir .. 'lib/dependency-graph.js"></script>\n')
        o:write('<script defer src="' ..local_dist_root_dir .. 'lib/makeWorkbook.js"></script>\n')
        o:write('<script defer src="' ..local_dist_root_dir .. 'lib/dictionaries.js"></script>\n')
        o:write('<script defer src="' ..local_dist_root_dir .. 'lib/pathway-tocs.js"></script>\n')
        o:write('<script defer src="' ..local_dist_root_dir .. 'lib/starterFiles.js"></script>\n')
        o:write('<script defer src="' ..local_dist_root_dir .. 'lib/graph-pages.js"></script>\n')
      end
      o:write('<script defer src="' ..local_dist_root_dir .. 'lib/page-render.js"></script>\n')
      -- Expose the page's pathway to scripts. Course pages (narrative/resource)
      -- carry it in their path; elsewhere it's left undefined (read from the URL).
      local pathway = get_pathway(fhtml_cached)
      if pathway then
        o:write('<script>var pathway = "' .. pathway .. '";</script>\n')
      else
        o:write('<script>var pathway;</script>\n')
      end
    end
    --
    if add_mathjax_p then
      -- print('adding mathjax')
      add_mathjax_p = false
      o:write('<script id="MathJax-script" async defer src="' .. 'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-chtml.js' .. '"></script>\n')
      o:write('<script>window.status = "not_ready_to_print";</script>\n')
    end
    --
    ::continue::
  end
  -- Safety net: flush a <li> deferred on the very last line of the file.
  if pending_li_p then o:write('<li>\n') end
  --
  i:close()
  o:close()
  if tipe == 'lessonplan' then
    return page_title
  end
end

local function extract_self_guided(fhtml_cached, lesson_title)
  if not file_exists_p(fhtml_cached) then return end
  local fdir = fhtml_cached:gsub('/%.cached/%.index%.html$', '')
  local fhtml = fdir .. '/index.shtml'
  local fjson = fdir .. '/selfGuidedBits.jsx'
  local fcss  = fdir .. '/selfGuidedExtra.css'
  local i = io.open(fhtml, 'r')
  local o = io.open(fjson, 'w')
  local c = io.open(fcss,  'w')
  local writing_p = false
  local skip_one_more_line_p = false
  local in_style_p = false
  local counter = 0
  local page_header = ''
  local piece_buf = {}  -- buffer lines for the current piece

  -- Fix a buffered piece's lines for split-list artifacts:
  -- If the first content line is a bare <li> (no wrapping <ul>), inject <ul>
  -- before it and drop the orphaned </ul> and subsequent debris lines after
  -- the last </li>. If the last content line has unclosed <li>/<ul> elements,
  -- append the missing close tags.
  local function fix_piece(lines)
    -- Count net open <ul> and <li> tags to detect unclosed list at end
    local ul_count, li_count = 0, 0
    for _, l in ipairs(lines) do
      if     l:match('^<ul')   then ul_count = ul_count + 1
      elseif l:match('^</ul>') then ul_count = ul_count - 1
      end
      if     l:match('^<li>')  then li_count = li_count + 1
      elseif l:match('^</li>') then li_count = li_count - 1
      end
    end

    -- Case 1: piece ends with unclosed <li> (break was inside a list item)
    -- Close the open <p>, <li>, and <ul> before the outer </div>
    if li_count > 0 then
      table.insert(lines, '</p>')
      for _ = 1, li_count do table.insert(lines, '</li>') end
      for _ = 1, ul_count  do table.insert(lines, '</ul>') end
    end

    -- Case 2: piece starts with a bare <li> (continuation of a split list)
    -- Find the first non-empty, non-header line; if it's <li>, inject <ul>
    -- before it and drop everything after the last </li>.
    local first = nil
    for idx, l in ipairs(lines) do
      if l:match('%S') and not l:match('^<h%d') then first = idx; break end
    end
    if first and lines[first]:match('^<li>') then
      table.insert(lines, first, '<ul>')
      local last_li = nil
      for idx = #lines, 1, -1 do
        if lines[idx]:match('^</li>') then last_li = idx; break end
      end
      if last_li then
        while #lines > last_li do table.remove(lines) end
        table.insert(lines, '</ul>')
      end
    end

    return lines
  end

  o:write('export const selfGuidedTitle = "' .. lesson_title .. '"\n\n')
  o:write('export const selfGuidedBits = [\n')
  for x0 in i:lines() do
    local x = x0
    if x:match('href="%.%./%.%./lessons/') then
      x = x:gsub('href="%.%./%.%./lessons/', 'href="../../../../lessons/')
    end
    if x == '<style>' then
      in_style_p = true
    elseif x == '</style>' then
      in_style_p = false
    elseif in_style_p then
      c:write(x, '\n')
    elseif writing_p then
      if skip_one_more_line_p then
        skip_one_more_line_p = false
        table.insert(piece_buf, page_header)
      elseif x:match('stop_self_guided_piece') then
        piece_buf = fix_piece(piece_buf)
        for _, l in ipairs(piece_buf) do o:write(l, '\n') end
        o:write('</div>`\n},\n')
        piece_buf = {}
        writing_p = false
      else
        table.insert(piece_buf, x)
      end
    elseif x:match('^<h2') then
      page_header = x
    elseif x:match('end_self_guided') then break -- needed?
    elseif x:match('start_self_guided_piece') then
      writing_p = true
      skip_one_more_line_p = true
      piece_buf = {}
      counter = counter + 1
      -- print('counter=', counter)
      local editorconfig_file = fdir .. '/.cached/.index-sg-' .. counter .. '.json'
      local editorconfig = '""'
      if file_exists_p(editorconfig_file) then
        editorconfig = table.concat(read_file_lines(editorconfig_file), '\n')
      end
      o:write('{\n', editorconfig, ',\nlessonText: `\n')
    else
      --noop
    end
  end
  o:write(']\n')
  i:close()
  o:close()
  c:close()
end

-- Build one combined worklist across all five types, then split it into
-- NUMCORES even shards via a K/N round-robin arg. Each shard owns its
-- lessons end-to-end: postproc, extract_self_guided, self-guided dir
-- setup, and make_slides_file all happen within a single worker for
-- the same lesson, so there are no synchronization barriers between
-- per-lesson stages.

local shard_k, shard_n
if arg[1] then
  local k, n = arg[1]:match('^(%d+)/(%d+)$')
  shard_k, shard_n = tonumber(k), tonumber(n)
end

local types = {'pathwayindependent', 'workbookpage', 'lessonplan', 'pathwaynarrative', 'pathwayresource'}
local batchf_env = {
  pathwayindependent = 'ADOC_POSTPROC_PATHWAYINDEPENDENT_INPUT',
  workbookpage       = 'ADOC_POSTPROC_WORKBOOKPAGE_INPUT',
  lessonplan         = 'ADOC_POSTPROC_LESSONPLAN_INPUT',
  pathwaynarrative   = 'ADOC_POSTPROC_PATHWAYNARRATIVE_INPUT',
  pathwayresource    = 'ADOC_POSTPROC_PATHWAYRESOURCE_INPUT',
}

local jobs = {}
for _,tipe in ipairs(types) do
  for _,f in ipairs(dofile(os.getenv(batchf_env[tipe]))) do
    table.insert(jobs, {tipe = tipe, file = f})
  end
end

dofile(make_dir .. 'make-slides.lua')
local self_guided_sh = os.getenv'TOPDIR' .. '/' .. make_dir .. 'make-self-guided.sh'

for i, job in ipairs(jobs) do
  if (not shard_k) or (((i - 1) % shard_n) + 1 == shard_k) then
    local title = postproc(job.file, job.tipe)
    if job.tipe == 'lessonplan' then
      extract_self_guided(job.file, title)
      local lesson_dir = job.file:gsub('/%.cached/%.index%.html', '')
      os.execute(self_guided_sh .. ' ' .. lesson_dir)
      make_slides_file(lesson_dir)
    end
  end
end
