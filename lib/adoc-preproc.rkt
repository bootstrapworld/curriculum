#!/usr/bin/env racket

#lang racket

(require "preproc.rkt")

(for ([f (current-command-line-arguments)])
  (initialize-autonumber-index)
  (preproc-adoc-file f))

(void)
