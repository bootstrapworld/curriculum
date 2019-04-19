#!/usr/bin/env racket

#lang racket

(define *workbook-index*
  (call-with-input-file "workbook-index.rkt" read))

(begin
  (system (format "rm -fr lessons"))

  (system (format "mkdir -p lessons"))
  (void))

(call-with-output-file "workbook-page-index.rkt"
  (lambda (o)
    (fprintf o "(~n")
    (for ((lesson *workbook-index*))
      (system (format "cp -pr $TOPDIR/lessons/~a/langs/en-us lessons/~a" lesson lesson))
      (let* ((lesson-index-file (format "lessons/~a/workbook-pages/lesson-index.rkt" lesson))
             (lesson-index
               (cond ((file-exists? lesson-index-file)
                      (call-with-input-file lesson-index-file read))
                     (else
                       (printf "WARNING: Lesson ~a is incorrectly organized~n" lesson)
                       '()))))
        (for ((page lesson-index))
          (fprintf o "(~s ~s)~n" lesson page))))
    (fprintf o ")~n")))

;(printf "returning from copy-lessons.rkt~n")

;(void)
