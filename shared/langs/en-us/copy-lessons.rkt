#!/usr/bin/env racket

#lang racket

(define lparen #\()
(define rparen #\))

(define *workbook-index*
  (call-with-input-file "workbook-index.rkt" read))

(begin
  (system (format "rm -fr lessons"))

  (system (format "mkdir -p lessons"))
  (void))

(call-with-output-file "workbook-page-index.rkt"
  (lambda (o)
    (fprintf o "~c~n" lparen)
    (for ((lesson *workbook-index*))
      (system (format "cp -pr $TOPDIR/lessons/~a/langs/en-us lessons/~a" lesson lesson))
      (let ((lesson-index
              (call-with-input-file
                (format "lessons/~a/workbook-pages/lesson-index.rkt" lesson) read)))
        (for ((page lesson-index))
          (fprintf o "(~s ~s)~n" lesson page))))
    (fprintf o "~c~n" rparen))) 

;(printf "returning from copy-lessons.rkt~n")

;(void)
