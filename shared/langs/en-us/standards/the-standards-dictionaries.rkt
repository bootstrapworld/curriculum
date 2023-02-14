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
(require "standards-or-dictionary.rkt")
(require "standards-cc-states-dictionaries.rkt")

(define *standards-list*
  (list
    ; nickname, expanded-name, standard-dictionary, URI
    (list "CCSS-Math"   "Common Core Math"  *cc-math-standards-list* "http://corestandards.org/Math/")
    (list "CC-ELA"      "Common Core ELA"   *cc-ela-standards-list* "http://corestandards.org/ELA-Literacy/")
    (list "CSTA"        "CSTA"              *csta-standards-list* "https://csteachers.org/page/standards")
    (list "K12CS"       "K-12CS"            *k12cs-standards-list* "https://k12cs.org")
    (list "NGSS"        "Next-Gen Science"  *ngss-standards-list* "https://www.nextgenscience.org/")

    (list "Alabama"     "Alabama"           *al-standards-list* "")
    (list "Arkansas"    "Arkansas"          *ar-standards-list* "")
    (list "California"  "California"        *ca-standards-list* "")
    (list "Colorado"    "Colorado"          *co-standards-list* "")
    (list "Connecticut" "Connecticut"       *ct-standards-list* "")
    (list "Delaware"    "Delaware"          *de-standards-list* "")
    (list "Georgia"     "Delaware"          *ga-standards-list* "")
    (list "Hawaii"      "Hawaii"            *hi-standards-list* "")
    (list "Idaho"       "Idaho"             *id-standards-list* "")
    (list "Illinois"    "Illinois"          *il-standards-list* "")
    (list "Iowa"        "Iowa"              *iowa-standards-list* "https://iowacore.gov/standards/iowa-core-standards")
    (list "Kansas"      "Kansas"            *ks-standards-list* "")
    (list "Kentucky"    "Kentucky"          *ky-standards-list* "")
    (list "Louisiana"   "Louisiana"         *la-standards-list* "")
    (list "Maine"       "Maine"             *me-standards-list* "")
    (list "Michigan"    "Michigan"          *mi-standards-list* "")
    (list "Maryland"    "Maryland"          *md-standards-list* "")
    (list "Massachusetts" "Massachusetts"   *ma-standards-list* "https://www.doe.mass.edu/frameworks/")
    (list "Mississippi" "Mississippi"       *ms-standards-list* "")
    (list "Missouri"    "Missouri"          *mo-standards-list* "")
    (list "Montana"     "Montana"           *mt-standards-list* "")
    (list "New Hampshire" "New Hampshire"   *nh-standards-list* "")
    (list "Nevada"      "Nevada"            *nv-standards-list* "")
    (list "New Jersey"  "New Jersey"        *nj-standards-list* "")
    (list "New Mexico"  "New Mexico"        *nm-standards-list* "")
    (list "North Carolina" "North Carolina" *nc-standards-list* "")
    (list "North Dakota" "North Dakota"     *nd-standards-list* "")
    (list "New York"    "New York"          *ny-standards-list* "http://www.nysed.gov/curriculum-instruction/new-york-state-next-generation-mathematics-learning-standards")
    (list "Oklahoma"    "Oklahoma"          *ok-standards-list* "https://sde.ok.gov/oklahoma-academic-standards")
    (list "Ohio"        "Ohio"              *oh-standards-list* "")
    (list "Oregon"      "Oregon"            *or-standards-list* "https://www.oregon.gov/ode/educator-resources/standards/pages/default.aspx")
    (list "Pennsylvania" "Pennsylvania"     *pa-standards-list* "")
    (list "Rhode Island" "Rhode Island"     *ri-standards-list* "")
    (list "South Dakota" "South Dakota"     *sd-standards-list* "")
    (list "Tennessee"   "Tennessee"         *tn-standards-list* "")
    (list "Utah"        "Utah"              *ut-standards-list* "")
    (list "Vermont"     "Vermont"           *vt-standards-list* "")
    (list "Washington"  "Washington"        *wa-standards-list* "")
    (list "West Virginia" "West Virginia"   *wv-standards-list* "")
    (list "Wisconsin"   "Wisconsin"         *wi-standards-list* "")
    (list "Wyoming"     "Wyoming"           *wy-standards-list* "")
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
