#lang racket

(provide
  print-standards-js
  print-textbooks-js
  print-menubar
  )

(define (print-standards-js o #:sidebar [sidebar #f])
  (display
    (string-append
      "\n++++\n"
      "<script>\n"
      "function preselect(klass) {\n"
      "  const items = document.getElementsByClassName(klass);\n"
      "  if (items.length > 0) {\n"
      "    items[0].style.display = 'block';\n"
      "  }\n"
      "}\n"
      "window.onload = function() {\n"
      "  preselect('alignedStandards');\n"
      "  preselect('alignedTextbooks');\n"
      "}\n"
      "function showStandardsAlignment() {\n"
      "  const selectTag = document.getElementsByClassName('standardsAlignmentSelect')[0];\n"
      "  const options = selectTag && selectTag.options;\n"
      "  const stdTables = document.getElementsByClassName('alignedStandards');\n"
      "  //const intro = document.getElementsByClassName('alignedStandardsIntro')[0];\n"
      "  //let introNeeded = true;\n"
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
      "         // introNeeded = false;\n"
      "        }\n"
      "      }\n"
      "    }\n"
      "  }\n"
      "  //intro.style.display = introNeeded ? 'block' : 'none';\n"
      "}\n"
      (if sidebar
          (string-append
            "function toggleNonPrereqDisplay() {\n"
            "  const inputTag = document.getElementsByClassName('sidebarinput')[0];\n"
            "  const checkedP = inputTag.checked;\n"
            "  const lessonTable = document.getElementsByClassName('sidebarlessons')[0];\n"
            "  const lis = lessonTable.getElementsByTagName('li');\n"
            "  for (let i = 0; i < lis.length; i++) {\n"
            "    const li = lis[i];\n"
            "    const lesson = li.getElementsByClassName('prerequisite');\n"
            "    if (lesson.length === 0) {\n"
            "      li.style.display = checkedP ? 'none' : 'block';\n"
            "    }\n"
            "  }\n"
            "}\n")
          "")
      "</script>\n"
      "++++\n\n") o))

(define (print-textbooks-js o)
  (display
    (string-append
      "\n++++\n"
      "<script>\n"
      "function showTextbooksAlignment() {\n"
      "  const selectTag = document.getElementsByClassName('textbooksAlignmentSelect')[0];\n"
      "  const options = selectTag && selectTag.options;\n"
      "  const textbookTables = document.getElementsByClassName('alignedTextbooks');\n"
      "  //const intro = document.getElementsByClassName('alignedTextbooksIntro')[0];\n"
      "  //let introNeeded = true;\n"
      "  for (let i = 0; i < textbookTables.length; i++) {\n"
      "    const textbookTable = textbookTables[i];\n"
      "    textbookTable.style.display = 'none';\n"
      "  }\n"
      "  for (let i = 0; i < options.length; i++) {\n"
      "    const opt = options[i];\n"
      "    if (opt.selected) {\n"
      "      const optTextbook = opt.value;\n"
      "      for (let j = 0; j < textbookTables.length; j++) {\n"
      "        const textbookTable = textbookTables[j];\n"
      "        if (textbookTable.classList.contains(optTextbook)) {\n"
      "          textbookTable.style.display = 'block';\n"
      "          //introNeeded = false;\n"
      "        }\n"
      "      }\n"
      "    }\n"
      "  }\n"
      "  //intro.style.display = introNeeded ? 'block' : 'none';\n"
      "}\n"
      "</script>\n"
      "++++\n\n") o))

(define (print-menubar f)
  ;(printf "print-menubar ~s\n" f)
  (call-with-output-file f
    (lambda (o)
      (display "<!--#include virtual=\"/menubar.ssi\"-->\n" o))
    #:exists 'replace))
