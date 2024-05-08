#!/usr/bin/env racket

#lang racket

(require "preproc.rkt")

(let ([adocables-file (vector-ref (current-command-line-arguments) 0)])
  (call-with-input-file adocables-file
    (lambda (i)
      (let loop ()
        (let ([args (read i)])
          (unless (eof-object? args)
            (let-values ([(key-list val-list other-args)
                          (rearrange-args args)])
              (keyword-apply preproc-adoc-file key-list val-list other-args))
            (loop)))))))

(void)
