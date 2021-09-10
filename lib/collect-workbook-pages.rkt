#!/usr/bin/env racket

#lang racket

(require "utils.rkt")

(define *pag-handle-prefix* "")
(define *pag-handle-counter* 0)

(define *nonpag-handle-prefix* "N")
(define *nonpag-handle-counter* 0)

(define *char-code-before-A* (sub1 (char->integer #\A)))

(define (gen-handle-pag)
  (set! *pag-handle-counter* (+ *pag-handle-counter* 1))
  (when (> *pag-handle-counter* 26)
    (set! *pag-handle-prefix* (string-append *pag-handle-prefix* "Z"))
    (set! *pag-handle-counter* 1))
  (format "~a~a" *pag-handle-prefix* (integer->char (+ *char-code-before-A* *pag-handle-counter*))))

(define (gen-handle-nonpag)
  (set! *nonpag-handle-counter* (+ *nonpag-handle-counter* 1))
  (when (> *nonpag-handle-counter* 26)
    (set! *nonpag-handle-prefix* (string-append *nonpag-handle-prefix* "Z"))
    (set! *nonpag-handle-counter* 1))
  (format "~a~a" *nonpag-handle-prefix* (integer->char (+ *char-code-before-A* *nonpag-handle-counter*))))

;

(define *pageno* 0)

(define *lesson-order* (read-data-file ".cached/.workbook-lessons.txt.kp"))

(define (write-pages-info lesson-dir o ol oe #:pageno [pageno "yes"]
                          #:back-matter-port [back-matter-port #f])
  ;(printf "doing write-pages-info pageno = ~s\n" pageno)
  (let* ([workbook-pages-file (format "~a/pages/.cached/.workbook-pages.txt.kp" lesson-dir)]
         [workbook-pages-ls-file (format "~a/pages/.cached/.workbook-pages-ls.txt.kp" lesson-dir)]
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
    (with-handlers ([exn:fail?
                      (lambda (e)
                        (printf "WARNING: collect-workbook-pages.rkt failed at ~s\n" lesson-dir)
                        ;((error-display-handler) (exn-message e) e)
                        ;(printf "WARNING: Couldn't open ~a\n" workbook-pages-ls-file)
                        )])
      (call-with-output-file workbook-pages-ls-file
        (lambda (o2)
          (for ([page workbook-pages])
            (let ([file (list-ref page 0)]
                  [aspect "portrait"]
                  [this-pageno pageno]
                  [n (length page)])
              (when (>= n 2)
                (set! aspect (list-ref page 1)))
              (when (>= n 3)
                (set! this-pageno (list-ref page 2)))
              (when (string-ci=? this-pageno "yes")
                (set! *pageno* (+ *pageno* 1))
                (set! this-pageno *pageno*))
              ;(printf "this-pageno = ~s\n" this-pageno)
              (fprintf o2 "~a\n" file)
              (let ([handle (gen-handle-pag)])
                (fprintf o "(~s ~s ~s ~s ~s)\n" lesson-dir file handle aspect this-pageno)
                (fprintf ol "(~s ~s ~s ~s ~s)\n" lesson-dir file handle aspect this-pageno)
                (when (and back-matter-port (contracts-page? lesson-dir file))
                  (fprintf back-matter-port "(~s ~s ~s ~s ~s)\n"
                           lesson-dir file handle aspect this-pageno)))
              ))
          ;
          )
        #:exists 'replace)
      (for ([page exercise-pages])
        (let ([file (list-ref page 0)]
              [aspect "portrait"]
              [n (length page)])
          (when (>= n 2)
            (set! aspect (list-ref page 1)))
          (let ([handle (gen-handle-nonpag)])
          (fprintf ol "(~s ~s ~s ~s ~s)\n" lesson-dir file handle aspect "no")
          (fprintf oe "(~s ~s ~s ~s ~s)\n" lesson-dir file handle aspect "no")
          ))))))

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
            (write-pages-info "front-matter" o ol oe #:pageno "no")
            (for ([lesson-dir *lesson-order*])
              (write-pages-info lesson-dir o ol oe))
            (call-with-output-file ".cached/.back-matter-contracts-index.rkt"
              (lambda (ob)
                (fprintf ob "(\n")
                ;TODO skip if dir nonexistent
                (write-pages-info "back-matter" o ol oe #:pageno "no" #:back-matter-port ob)
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
