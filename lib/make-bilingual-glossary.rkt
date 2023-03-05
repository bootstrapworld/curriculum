#!/usr/bin/env racket

#lang racket

; last modified 2023-03-04

(require "glossary-terms.rkt")

; not dealing with any shadowing glossaries, intentionally i think

; assumes glossary is given in alpha order for English at least

(define (extract-keywords kwds)
  (let ([kwd1 (first kwds)] [other-kwds (rest kwds)])
    (string-join
      (cons
        (if (list? kwd1) (first kwd1) kwd1)
        (flatten
          (map (lambda (kwd)
                 (if (list? kwd) (car kwd) '())) (rest kwds)))) ", ")))

(define *glossary-adoc-file*
  (string-append
    (or (getenv "GLOSSFILE")
        "bilingual-glossary") ".adoc"))

(call-with-output-file *glossary-adoc-file*
  (lambda (o)
    (fprintf o "= Bilingual Glossary\n\n")
    (fprintf o "++++\n")
    (fprintf o "<style>\n")
    (fprintf o ".missing { font-style: italic; color: #993333; }\n")
    (fprintf o "</style>\n")
    (fprintf o "++++\n\n")

    (for ([entry *glossary-list*])
      ; (printf "entry = ~s\n" entry)
      (let ([en-entry (assoc 'en-us entry)]
            [es-entry (assoc 'es-mx entry)])
        (if en-entry
            (let* ([kwds (second en-entry)]
                   [kwd (if (list? kwds) (extract-keywords kwds) kwds)]
                   [desc (third en-entry)])
              (fprintf o "~a :: ~a\n\n" kwd desc))
            (fprintf o "[.missing]#missing entry# :: ...\n\n"))
        (if es-entry
            (let* ([kwds (second es-entry)]
                   [kwd (if (list? kwds) (extract-keywords kwds) kwds)]
                   [desc (third es-entry)])
              (fprintf o "~a :: ~a\n\n" kwd desc))
            (fprintf o "[.missing]#missing entry# :: ...\n\n"))
        (fprintf o "'''\n\n"))))
  #:exists 'replace)
