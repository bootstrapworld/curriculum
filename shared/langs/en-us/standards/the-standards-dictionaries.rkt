#lang racket

(provide
  *standards-list*
  *dict-canonical-order*
  *disallowed-standards-list*
  expand-dict-abbrev
  disallow-standards
  )

(define (read-file f)
  (let* ([progdir (or (getenv "PROGDIR") "shared/langs/en-us")]
         [f (format "~a/~a" progdir f)])
    (call-with-input-file f read)))

(define *cc-ela-standards-list* (read-file "standards/standards-cc-ela-dictionary.rkt"))
(define *cc-math-standards-list* (read-file "standards/standards-cc-math-dictionary.rkt"))
(define *csta-standards-list* (read-file "standards/standards-csta-dictionary.rkt"))
(define *k12cs-standards-list* (read-file "standards/standards-k12cs-dictionary.rkt"))
(define *ngss-standards-list* (read-file "standards/standards-ngss-dictionary.rkt"))
(define *ok-standards-list* (read-file "standards/standards-ok-dictionary.rkt"))
(define *or-standards-list* (read-file "standards/standards-or-dictionary.rkt"))
(define *iowa-standards-list* (read-file "standards/standards-ia-dictionary.rkt"))
(define *ma-standards-list* (read-file "standards/standards-ma-dictionary.rkt"))

(define *standards-list*
  (list
    ; nickname, expanded-name, standard-dictionary, URI
    (list "CCSS-Math"   "Common Core Math"  *cc-math-standards-list* "http://corestandards.org/Math/")
    (list "CC-ELA"      "Common Core ELA"   *cc-ela-standards-list* "http://corestandards.org/ELA-Literacy/")
    (list "CSTA"        "CSTA"              *csta-standards-list* "https://csteachers.org/page/standards")
    (list "K12CS"       "K-12CS"            *k12cs-standards-list* "https://k12cs.org")
    (list "NGSS"        "Next-Gen Science"  *ngss-standards-list* "https://www.nextgenscience.org/")
    (list "IA"          "Iowa"              *iowa-standards-list* "https://iowacore.gov/standards/iowa-core-standards")
    (list "MA"          "Massachusetts"     *ma-standards-list* "https://www.doe.mass.edu/frameworks/")
    (list "OK"          "Oklahoma"          *ok-standards-list* "https://sde.ok.gov/oklahoma-academic-standards")
    (list "OR"          "Oregon"            *or-standards-list* "https://www.oregon.gov/ode/educator-resources/standards/pages/default.aspx")
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
