#! /usr/bin/env lua

dofile(os.getenv('TOPDIR') .. '/' .. os.getenv('MAKE_DIR') .. 'utils.lua')

local otherdirs = { 'fragments', 'xtra', 'xtras' }
local all_proglangs = { 'codap', 'none', 'pyret', 'spreadsheets', 'wescheme' }

local pathway_independent_adocs = dofile(os.getenv 'SETUP_PATHWAYINDEPENDENT')
local workbook_page_adocs = dofile(os.getenv 'SETUP_WORKBOOKPAGE')
local lesson_plan_adocs = dofile(os.getenv 'SETUP_LESSONPLAN')
local pathway_resource_adocs = dofile(os.getenv 'SETUP_PATHWAYRESOURCE')
local pathway_narrative_adocs = dofile(os.getenv 'SETUP_PATHWAYNARRATIVE')

local adocables_input_o = io.open(os.getenv 'ADOCABLES_INPUT', 'a')
local adoc_input_o = io.open(os.getenv 'ADOC_INPUT', 'a')
local adoc_postproc_pathway_independent_input_o = io.open(os.getenv 'ADOC_POSTPROC_PATHWAYINDEPENDENT_INPUT', 'a')
local adoc_postproc_workbook_page_input_o = io.open(os.getenv 'ADOC_POSTPROC_WORKBOOKPAGE_INPUT', 'a')
local adoc_postproc_lesson_plan_input_o = io.open(os.getenv 'ADOC_POSTPROC_LESSONPLAN_INPUT', 'a')
local adoc_postproc_pathway_resource_input_o = io.open(os.getenv 'ADOC_POSTPROC_PATHWAYRESOURCE_INPUT', 'a')
local adoc_postproc_pathway_narrative_input_o = io.open(os.getenv 'ADOC_POSTPROC_PATHWAYNARRATIVE_INPUT', 'a')

function get_distrootdir(me)
  return me:gsub('distribution/.-/', ''):gsub('[^/]', ''):gsub('/', '../')
end

for _,adocfile in ipairs(pathway_independent_adocs) do
  local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
  local distrootdir = get_distrootdir(adocfile)
  local adocbasename = adocfile:gsub('^.*/', '')
  local ascfile = containingdirectory .. '/.cached/.' .. adocbasename:gsub('%.adoc$', '.asc')
  local htmlfile = ascfile:gsub('%.asc', '.html')
  local solutionsmodearg = '#f'
  if adocfile:match('/solution%-pages/') then
    solutionsmodearg = '#t'
  end
  adocables_input_o:write('("', adocbasename, '" ', '#:containing-directory "', containingdirectory, '" ', '#:dist-root-dir "', distrootdir, '")\n')
  adoc_input_o:write(ascfile, '\n')
  adoc_postproc_pathway_independent_input_o:write('   "', htmlfile, '",')
end

for _,adocfile in ipairs(workbook_page_adocs) do
  local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
  local lessondirectory = containingdirectory:gsub('(.*/lessons/.-)/.*', '%1')
  if file_exists_p(lessondirectory .. '/.proglang-ignore') then
    goto continue
  end
  local distrootdir = get_distrootdir(adocfile)
  local adocbasename = adocfile:gsub('^.*/', '')
  local ascfile = containingdirectory .. '/.cached/.' .. adocbasename:gsub('%.adoc$', '.asc')
  local whtmlfile = containingdirectory .. '/' .. adocbasename:gsub('%.adoc$', '.html')
  local htmlfile = ascfile:gsub('%.asc', '.html')
  local otherdirarg = '#f'
  for _,otherdir in ipairs(otherdirs) do
    if adocfile:match(otherdir) then
      otherdirarg = '#t'; break
    end
  end
  local solutionsmodearg = '#f'
  if adocfile:match('/solution%-pages/') then
    solutionsmodearg = '#t'
  end
  local lesson = lessondirectory:gsub('.*/', '')

  local proglangarg = 'pyret'
  for _,proglang in ipairs(all_proglangs) do
    local f = lessondirectory .. '.cached/.proglang-' .. proglang
    if file_exists_p(f) then
      proglangarg = proglang; break
    end
  end

  adocables_input_o:write('("', adocbasename, '" #:containing-directory "', containingdirectory, '" #:dist-root-dir "', distrootdir, '" #:lesson "', lesson, '" #:other-dir ', otherdirarg, ' #:solutions-mode? ', solutionsmodearg, ' #:proglang "', proglangarg, '")\n')

  if otherdirarg ~= '#t' then
    adoc_input_o:write(ascfile, '\n')
    adoc_postproc_workbook_page_input_o:write('   "', htmlfile , '",\n')
  end

  ::continue::
end

