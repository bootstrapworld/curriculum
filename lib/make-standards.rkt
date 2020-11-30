#!/usr/bin/env racket

#lang racket

(require "defines.rkt")
(require "html-tag-gen.rkt")
(require "the-standards-dictionaries.rkt")
(require "utils.rkt")
(require "preproc.rkt")

(define *standards-met* '())

(define *dictionaries-represented* '())

;(print-menubar "standards")

(define *lesson* #f)

(define *all-standards* (read-data-file "all-standards.txt" #:mode 'forms))

(let ([ss *all-standards*])
  (for ([s ss])
    (let ([std (list-ref s 0)]
          [ltitle (list-ref s 1)]
          [lesson (list-ref s 2)]
          [pwy (list-ref s 3)])
      (add-standard std ltitle lesson pwy #f))))

;(printf "standards-met= ~s\n\n\n" *standards-met*)

;(printf "dictionaries-represented= ~s\n" *dictionaries-represented*)

(create-standards-file "Standards" #t #f *standards-met* *dictionaries-represented*)

(void)
