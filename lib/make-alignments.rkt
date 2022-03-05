#!/usr/bin/env racket

#lang racket

(require "utils.rkt")
(require "preproc.rkt")

(for ([s (read-data-file ".cached/.all-standards.txt" #:mode 'forms)])
  (apply add-standard s))

(for ([s (read-data-file ".cached/.all-textbooks.txt" #:mode 'forms)])
  (apply add-textbook-chapter s))

(for ([s (read-data-file ".cached/.all-practices.txt" #:mode 'forms)])
  (apply add-practice s))

(create-alignments-subfile ".cached/.Alignments")

(void)
