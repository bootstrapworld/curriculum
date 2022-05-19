#!/usr/bin/env racket

#lang racket

(require "glossary-terms.rkt")

; assumes glossary is given in alpha order for English at least

(call-with-output-file "bilingual-glossary.adoc"
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
                   [kwd (if (list? kwds) (string-join kwds ", ") kwds)]
                   [desc (third en-entry)])
              (fprintf o "~a :: ~a\n\n" kwd desc))
            (fprintf o "[.missing]#missing entry# :: ...\n\n"))
        (if es-entry
            (let* ([kwds (second es-entry)]
                   [kwd (if (list? kwds) (string-join (second es-entry) ", ") kwds)]
                   [desc (third es-entry)])
              (fprintf o "~a :: ~a\n\n" kwd desc))
            (fprintf o "[.missing]#missing entry# :: ...\n\n"))
        (fprintf o "'''\n\n"))))
  #:exists 'replace)
