#lang racket

(require "utils.rkt")

(provide
  create-begin-tag
  create-end-tag
  enclose-tag
  enclose-span
  enclose-div
  enclose-textarea

  span-stack-present?
  top-span-stack
  increment-top-span-stack
  decrement-top-span-stack
  display-begin-span
  display-end-span
  )

(define (create-begin-tag tag-name classes #:attribs [attribs #f])
  (let ([classes (if (string=? classes "") '()
                     (regexp-split #rx"\\." (substring classes 1)))])
    (string-append
      "%CURRICULUM" tag-name "%"
      (if (pair? classes) (string-append
                            " class=\""
                            (string-join classes " ")
                            "\"")
          "")
      (if attribs (string-append " " attribs) "")
      "%BEGINCURRICULUM" tag-name "%")))

(define (create-end-tag tag-name)
  (string-append
    "%ENDCURRICULUM" tag-name "%"))

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

;for the @span{...}{...}

(define *span-stack* '())

(define (span-stack-present?)
  (pair? *span-stack*))

(define (top-span-stack)
  (car *span-stack*))

(define (grow-span-stack)
  (set! *span-stack* (cons 0 *span-stack*)))

(define (pop-span-stack)
  (set! *span-stack* (cdr *span-stack*)))

(define (increment-top-span-stack)
  (let ([n (car *span-stack*)])
    (set! *span-stack* (cons (+ n 1) (cdr *span-stack*)))))

(define (decrement-top-span-stack)
  (let ([n (car *span-stack*)])
    (when (<= n 0)
      (ferror 'span "Bad @span: Check missing braces"))
    (set! *span-stack* (cons (- n 1) (cdr *span-stack*)))))

(define (display-begin-span span-args o)
  (grow-span-stack)
  (display (create-begin-tag "span" span-args) o))

(define (display-end-span o)
  (pop-span-stack)
  (display (create-end-tag "span") o))
