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
    (list "CMP" "Connected Math" *cmp-textbook-list* "https://connectedmath.msu.edu/")
    (list "IM.6" "IM 6 Math™" *im-6-textbook-list* "https://illustrativemathematics.org/")
    (list "IM.7" "IM 7 Math™" *im-7-textbook-list* "https://illustrativemathematics.org/")
    (list "IM.8" "IM 8 Math™" *im-8-textbook-list* "https://illustrativemathematics.org/")
    (list "IM.Alg.1" "IM Algebra 1" *im-alg-1-textbook-list* "https://illustrativemathematics.org/")

    ))

(define (expand-textbook-abbrev tbk)
  (let ([x (assoc tbk *textbooks-list*)])
    (if x
        (format "link:~a[~a]" (list-ref x 3) (or (list-ref x 1) tbk))
        tbk)))

