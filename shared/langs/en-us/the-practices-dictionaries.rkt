#lang racket

(provide 
  *practices-list*
  )

(require "practices-mlr-dictionary.rkt")
(require "practices-sj-dictionary.rkt")

(define *practices-list*
  (append
    *mlr-practices-list*
    *sj-practices-list*)
  )
