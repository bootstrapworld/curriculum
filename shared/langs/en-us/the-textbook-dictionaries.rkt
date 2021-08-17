#lang racket

(provide
  *textbook-list*)

(require "textbook-cmp-dictionary.rkt")
(require "textbook-im-dictionary.rkt")

(define *textbook-list*
  (append *cmp-textbook-list*
          *im-textbook-list*))

