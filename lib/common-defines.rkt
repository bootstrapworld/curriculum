#lang racket

(provide
  print-coverage-js
  print-standards-js
  print-menubar
  )

(define (print-coverage-js o)
  (display
    (string-append
      "\n++++\n"
      "<script>\n"

      "function preselect(klass) {\n"
      "  const items = document.getElementsByClassName(klass);\n"
      "  for (let i = 0; i < items.length; i++) {\n"
      "    items[i].style.display = 'none';\n"
      "  }\n"
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

(define (print-standards-js o)
  (display
    (string-append
      "\n++++\n"
      "<script>\n"
      "function preselect(klass) {\n"
      "  const items = document.getElementsByClassName(klass);\n"
      "  for (let i = 0; i < items.length; i++) {\n"
      "    items[i].style.display = 'none';\n"
      "  }\n"
      "  if (items.length > 0) {\n"
      "    items[0].style.display = 'block';\n"
      "  }\n"
      "}\n"
      "window.onload = function() {\n"
      "  preselect('alignedStandards');\n"
      "}\n"
      "</script>\n"
      "++++\n\n") o))

(define (print-menubar f)
  ;(printf "print-menubar ~s\n" f)
  (call-with-output-file f
    (lambda (o)
      (display "<!--#include virtual=\"/menubar.ssi\"-->\n" o))
    #:exists 'replace))
