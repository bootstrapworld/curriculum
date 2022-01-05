#!/usr/bin/env racket

#lang racket

;standards

(require "standards/standards-cc-ela-dictionary.rkt")
(require "standards/standards-cc-math-dictionary.rkt")
(require "standards/standards-csta-dictionary.rkt")
(require "standards/standards-k12cs-dictionary.rkt")
(require "standards/standards-ngss-dictionary.rkt")
(require "standards/standards-ok-dictionary.rkt")
(require "standards/standards-ia-dictionary.rkt")

(require "standards/lessons-and-standards.rkt")

;practices

(require "practices/practices-mlr-dictionary.rkt")
(require "practices/practices-sj-dictionary.rkt")
(require "practices/practices-sep-dictionary.rkt")
(require "practices/practices-cc-dictionary.rkt")

(require "practices/lessons-and-practices.rkt")

;textbooks

(require "textbooks/textbook-cmp-dictionary.rkt")
(require "textbooks/textbook-im-6-dictionary.rkt")
(require "textbooks/textbook-im-7-dictionary.rkt")
(require "textbooks/textbook-im-8-dictionary.rkt")
(require "textbooks/textbook-im-alg-1-dictionary.rkt")

(require "textbooks/lessons-and-textbooks.rkt")

;;;;;;;;;;;;;

(define (display-subreport o title lesson-entries list-of-alists)
  (define *all-the-values* '())

  (for ([lyst list-of-alists])
    (for ([desc lyst])
      (set! *all-the-values*
        (cons (list (car desc) (cadr desc) (box 0)) *all-the-values*))))

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

    (fprintf o "++++\n")
    (fprintf o "<style>\n")
    (fprintf o ".unused { background-color: #ffdddd; }\n")
    (fprintf o "</style>\n")
    (fprintf o "++++\n\n")

    (display-subreport o "Standards" *lessons-and-standards*
                       (list *cc-ela-standards-list*
                             *cc-math-standards-list*
                             *csta-standards-list*
                             *k12cs-standards-list*
                             *ngss-standards-list*
                             *ok-standards-list*
                             *iowa-standards-list*
                             ))

    (display-subreport o "Practices" *lessons-and-practices*
                       (list *mlr-practices-list*
                             *sj-practices-list*
                             *sep-practices-list*
                             *cc-practices-list*))

    (display-subreport o "Textbooks" *lessons-and-textbooks*
                       (list *cmp-textbook-list*
                             *im-6-textbook-list*
                             *im-7-textbook-list*
                             *im-8-textbook-list*
                             *im-alg-1-textbook-list*))
    )

  #:exists 'replace)

