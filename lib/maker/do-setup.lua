#! /usr/bin/env lua

dofile(os.getenv'TOPDIR' .. '/' .. os.getenv'MAKE_DIR' .. 'utils.lua')

local natlang = os.getenv'NATLANG'

local otherdirs = { 'fragments', 'xtra', 'xtras' }
local all_proglangs = { 'codap', 'none', 'pyret', 'spreadsheets', 'wescheme' }

local pathways_to_ignore = {
  '__sample',
  '__sample-codap',
  '__sample-wescheme',
  -- 'zample'
}

local pathwayindependent_adocs = dofile(os.getenv 'SETUP_PATHWAYINDEPENDENT')
local workbookpage_adocs = dofile(os.getenv 'SETUP_WORKBOOKPAGE')
local lessonplan_adocs = dofile(os.getenv 'SETUP_LESSONPLAN')
local pathwayresource_adocs = dofile(os.getenv 'SETUP_PATHWAYRESOURCE')
local pathwaynarrative_adocs = dofile(os.getenv 'SETUP_PATHWAYNARRATIVE')
local ignorable_directories = dofile(os.getenv 'IGNORABLE_DIRECTORIES')

local adocables_input_o = io.open(os.getenv 'ADOCABLES_INPUT', 'w')
local adoc_input_o = io.open(os.getenv 'ADOC_INPUT', 'w')
local adoc_postproc_pathwayindependent_input_o = io.open(os.getenv 'ADOC_POSTPROC_PATHWAYINDEPENDENT_INPUT', 'w')
local adoc_postproc_workbookpage_input_o = io.open(os.getenv 'ADOC_POSTPROC_WORKBOOKPAGE_INPUT', 'w')
local adoc_postproc_lessonplan_input_o = io.open(os.getenv 'ADOC_POSTPROC_LESSONPLAN_INPUT', 'w')
local adoc_postproc_pathwayresource_input_o = io.open(os.getenv 'ADOC_POSTPROC_PATHWAYRESOURCE_INPUT', 'w')
local adoc_postproc_pathwaynarrative_input_o = io.open(os.getenv 'ADOC_POSTPROC_PATHWAYNARRATIVE_INPUT', 'w')

adoc_postproc_pathwayindependent_input_o:write('return {\n')
adoc_postproc_workbookpage_input_o:write('return {\n')
adoc_postproc_lessonplan_input_o:write('return {\n')
adoc_postproc_pathwayresource_input_o:write('return {\n')
adoc_postproc_pathwaynarrative_input_o:write('return {\n')

local function get_distrootdir(me)
  return me:gsub('distribution/.-/', ''):gsub('[^/]', ''):gsub('/', '../')
end

local function first_n_lines_contain(file, n, pat)
  local i = io.open(file, 'r')
  if not i then return false end
  local m = 0
  while m < n do
    local L = i:read()
    if not L then i:close(); return false end
    if L:match(pat) then return true end
    m = m + 1
  end
  return false
end

for _,adocfile in ipairs(pathwayindependent_adocs) do
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
  adoc_postproc_pathwayindependent_input_o:write('"', htmlfile, '",\n')
end

for _,adocfile in ipairs(workbookpage_adocs) do
  local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
  local lessondirectory = containingdirectory:gsub('(.*/lessons/.-)/.*', '%1')
  if memberp(lessondirectory, ignorable_directories) then
    goto continue
  end
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
  local lesson = lessondirectory:gsub('.*/', '')

  local proglangarg = 'pyret'
  for _,proglang in ipairs(all_proglangs) do
    local f = lessondirectory .. '/.cached/.proglang-' .. proglang
    if file_exists_p(f) then
      proglangarg = proglang; break
    end
  end

  adocables_input_o:write('("', adocbasename, '" #:containing-directory "', containingdirectory, '" #:dist-root-dir "', distrootdir, '" #:lesson "', lesson, '" #:other-dir ', otherdirarg, ' #:solutions-mode? ', solutionsmodearg, ' #:proglang "', proglangarg, '")\n')

  if otherdirarg ~= '#t' then
    adoc_input_o:write(ascfile, '\n')
    adoc_postproc_workbookpage_input_o:write('"', htmlfile , '",\n')
  end

  ::continue::
end

local distrootdir = "../../"

for _,adocfile in ipairs(lessonplan_adocs) do
  local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
  if memberp(containingdirectory, ignorable_directories) then
    goto continue
  end
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
  adoc_postproc_lessonplan_input_o:write('"', htmlfile, '",\n')
  ::continue::
end

for _,adocfile in ipairs(pathwayresource_adocs) do
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
    local f = 'distribution/' .. natlang .. '/courses/' .. targetpathway .. '/.cached/.proglang-' .. proglang
    if file_exists_p(f) then
      proglangarg = proglang; break
    end
  end

  adocables_input_o:write('("', adocbasename, '" #:containing-directory "', containingdirectory, '" #:dist-root-dir "', distrootdir, '" #:other-dir ', otherdirarg, ' #:resources ', resourcesarg, ' #:target-pathway "', targetpathway, '" #:solutions-mode? ', solutionsmodearg, ' #:proglang "', proglangarg, '")\n')

  if otherdirarg ~= '#t' then

    adoc_input_o:write(ascfile, '\n')

    if resourcesarg == '#t' and adocbasename == 'index.adoc' and distrootdir == '../../../' then
      adoc_postproc_pathwayresource_input_o:write('"', htmlfile, '",\n')
    else
      adoc_postproc_workbookpage_input_o:write('"', htmlfile, '",\n')
    end
  end
  ::continue::
