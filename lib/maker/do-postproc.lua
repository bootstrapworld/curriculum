#! /usr/bin/env lua

local make_dir = os.getenv'MAKE_DIR'

dofile(make_dir .. 'utils.lua')

local website_branch_p = (shell_output('git branch --show-current')[1] == 'website')
website_branch_p = true

local pathwayindependent_batchf =  os.getenv'ADOC_POSTPROC_PATHWAYINDEPENDENT_INPUT'
local workbookpage_batchf =  os.getenv'ADOC_POSTPROC_WORKBOOKPAGE_INPUT'
local lessonplan_batchf =  os.getenv'ADOC_POSTPROC_LESSONPLAN_INPUT'
local pathwaynarrative_batchf =  os.getenv'ADOC_POSTPROC_PATHWAYNARRATIVE_INPUT'
local pathwayresource_batchf =  os.getenv'ADOC_POSTPROC_PATHWAYRESOURCE_INPUT'

local old_analytics_file = os.getenv'TOPDIR' .. '/lib/old-analytics.txt'
local new_analytics_file = os.getenv'TOPDIR' .. '/lib/new-analytics.txt'
local gtm_file = os.getenv'TOPDIR' .. '/lib/gtm.txt'
local gtm_noscript_file = os.getenv'TOPDIR' .. '/lib/gtm-noscript.txt'

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

