#!/usr/bin/env racket

#lang racket

(require "preproc.rkt")

(let* ([adocables-file (vector-ref (current-command-line-arguments) 0)]
       [args* (call-with-input-file adocables-file read)])
  (for ([args args*])
    ;(printf "processing ~s\n" args)
    (let-values ([(key-list val-list other-args)
                  (rearrange-args args)])
      (keyword-apply preproc-adoc-file key-list val-list other-args))))

(void)
