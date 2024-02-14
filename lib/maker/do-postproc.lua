#! /usr/bin/env lua

dofile(os.getenv('MAKE_DIR') .. 'utils.lua')

-- dir_prefix = os.getenv('TOPDIR') .. '/distribution/' .. os.getenv('NATLANG') .. '/'

dir_prefix = ''

pwyindep_batchf =  os.getenv('ADOC_POSTPROC_PWYINDEP_INPUT')
workbookpage_batchf =  os.getenv('ADOC_POSTPROC_WORKBOOKPAGE_INPUT')
lessonplan_batchf =  os.getenv('ADOC_POSTPROC_LESSONPLAN_INPUT')
narrative_batchf =  os.getenv('ADOC_POSTPROC_NARRATIVE_INPUT')
narrativeaux_batchf =  os.getenv('ADOC_POSTPROC_NARRATIVEAUX_INPUT')
resources_batchf =  os.getenv('ADOC_POSTPROC_RESOURCES_INPUT')

analytics_file = os.getenv('TOPDIR') .. '/lib/analytics.txt'

function calculate_dist_root_dir(fhtml_cached)
  local f = fhtml_cached:gsub('^%./', '')
  f = f:gsub('/%./', '/')
  f = f:gsub('[^/]', '')
  f = f:gsub('^/', '')
  f = f:gsub('/', '../')
  f = f:gsub('^%.%./%.%./', '')
  return f
end

