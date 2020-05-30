#lang racket

(provide
  *standards-list*
  expand-dict-abbrev
  )

(require "ccss-standards-dictionary.rkt")
(require "csta-standards-dictionary.rkt")
(require "ngss-standards-dictionary.rkt")
(require "ok-standards-dictionary.rkt")
(require "old-standards-dictionary.rkt")

(define *standards-list*
  (list
    (list "CCSS" "Common Core State" *ccss-standards-list*)
    (list "CSTA" #f *csta-standards-list*)
    (list "NGSS" "Next-Gen Science" *ngss-standards-list*)
    (list "OK" "Oklahoma" *ok-standards-list*)
    (list "OLD" "Older" *old-standards-list*)
    ))

(define (expand-dict-abbrev dict)
  (let ([x (assoc dict *standards-list*)])
    (if x (cadr x) dict)))
