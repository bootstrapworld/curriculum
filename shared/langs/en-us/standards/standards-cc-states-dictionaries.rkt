#lang racket

(provide 
  *al-standards-list*
  *ar-standards-list*
  *ca-standards-list*
  *co-standards-list*
  *ct-standards-list*
  *de-standards-list*
  *ga-standards-list*
  *hi-standards-list*
  *id-standards-list*
  *il-standards-list*
  *ks-standards-list*
  *ky-standards-list*
  *la-standards-list*
  *me-standards-list*
  *mi-standards-list*
  *md-standards-list*
  *ms-standards-list*
  *mo-standards-list*
  *mt-standards-list*
  *nh-standards-list*
  *nv-standards-list*
  *nj-standards-list*
  *nm-standards-list*
  *nc-standards-list*
  *nd-standards-list*
  *ny-standards-list*
  *oh-standards-list*
  *or-standards-list*
  *pa-standards-list*
  *ri-standards-list*
  *sd-standards-list*
  *tn-standards-list*
  *ut-standards-list*
  *vt-standards-list*
  *wa-standards-list*
  *wv-standards-list*
  *wi-standards-list*
  *wy-standards-list*
  )

(require "standards-cc-ela-dictionary.rkt")
(require "standards-cc-math-dictionary.rkt")

; given a state abbreviation and a list of 
; standards, producea standard-list where 
; each one is prefixed by the abbreviation
(define (state-prefix state stds)
  (map
    (lambda (std)
      (cons (string-append state "." (first std))
            (rest std)))
    stds))

; given a state, produce both math and ela standards,
; prefixed by the abbreviation for that state
(define (math-and-ela state)
  `(,@(state-prefix state *cc-math-standards-list*)
    ,@(state-prefix state *cc-ela-standards-list*)))

(define *al-standards-list* (math-and-ela "AL"))
(define *ar-standards-list* (math-and-ela "AR"))
(define *ca-standards-list* (math-and-ela "CA"))
(define *co-standards-list* (math-and-ela "CO"))
(define *ct-standards-list* (math-and-ela "CT"))
(define *de-standards-list* (math-and-ela "DE"))
(define *ga-standards-list* (math-and-ela "GA"))
(define *hi-standards-list* (math-and-ela "HI"))
(define *id-standards-list* (math-and-ela "ID"))
(define *il-standards-list* (math-and-ela "IL"))
(define *ks-standards-list* (math-and-ela "KS"))
(define *ky-standards-list* (math-and-ela "KY"))
(define *la-standards-list* (math-and-ela "LA"))
(define *me-standards-list* (math-and-ela "ME"))
(define *md-standards-list* (math-and-ela "MD"))
(define *mi-standards-list* (math-and-ela "MI"))
(define *ms-standards-list* (math-and-ela "MS"))
(define *mo-standards-list* (math-and-ela "MO"))
(define *mt-standards-list* (math-and-ela "MT"))
(define *nv-standards-list* (math-and-ela "NV"))
(define *nh-standards-list* (math-and-ela "NH"))
(define *nj-standards-list* (math-and-ela "NJ"))
(define *nm-standards-list* (math-and-ela "NM"))
(define *nc-standards-list* (math-and-ela "NC"))
(define *nd-standards-list* (math-and-ela "ND"))
(define *ny-standards-list* (math-and-ela "NY"))
(define *oh-standards-list* (math-and-ela "OH"))
(define *or-standards-list* (math-and-ela "OR"))
(define *pa-standards-list* (math-and-ela "PA"))
(define *ri-standards-list* (math-and-ela "RI"))
(define *sd-standards-list* (math-and-ela "SD"))
(define *tn-standards-list* (math-and-ela "TN"))
(define *ut-standards-list* (math-and-ela "UT"))
(define *vt-standards-list* (math-and-ela "VT"))
(define *wa-standards-list* (math-and-ela "WA"))
(define *wv-standards-list* (math-and-ela "WV"))
(define *wi-standards-list* (math-and-ela "WI"))
(define *wy-standards-list* (math-and-ela "WY"))
