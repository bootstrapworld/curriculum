#!/usr/bin/env racket

#lang racket

(require "defines.rkt")
(require "html-tag-gen.rkt")
(require "the-standards-dictionaries.rkt")
(require "utils.rkt")
(require "preproc.rkt")

;(print-menubar "standards")

(define *all-standards* (read-data-file ".cached/.all-standards.txt" #:mode 'forms))

;(printf "all-standards= ~s\n\n" *all-standards*)

(for ([s *all-standards*])
  (let ([std (list-ref s 0)]
        [ltitle (list-ref s 1)]
        [lesson (list-ref s 2)]
        [pwy (list-ref s 3)])
    (add-standard std ltitle lesson pwy #f)))

(create-standards-file ".cached/Standards" #t #f)

(void)
