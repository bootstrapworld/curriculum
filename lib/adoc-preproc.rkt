#!/usr/bin/env racket

#lang racket

(require "preproc.rkt")

(for ([f (current-command-line-arguments)])
  (preproc-adoc-file f))

(void)
