#lang racket

(provide
  *standards-list*
  *dict-canonical-order*
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
(require "standards-ia-dictionary.rkt")
(require "standards-ma-dictionary.rkt")

(define *standards-list*
  (list
    ; nickname, expanded-name, standard-dictionary, URI
    (list "CCSS-Math"   "Common Core Math"  *cc-math-standards-list* "http://corestandards.org/Math/")
    (list "CC-ELA"      "Common Core ELA"   *cc-ela-standards-list* "http://corestandards.org/ELA-Literacy/")
    (list "CSTA"        "CSTA"              *csta-standards-list* "https://csteachers.org/page/standards")
    (list "K12CS"       "K-12CS"            *k12cs-standards-list* "https://k12cs.org")
    (list "NGSS"        "Next-Gen Science"  *ngss-standards-list* "https://www.nextgenscience.org/")
    (list "Illinois"    "Illinois"          *il-standards-list* "")
    (list "Massachusetts" "Massachusetts"   *ma-standards-list* "https://www.doe.mass.edu/frameworks/")
    (list "Oklahoma"    "Oklahoma"          *ok-standards-list* "https://sde.ok.gov/oklahoma-academic-standards")
    ))

(define *dict-canonical-order* (map first *standards-list*))

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
    (if x
        (format "link:~a[~a Standards]" (list-ref x 3) (list-ref x 1))
        (string-append dict " Standards"))))