end

distrootdir = '../../'

for _,adocfile in ipairs(pathwaynarrative_adocs) do
  local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
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
    local f = 'distribution/' .. natlang .. '/courses/' .. targetpathway .. '/.cached/.proglang-' .. proglang
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

  adoc_postproc_pathwaynarrative_input_o:write('"', htmlfile, '",\n')
  ::continue::
end

local book_p = os.getenv 'BOOK'

if book_p == '' then book_p = false end

if book_p then

  local pathwayindependent_adocs_4pdf = dofile(os.getenv 'SETUP_PATHWAYINDEPENDENT_PDF')
  local workbookpage_adocs_4pdf = dofile(os.getenv 'SETUP_WORKBOOKPAGE_PDF')
  local lessonplan_adocs_4pdf = dofile(os.getenv 'SETUP_LESSONPLAN_PDF')
  local pathwayresource_adocs_4pdf = dofile(os.getenv 'SETUP_PATHWAYRESOURCE_PDF')
  local contracts_pdfs = dofile(os.getenv 'SETUP_CONTRACTS_PDF')

  local puppeteer_input_o = io.open(os.getenv 'PUPPETEER_INPUT', 'w')

  puppeteer_input_o:write('{ "htmlFileSpecs": [ "ignoreElement"\n')

  for _,adocfile in ipairs(pathwayindependent_adocs_4pdf) do
    local whtmlfile = adocfile:gsub('%.adoc$', '.html')
    puppeteer_input_o:write(', { "input": "', whtmlfile, '"}\n')
  end

  for _,adocfile in ipairs(workbookpage_adocs_4pdf) do
    -- print('trying', adocfile)
    local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
    local lessondirectory = containingdirectory:gsub('(.*/lessons/.-)/.*', '%1')
    if memberp(lessondirectory, ignorable_directories) then
      -- print('skipping', adocfile)
      goto continue
    end
    local whtmlfile = adocfile:gsub('%.adoc$', '.html')
    local aspect = 'portrait'
    if first_n_lines_contain(adocfile, 5, '%[%.landscape%]') then
      aspect = 'landscape'
    end
    local otherdirarg = false
    for _,otherdir in ipairs(otherdirs) do
      if adocfile:match(otherdir) then
        otherdirarg = true; break
      end
    end

    if not otherdirarg  then
      puppeteer_input_o:write(', { "input": "', whtmlfile, '", "aspect": "', aspect, '" }\n')
    end

    ::continue::
  end

  for _,adocfile in ipairs(lessonplan_adocs_4pdf) do
    local containingdirectory = adocfile:gsub('^(.*)/.*', '%1')
    if memberp(containingdirectory, ignorable_directories) then
      goto continue
    end
    local whtmlfile = adocfile:gsub('%.adoc$', '.shtml')

    puppeteer_input_o:write(', { "input": "', whtmlfile, '", "aspect": "portrait" }\n')
    ::continue::
  end

  for _,adocfile in ipairs(pathwayresource_adocs_4pdf) do
    local adocbasename = adocfile:gsub('^.*/', '')

    local resourcesarg='#f'

    if adocfile:match('/resources/') then
      resourcesarg='#t'
    end

    local otherdirarg = false
    for _,otherdir in ipairs(otherdirs) do
      if adocfile:match(otherdir) then
        otherdirarg = true; break
      end
    end

    local whtmlfile = adocfile:gsub('%.adoc$', '.html')

    if not otherdirarg then
      if adocfile:match('/resources/index%.adoc$') then
        whtmlfile = adocfile:gsub('%.adoc$', '.shtml')
      end

      puppeteer_input_o:write(', { "input": "', whtmlfile, '"}\n')

    end

  end

  for _,pdffile in ipairs(contracts_pdfs) do
    local targetpathway = pdffile:gsub('/resources/pages/Contracts%.pdf', ''):gsub('.*/courses/', '')

    if not memberp(targetpathway, pathways_to_ignore) then
      local inputfile = 'distribution/' .. natlang .. '/Contracts.shtml?pathway=' .. targetpathway
      local outputfile = 'distribution/' .. natlang .. '/courses/' .. targetpathway .. '/resources/pages/Contracts.pdf'
      puppeteer_input_o:write(', { "input": "', inputfile, '", "output": "', outputfile, '" }\n')
      --solution
      inputfile = inputfile .. '&solns=true'
      outputfile = outputfile:gsub('/pages/Contracts%.pdf$', '/solution-pages/Contracts.pdf')
      puppeteer_input_o:write(', { "input": "', inputfile, '", "output": "', outputfile, '" }\n')
    end

  end

  puppeteer_input_o:write('] }\n')
  puppeteer_input_o:close()

end

adoc_input_o:close()

adocables_input_o:close()

adoc_postproc_pathwayindependent_input_o:write('}\n')
adoc_postproc_workbookpage_input_o:write('}\n')
adoc_postproc_lessonplan_input_o:write('}\n')
adoc_postproc_pathwayresource_input_o:write('}\n')
adoc_postproc_pathwaynarrative_input_o:write('}\n')

adoc_postproc_pathwayindependent_input_o:close()
adoc_postproc_workbookpage_input_o:close()
adoc_postproc_lessonplan_input_o:close()
adoc_postproc_pathwayresource_input_o:close()
adoc_postproc_pathwaynarrative_input_o:close()
