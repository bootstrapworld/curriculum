#!/usr/bin/env racket

#lang racket

(define *handle-prefix* "")
(define *handle-counter* 0)

(define *char-code-before-A* (sub1 (char->integer #\A)))

(define (zero-out-handle)
  (set! *handle-prefix* "")
  (set! *handle-counter* 0))

(define (gen-handle)
  (set! *handle-counter* (+ *handle-counter* 1))
  (when (> *handle-counter* 26)
    (set! *handle-prefix* (string-append *handle-prefix* "Z"))
    (set! *handle-counter* 1))
  (format "~a~a" *handle-prefix* (integer->char (+ *char-code-before-A* *handle-counter*))))

;

(define *lesson-order*
  (call-with-input-file "lesson-order.rkt" read))

(define *language* (getenv "LANGUAGE"))

(call-with-output-file "lessons/lessons.txt"
  (lambda (o)
    (for ([lesson *lesson-order*])
      (display lesson o) (newline o)))
  #:exists 'replace)

(call-with-output-file "workbook-page-index.rkt"
  (lambda (o)
    (fprintf o "(\n")
    (for ([lesson *lesson-order*])
      (system (format "mkdir -p lessons/~a" lesson))
      ;(system (format "cp -pr $TOPDIR/lessons/~a/langs/~a/* lessons/~a" lesson *language* lesson))
      (let ([lesson-dir (format "~a/lessons/~a/langs/~a" (getenv "TOPDIR") lesson *language*)])
        (unless (empty? (directory-list lesson-dir))
          (system (format "cp -pr ~a/* lessons/~a" lesson-dir lesson))))
      (let* ([workbook-pages-file (format "lessons/~a/pages/workbook-pages.rkt" lesson)]
             [workbook-pages
               (cond [(file-exists? workbook-pages-file)
                      (call-with-input-file workbook-pages-file read)]
                     [else
                       (printf "WARNING: ~a missing workbook-pages.rkt\n" lesson)
                       ;(printf "WARNING: Lesson ~a is incorrectly organized\n" lesson)
                       '()])])
        (for ([page workbook-pages])
          (let ([file page]
                [aspect "portrait"]
                [paginate "yes"])
            (when (pair? page)
              (let ([len (length page)])
                (set! file (car page))
                (set! aspect (cadr page))
                (when (>= len 3)
                  (set! paginate (caddr page)))))
            (fprintf o "(~s ~s ~s ~s ~s)\n" lesson file (gen-handle) aspect paginate)))))
    (fprintf o ")\n"))
  #:exists 'replace)

;(printf "returning from copy-lessons.rkt\n")
