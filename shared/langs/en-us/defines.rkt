#lang racket

(provide
  print-lessons-intro
  print-other-resources-intro
  print-link-to-glossary
  print-link-to-standards
  print-link-to-student-workbook
  print-link-to-teacher-resources
  print-link-to-forum
  )

(define (print-lessons-intro o)
  (fprintf o "We provide all of our materials _free of charge_,
to anyone who is interested in using our lesson plans or student
workbooks.

== Lesson Plans\n
[#lesson-list]\n"))

(define (print-other-resources-intro o)
  (fprintf o "== Other Resources\nOf course, there's more to a curriculum than software
and lesson plans! We also provide a number of resources to educators,
including standards alignment, a complete student workbook, an answer
key for the programming exercises and a forums where they can ask
questions and share ideas.

[.pathway_external_links]\n"))

(define (print-link-to-glossary o)
  (fprintf o "\n- link:./index-glossary.html[Glossary]\n")
  (fprintf o "-- A list of vocabulary words used in this pathway.\n"))

(define (print-link-to-standards o)
  (fprintf o "\n- link:./index-standards.html[Standards Alignment]\n")
  (fprintf o "-- Find out how our materials align with Common Core Content
  and Practice Standards, as well as the TEK and CSTA Standards.\n"))

(define (print-link-to-student-workbook o)
  (fprintf o "\n- link:./workbook/workbook.pdf[Student Workbook]\n")
  (fprintf o "-- Sometimes, the best way for students to get real thinking done is to step away from the keyboard! Our lesson plans are tightly integrated with the Student Workbook, allowing for paper-and-pencil practice and activities that don't require a computer.\n"))

(define (print-link-to-teacher-resources o)
  (fprintf o "\n- link:./resources/index.html[Teacher-Only Resources]\n")
  (fprintf o "-- We also offer several teachers-only materials, including an
answer key to the student workbook, a quick-start guide to making the final
project, and pre- and post-tests for teachers who are participating in our
research study. For access to these materials, please fill out the
link:https://docs.google.com/a/bootstrapworld.org/spreadsheet/viewform?formkey=dHpQc0VHV2dBU2tSN1ptMktBUmtoZWc6MQ#gid=0[password request form]. We'll get back to you soon with the necessary
login information.\n"))

(define (print-link-to-forum o)
  (fprintf o "\n- link:https://discourse.bootstrapworld.org[Bootstrap Discussion Forum]\n")
  (fprintf o "-- Want to be kept up-to-date about Bootstrap events, workshops, and curricular
changes? Want to ask a question or pose a lesson idea for other Bootstrap
teachers? These forums are the place to do it.\n")
  )
