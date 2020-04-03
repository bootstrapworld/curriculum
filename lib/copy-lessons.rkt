#!/usr/bin/env racket

#lang racket

(require "utils.rkt")

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

(define *lesson-order* (read-data-file "lesson-order.txt"))

(define *language* (getenv "LANGUAGE"))

(call-with-output-file "lessons/lessons.txt"
  (lambda (o)
    (for ([lesson *lesson-order*])
      (display lesson o) (newline o)))
  #:exists 'replace)

(define (write-pages-info lesson-dir o #:paginate [paginate "yes"])
  (let* ([workbook-pages-file (format "~a/pages/workbook-pages.txt" lesson-dir)]
         [workbook-pages
           (cond [(file-exists? workbook-pages-file)
                  (read-data-file workbook-pages-file #:lists #t)]
                 [else
                   (printf "WARNING: missing ~a\n" workbook-pages-file)
                   '()])])
    (unless (null? workbook-pages)
      (let ([workbook-pages-ls-file (format "~a/pages/workbook-pages.txt.kp" lesson-dir)])
        (call-with-output-file workbook-pages-ls-file
          (lambda (o2)
            (for ([page workbook-pages])
              (let ([file (list-ref page 0)]
                    [aspect "portrait"]
                    [n (length page)])
                (when (>= n 2)
                  (set! aspect (list-ref page 1)))
                (when (>= n 3)
                  (set! paginate (list-ref page 2)))
                (fprintf o2 "~a\n" file)
                (fprintf o "(~s ~s ~s ~s ~s)\n" lesson-dir file (gen-handle) aspect paginate))))
          #:exists 'replace)))))

(call-with-output-file "workbook-page-index.rkt"
  (lambda (o)
    (fprintf o "(\n")
    (write-pages-info "front-matter" o #:paginate "no")
    (for ([lesson *lesson-order*])
      (let ([lesson-dir (string-append "lessons/" lesson)])
        (system (format "mkdir -p ~a" lesson-dir))
        (let ([orig-lesson-dir (format "~a/~a/langs/~a" (getenv "TOPDIR") lesson-dir *language*)])
          (unless (empty? (directory-list orig-lesson-dir))
            (system (format "cp -pr ~a/* ~a" orig-lesson-dir lesson-dir))))
        (write-pages-info lesson-dir o)))
    (write-pages-info "back-matter" o #:paginate "no")
    (fprintf o ")\n"))
  #:exists 'replace)

;(printf "returning from copy-lessons.rkt\n")

(void)

