#!/usr/bin/env racket

#lang racket

(require "standards-cc-ela-dictionary.rkt")
(require "standards-cc-math-dictionary.rkt")
(require "standards-csta-dictionary.rkt")
(require "standards-k12cs-dictionary.rkt")
(require "standards-ngss-dictionary.rkt")
(require "standards-ok-dictionary.rkt")
(require "textbook-cmp-dictionary.rkt")

(require "lessons-and-standards.rkt")

(define *all-the-standards* '())

(for ([std-list (list *cc-ela-standards-list*
                      *cc-math-standards-list*
                      *csta-standards-list*
                      *k12cs-standards-list*
                      *ngss-standards-list*
                      *ok-standards-list*
                      *cmp-standards-list*)])
  (for ([std-desc std-list])
    (let ([std (car std-desc)])
      (set! *all-the-standards*
        (cons (list std (box 0)) *all-the-standards*)))))

(for ([lesson-line *lessons-and-standards*])
  (let ([lesson-stds (cdr lesson-line)])
    (for ([std lesson-stds])
      (let ([c (assoc std *all-the-standards*)])
        (when c
          (let ([b (cadr c)])
            (set-box! b (+ (unbox b) 1))))))))

(call-with-output-file "coverage-report.adoc"
  (lambda (o)
    (fprintf o "= Coverage of Standards\n\n")

    (fprintf o "Each line shows the name of the standard followed by the number of times it's used. ")
    (fprintf o "If a standard is not used at all, the line is highlighted in red.\n\n")

    (fprintf o "++++\n")
    (fprintf o "<style>\n")
    (fprintf o ".unused { background-color: darkred; color: white; }\n")
    (fprintf o "</style>\n")
    (fprintf o "++++\n\n")

    (fprintf o "[verse]\n")
    (for ([std-desc *all-the-standards*])
      (let ([std (car std-desc)] [count (unbox (cadr std-desc))])
        (if (= count 0)
            (fprintf o "[.unused]#~a \t ~a#\n" std count)
            (fprintf o "~a \t ~a\n" std count))))
    (fprintf o "\n\n")
    )
  #:exists 'replace)

