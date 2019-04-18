#!/usr/bin/env racket

#lang racket

(define (make-workbook protected?)

  (define *workbook-page-specs*
    (call-with-input-file "workbook-page-index.rkt" read))

  ;(printf "*workbook-page-specs* = ~s~n" *workbook-page-specs*)

  (define *lessons* '())

  (for ((spec *workbook-page-specs*))
    (let ((lesson (car spec)))
      (unless (member lesson *lessons*)
        (set! *lessons* (cons lesson *lessons*)))))

  (define *pdf-pages*
    (map (lambda (f)
           (let ((f (string-append "lessons/" (car f)
                                   (if protected? "/workbook-sols-pages/" "/workbook-pages/")
                                   (cadr f))))
             (when (path-has-extension? f #".adoc")
               (set! f (path-replace-extension f ".pdf")))
             f))
         *workbook-page-specs*))

  ;(printf "*pdf-pages* = ~s~n" *pdf-pages*)

  (define *workbook-pdf*
    (if protected?
        "workbook/workbook-sols.pdf" "workbook/workbook.pdf"))

  (printf "~nbuilding ~a from PDF pages ~a~n" *workbook-pdf* *pdf-pages*)

  (unless (null? *pdf-pages*)
    (let ((pdftk-args (append *pdf-pages* (list "output" *workbook-pdf* "dont_ask"))))
      (apply system* (cons (find-executable-path "pdftk") pdftk-args)))

    (when protected?
      (system (format "mv ~a resources/protected" *workbook-pdf*)))
    )

  )

(make-workbook #f)

(make-workbook #t)

(void)
