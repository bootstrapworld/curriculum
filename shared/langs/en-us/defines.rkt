#lang racket

(require "utils.rkt")
(require "html-tag-gen.rkt")
(require "course-specifics.rkt")

(provide
  print-lessons-intro
  print-course-logo
  print-other-resources-intro
  print-teach-remotely
  print-ordering-workbooks
  print-link-to-glossary
  print-link-to-standards
  print-link-to-student-workbook
  print-link-to-teacher-resources
  print-link-to-forum
  ; print-standards-js
  ; print-textbooks-js
  ; print-menubar
  )

(define (print-lessons-intro o)
  (display
    (string-append
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
      "\n- link:./pathway-glossary.shtml[Glossary]\n"
      "-- A list of vocabulary words used in this pathway.\n") o))

(define (print-teach-remotely o)
  (display
    (string-append
      "== Teaching Remotely?\n"
      "\n"
      "If you're teaching remotely, we've assembed an link:../../ImplementationNotes.shtml[Implementation Notes] page that makes\n"
      "specific recommendations for in-person v. remote instruction.\n"
      "\n") o))

(define (print-course-logo course make-image o)
  ; (printf "doing print-course-logo ~s\n" course)
  (display
    (let* ([c (assoc course *course-names*)]
          [course-name (if c (cadr c) "Bootstrap")])
      (string-append
        "= "
        course-name "\n\n"
        "[.logo]\n"
        (make-image "images/Logo.png" (list (if c (cadr c) "Bootstrap")))
        "\n\n")) o))

(define (print-ordering-workbooks course o)
  (display
    (string-append
      "== Ordering Student Workbooks?\n"
      "\n"
      "While we give our workbooks away as a PDF (see below), we understand that printing them yourself can be expensive!\n"
      "You can purchase beautifully-bound copies of the student workbook from Lulu.com.\n"
      "link:"
      (let ([c (assoc course *lulu-links*)])
        (if c (cadr c) "missing-link"))
      "[Click here to order].\n"
      "\n") o))

(define (print-link-to-standards o)
  (display
    (string-append
      "\n- link:./pathway-standards.shtml[Standards Alignment]\n"
      "-- Find out how our materials align with Common Core Content\n"
      "and Practice Standards, as well as the TEK and CSTA Standards.\n")
    o))

(define (print-link-to-student-workbook o)
  (display
    (string-append
      "\n- link:./workbook/workbook.pdf[Workbook]\n"
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