for _,adocfile in ipairs(lesson_plan_adocs) do
  local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
  if file_exists_p(containingdirectory .. '/.proglang-ignore') then
    goto continue
  end
  local distrootdir = get_distrootdir(adocfile)
  local adocbasename = adocfile:gsub('^.*/', '')
  local ascfile = containingdirectory .. '/.cached/.' .. adocbasename:gsub('%.adoc$', '.asc')

  local htmlfile = ascfile:gsub('%.asc', '.html')
  local solutionsmodearg = '#f'
  if adocfile:match('/solution%-pages/') then
    solutionsmodearg = '#t'
  end

  local lesson = containingdirectory:gsub('.-/lessons/([^/]*).*', '%1')

  local proglangarg = 'pyret'
  for _,proglang in ipairs(all_proglangs) do
    local f = containingdirectory .. '/.cached/.proglang-' .. proglang
    if file_exists_p(f) then
      proglangarg = proglang; break
    end
  end

  otherproglangs=''

  proglangfile = containingdirectory .. '/proglang.txt'

  if file_exists_p(proglangfile) then
    local h = io.open(proglangfile)
    while true do
      local pl = h:read()
      if not pl then break end
      otherproglangs = otherproglangs .. ' "' .. pl .. '"'
    end

  end

  touch(containingdirectory .. '/.cached/.index-standards.asc')

  adocables_input_o:write('("', adocbasename, '" #:containing-directory "', containingdirectory, '" #:dist-root-dir "', distrootdir, '" #:lesson-plan "', lesson,  '" #:proglang "', proglangarg, '" #:other-proglangs `(' .. otherproglangs .. '))\n')

  adoc_input_o:write(ascfile, '\n')
  adoc_postproc_lesson_plan_input_o:write('   "', htmlfile, '",\n')
  ::continue::
end

for _,adocfile in ipairs(pathway_resource_adocs) do
  local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
  local distrootdir = get_distrootdir(adocfile)
  local adocbasename = adocfile:gsub('^.*/', '')
  local ascfile = containingdirectory .. '/.cached/.' .. adocbasename:gsub('%.adoc$', '.asc')

  local htmlfile = ascfile:gsub('%.asc', '.html')

  local otherdirarg = '#f'
  for _,otherdir in ipairs(otherdirs) do
    if adocfile:match(otherdir) then
      otherdirarg = '#t'; break
    end
  end

  local solutionsmodearg = '#f'
  if adocfile:match('/solution%-pages/') then
    solutionsmodearg = '#t'
  end

  local resourcesarg='#f'

  if adocfile:match('/resources/') then
    resourcesarg='#t'
  end

  local targetpathway = containingdirectory:gsub('.-/courses/([^/]*).*', '%1')

  local proglangarg = 'pyret'
  for _,proglang in ipairs(all_proglangs) do
    local f = 'distribution/' .. os.getenv('NATLANG') .. '/courses/' .. targetpathway .. '/.cached/.proglang-' .. proglang
    if file_exists_p(f) then
      proglangarg = proglang; break
    end
  end

  adocables_input_o:write('("', adocbasename, '" #:containing-directory "', containingdirectory, '" #:dist-root-dir "', distrootdir, '" #:other-dir ', otherdirarg, ' #:resources ', resourcesarg, ' #:target-pathway "', targetpathway, '" #:solutions-mode? ', solutionsmodearg, ' #:proglang "', proglangarg, '")\n')

  if otherdirarg ~= '#t' then

    adoc_input_o:write(ascfile, '\n')

    if resourcesarg == '#t' and adocbasename == 'index.adoc' and distrootdir == '../../../' then
      adoc_postproc_pathway_resource_input_o:write('   "', htmlfile, '",\n')
    else
      adoc_postproc_workbook_page_input_o:write('   "', htmlfile, '",\n')
    end
  end
  ::continue::
end

for _,adocfile in ipairs(pathway_narrative_adocs) do
  local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
  local distrootdir = get_distrootdir(adocfile)
  local adocbasename = adocfile:gsub('^.*/', '')
  local ascfile = containingdirectory .. '/.cached/.' .. adocbasename:gsub('%.adoc$', '.asc')

  local htmlfile = ascfile:gsub('%.asc', '.html')

  local solutionsmodearg = '#f'
  if adocfile:match('/solution%-pages/') then
    solutionsmodearg = '#t'
  end

  local targetpathway = containingdirectory:gsub('.-/courses/([^/]*).*', '%1')

  local proglangarg = 'pyret'
  for _,proglang in ipairs(all_proglangs) do
    local f = 'distribution/' .. os.getenv('NATLANG') .. '/courses/' .. targetpathway .. '/.cached/.proglang-' .. proglang
    if file_exists_p(f) then
      proglangarg = proglang; break
    end
  end

  otherproglangs=''

  proglangfile = containingdirectory .. '/proglang.txt'

  if file_exists_p(proglangfile) then
    local h = io.open(proglangfile)
    while true do
      local pl = h:read()
      if not pl then break end
      otherproglangs = otherproglangs .. ' "' .. pl .. '"'
    end

  end

  adocables_input_o:write('("', adocbasename, '" #:containing-directory "', containingdirectory, '" #:dist-root-dir "', distrootdir, '" #:narrative #t #:target-pathway "',  targetpathway,     '" #:proglang "', proglangarg, '" #:other-proglangs `(', otherproglangs, '))\n')

  adoc_input_o:write(ascfile, '\n')

  adoc_postproc_pathway_narrative_input_o:write('   "', htmlfile, '",\n')
  ::continue::
end

adocables_input_o:close()
adoc_input_o:close()
adoc_postproc_pathway_independent_input_o:close()
adoc_postproc_workbook_page_input_o:close()
adoc_postproc_lesson_plan_input_o:close()
adoc_postproc_pathway_resource_input_o:close()
adoc_postproc_pathway_narrative_input_o:close()