function postproc(fhtml_cached, tipe)
  -- print('doing postproc', fhtml_cached, tipe)
  -- if not file_exists_p(dir_prefix .. '/' .. fhtml_cached) then return end
  if not file_exists_p(fhtml_cached) then return end
  local local_dist_root_dir = calculate_dist_root_dir(fhtml_cached)
  -- print('local_dist_root_dir is', local_dist_root_dir)
  local fdir = fhtml_cached:gsub('/%.cached/[^/]*html$', '')
  -- print('fdir is', fdir)
  local fbase = fhtml_cached:gsub('^.*/%.([^/]*html)$', '%1')
  if memberp(tipe, {'lessonplan', 'narrative', 'narrativeaux', 'resources'}) then
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
      if memberp(tipe, {'lessonplan', 'narrative', 'narrativeaux', 'resources'}) then
        add_body_id_p = true
        add_end_body_id_p = true
      end
      --
      if memberp(tipe, {'lessonplan', 'narrative'}) then
        add_analytics_p = true
      end
      --
      if tipe == 'resources' then -- TEACHERRESOURCEPAGE
        x = x:gsub('^<body class="', '%0TeacherResources ')
      end
      --
      --fixme datasheetpage?
      if tipe == 'workbookpage' then
        x = x:gsub('<body class="', '%0workbookpage ')
      elseif tipe == 'pwyindep' then
        if fhtml_cached:match('/pages/') or fhtml_cached:match('/textbooks/') then
          x = x:gsub('<body class="', '%0workbookpage ')
        else
          x = x:gsub('<body class="', '%0narrativepage ')
        end
      elseif not memberp(tipe, {'workbookpage', 'lessonplan', 'datasheetpage'}) then
        x = x:gsub('^<body class="', '%0narrativepage ')
      end
      if tipe == 'workbookpage' then
        if fhtml_cached:find('/courses/[^/]-/back%-matter/') then
          x = x:gsub('<body class="', '%0back-matter ')
        end
        if fbase:find('^notes%-') then
          x = x:gsub('<body class="', '%0LessonNotes ')
        end
      end
      if tipe ~= 'narrativeaux' then
        x = x:gsub('^<body ', '%1 " ')
      end
      --
    end
    --
    if add_end_body_id_p and x:find('</body>') then
      add_end_body_id_p = false
      x = x:gsub('</body>', '</div>\n%0')
    end
    --
    if x:find('^<link.*curriculum%.css') then
      x = x:gsub('^<link.*curriculum%.css', '<link rel="stylesheet" href="' .. local_dist_root_dir .. 'lib/curriculum.css')
      add_bootstrap_lesson_p = true
      if file_exists_p(f_codemirror_file) or tipe == 'narrative' then
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
    x = x:gsub('<p> </p>', '<p></p>')
    x = x:gsub('<p>(%%CURRICULUMCOMMENT%%)', '%1')
    x = x:gsub('(%%ENDCURRICULUMCOMMENT%%)<.p>', '%1')
    x = x:gsub('%%CURRICULUMCOMMENT%%', '<!-- ')
    x = x:gsub('%%ENDCURRICULUMCOMMENT%%', '\n-->')
    --
    x = x:gsub('class="exampleblock actually%-openblock ', 'class="openblock ')
    --
    x = x:gsub('%%CURRICULUMMATHJAXMARKER%%', '$$')
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
    if tipe ~= 'narrativeaux' then
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
        ]])
        o:write(z, '\n')
        delete_line_p = true
      end
      if x:find('</h1>') then
        x = x:gsub('</h1>.*', '%0\n')
      end
      if x:find('^<div id="body"') then
        x = x:gsub('id="body"', '%1 "')
      end
    end
    --
    if memberp(tipe, {'lessonplan', 'resources'}) then
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
        x = x:gsub('^<h2 id="([^>]*)>(.*)</h2>', '<h2 id="%1><span class="section-link"><a href="#%1" title="Direct link to this part of the lesson"><span class="section-link-symbol">&#128279;</span></a></span>%2</h2>')
      end
    end

    --

    if delete_line_p then delete_line_p = false
    else o:write(x, '\n')
    end
    --
    if add_comment_p then
      add_comment_p = false
      copy_file_to_port(f_comment_file, o)
    end
    --
    if add_analytics_p then
      add_analytics_p = false
      copy_file_to_port(analytics_file, o)
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
      o:write('<script src="' .. local_dist_root_dir .. 'lib/codemirror.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/runmode.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/scheme2.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/pyret-mode.js"></script>\n')

    end
    --
    if add_mathjax_p then
      -- print('adding mathjax')
      add_mathjax_p = false
      o:write(
[=[<script>
  MathJax = {
    options: { enableMenu: false, },
    tex:     {
      inlineMath: [['$$', '$$'], ['\\(', '\\)']],
      displayMath: [],
    },
    svg:     { fontCache: 'global' },
    startup: {
      ready: () => {
            MathJax.startup.defaultReady();
            MathJax.startup.promise.then(() => {
              window.status="MathJax Complete!"
            });
          }
    }
  };
  </script>
]=]);
      o:write('<script src="' .. 'https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-chtml-full-speech.min.js' .. '"><script>\n')
      -- o:write('<script src="' .. local_dist_root_dir .. 'extlib/mathjax/tex-chtml-full-speech.js' .. '"></script>\n')
      o:write('<script>window.status = "not_ready_to_print";</script>\n')
    end
    --
    if add_bootstrap_lesson_p then
      add_bootstrap_lesson_p = false
      o:write('<!-- Load PDF and Download modules -->\n')
      o:write('<script src="https://unpkg.com/pdf-lib@1.4.0"></script>\n')
      o:write('<script src="https://unpkg.com/downloadjs@1.4.7"></script>\n')

      o:write('<script src="' .. local_dist_root_dir .. 'lib/langtable.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/bootstraplesson.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'lib/dictionaries.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'dependency-graph.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'pathway-tocs.js"></script>\n')
      o:write('<script src="' .. local_dist_root_dir .. 'starter-files.js"></script>\n')
      o:write('<script>var pathway;</script>\n')
    end
    --
  end
  --
  i:close()
  o:close()

end

function run_postproc(batchf, tipe)
  -- print('doing run_postproc', batchf, tipe)
  local files = dofile(batchf)
  for _,f in ipairs(files) do
    postproc(f, tipe)
  end
end

run_postproc(pwyindep_batchf, 'pwyindep')
run_postproc(workbookpage_batchf, 'workbookpage')
run_postproc(lessonplan_batchf, 'lessonplan')
run_postproc(narrative_batchf, 'narrative')
run_postproc(narrativeaux_batchf, 'narrativeaux')
run_postproc(resources_batchf, 'resources')
