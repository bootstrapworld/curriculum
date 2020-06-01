#!/usr/bin/env racket

#lang racket

(require "preproc.rkt")

(preproc-n-asciidoctor
  (vector-ref (current-command-line-arguments) 0))

(void)
