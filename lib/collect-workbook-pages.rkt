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

(define *lesson-order* (read-data-file "workbook-lessons.txt"))

(define (write-pages-info lesson-dir o #:paginate [paginate "yes"]
                          #:back-matter-port [back-matter-port #f])
  (let* ([workbook-pages-file (format "~a/pages/workbook-pages.txt" lesson-dir)]
         [exercise-pages-file (format "~a/pages/exercise-pages.txt.kp" lesson-dir)]
         [workbook-pages
           (cond [(file-exists? workbook-pages-file)
                  (read-data-file workbook-pages-file #:mode 'lines)]
                 [else
                   (printf "WARNING: missing ~a\n\n" workbook-pages-file)
                   '()])]
         [exercise-pages
           (cond [(not (truthy-getenv "ADDEXERCISES")) '()]
                 [(file-exists? exercise-pages-file)
                  (read-data-file exercise-pages-file #:mode 'files)]
                 [else
                   '()])])
    (let ([workbook-pages-ls-file (format "~a/pages/workbook-pages-ls.txt.kp" lesson-dir)])
      (with-handlers ([exn:fail?
                        (lambda (e)
                          (printf "WARNING: Couldn't open ~a\n" workbook-pages-ls-file))])
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
                (fprintf o "(~s ~s ~s ~s ~s)\n" lesson-dir file (gen-handle) aspect paginate)
                (when (and back-matter-port (contracts-page? lesson-dir file))
                  (fprintf back-matter-port "(~s ~s ~s ~s ~s)\n"
                           lesson-dir file (gen-handle) aspect paginate))
                ))
            ;
            (for ([file exercise-pages])
              (fprintf o "(~s ~s ~s ~s ~s)\n" lesson-dir file (gen-handle) "portrait" "no")))
          #:exists 'replace)))))

(define (contracts-page? dir file)
  (let ([f (build-path dir "solution-pages" file)])
    (and (file-exists? f)
         (call-with-input-file f
           (lambda (i)
             (let loop ([k 0])
               (if (>= k 10) #f
                   (let ([x (read-line i)])
                     (if (eof-object? x) #f
                         (if (regexp-match "^=.*(?i:contract)" x)
                             #t
                             (loop (+ k 1))))))))))))

(call-with-output-file "workbook-page-index.rkt"
  (lambda (o)
    (fprintf o "(\n")
    (write-pages-info "front-matter" o #:paginate "no")
    (for ([lesson-dir *lesson-order*])
      (write-pages-info lesson-dir o))
    (call-with-output-file "back-matter-contracts-index.rkt"
      (lambda (ob)
        (fprintf ob "(\n")
        (write-pages-info "back-matter" o #:paginate "no" #:back-matter-port ob)
        (fprintf ob ")\n")
        )
      #:exists 'replace)
    (fprintf o ")\n"))
  #:exists 'replace)

(void)

