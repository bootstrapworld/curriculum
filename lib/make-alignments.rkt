#!/usr/bin/env racket

#lang racket

(require "defines.rkt")
(require "html-tag-gen.rkt")
(require "utils.rkt")
(require "preproc.rkt")

(for ([s (read-data-file ".cached/.all-standards.txt" #:mode 'forms)])
  (let ([std (list-ref s 0)]
        [ltitle (list-ref s 1)]
        [lesson (list-ref s 2)]
        [pwy (list-ref s 3)])
    (add-standard std ltitle lesson pwy)))

(for ([s (read-data-file ".cached/.all-textbooks.txt" #:mode 'forms)])
  (let ([chap (list-ref s 0)]
        [ltitle (list-ref s 1)]
        [lesson (list-ref s 2)]
        [pwy (list-ref s 3)])
    (add-textbook-chapter chap ltitle lesson pwy)))

(for ([s (read-data-file ".cached/.all-practices.txt" #:mode 'forms)])
  (let ([pce (list-ref s 0)]
        [ltitle (list-ref s 1)]
        [lesson (list-ref s 2)]
        [pwy (list-ref s 3)])
    (add-practice pce ltitle lesson pwy)))

(create-alignments-subfile ".cached/.Alignments")

(void)
