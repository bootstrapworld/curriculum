#!/usr/bin/env racket

#lang racket

(require "preproc.rkt")

(define *progdir* (getenv "PROGDIR"))

(for ([f (current-command-line-arguments)])
  (preproc-n-asciidoctor f))

(void)
