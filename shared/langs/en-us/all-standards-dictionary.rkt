#lang racket

(provide *standards-alist*)

(require "ccss-standards-dictionary.rkt")
(require "csta-standards-dictionary.rkt")
(require "ok-standards-dictionary.rkt")

(define *standards-alist*
  (list
    (cons "ccss" *ccss-standards-list*)
    (cons "csta" *csta-standards-list*)
    (cons "ok" *ok-standards-list*)))
