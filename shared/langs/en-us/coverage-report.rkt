#!/usr/bin/env racket

#lang racket

(require "coverage-dropdown.rkt")

;standards

(require "standards/lessons-and-standards.rkt")

(require "standards/the-standards-dictionaries.rkt")

;textbooks

(require "textbooks/lessons-and-textbooks.rkt")

(require "textbooks/the-textbook-dictionaries.rkt")

;practices

(require "practices/lessons-and-practices.rkt")

(require "practices/the-practices-dictionaries.rkt")

;;;;;;;;;;;;;

(define (sanitize-css-id id)
  (regexp-replace* "\\." id "_"))

(define (display-selection o )
  (display "\n++++\n" o)
  (display "<select class=\"coverageAlignmentSelect\" onchange=\"showCoverageAlignment()\">\n" o)
  (display "<optgroup label=\"Standards\">\n" o)
  (for ([categ *standards-list*])
    (fprintf o "<option>~a</option>\n" (sanitize-css-id (car categ)))
    )
  (display "</optgroup>\n" o)
  ;
  (display "<optgroup label=\"Textbooks\">\n" o)
  (for ([categ *textbooks-list*])
    (fprintf o "<option>~a</option>\n" (sanitize-css-id (car categ))))
  (display "</optgroup>\n" o)
  ;
  (display "<optgroup label=\"Practices\">\n" o)
  (for ([categ *practices-list*])
    (fprintf o "<option>~a</option>\n" (sanitize-css-id (car categ))))
  (display "</optgroup>\n" o)
  (display "</select>\n" o)
  (display "++++\n" o))

(define (display-subreport o title lesson-entries dictionaries)
  ; (printf "doing display-subreport ~s  \n" title  )

  (for ([dictionary dictionaries])
    ; (printf "doing dictionary ~s\n" dictionary)
    (let ([lyst (list-ref dictionary (- (length dictionary) 1))]
          [opt (sanitize-css-id (car dictionary))]
          [counters '()])
      ; (printf "doing lyst = ~s\n" opt)
      (for ([desc lyst])
        (set! counters
          (cons (list (car desc) (cadr desc) (box 0)) counters)))

      (set! counters (reverse counters))

      (for ([lesson-entry lesson-entries])
        (let ([lesson-vals (cdr lesson-entry)])
          (for ([val lesson-vals])
            (let ([c (assoc val counters)])
              (when c
                (let ([b (caddr c)])
                  (set-box! b (+ (unbox b) 1))))))))

      (fprintf o "[.coverageElement.~a]\n" opt)
      (fprintf o "[cols=\"2a,1a,7a\"]\n")
      (fprintf o "|===\n")
      (for ([entry counters])
        (let ([std (car entry)] [desc (cadr entry)] [count (unbox (caddr entry))])
          (set! desc (regexp-replace* "\\|" desc "\\&#x7c;"))
          (if (= count 0)
              (fprintf o "| [.unused]#~a# | [.unused]#~a# | [.unused]#~a#\n" std count desc)
              (fprintf o "| ~a | ~a | ~a\n" std count desc)))
        )
      (fprintf o "|===\n\n")
      )))

(call-with-output-file "coverage-report.adoc"
  (lambda (o)
    (fprintf o "= Coverage Report\n\n")

    (fprintf
      o "Each line shows the name of the standard/practice/textbook followed by the number of times it's used.\n")
    (fprintf o "If a standard is not used at all, the line is highlighted in red.\n\n")

    (print-coverage-script-n-style o)
    (display-selection o)

    (display-subreport o "Standards" *lessons-and-standards* *standards-list*)

    (display-subreport o "Textbooks" *lessons-and-textbooks* *textbooks-list*)

    (display-subreport o "Practices" *lessons-and-practices* *practices-list*)

    )

  #:exists 'replace)

