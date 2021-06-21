#lang racket

(require "utils.rkt")
(require "html-tag-gen.rkt")

(provide
  print-lessons-intro
  print-other-resources-intro
  print-link-to-glossary
  print-link-to-standards
  print-link-to-student-workbook
  print-link-to-teacher-resources
  print-link-to-forum
  print-standards-js
  print-menubar
  )

(define (print-lessons-intro o)
  (display
    (string-append
      "\n"
      "We provide all of our materials _free of charge_,\n"
      "to anyone who is interested in using our lesson plans or student\n"
      "workbooks.\n"
      "\n"
      "== Lesson Plans\n\n") o))

(define (print-other-resources-intro o)
  (display
    (string-append
      "== Other Resources\n"
      "\n"
      "Of course, there's more to a curriculum than software\n"
      "and lesson plans! We also provide a number of resources to educators,\n"
      "including standards alignment, a complete student workbook, an answer\n"
      "key for the programming exercises and a forum where they can ask\n"
      "questions and share ideas.\n"
      "\n"
      "[.pathway_external_links]\n") o))

(define (print-link-to-glossary o)
  (display
    (string-append
      "\n- link:./.pathway-glossary.shtml[Glossary]\n"
      "-- A list of vocabulary words used in this pathway.\n") o))

(define (print-link-to-standards o)
  (display
    (string-append
      "\n- link:./.pathway-standards.shtml[Standards Alignment]\n"
      "-- Find out how our materials align with Common Core Content\n"
      "and Practice Standards, as well as the TEK and CSTA Standards.\n")
    o))

(define (print-link-to-student-workbook o)
  (display
    (string-append
      "\n- link:./workbook/workbook.pdf[Student Workbook]\n"
      "-- Sometimes, the best way for students to get real thinking done\n"
      "is to step away from the keyboard! Our lesson plans are tightly integrated\n"
      "with the Student Workbook, allowing for paper-and-pencil practice and\n"
      "activities that don't require a computer.\n") o))

(define (print-link-to-teacher-resources o)
  (display
    (string-append
      "\n- link:./resources/index.shtml[Teacher-Only Resources]\n"
      "-- We also offer several teachers-only materials, including an\n"
      "answer key to the student workbook, a quick-start guide to making the final\n"
      "project, and pre- and post-tests for teachers who are participating in our\n"
      "research study. For access to these materials, please fill out the\n"
      "link:https://docs.google.com/a/bootstrapworld.org/spreadsheet/viewform?formkey=dHpQc0VHV2dBU2tSN1ptMktBUmtoZWc6MQ#gid=0[password request form].\n"
      "We'll get back to you soon with the necessary login information.\n") o))

(define (print-link-to-forum o)
  (display
    (string-append
      "\n- link:https://discourse.bootstrapworld.org[Online Community (Discourse)]\n"
      "-- Want to be kept up-to-date about Bootstrap events, workshops, and curricular\n"
      "changes? Want to ask a question or pose a lesson idea for other Bootstrap\n"
      "teachers? These forums are the place to do it.\n") o))

(define (print-standards-js o)
  (display
    (string-append
      "\n++++\n"
      "<script>\n"
      "function showStandardsAlignment() {\n"
      "  const selectTag = document.getElementsByClassName('standardsAlignmentSelect')[0];\n"
      "  const options = selectTag && selectTag.options;\n"
      "  const stdTables = document.getElementsByClassName('alignedStandards');\n"
      "  const intro = document.getElementsByClassName('alignedStandardsIntro')[0];\n"
      "  let introNeeded = true;\n"
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
      "          introNeeded = false;\n"
      "        }\n"
      "      }\n"
      "    }\n"
      "  }\n"
      "  intro.style.display = introNeeded ? 'block' : 'none';\n"
      "}\n"
      "// %ENDSIDEBARSCRIPT%\n"
      "</script>\n"
      "++++\n\n") o))

(define (print-menubar f)
  ;(printf "print-menubar ~s\n" f)
  (call-with-output-file f
    (lambda (o)
      (display "<!--#include virtual=\"/menubar.ssi\"-->\n" o))
    #:exists 'replace))