local function postproc(fhtml_cached, tipe)
  local page_title = ''
  -- print('doing postproc', fhtml_cached, tipe)
  if not file_exists_p(fhtml_cached) then return end
  local local_dist_root_dir = calculate_dist_root_dir(fhtml_cached)
  -- print('local_dist_root_dir is', local_dist_root_dir)
  local fdir = fhtml_cached:gsub('/%.cached/[^/]*html$', '')
  -- print('fdir is', fdir)
  local fbase = fhtml_cached:gsub('^.*/%.([^/]*html)$', '%1')
  if memberp(tipe, {'lessonplan', 'pathwaynarrative', 'pathwayresource'}) then
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
  local f_mathjax_file = fhtml_cached:gsub('%.html$', '.asc.uses-mathjax')
  local f_codemirror_file = fhtml_cached:gsub('%.html$', '.asc.uses-codemirror')
  --
  os.execute('cp ' .. fhtml_cached .. ' ' .. fhtml_cached .. '.save')
  local i = io.open(fhtml_cached, 'r')
  local o = io.open(fhtml, 'w')
  --
  local add_analytics_p = false
  local add_bootstrap_lesson_p = false
  local add_menubar_p = false
  local add_mathjax_p = false
  local add_codemirror_p = false
  local add_body_id_p = false
  local add_landscape_p = false
  local add_end_body_id_p = false
  local delete_line_p = false
  local read_end_sidebar_p = false
  local num_of_lines_past_end_sidebar = 0
  local openblock_attribs = false
  local item_attrib = false
  --
  for x in i:lines() do
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
      if memberp(tipe, {'lessonplan', 'pathwaynarrative', 'pathwayresource'}) and not website_branch_p then
        add_menubar_p = true
      end
      if x:find('landscape') then
        x = x:gsub('landscape', '')
        add_landscape_p = true
      end
      --
      add_body_id_p = true
      add_end_body_id_p = true
      --
      if memberp(tipe, {'lessonplan', 'pathwaynarrative'}) then
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
      x = x:gsub('</body>', string.format([[
</div>
<!--#include virtual="%slib/wp-adaptors/sidebar/curricula.ssi" -->
</div>
</div>
<!--#include virtual="%slib/wp-adaptors/footer.ssi" -->
</body>
]], local_dist_root_dir, local_dist_root_dir))
    end
    --
    if x:find('^<link.*curriculum%.css') then
      x = x:gsub('^<link.*curriculum%.css', '<link rel="stylesheet" href="' .. local_dist_root_dir .. 'lib/curriculum.css')
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
    x = x:gsub('<pre>', '<pre><code class="' .. code_lang .. '">')
    x = x:gsub('</pre>', '</code></pre>')
    x = x:gsub('<code>', '<code class="' .. code_lang .. '">')
    x = x:gsub('<p> </p>', '<p></p>')
    --
    if x:find('<p>%%BEGINQBLOCKITEM%%') then
      x = x:gsub('<p>%%BEGINQBLOCKITEM%%', '<p class="qblock">')
    end
    --
    if x:find('<p>%%BEGINABLOCKITEM%%') then
      x = x:gsub('<p>%%BEGINABLOCKITEM%%', '<p class="ablock">')
    end
    --
    if item_attrib and (x:find('<li>')) then
      x = x:gsub('<li>', '<li class="' .. item_attrib .. '">')
      item_attrib = false
    end
    --
    if x:find('%%END[QA]BLOCKITEM%%') then
      if x:find('%%ENDQBLOCKITEM%%') then
        item_attrib = 'ablockitem'
      else
        item_attrib = false
      end
      x = x:gsub('%%END[QA]BLOCKITEM%%', '')
    end
    --
    if x:find('class="exampleblock .-actually%-openblock ') and openblock_attribs then
      x = x:gsub('class=".-"', '%0' .. openblock_attribs)
      openblock_attribs = false
    end
    x = x:gsub('class="exampleblock (.-)actually%-openblock ', 'class="openblock %1')
    x = x:gsub('class="openblock sidebar', 'class="sidebar')
    x = x:gsub('<div class="sidebar">', '</div>\n</div>\n</div>\n%0<div id="toggle"></div>')
    --
    x = x:gsub('%%CURRICULUMMATHJAXMARKER%%', '$$')
    --
    x = x:gsub('%%CURRICULUMCOMMENTSTART%%', '<!--')
    x = x:gsub('%%CURRICULUMCOMMENTSTOP%%', '-->')
    --
    x = x:gsub('%%CURRICULUM([^%%]*)%%', '<%1')
    x = x:gsub('%%BEGINCURRICULUM([^%%]*)%%', '>')
    x = x:gsub('%%ENDCURRICULUM([^%%]*)%%', '</%1>')
    --
    x = x:gsub('&#8656;', '&lt;=')
    x = x:gsub('&#8594;', '-&gt;')
    --
    x = x:gsub('^(<div id="preamble)">', '%1_disabled" class="lessonSummary">')
    --
    x = x:gsub('<span class="([^"]+)">(<figure class="image")', '%2 style="text-align: %1"')
    x = x:gsub('(</figure>)</span>', '%1')
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
      o:write(z, '\n')
      -- added for DesignHammer
      --o:write('<link rel="stylesheet" type="text/css" href="' .. local_dist_root_dir .. 'lib/wp-adaptors/style-overrides.css">\n')
      o:write('<link rel="stylesheet" type="text/css" href="' .. local_dist_root_dir .. 'lib/wp-adaptors/style-bsw.css">\n')
      o:write('<link rel="preconnect" href="https://fonts.googleapis.com">\n')
      o:write('<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\n')
      o:write('<link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/wp-adaptors/script.js"></script>\n')
      --
      delete_line_p = true
    end
    if x:find('</h1>') then
      x = x:gsub('</h1>.*', '%0\n<div id="savetodrive-div"></div>')
    end
    if x:find('^<div id="body"') then
      x = x:gsub('id="body"', '%0 onload="renderSaveToDrive()"')
    end
    --
    if memberp(tipe, {'lessonplan', 'pathwayresource'}) then
      if x:find('^<title>') then
        x = x:gsub('</?span[^>]*>', '')
      end
    end
    --
    if tipe == 'lessonplan' then
      if x:find('^<h2 id') then
        x = x:gsub('begincurriculumspan', '')
        x = x:gsub('endcurriculumspan', '')
        x = x:gsub('curriculumspan_class', '')
        x = x:gsub('^<h2 id="([^>]*)>(.*)</h2>', '<h2 id="%1><span class="section-link"><a href="#%1 title="Direct link to this part of the lesson"><span class="section-link-symbol">&#128279;</span></a></span>%2</h2>')
      end
    end

    --

    if delete_line_p then delete_line_p = false
    else o:write(x, '\n')
    end
    --
    if add_menubar_p then
      add_menubar_p = false
      o:write('<!--#include virtual="/menubar.ssi"-->\n')
    end
    --
    if add_analytics_p then
      add_analytics_p = false
      if not website_branch_p then
        copy_file_to_port(old_analytics_file, o)
      end
      if website_branch_p then
        copy_file_to_port(gtm_noscript_file, o)
      end
    end
    --
    if add_body_id_p then
      add_body_id_p = false
      if website_branch_p then
        o:write(string.format([[
<!--#include virtual="%slib/wp-adaptors/header.ssi" -->
<div class="x-row x-container max width e4468439224895391-e2 m17zxgn2tjtr-8 m17zxgn2tjtr-9 m17zxgn2tjtr-b">
<div class="x-row-inner">
<div class="x-col e4468439224895391-e3 m17zxgn2tjtr-d m17zxgn2tjtr-e m17zxgn2tjtr-f lesson-content">
]], local_dist_root_dir, local_dist_root_dir))
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
        --
        o:write('<div id="body" class="' .. klass .. '">\n')
      else
        o:write('<div id="body">\n')
      end
    --
    end
    --
    if add_codemirror_p then
      add_codemirror_p = false
      o:write('<link rel="stylesheet" href="' .. local_dist_root_dir .. 'lib/codemirror.css" />\n')
      if website_branch_p then
        copy_file_to_port(new_analytics_file, o)
      end
      o:write('<script src="' .. local_dist_root_dir .. 'lib/codemirror.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/runmode.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/scheme2.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/pyret-mode.js"></script>\n')

    end
    --
    if add_bootstrap_lesson_p then
      add_bootstrap_lesson_p = false
      if tipe ~= 'workbookpage' then
        o:write('<!-- Load PDF and Download modules -->\n')
        o:write('<script async defer src="https://unpkg.com/pdf-lib@1.4.0"></script>\n')
        o:write('<script async defer src="https://unpkg.com/@pdf-lib/fontkit/dist/fontkit.umd.min.js"></script>\n')
        o:write('<script async defer src="https://unpkg.com/downloadjs@1.4.7"></script>\n')
        o:write('<script src="' .. local_dist_root_dir .. 'lib/dependency-graph.js"></script>\n')
        o:write('<script src="' .. local_dist_root_dir .. 'lib/makeWorkbook.js"></script>\n')
        o:write('<script src="' .. local_dist_root_dir .. 'lib/dictionaries.js"></script>\n')
        o:write('<script src="' .. local_dist_root_dir .. 'lib/pathway-tocs.js"></script>\n')
        o:write('<script src="' .. local_dist_root_dir .. 'lib/starterFiles.js"></script>\n')
      end
      o:write('<script src="' .. local_dist_root_dir .. 'lib/bootstraplesson.js"></script>\n')
      o:write('<script>var pathway;</script>\n')
    end
    --
    if add_mathjax_p then
      -- print('adding mathjax')
      add_mathjax_p = false
      o:write('<script src="' .. 'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-chtml-full-speech.min.js' .. '"><script>\n')
      o:write('<script>window.status = "not_ready_to_print";</script>\n')
    end
    --
    ::continue::
  end
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
  local i = io.open(fhtml, 'r')
  local o = io.open(fjson, 'w')
  local writing_p = false
  local skip_one_more_line_p = false
  local counter = 0
  local page_header = ''
  o:write('export const selfGuidedTitle = "' .. lesson_title .. '"\n\n')
  o:write('export const selfGuidedBits = [\n')
  for x in i:lines() do
    if writing_p then
      if skip_one_more_line_p then
        skip_one_more_line_p = false
        o:write(page_header, '\n')
      elseif x:match('stop_self_guided_piece') then
        o:write('</div>`\n},\n')
        writing_p = false
      else
        o:write(x, '\n')
      end
    elseif x:match('^<h2') then
      page_header = x
    elseif x:match('end_self_guided') then break -- needed?
    elseif x:match('start_self_guided_piece') then
      writing_p = true
      skip_one_more_line_p = true
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
end

local function run_postproc(batchf, tipe)
  -- print('doing run_postproc', batchf, tipe)
  local files = dofile(batchf)
  for _,f in ipairs(files) do
    local title = postproc(f, tipe)
    if tipe == 'lessonplan' then extract_self_guided(f, title) end
  end
end

run_postproc(pathwayindependent_batchf, 'pathwayindependent')
run_postproc(workbookpage_batchf, 'workbookpage')
run_postproc(lessonplan_batchf, 'lessonplan')
run_postproc(pathwaynarrative_batchf, 'pathwaynarrative')
run_postproc(pathwayresource_batchf, 'pathwayresource')

dofile(make_dir .. 'make-slides.lua')

do
  local cached_html_files = dofile(lessonplan_batchf)
  -- e.g., "distribution/en-us/lessons/quadratic3-fitting-models/.cached/.index.html"
  for _,cached_html_file in ipairs(cached_html_files) do
    local lesson_dir = cached_html_file:gsub('/%.cached/%.index.html', '')
    make_slides_file(lesson_dir)
  end
end
