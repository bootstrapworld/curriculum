#! /usr/bin/env lua

-- last modified 2023-03-08

local coverage_report_file = ...

dofile('lib/maker/read-alignments.lua')

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
    -- each dictionary has: nickname, expanded_name, ({std, desc, lesson, ...} ...), url)
    local opt = dictionary[1]:gsub('[%.%s]', '_')
    o:write('[.coverageElement.' .. opt .. ']\n')
    o:write('[cols="2a,1a,7a"]\n')
    o:write('|===\n')
    local entries = dictionary[3]
    for _,entry in ipairs(entries) do
      local std = entry[1]
      local desc = entry[2]:gsub('|', '&#x7c;')
      local count = #entry - 2
      if count == 0 then
        o:write('| [.unused]#' .. std .. '# ')
        o:write('| [.unused]#none# ')
        o:write('| [.unused]#' .. desc .. '#\n')
      else
        o:write('| ' .. std .. ' ')
        o:write('| ' .. table.concat(entry, ', ', 3) .. ' (' .. count .. ') ')
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
