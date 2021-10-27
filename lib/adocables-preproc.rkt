#!/usr/bin/env racket

#lang racket

(require "preproc.rkt")

(define (list-unzip x)
  (let loop ([x x] [r1 '()] [r2 '()])
    (if (null? x) (list (reverse r1) (reverse r2))
        (loop (cddr x) (cons (car x) r1) (cons (cadr x) r2)))))

(let* ([adocables-file (vector-ref (current-command-line-arguments) 0)]
       [args* (call-with-input-file adocables-file read)])
  (for ([args args*])
    ;(printf "processing ~s\n" args)
    (let-values ([(key-list val-list other-args)
                  (rearrange-args args)])
      (keyword-apply preproc-adoc-file key-list val-list other-args))))

(void)
