#!/usr/bin/env racket

#lang racket

(require "coverage-dropdown.rkt")

;standards

(require "standards/standards-and-lessons.rkt")

(require "standards/the-standards-dictionaries.rkt")

;textbooks

(require "textbooks/textbooks-and-lessons.rkt")

(require "textbooks/the-textbook-dictionaries.rkt")

;practices

(require "practices/practices-and-lessons.rkt")

(require "practices/the-practices-dictionaries.rkt")

;;;;;;;;;;;;;

(define (sanitize-css-id id)
  (regexp-replace* "[. ]" id "_")
  )

(define (display-selection o )
  (display "\n++++\n" o)
  (display "<select class=\"coverageAlignmentSelect\" onchange=\"showCoverageAlignment()\">\n" o)
  (display "<optgroup label=\"Standards\">\n" o)
  (for ([categ *standards-list*])
    (fprintf o "<option>~a</option>\n" (first categ))
    )
  (display "</optgroup>\n" o)
  ;
  (display "<optgroup label=\"Textbooks\">\n" o)
  (for ([categ *textbooks-list*])
    (fprintf o "<option>~a</option>\n" (first categ)))
  (display "</optgroup>\n" o)
  ;
  (display "<optgroup label=\"Practices\">\n" o)
  (for ([categ *practices-list*])
    (fprintf o "<option>~a</option>\n" (first categ)))
  (display "</optgroup>\n" o)
  (display "</select>\n" o)
  (display "++++\n" o))

(define (display-subreport o title standard-entries dictionaries)
  ; (printf "doing display-subreport ~s  \n" title  )

  (for ([dictionary dictionaries])
    ; (printf "doing dictionary ~s\n" dictionary)
    (let ([lyst (list-ref dictionary 2)]
          [opt (sanitize-css-id (first dictionary))]
          [counters '()])
      ; (printf "doing lyst = ~s\n" opt)
      (for ([desc lyst])
        (set! counters
          (cons (list (first desc) (second desc) (box "") (box 0)) counters)))

      (set! counters (reverse counters))

      (for ([s-ll standard-entries])
        (let* ([s (first s-ll)] [ll (rest s-ll)]
               [c (assoc s counters)])
          (when c
            (let* ([b (third c)]
                   [count-box (fourth c)])
              (set-box! b (string-join ll ", "))
              (set-box! count-box (length ll))))))

      (fprintf o "[.coverageElement.~a]\n" opt)
      (fprintf o "[cols=\"2a,1a,7a\"]\n")
      (fprintf o "|===\n")
      (for ([entry counters])
        (let ([std (first entry)] [desc (second entry)] [lessons (unbox (third entry))]
                                [count (unbox (fourth entry))])
          (set! desc (regexp-replace* "\\|" desc "\\&#x7c;"))
          (if (string=? lessons "")
              (fprintf o "| [.unused]#~a# | [.unused]#none# | [.unused]#~a#\n" std desc)
              (fprintf o "| ~a | ~a (~a) | ~a\n" std lessons count desc)))
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

    (display-subreport o "Standards" *standards-and-lessons* *standards-list*)

    (display-subreport o "Textbooks" *textbooks-and-lessons* *textbooks-list*)

    (display-subreport o "Practices" *practices-and-lessons* *practices-list*)

    )

  #:exists 'replace)

