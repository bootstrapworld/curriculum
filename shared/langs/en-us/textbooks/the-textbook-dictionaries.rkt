#lang racket

(provide
  *textbooks-list*
  expand-textbook-abbrev
  )

(require "textbook-cmp-dictionary.rkt")
(require "textbook-im-6-dictionary.rkt")
(require "textbook-im-7-dictionary.rkt")
(require "textbook-im-8-dictionary.rkt")
(require "textbook-im-alg-1-dictionary.rkt")

(define *textbooks-list*
  (list
    ; nickname expanded-name list URI
    (list "CMP" #f *cmp-textbook-list* "https://connectedmath.msu.edu/")
    (list "IM.6" #f *im-6-textbook-list* "https://illustrativemathematics.org/")
    (list "IM.7" #f *im-7-textbook-list* "https://illustrativemathematics.org/")
    (list "IM.8" #f *im-8-textbook-list* "https://illustrativemathematics.org/")
    (list "IM.Alg.1" #f *im-alg-1-textbook-list* "https://illustrativemathematics.org/")

    ))

(define (expand-textbook-abbrev tbk)
  (let ([x (assoc tbk *textbooks-list*)])
    (if x
        (format "link:~a[~a]" (list-ref x 3) (or (list-ref x 1) tbk))
        tbk)))

