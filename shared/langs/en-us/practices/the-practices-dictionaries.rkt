#lang racket

(provide
  *practices-list*
  *flat-practices-list*
  )

(require "practices-mlr-dictionary.rkt")
(require "practices-sj-dictionary.rkt")
(require "practices-sep-dictionary.rkt")
(require "practices-cc-dictionary.rkt")
(require "practices-k12cs-dictionary.rkt")

(define *practices-list*
  (list
    (list "Practices" #f
          (append
            *mlr-practices-list*
            *sj-practices-list*
            *sep-practices-list*
            *cc-practices-list*
            *k12cs-practices-list*)
          )))

(define *flat-practices-list* (caddr (car *practices-list*)))
