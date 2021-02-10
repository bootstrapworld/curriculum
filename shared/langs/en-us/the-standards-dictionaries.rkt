#lang racket

(provide
  *standards-list*
  *disallowed-standards-list*
  expand-dict-abbrev
  disallow-standards
  )

(require "standards-cc-ela-dictionary.rkt")
(require "standards-cc-math-dictionary.rkt")
(require "standards-csta-dictionary.rkt")
(require "standards-k12cs-dictionary.rkt")
(require "standards-ngss-dictionary.rkt")
(require "standards-ok-dictionary.rkt")

(define *standards-list*
  (list
    (list "CC-ELA"  "Common Core ELA" *cc-ela-standards-list*)
    (list "CC-Math" "Common Core Math" *cc-math-standards-list*)
    (list "CSTA"    #f *csta-standards-list*)
    (list "K12CS"   "K-12CS" *k12cs-standards-list*)
    (list "NGSS"    "Next-Gen Science" *ngss-standards-list*)
    (list "OK"      "Oklahoma" *ok-standards-list*)
    ))

(define *disallowed-standards-list*
  '())

(define (disallow-standards . stds)
  ;(printf "doing disallow-standards ~s\n" stds)
  (for ((std stds))
    (unless (assoc std *disallowed-standards-list*)
      (let ((x (assoc std *standards-list*)))
        (when x
          (set! *disallowed-standards-list*
            (cons x *disallowed-standards-list*))))))
  ;(printf "*standards-list* = ~s\n" *standards-list*)
  ;(printf "*disallowed-standards-list* = ~s\n" *disallowed-standards-list*)
  )

(define (expand-dict-abbrev dict)
  (let ([x (assoc dict *standards-list*)])
    (or (and x (cadr x)) dict)))
