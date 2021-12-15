#lang racket

(provide
  *textbooks-list*)

(require "textbook-cmp-dictionary.rkt")
(require "textbook-im-6-dictionary.rkt")
(require "textbook-im-7-dictionary.rkt")
(require "textbook-im-8-dictionary.rkt")
(require "textbook-im-alg-1-dictionary.rkt")

; (define *textbook-list*
;   (append *cmp-textbook-list*
;           *im-textbook-list*))

(define *textbooks-list*
  (list
    (list "CMP" *cmp-textbook-list*)
    (list "IM.6" *im-6-textbook-list*)
    (list "IM.7" *im-7-textbook-list*)
    (list "IM.8" *im-8-textbook-list*)
    (list "IM.Alg.1" *im-alg-1-textbook-list*)

    ))

