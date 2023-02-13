#! /usr/bin/env lua

dir_prefix = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/'

pwyindep_batchf =  os.getenv('ADOC_POSTPROC_PWYINDEP_INPUT')
workbookpage_batchf =  os.getenv('ADOC_POSTPROC_WORKBOOKPAGE_INPUT')
lessonplan_batchf =  os.getenv('ADOC_POSTPROC_LESSONPLAN_INPUT')
narrative_batchf =  os.getenv('ADOC_POSTPROC_NARRATIVE_INPUT')
narrativeaux_batchf =  os.getenv('ADOC_POSTPROC_NARRATIVEAUX_INPUT')
resources_batchf =  os.getenv('ADOC_POSTPROC_RESOURCES_INPUT')

analytics_file = os.getenv('TOPDIR') .. '/lib/analytics.txt'

function file_exists_p(f)
  -- print('doing file_exists_p', f)
  local h = io.open(f)
  if h then h:close(); return true
  else return false
  end
end

function memberp(elt, tbl)
  for _,val in pairs(tbl) do
    if elt == val then return true end
  end
  return false
end

function with_open_input_file(f, fn)
  local i = io.open(f, 'r')
  local res = fn(i)
  i:close()
  return res
end

function copy_file_to_stream(fi, o)
  with_open_input_file(fi, function(i)
    for line in i:lines() do
      o:write(line, '\n')
    end
  end)
end

function calculate_dist_root_dir(fhtml_cached)
  local f = fhtml_cached:gsub('^%./', '')
  f = f:gsub('/%./', '/')
  f = f:gsub('[^/]', '')
  f = f:gsub('^/', '')
  f = f:gsub('/', '../')
  return f
end

