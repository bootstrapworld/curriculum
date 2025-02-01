#lang racket

(require "utils.rkt")
(require "html-tag-gen.rkt")
(require "course-specifics.rkt")

(provide
  print-lessons-intro
  print-course-title-and-logo
  print-pathway-logo
  print-course-banner
  print-other-resources-intro
  print-workbook-info
  print-other-resources
  natlang:also-available-in
  ; print-teach-remotely
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

(define (print-link-to-glossary course o)
  (display
    (string-append
      "\n- link:../../Glossary.shtml?pathway=" course "[Glossary]\n"
      "-- A list of vocabulary words used in this pathway.\n"
      "We also provide a link:../../lib/bilingual-glossary.html[bilingual glossary],\n"
      "which defines all vocabulary words across our lessons in English and Spanish.") o))

#|
(define (print-teach-remotely o)
  (display
    (string-append
      "== Teaching Remotely?\n"
      "\n"
      "If you're teaching remotely, we've assembed an link:../../ImplementationNotes.shtml[Implementation Notes] page that makes\n"
      "specific recommendations for in-person v. remote instruction.\n"
      "\n") o))
|#
(define (print-course-title-and-logo course make-image store-title o)
  ; (printf "doing print-course-title-and-logo ~s\n" course)
  (let* ([c (assoc course *course-names*)]
         [course-name (if c (second c) "Bootstrap")])
    (display
      (string-append
        "= "
        course-name "\n") o)
    (store-title course-name)
    (print-pathway-logo course make-image o #:course-name course-name)))

(define (print-pathway-logo course make-image o #:course-name [course-name #f])
  ; (printf "doing print-pathway-logo\n")
  (unless course-name
    (let ([c (assoc course *course-names*)])
      (set! course-name (if c (second c) "Bootstrap"))))
  (display
    (string-append
      "\n"
      "[.logo]\n"
      (make-image "images/Logo.png" "" #:text course-name)
      "\n\n") o))

(define (print-course-banner course o)
  (let ([c (assoc course *course-banners*)])
    (when c
      (display
        (string-append
          "\n\n"
          "[.course-banner]\n"
          "--\n"
          (second c)
          "\n"
          "--"
          "\n\n") o))))

(define (print-workbook-info course o)
  (let ([c (assoc course *course-workbook-links*)])
    (display
      (string-append
        "== Student Workbooks\n"
        "\n"
        "Sometimes, the best place for students to get real thinking done\n"
        "is __away from the keyboard!__ Our lesson plans are tightly integrated\n"
        "with a detailed Student Workbook, allowing for paper-and-pencil practice and\n"
        "activities that don't require a computer.\n"
          "That's why we provide a free PDF of the link:./workbook/workbook.pdf[core workbook],"
          " as well as a link to link:./workbook/workbook-long.pdf[the book with every optional exercise included].\n"
        "\n"
        "Of course, we understand that printing them yourself can be expensive! "
         "link:"
          (if c (second c) "missing-link")
          "[Click here to purchase beautifully-bound copies of the student workbook from Lulu.com].\n"
        "\n") o)))

(define (print-link-to-standards course o)
  (display
    (string-append
      "\n- link:../../Alignments.shtml?pathway=" course "[Standards Alignment]\n"
      "-- Find out how our materials align with National and State\n"
      "Standards, as well as some of the most commonly used math\n"
      " textbooks.\n")
    o))

(define (print-link-to-contracts course o)
  (display
    (string-append
      "\n- link:../../Contracts.shtml?pathway=" course "[Contracts Reference]\n"
      "-- Complete student-facing documentation for all the functions used\n"
      "in these lessons (also printed in the back of the student workbook).\n")
    o))

(define (print-link-to-teacher-resources course o)
  (display
    (string-append
      "\n- link:./resources/index.shtml?pathway=" course "[Teacher-Only Resources]\n"
      "-- We also offer several teachers-only materials, including an\n"
      "answer key to the student workbook, keys to all the exercises,\n"
      "and pre- and post-tests for teachers who are participating in our\n"
      "research study. For access to these materials, please fill out the\n"
      "https://docs.google.com/forms/d/e/1FAIpQLSefQhHo-AA6ruZyICrx51OnJp0sU63b_Y3h05f4KZKHiUbPXw/viewform[password request form].\n"
      "We'll get back to you soon with the necessary login information.\n") o))

(define (print-link-to-forum o)
  (display
    (string-append
      "\n- link:https://discourse.bootstrapworld.org[Online Community (Discourse)]\n"
      "-- Want to be kept up-to-date about Bootstrap events, workshops, and curricular\n"
      "changes? Want to ask a question or pose a lesson idea for other Bootstrap\n"
      "teachers? These forums are the place to do it.\n") o))

(define (print-other-resources course proglang o)
  (when (or (string=? proglang "wescheme") (string=? proglang "pyret")) 
    (print-link-to-contracts course o))
  (print-link-to-glossary course o)
  (print-link-to-standards course o)
  (print-link-to-teacher-resources course o)
  (print-link-to-forum o))

(define (natlang:also-available-in s)
  (string-append "_(Using another tool? Please select it now: " s ".)_"))
