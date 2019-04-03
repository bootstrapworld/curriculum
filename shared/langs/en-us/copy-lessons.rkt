#!/usr/bin/env racket

#lang racket

(define *workbook-index*
  (call-with-input-file "workbook-index.rkt" read))

(begin
  (system (format "rm -fr lessons"))

  (system (format "mkdir -p lessons"))
  (void))

(for ((lesson *workbook-index*))
  (system (format "cp -pr $TOPDIR/lessons/~a/langs/en-us lessons/~a" lesson lesson))
  )

(define (create-modified-workbook-index student?)
  (call-with-output-file
    (if student? "workbook-page-index.rkt" "workbook-sols-page-index.rkt")
    (lambda (o)
      (fprintf o "(~n")
      (for ((lesson *workbook-index*))
        (let* ((lesson-index-file
                 (format "lessons/~a/workbook-pages/~a" lesson
                         (if student? "lesson-index.rkt" "lesson-sols-index.rkt")))
               (lesson-index
                 (if (file-exists? lesson-index-file)
                     (call-with-input-file lesson-index-file read) '())))
          (for ((page lesson-index))
            (fprintf o "(~s ~s)~n" lesson page))))
      (fprintf o ")~n"))))

(create-modified-workbook-index #t)

(create-modified-workbook-index #f)

;(printf "returning from copy-lessons.rkt~n")

;(void)
