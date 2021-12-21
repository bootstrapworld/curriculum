#!/usr/bin/env racket

#lang racket

(require "standards/standards-cc-ela-dictionary.rkt")
(require "standards/standards-cc-math-dictionary.rkt")
(require "standards/standards-csta-dictionary.rkt")
(require "standards/standards-k12cs-dictionary.rkt")
(require "standards/standards-ngss-dictionary.rkt")
(require "standards/standards-ok-dictionary.rkt")
(require "standards/standards-ia-dictionary.rkt")

(require "standards/lessons-and-standards.rkt")

(define *all-the-standards* '())

(for ([std-list (list *cc-ela-standards-list*
                      *cc-math-standards-list*
                      *csta-standards-list*
                      *k12cs-standards-list*
                      *ngss-standards-list*
                      *ok-standards-list*
                      *iowa-standards-list*
                      )])
  (for ([std-desc std-list])
    (set! *all-the-standards*
      (cons (list (car std-desc) (cadr std-desc) (box 0)) *all-the-standards*))))

(for ([lesson-line *lessons-and-standards*])
  (let ([lesson-stds (cdr lesson-line)])
    (for ([std lesson-stds])
      (let ([c (assoc std *all-the-standards*)])
        (when c
          (let ([b (caddr c)])
            (set-box! b (+ (unbox b) 1))))))))

(call-with-output-file "coverage-report.adoc"
  (lambda (o)
    (fprintf o "= Coverage of Standards\n\n")

    (fprintf
      o "Each line shows the name of the standard followed by the number of times it's used.\n")
    (fprintf o "If a standard is not used at all, the line is highlighted in red.\n\n")

    (fprintf o "++++\n")
    (fprintf o "<style>\n")
    (fprintf o ".unused { background-color: #ffdddd; }\n")
    (fprintf o "</style>\n")
    (fprintf o "++++\n\n")

    (fprintf o "[cols=\"2a,1a,7a\"]\n")
    (fprintf o "|===\n")
    (for ([entry *all-the-standards*])
      (let ([std (car entry)] [desc (cadr entry)] [count (unbox (caddr entry))])
        (set! desc (regexp-replace* "\\|" desc "\\&#x7c;"))
        (if (= count 0)
            (fprintf o "| [.unused]#~a# | [.unused]#~a# | [.unused]#~a#\n" std count desc)
            (fprintf o "| ~a | ~a | ~a\n" std count desc))))
    (fprintf o "|===\n\n")

    )

  #:exists 'replace)

