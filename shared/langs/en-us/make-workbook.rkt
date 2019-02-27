#!/usr/bin/env racket

#lang racket

(define *workbook-page-specs*
  (call-with-input-file "workbook-index.rkt" read))

(define *lessons* '())

(for ((spec *workbook-page-specs*))
  (let ((lesson (car spec)))
    (unless (member lesson *lessons*)
      (set! *lessons* (cons lesson *lessons*)))))

(for ((lesson *lessons*))
  (system (format "cp -pr $TOPDIR/distribution/lessons/~a lessons" lesson)))

(define *pdf-pages*
  (map (lambda (f)
         (let ((f (string-append "lessons/" (car f) "/langs/en-us/" (cadr f))))
           (when (path-has-extension? f #".adoc")
             (set! f (path-replace-extension f ".pdf")))
           f))
       *workbook-page-specs*))

(define *workbook-pdf* "workbook/workbook.pdf")

(printf "building ~a from PDF pages ~a~n" *workbook-pdf* *pdf-pages*)

(let ((pdftk-args (append *pdf-pages* (list "output" *workbook-pdf* "dont_ask"))))
  (apply system* (cons (find-executable-path "pdftk") pdftk-args)))

(void)
