#lang racket

(provide *standards-alist*)

(require "ccss-standards-dictionary.rkt")
(require "csta-standards-dictionary.rkt")
(require "ok-standards-dictionary.rkt")
(require "old-standards-dictionary.rkt")

(define *standards-alist*
  (list
    (cons "CCSS" *ccss-standards-list*)
    (cons "CSTA" *csta-standards-list*)
    (cons "OK" *ok-standards-list*)
    (cons "OLD" *old-standards-list*)
    ))
