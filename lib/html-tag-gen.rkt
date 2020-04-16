#lang racket

(require "utils.rkt")

(provide
  create-begin-tag
  create-end-tag
  enclose-tag
  enclose-span
  enclose-div
  enclose-textarea
  enclose-math

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

(define (enclose-textarea classes s #:multi-line [multi-line #f])
  (let ([textarea "tt"]) ;shd be "textarea" eventually
    (let ([ta (enclose-tag textarea classes s)])
      (if multi-line
          (enclose-div ".obeyspaces" ta)
          ta))))

(define (enclose-math e)
  (string-append
    (format "%CURRICULUMSCRIPT%")
    (format "%BEGINCURRICULUMSCRIPT%\\displaystyle ")
    e
    (format "%ENDCURRICULUMSCRIPT%")))

;for the @span{...}{...}

(struct span (real? [nesting #:mutable]))

(define *span-stack* '())

(define (span-stack-present?)
  (pair? *span-stack*))

(define (top-span-stack)
  (span-nesting (car *span-stack*)))

(define (grow-span-stack span-type)
  (set! *span-stack* (cons (span span-type 0) *span-stack*)))

(define (pop-span-stack)
  (let ([a (car *span-stack*)])
    (set! *span-stack* (cdr *span-stack*))
    a))

(define (increment-top-span-stack)
  (let* ([top-span (car *span-stack*)]
        [n (span-nesting top-span)])
    (set-span-nesting! top-span (+ n 1))))

(define (decrement-top-span-stack)
  (let* ([top-span (car *span-stack*)]
         [n (span-nesting top-span)])
    (when (<= n 0)
      (error 'ERROR "Bad @span: Check missing braces"))
    (set-span-nesting! top-span (- n 1))))

(define (display-begin-span span-args o #:attribs [attribs #f])
  (cond [span-args
          (grow-span-stack 'real-span)
          (display (create-begin-tag "span" span-args #:attribs attribs) o)]
        [else (grow-span-stack #f)]))

(define (display-end-span o)
  (when (span-real? (pop-span-stack))
    (display (create-end-tag "span") o)))
