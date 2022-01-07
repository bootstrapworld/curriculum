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

(define (display-subreport o title lesson-entries dictionaries) ; list-of-alists
  ; (printf "doing display-subreport ~s  \n" title  )
  (define *all-the-values* '())

  (for ([dictionary dictionaries])
    ; (printf "doing dictionary ~s\n" dictionary)
    (let ([lyst (list-ref dictionary (- (length dictionary) 1))])
      ; (printf "doing lyst = ~s\n" lyst)
      (for ([desc lyst])
        (set! *all-the-values*
          (cons (list (car desc) (cadr desc) (box 0)) *all-the-values*)))))

  (for ([lesson-entry lesson-entries])
    (let ([lesson-vals (cdr lesson-entry)])
      (for ([val lesson-vals])
        (let ([c (assoc val *all-the-values*)])
          (when c
            (let ([b (caddr c)])
              (set-box! b (+ (unbox b) 1))))))))

  (fprintf o "== ~a\n\n" title)

    (fprintf o "[cols=\"2a,1a,7a\"]\n")
    (fprintf o "|===\n")
    (for ([entry *all-the-values*])
      (let ([std (car entry)] [desc (cadr entry)] [count (unbox (caddr entry))])
        (set! desc (regexp-replace* "\\|" desc "\\&#x7c;"))
        (if (= count 0)
            (fprintf o "| [.unused]#~a# | [.unused]#~a# | [.unused]#~a#\n" std count desc)
            (fprintf o "| ~a | ~a | ~a\n" std count desc))))
    (fprintf o "|===\n\n"))

(call-with-output-file "coverage-report.adoc"
  (lambda (o)
    (fprintf o "= Coverage Report\n\n")

    (fprintf
      o "Each line shows the name of the standard/practice/textbook followed by the number of times it's used.\n")
    (fprintf o "If a standard is not used at all, the line is highlighted in red.\n\n")

    (print-coverage-script-n-style o)

    (display-subreport o "Standards" *lessons-and-standards* *standards-list*)

    (display-subreport o "Textbooks" *lessons-and-textbooks* *textbooks-list*)

    (display-subreport o "Practices" *lessons-and-practices* *practices-list*)

    )

  #:exists 'replace)

