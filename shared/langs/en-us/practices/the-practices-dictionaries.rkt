#lang racket

(provide
  *practices-list*
  *flat-practices-list*
  expand-practice-abbrev
  )

(define (read-file f)
  (let* ([progdir (or (getenv "PROGDIR") "shared/langs/en-us")]
         [f (format "~a/~a" progdir f)])
    (call-with-input-file f read)))

;(define *mlr-practices-list* (read-file "practices/practices-mlr-dictionary.rkt"))
(define *sj-practices-list* (read-file "practices/practices-sj-dictionary.rkt"))
(define *sep-practices-list* (read-file "practices/practices-sep-dictionary.rkt"))
(define *cc-practices-list* (read-file "practices/practices-cc-dictionary.rkt"))
(define *k12cs-practices-list* (read-file "practices/practices-k12cs-dictionary.rkt"))

(define *practices-list*
  (list
    ; nickname expanded-name list URI
    ;(list "MLR" "Math Lang. Routines" *mlr-practices-list*
    ;      "https://achievethecore.org/peersandpedagogy/developing-math-language-routines/")
    (list "SJ" "Social Justice" *sj-practices-list*
          "https://www.learningforjustice.org/sites/default/files/2017-06/TT_Social_Justice_Standards_0.pdf")
    (list "NGSS" "Science and Engineering" *sep-practices-list* "https://ngss.nsta.org/practicesfull.aspx")
    (list "CC" "Math" *cc-practices-list* "http://corestandards.org/Math/")
    (list "K12CS" "K12CS" *k12cs-practices-list* "https://k12cs.org")))

(define *flat-practices-list* (apply append (map third *practices-list*)))

(define (expand-practice-abbrev pce)
  (let ([x (assoc pce *practices-list*)])
    (if x
        (format "link:~a[~a]" (list-ref x 3) (or (list-ref x 1) pce))
        pce)))
