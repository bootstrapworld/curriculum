#lang racket

(provide print-coverage-script-n-style)

(define (print-coverage-script-n-style o)
  (display
    (string-append
      "\n++++\n"
      "<style>\n"
      ".unused { background-color: #ffdddd; }\n"
      ".coverageElement { display: none; }\n"
      "</style>\n"

      "<script>\n"
      "function preselect(klass) {\n"
      "  const items = document.getElementsByClassName(klass);\n"
      "  if (items.length > 0) {\n"
      "    items[0].style.display = 'block';\n"
      "  }\n"
      "}\n"

      "window.onload = function() {\n"
      "  preselect('coverageElement');\n"
      "}\n"

      "function showCoverageAlignment() {\n"
      "  const selectTag = document.getElementsByClassName('coverageAlignmentSelect')[0];\n"
      "  const options = selectTag && selectTag.options;\n"
      "  if(!options) return;\n"
      "  const stdTables = document.getElementsByClassName('coverageElement');\n"
      "  for (let i = 0; i < stdTables.length; i++) {\n"
      "    const stdTable = stdTables[i];\n"
      "    stdTable.style.display = 'none';\n"
      "  }\n"
      "  for (let i = 0; i < options.length; i++) {\n"
      "    const opt = options[i];\n"
      "    if (opt.selected) {\n"
      "      const optStd = opt.value;\n"
      "      for (let j = 0; j < stdTables.length; j++) {\n"
      "        const stdTable = stdTables[j];\n"
      "        if (stdTable.classList.contains(optStd)) {\n"
      "          stdTable.style.display = 'block';\n"
      "        }\n"
      "      }\n"
      "    }\n"
      "  }\n"
      "}\n"
      "</script>\n"
      "++++\n\n") o))
