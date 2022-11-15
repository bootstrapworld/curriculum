#lang racket

(provide
  print-lessons-intro
  print-other-resources-intro
  print-link-to-glossary
  print-link-to-standards
  print-workbook-info
  print-link-to-teacher-resources
  print-link-to-forum
  print-other-resources
  )

;please add definitions for
; print-course-logo print-course-banner print-teach-remotely print-preparation
; print-workbook-info

(define (print-lessons-intro o)
  (fprintf o "Proporcionamos todos nuestros materiales @italic{de forma gratuita}, a cualquier persona que esté interesada en usar nuestros planes de lección o libros de ejercicios para estudiantes.

[#lesson-list]\n"))

(define (print-other-resources-intro o)
  (fprintf o "Por supuesto, hay más a un plan de estudios que el software y planes de lecciones! También proporcionamos una serie de recursos a los educadores, incluyendo las normas del estándar, las respuestas para los ejercicios de programación y foros donde pueden hacer preguntas y compartir ideas.

[.pathway_external_links]\n"))

(define (print-link-to-glossary o)
  (fprintf o "\n- link:./pathway-glossary.html[Glossary]\n")
  (fprintf o "-- Check here for the technical terms and concepts used
  in this material.\n"))

(define (print-link-to-standards o)
  (fprintf o "\n- link:./pathway-standards.html[Standards Alignment]\n")

(define (print-link-to-forum o)
  (fprintf o "\n- link:https://discourse.bootstrapworld.org[Online Community (Discourse)]\n")
  (fprintf o "--
Want to be kept up-to-date about Bootstrap events, workshops, and curricular
changes? Want to ask a question or pose a lesson idea for other Bootstrap
teachers? These forums are the place to do it.n")
  )
  (fprintf o "-- Find out how our materials align with Common Core Content
  and Practice Standards, as well as the TEK and CSTA Standards.\n"))

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
        "\n"
        "link:"
          (if c (second c) "missing-link")
          "[Click here to purchase beautifully-bound copies of the student workbook from Lulu.com].\n"
        "\n"
        "Of course, we understand that printing them yourself can be expensive!\n"
        "link:./workbook/workbook.pdf[Click Here to download a free PDF of the workbook].\n"
        "\n") o)))

(define (print-link-to-teacher-resources o)
  (fprintf o "\n- link:./resources/index.html[Recursos para maestros]\n")
  (fprintf o "-- También ofrecemos varios materiales para los maestros, incluyendo una clave de
respuestas para el libro del estudiante, una guía de inicio rápido para hacer
el proyecto final, exámenes previos y posteriores para los maestros que están
participando en nuestra investigación. Para acceder a estos materiales, rellene
el
link:https://docs.google.com/a/bootstrapworld.org/spreadsheet/viewform?formkey=dHpQc0VHV2dBU2tSN1ptMktBUmtoZWc6MQ#gid=0[formulario
de solicitud de contraseña]). Pronto nos pondremos en contacto con usted con la
información de inicio de sesión necesaria para acceder.\n"))

(define (print-link-to-forum o)
  (fprintf o "\n- link:https://discourse.bootstrapworld.org[Bootstrap Discussion Forum]\n")
  (fprintf o "-- ¿Quiere mantenerse al día sobre los eventos Bootstrap, talleres y cambios en el
plan de estudios? ¿Quieres hacer una pregunta o plantear una idea de lección
para otros maestros de Bootstrap? Estos foros son el lugar para hacerlo.\n")
  )

(define (print-other-resources o)
  (print-link-to-glossary o)
  (print-link-to-standards o)
  (print-link-to-student-workbook o)
  (print-link-to-teacher-resources o)
  (print-link-to-forum o))
