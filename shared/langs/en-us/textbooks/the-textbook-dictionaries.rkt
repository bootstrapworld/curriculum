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
    (list "CMP" #f *cmp-textbook-list*)
    (list "IM.6" #f *im-6-textbook-list*)
    (list "IM.7" #f *im-7-textbook-list*)
    (list "IM.8" #f *im-8-textbook-list*)
    (list "IM.Alg.1" #f *im-alg-1-textbook-list*)

    ))

