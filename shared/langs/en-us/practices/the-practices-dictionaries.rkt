#lang racket

(provide
  *practices-list*
  *flat-practices-list*
  expand-practice-abbrev
  )

(require "practices-mlr-dictionary.rkt")
(require "practices-sj-dictionary.rkt")
(require "practices-sep-dictionary.rkt")
(require "practices-cc-dictionary.rkt")
(require "practices-k12cs-dictionary.rkt")

(define *practices-list*
  (list
    (list "MLR" #f *mlr-practices-list*
          "https://achievethecore.org/peersandpedagogy/developing-math-language-routines/")
    (list "SJ" #f *sj-practices-list*
          "https://www.learningforjustice.org/sites/default/files/2017-06/TT_Social_Justice_Standards_0.pdf")
    (list "SEP" #f *sep-practices-list* "https://ngss.nsta.org/practicesfull.aspx")
    (list "CC" #f *cc-practices-list* "http://corestandards.org/Math/")
    (list "K12CS" #f *k12cs-practices-list* "https://k12cs.org")))

(define *flat-practices-list* (apply append (map caddr *practices-list*)))

(define (expand-practice-abbrev pce)
  (let ([x (assoc pce *practices-list*)])
    (if x
        (format "link:~a[~a]" (list-ref x 3) pce)
        pce)))