function postproc(fhtml_cached, tijpe)
  -- print('doing postproc', fhtml_cached, tijpe)
  if not file_exists_p(dir_prefix .. '/' .. fhtml_cached) then return end
  local local_dist_root_dir = calculate_dist_root_dir(fhtml_cached)
  -- print('local_dist_root_dir is', local_dist_root_dir)
  local fdir = fhtml_cached:gsub('/%.cached/[^/]*html$', '')
  -- print('fdir is', fdir)
  local fbase = fhtml_cached:gsub('^.*/%.([^/]*html)$', '%1')
  if memberp(tijpe, {'lessonplan', 'narrative', 'narrativeaux', 'resources'}) then
    fbase = fbase:gsub('%.html$', '.shtml')
  end
  -- print('fbase is', fbase)
  local fhtml = fdir .. '/' .. fbase
  -- print('fhtml is', fhtml)
  local code_lang = 'pyret'
  if fhtml_cached:find('^[^/]*/[^/]*-wescheme') then
    code_lang = 'wescheme'
  end
  local f_comment_file = dir_prefix .. fhtml_cached:gsub('%.html$', '') .. '-comment.txt'
  local f_mathjax_file = dir_prefix .. fhtml_cached:gsub('%.html$', '.asc.uses-mathjax')
  local f_codemirror_file = dir_prefix .. fhtml_cached:gsub('%.html$', '.asc.uses-codemirror')
  --
  local i = io.open(dir_prefix .. fhtml_cached, 'r')
  local o = io.open(dir_prefix .. fhtml, 'w')
  --
  local add_analytics_p = false
  local add_bootstrap_lesson_p = false
  local add_comment_p = false
  local add_mathjax_p = false
  local add_codemirror_p = false
  local add_body_id_p = false
  local add_end_body_id_p = false
  local inside_sidebar_section_p = false
  local delete_line_p = false
  --
  for x in i:lines() do
    --
    if x:find('^<body') then
      if file_exists_p(f_comment_file) then
        add_comment_p = true
      end
      --
      if memberp(tijpe, {'lessonplan', 'narrative', 'narrativeaux', 'resources'}) then
        add_body_id_p = true
        add_end_body_id_p = true
      end
      --
      --
      if memberp(tijpe, {'lessonplan', 'narrative'}) then
        add_analytics_p = true
      end
      --
      if tijpe == 'resources' then -- TEACHERRESOURCEPAGE
        x = x:gsub('^<body class="', '%0TeacherResources ')
      end
      --
      if tijpe ~= 'narrativeaux' then
        x = x:gsub('^<body ', '%1 onload="renderSaveToDrive()" ')
      end

      --
      --fixme datasheetpage?
      if memberp(tijpe, {'workbookpage', 'lessonplan', 'datasheetpage'}) then
        x = x:gsub('^<body class="', '%0narrativepage')
      end
    end
    --
    if add_end_body_id_p and x:find('</body>') then
      add_end_body_id_p = false
      x = x:gsub('</body>', '</div>\n%0')
    end
    --
    if x:find('^<link.*curriculum%.css') then
      x = x:gsub('^<link.*curriculum%.css', '<link rel="stylesheet" href="' .. local_dist_root_dir .. 'lib/curriculum.css" />')
      add_bootstrap_lesson_p = true
      if file_exists_p(f_codemirror_file) or tijpe == 'narrative' then
        add_codemirror_p = true
      end
      if file_exists_p(f_mathjax_file) then
        add_mathjax_p = true
      end
    end
    --
    x = x:gsub('<pre>', '<pre><code="' .. code_lang .. '">')
    x = x:gsub('</pre>', '</code></pre>')
    x = x:gsub('<code>', '<code class="' .. code_lang .. '">')
    x = x:gsub('<p>(%%CURRICULUMCOMMENT%%)', '%1')
    x = x:gsub('(%%ENDCURRICULUMCOMMENT%%)<.p>', '%1')
    x = x:gsub('%%CURRICULUMCOMMENT%%', '<!-- ')
    x = x:gsub('%%ENDCURRICULUMCOMMENT%%', '\n-->')
    --
    x = x:gsub('%%CURRICULUMSCRIPT%%', '<script type="math/tex"')
    x = x:gsub('%%BEGINCURRICULUMSCRIPT%%', '>')
    x = x:gsub('%%ENDCURRICULUMSCRIPT%%', '</script>')
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
    if not inside_sidebar_section_p and x:find('%%SIDEBARSECTION%%') then
      inside_sidebar_section_p = true
      x = x:gsub('%%SIDEBARSECTION%%', '--></div><div class="sidebar"><div id="toggle"></div><div class="paragraph"><!--')
    end
    --
    if inside_sidebar_section_p then
      x = x:gsub('(</div>)</p>', '%1')
      x = x:gsub('<p>(<div>)', '%1')
      --
      if x:find('%%ENDSIDEBARSECTION%%') then
        x = x:gsub('%%ENDSIDEBARSECTION%%', '--></div><!--')
        inside_sidebar_section_p = false
      end
    end
    --
    if x:find('BOGUSACKNOWLEDGMENTSECTIONHEADER') then
      delete_line_p = true
    end
    --
    if tijpe ~= 'narrativeaux' then
      if x:find('</head>') then
        local page_title = ''
        local adoc_file = dir_prefix .. fhtml:gsub('%.s?html', '.adoc')
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
        <script>function renderSaveToDrive() {
          var isSafari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);
          gapi.savetodrive.render('savetodrive-div', {
            src:]] ..
            "(window.location.href.match(/\\/$/)?(window.location.href+'index-gdrive-import.html'):(window.location.href.replace(/([^\\/]+)\\.([^.\\/]+)$/, '$1-gdrive-import.html')))," ..
            [[
            filename:
            ]] .. '"' .. page_title .. '",' ..
            [[
            sitename:"Bootstrap, Brown University"
          });
          if(isSafari){
            var warning = document.createElement("div");
            warning.id = "safariWarning";
            warning.innerHTML = "You appear to be using Safari, which interferes with Google's Save-to-Drive button. You can fix it by going to Preferences, clicking 'Privacy', and making sure that 'Prevent cross-site tracking' is <b>not</b> checked."
            var button = document.getElementById("savetodrive-div");
            button.parentNode.insertBefore(warning, warning.nextSibling);
          }
        }
        </script>
        ]])
        o:write(z, '\n')
        delete_line_p = true
      end
      if x:find('</h1>') then
        x = x:gsub('</h1>.*', '%0\n<div id="savetodrive-div"></div>')
      end
      if x:find('^<div id="body"') then
        x = x:gsub('id="body"', '%1 onload="renderSaveToDrive()"')
      end
    end
    --
    if memberp(tijpe, {'lessonplan', 'resources'}) then
      if x:find('^<title>') then
        x = x:gsub('</?span[^>]*>', '')
      end
    end
    --
    if tijpe == 'lessonplan' then
      if x:find('^<h2 id') then
        x = x:gsub('begincurriculumspan', '')
        x = x:gsub('endcurriculumspan', '')
        x = x:gsub('curriculumspan_class', '')
        x = x:gsub('^<h2 id="([^>]*)>(.*)</h2>', '<h2 id="%1><span class="section-link"><a href="#%1" title="Direct link to this part of the lesson"><span class="section-link-symbol">&#128279;</span>>/a></span>%2</h2>')
      end
    end

    --

    if delete_line_p then delete_line_p = false
    else o:write(x, '\n')
    end
    --
    if add_comment_p then
      add_comment_p = false
      copy_file_to_stream(f_comment_file, o)
    end
    --
    if add_analytics_p then
      add_analytics_p = false
      copy_file_to_stream(analytics_file, o)
    end
    --
    if add_body_id_p then
      add_body_id_p = false
      o:write('<div id="body">\n')
    end
    --
    if add_codemirror_p then
      add_codemirror_p = false
      o:write('<link rel="stylesheet" href="' .. local_dist_root_dir .. 'lib/codemirror.css" />\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/codemirror.js" />\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/runmode.js" />\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/scheme2.js" />\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/pyret-mode.js" />\n')

    end
    --
    if add_mathjax_p then
      -- print('adding mathjax')
      add_mathjax_p = false
      o:write('<script src="' .. local_dist_root_dir .. 'extlib/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML%2Clocal%2Fmathjaxlocal.js"></script>\n')
      o:write('<script>window.status = "not_ready_to_print";</script>\n')
    end
    --
    if add_bootstrap_lesson_p then
      add_bootstrap_lesson_p = false
      o:write('<script src="' .. local_dist_root_dir .. 'lib/langtable.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/bootstraplesson.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/dictionaries.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'dependency-graph.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'pathway-tocs.js"></script>\n')
      o:write('<script>var pathway;</script>\n')
    end
    --
  end
  --
  i:close()
  o:close()

  if tijpe ~= 'narrativeaux' then
    local gdrive_fhtml = fhtml:gsub('%.s?html', '-gdrive-import.html')
    i = io.open(dir_prefix .. fhtml, 'r')
    o = io.open(dir_prefix .. gdrive_fhtml, 'w')
    for x in i:lines() do
      if x:find('src:%(window.location.href') then
        o:write('src:window.location.href,\n')
      else
        o:write(x, '\n')
      end
    end

    i:close()
    o:close()

  end

end

function run_postproc(batchf, tijpe)
  -- print('doing run_postproc', batchf, tijpe)
  local i = io.open(batchf, 'r')
  if not i then
    -- print('run_postproc skipping nonexistent ', batchf)
    return
  end
  for f in i:lines() do
    postproc(f, tijpe)
  end
  i:close()
end

run_postproc(pwyindep_batchf, 'pwyindep')
run_postproc(workbookpage_batchf, 'workbookpage')
run_postproc(lessonplan_batchf, 'lessonplan')
run_postproc(narrative_batchf, 'narrative')
run_postproc(narrativeaux_batchf, 'narrativeaux')
run_postproc(resources_batchf, 'resources')
