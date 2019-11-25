#lang racket

(provide
  mstring
  create-begin-tag
  create-end-tag
  enclose-tag
  enclose-span
  enclose-div
  enclose-textarea
  )

(define (mstring . strs)
  (string-join strs "\n"))

(define (create-begin-tag tag-name classes #:attribs [attribs #f])
  (let ([classes (if (string=? classes "") '()
                     (regexp-split #rx"\\." (substring classes 1)))])
    (string-append
      "@CURRICULUM" tag-name
      (cond [(pair? classes) (string-append
                               " class=\""
                               (string-join classes " ")
                               "\"")]
            [else ""])
      (or attribs "")
      "@BEGINCURRICULUM" tag-name)))

(define (create-end-tag tag-name)
  (string-append
    "@ENDCURRICULUM" tag-name))

(define (enclose-tag tag classes s #:attribs [attribs #f])
  (string-append
    (create-begin-tag tag classes #:attribs attribs)
    s
    (create-end-tag tag)))

(define (enclose-span classes s)
  (enclose-tag "span" classes s))

(define (enclose-div classes s)
  (enclose-tag "div" classes s))

(define (enclose-textarea classes s)
  (let ([textarea "tt"]) ;shd be "textarea" eventually
    (enclose-div ".obeyspaces"
                 (enclose-tag textarea classes s))))
