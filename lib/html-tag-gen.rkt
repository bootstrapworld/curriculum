#lang racket

(provide
  create-begin-tag
  create-end-tag
  enclose-tag
  enclose-span
  enclose-div
  enclose-openblock
  enclose-textarea
  enclose-textarea-2
  enclose-math

  erase-span-stack!
  span-stack-present?
  top-span-stack
  increment-top-span-stack
  decrement-top-span-stack
  display-begin-span
  display-end-span

  string-multiply
  fitb
  hspace
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

(define (enclose-span classes s #:attribs [attribs #f])
  (enclose-tag "span" classes s #:attribs attribs))

(define (enclose-div classes s #:attribs [attribs #f])
  (enclose-tag "div" classes s #:attribs attribs))

(define *openblock-nesting-level* 0)

(define (enclose-openblock classes s #:attribs [attribs #f])
  (let ([old-openblock-nesting-level *openblock-nesting-level*]
        [delimiter (make-string (+ 5 *openblock-nesting-level*) #\=)])
    (set! *openblock-nesting-level* (+ old-openblock-nesting-level 1))
    (let ([result
            (string-append
              "\n++++"
              "\n<!-- %BEGINOPENBLOCKATTRIBS%" (if attribs (string-append " " attribs) "") "%ENDOPENBLOCKATTRIBS% -->"
              "\n++++\n"
              "[.actually-openblock" classes "]\n"
              delimiter "\n"
              (s) "\n"
              delimiter "\n")])
      (set! *openblock-nesting-level* old-openblock-nesting-level)
      result)))

(define (enclose-textarea classes s #:multiline? [multiline? #f])
  (let ([textarea "code"]) ;shd be "textarea" eventually
    (let ([ta (enclose-tag textarea classes s)])
      (if multiline?
          (enclose-span ".obeyspaces" ta)
          ta))))

(define (enclose-textarea-2 classes s #:multiline? [multiline? #f])
  ;(printf "doing enclose-textarea-2 ~s\n" s)
  (set! classes ".codetwo")
  (let ([ta (enclose-tag "span" classes s)])
    (if multiline? (enclose-span ".obeyspaces" ta)
        ta)))

(define (enclose-math e)
  ;(printf "enclose-math of ~s\n" e)
  (string-append
    "%CURRICULUMMATHJAXMARKER%"
    "\\displaystyle "
    e
    "%CURRICULUMMATHJAXMARKER%"))

;for the @span{...}{...}

(struct span (real? [nesting #:mutable]))

(define *span-stack* '())

(define (erase-span-stack!)
  (set! *span-stack* '()))

(define (span-stack-present?)
  (pair? *span-stack*))

(define (top-span-stack)
  (span-nesting (first *span-stack*)))

(define (grow-span-stack span-type)
  (set! *span-stack* (cons (span span-type 0) *span-stack*)))

(define (pop-span-stack)
  (let ([a (first *span-stack*)])
    (set! *span-stack* (rest *span-stack*))
    a))

(define (increment-top-span-stack)
  (let* ([top-span (first *span-stack*)]
        [n (span-nesting top-span)])
    (set-span-nesting! top-span (+ n 1))))

(define (decrement-top-span-stack)
  (let* ([top-span (first *span-stack*)]
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

(define (string-multiply s n)
  (let loop ([n n] [r ""])
    (if (= n 0) r
        (loop (- n 1) (string-append r s)))))

(define (fitb width text [show? #t])
  (string-append
    (if (string=? width "")
        (create-begin-tag "span" ".fitb" #:attribs "style=\"flex-grow: 1\"")
        (create-begin-tag "span" ".fitb" #:attribs (format "style=\"width: ~a\"" width)))
    (if show? text "")
    (create-end-tag "span")))

(define (hspace width)
  (string-append
    (create-begin-tag "span" ".quad" #:attribs
                      (format "style=\"width: ~a\"" width))
    (create-end-tag "span"))
  )
