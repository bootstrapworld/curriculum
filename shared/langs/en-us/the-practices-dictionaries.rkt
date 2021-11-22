#lang racket

(provide 
  *practices-list*
  )

(require "practices-mlr-dictionary.rkt")
(require "practices-sj-dictionary.rkt")

(define *practices-list*
  (list
    *mlr-practices-list*
    *sj-practices-list*)
  )
