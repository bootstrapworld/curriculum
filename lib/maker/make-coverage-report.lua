#! /usr/bin/env lua

local coverage_report_file = ...

local make_dir = 'lib/maker/'

dofile(make_dir .. 'read-alignments.lua')

local o = io.open(coverage_report_file, 'w+')

local function print_coverage_script_n_style()
  o:write('++++\n')
  o:write([[
  <style>
  .unused { background-color: #ffdddd; }
  .via_standards_dict { background-color: #ffffdd; }
  .via_objectives_dict_only { background-color: #ddffdd; }
  .coverageElement { display: none; }
  .coverageAlignmentSelect { width: 30%; display: inline-block; }
  #showUncoveredStandards { display: inline-block; }

  td:first-child { white-space: pre; }
  </style>

  <style id="unused-toggle">
    tr:has(p.unused) { display: table-row; }
  </style>

  <script>
  function preselect(klass) {
    const items = document.getElementsByClassName(klass);
    if (items.length > 0) {
      items[0].style.display = 'block';
    }
  }

  window.onload = function() {
    preselect('coverageElement');
  }

  function sanitizeCSSId(id) {
    return id.replace(/[. ]/g, '_');
  }

  function showCoverageAlignment() {
    const selectTag = document.getElementsByClassName('coverageAlignmentSelect')[0];
    const options = selectTag && selectTag.options;
    if(!options) return;
      const stdTables = document.getElementsByClassName('coverageElement');
      for (let i = 0; i < stdTables.length; i++) {
        const stdTable = stdTables[i];
        stdTable.style.display = 'none';
      }
      for (let i = 0; i < options.length; i++) {
        const opt = options[i];
        if (opt.selected) {
          const optStd = sanitizeCSSId(opt.value);
          for (let j = 0; j < stdTables.length; j++) {
            const stdTable = stdTables[j];
            if (stdTable.classList.contains(optStd)) {
              stdTable.style.display = 'block';
            }
          }
        }
      }
    }

    function toggleUncoveredLessonDisplay() {
      const checked = document.querySelector("#showUncoveredStandards input").checked;
      const styleBlock = document.getElementById('unused-toggle');
      const rule = styleBlock.sheet.cssRules[0];
      rule.style.display = checked? 'table-row' : 'none';
    }
    </script>
    ]])
    o:write('\n++++\n')
end

local function display_selection()
  o:write('++++\n')
  o:write([[
    <div id="showUncoveredStandards">
      <input type="checkbox" name="showUncoveredStandards" checked onchange="toggleUncoveredLessonDisplay()" />
      <label for="showUncoveredStandards">Show Un-Covered Standards for</label>
    </div>
    ]])
  o:write('<select class="coverageAlignmentSelect" onchange="showCoverageAlignment()">\n')
  --
  o:write('<optgroup label="Standards">\n')
  for _,categ in ipairs(standards_list) do
    o:write('<option>' .. categ[1] .. '</option>')
  end
  o:write('</optgroup>\n')
  --
  o:write('<optgroup label="Textbooks">\n')
  for _,categ in ipairs(textbooks_list) do
    o:write('<option>' .. categ[1] .. '</option>')
  end
  o:write('</optgroup>\n')
  --
  o:write('<optgroup label="Practices">\n')
  for _,categ in ipairs(practices_list) do
    o:write('<option>' .. categ[1] .. '</option>')
  end
  o:write('</optgroup>\n')
  --
  o:write('</select>\n')
  o:write('++++\n')
end

local function display_subreport(dictionaries, standard_to_lessons_map)
  for _,dictionary in ipairs(dictionaries) do
    -- each dictionary is an array { nickname, expanded_name, dict_obj, url }
    -- each dict_obj is a json-hash mapping label to { description = string, lessons = array }
    --
    -- replace all dots & spaces in nickname by underscore so it's a valid css class name
    local nickname = dictionary[1]:gsub('[%.%s]', '_')
    o:write('[.coverageElement.' .. nickname .. ']\n')
    o:write('[cols="1a,2a,7a"]\n')
    o:write('|===\n')
    local dict_obj = dictionary[3]
    for _,lbl in ipairs(dict_obj.__json_keys) do
      local entry = dict_obj[lbl]
      local desc = entry.description:gsub('|', '&#x7c;')
      local lessons = entry.lessons
      local lessons_via_objectives
      if standard_to_lessons_map then
        lessons_via_objectives = standard_to_lessons_map[lbl] or {}
      else
        lessons_via_objectives = {}
      end
      local lessons_via_objectives_only = {}
      for _,lesson in ipairs(lessons_via_objectives) do
        if not memberp(lesson, lessons) then
          table.insert(lessons_via_objectives_only, lesson)
        end
      end
      local count = #lessons + #lessons_via_objectives_only
      if count == 0 then
        o:write('| [.unused]#' .. lbl .. '# ')
        o:write('| [.unused]#none# ')
        o:write('| [.unused]#' .. desc .. '#\n')
      else
        o:write('| ' .. lbl .. ' ')
        o:write('| ')
        if #lessons > 0 then
          if standard_to_lessons_map then
            o:write('[.via_standards_dict]#')
          end
          o:write(table.concat(lessons, ', '))
          if standard_to_lessons_map then
            o:write('#')
          end
          if #lessons_via_objectives_only > 0 then
            o:write(', ')
          end
        end
        if #lessons_via_objectives_only > 0 then
          o:write('[.via_objectives_dict_only]#')
          o:write(table.concat(lessons_via_objectives, ', '))
          o:write('#')
        end
        o:write(' (' .. count .. ') ')
        o:write('| ' .. desc .. '\n')
      end
    end
    o:write('|===\n\n')
  end
end

o:write('= Coverage Report\n\n')
o:write('Each line shows the name of the standard/practice/textbook followed by the number of times it\'s used.\n')
o:write('If a standard is not used at all, the line is highlighted in [.unused]#red#.\n')
o:write('If a lesson is not explicity associated a standard, but is associated with a related objective, it is highlighted in [.via_objectives_dict_only]#green#.\n')
o:write('\n')

local objectives_list = read_json_file('distribution/en-us/lib/learningObjectives.js')

local standard_to_objectives_map = {}

for objective,hashob in pairs(objectives_list) do
  local hashob_standards = hashob.standards or {}
  for _,std in ipairs(hashob_standards) do
    if not standard_to_objectives_map[std] then
      standard_to_objectives_map[std] = {}
    end
    table.insert(standard_to_objectives_map[std], objective)
  end
end

local objective_to_lessons_map = {}

for _,lsn in ipairs(shell_output('ls distribution/en-us/lessons')) do
  local lesson_objectives_file = 'distribution/en-us/lessons/' .. lsn .. '/.cached/.index-objectives.txt.kp'
  if file_exists_p(lesson_objectives_file) then
    local i = io.open(lesson_objectives_file)
    for obj in i:lines() do
      if not objective_to_lessons_map[obj] then
        objective_to_lessons_map[obj] = {}
      end
      table.insert(objective_to_lessons_map[obj], lsn)
    end
    i:close()
  end
end

local standard_to_lessons_map = {}

for std,objs in pairs(standard_to_objectives_map) do
  if not standard_to_lessons_map[std] then
    standard_to_lessons_map[std] = {}
  end
  for _,obj in ipairs(objs) do
    local obj_lsns = objective_to_lessons_map[obj] or {}
    for _,lsn in ipairs(obj_lsns) do
      table.insert(standard_to_lessons_map[std], lsn)
    end
  end
end

print_coverage_script_n_style()
display_selection()
display_subreport(standards_list, standard_to_lessons_map)
display_subreport(textbooks_list)
display_subreport(practices_list)

o:close()
