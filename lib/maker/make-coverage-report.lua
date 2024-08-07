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
  .coverageElement { display: none; }
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
    </script>
    ]])
    o:write('\n++++\n')
end

local function display_selection()
  o:write('++++\n')
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

local function display_subreport(dictionaries)
  for _,dictionary in ipairs(dictionaries) do
    -- each dictionary is an array of: nickname, expanded_name, dict_obj, url)
    -- each dict_obj is a hash mapping label to { description = string, lessons = array }
    --
    -- replace all dots and spaces in label by underscore so it's a valid css class name
    local nickname = dictionary[1]:gsub('[%.%s]', '_')
    o:write('[.coverageElement.' .. nickname .. ']\n')
    o:write('[cols="2a,1a,7a"]\n')
    o:write('|===\n')
    local dict_obj = dictionary[3]
    for _,lbl in ipairs(dict_obj.__json_keys) do
      local entry = dict_obj[lbl]
      local desc = entry.description:gsub('|', '&#x7c;')
      local lessons = entry.lessons
      local count = #lessons
      if count == 0 then
        o:write('| [.unused]#' .. lbl .. '# ')
        o:write('| [.unused]#none# ')
        o:write('| [.unused]#' .. desc .. '#\n')
      else
        o:write('| ' .. lbl .. ' ')
        o:write('| ' .. table.concat(lessons, ', ') .. ' (' .. count .. ') ')
        o:write('| ' .. desc .. '\n')
      end
    end
    o:write('|===\n\n')
  end
end

o:write('= Coverage Report\n\n')
o:write('Each line shows the name of the standard/practice/textbook followed by the number of times it\'s used.\n')
o:write('If a standard is not used at all, the line is highlighted in red.\n\n')

print_coverage_script_n_style()
display_selection()
display_subreport(standards_list)
display_subreport(textbooks_list)
display_subreport(practices_list)

o:close()
