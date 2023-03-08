#!/usr/bin/env racket

#lang racket

(require "utils.rkt")

;

;(printf "doing collect-workbook-pages.rkt\n")

(define *lesson-order* (read-data-file ".cached/.workbook-lessons.txt.kp"))

(define (write-pages-info lesson-dir o ol oe #:pageno [pageno "true"]
                          #:back-matter-port [back-matter-port #f])
  ;(printf "doing write-pages-info lesson-dir= ~s pageno= ~s\n" lesson-dir pageno)
  (let* ([workbook-pages-file (format "~a/pages/.cached/.workbook-pages.txt.kp" lesson-dir)]
         [exercise-pages-file (format "~a/pages/.cached/.exercise-pages.txt.kp" lesson-dir)]
         [workbook-pages
           (cond [(file-exists? workbook-pages-file)
                  (read-data-file workbook-pages-file #:mode 'lines)]
                 [else
                   ;(printf "WARNING: missing ~a\n\n" workbook-pages-file)
                   '()])]
         [exercise-pages
           (cond [(file-exists? exercise-pages-file)
                  (read-data-file exercise-pages-file #:mode 'lines)]
                 [else
                   '()])])
    ;(printf "workbook-pages= ~s\n" workbook-pages)
    (with-handlers ([exn:fail?
                      (lambda (e)
                        (printf "WARNING: collect-workbook-pages.rkt failed at ~s\n" lesson-dir)
                        (printf "EXN: ~s\n"  e)
                        ;((error-display-handler) (exn-message e) e)
                        )])
          (for ([page workbook-pages])
            (let ([file (list-ref page 0)]
                  [aspect "portrait"]
                  [this-pageno pageno]
                  [n (length page)])
              (when (>= n 2)
                (set! aspect (list-ref page 1)))
              (when (>= n 3)
                (set! this-pageno (list-ref page 2)))
              ;(printf "this-pageno = ~s\n" this-pageno)
              ;(fprintf o2 "~a\n" file)
              (fprintf o "(~s ~s ~s ~s)\n" lesson-dir file aspect this-pageno)
              (fprintf ol "(~s ~s ~s ~s)\n" lesson-dir file aspect this-pageno)
              (when (and back-matter-port (contracts-page? lesson-dir file))
                (fprintf back-matter-port "(~s ~s ~s ~s)\n"
                         lesson-dir file aspect this-pageno))
              ))
          ;
      (for ([page exercise-pages])
        (let ([file (list-ref page 0)]
              [aspect "portrait"]
              [n (length page)])
          (when (>= n 2)
            (set! aspect (list-ref page 1)))
          (fprintf ol "(~s ~s ~s ~s)\n" lesson-dir file aspect "false")
          (fprintf oe "(~s ~s ~s ~s)\n" lesson-dir file aspect "false")
          )))))

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

(call-with-output-file ".cached/.workbook-page-index.rkt"
  (lambda (o)
    (call-with-output-file ".cached/.workbook-long-page-index.rkt"
      (lambda (ol)
        (call-with-output-file ".cached/.opt-exercises-index.rkt"
          (lambda (oe)
            (fprintf o "(\n")
            (fprintf ol "(\n")
            (fprintf oe "(\n")
            ;TODO skip if dir nonexistent
            (write-pages-info "front-matter" o ol oe #:pageno "false")
            (for ([lesson-dir *lesson-order*])
              (write-pages-info lesson-dir o ol oe))
            (call-with-output-file ".cached/.back-matter-contracts-index.rkt"
              (lambda (ob)
                (fprintf ob "(\n")
                ;TODO skip if dir nonexistent
                (write-pages-info "back-matter" o ol oe #:pageno "false" #:back-matter-port ob)
                (fprintf ob ")\n")
                )
              #:exists 'replace)
            (fprintf o ")\n")
            (fprintf ol ")\n")
            (fprintf oe ")\n")
            )
          #:exists 'replace))
      #:exists 'replace))
  #:exists 'replace)

(void)