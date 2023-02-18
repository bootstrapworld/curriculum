#!/usr/bin/env racket

#lang racket

(require "readers.rkt")
(require "utils.rkt")

(define read-group
  (*make-read-group (lambda z "")
                    (lambda ()
                      (format "Collecting exercises"))))

(define (read-first-arg i directive)
  (let ([c (peek-char i)])
    (cond [(char=? c #\{) (read-char i)
                          (let loop ([r '()])
                            (let ([c (read-char i)])
                              (cond [(eof-object? c) ""]
                                    [(or (char=? c #\,) (char=? c #\}))
                                     (string-trim (list->string (reverse r)))]
                                    [else (loop (cons c r))])))]
          [else ""])))

(define *natlang* (getenv "NATLANG"))

(define (scan-exercise-directives i proglang)
  (let ([opt-exercises-files '()]
        [workbook-exercises-files '()]
        [handout-exercises-files '()])
    (let loop ()
      (let ([c (read-char i)])
        (unless (eof-object? c)
          (when (char=? c #\@)
            (let ([directive (read-word i)])
              ;(printf "ce directive= ~s\n" directive)
              (cond [(member directive
                             '("opt-printable-exercise" "printable-exercise" "handout"))
                     (let* ([page (read-first-arg i directive)]
                            [compts (string-split page "/")]
                            [num-compts (length compts)])
                       ;(printf "doing ex ~s ~s\n" directive page)
                       (when (<= 1 num-compts 2)
                         (let ([f (list-ref compts (- num-compts 1))])
                           (cond [(string=? directive "opt-printable-exercise")
                                  (unless (member f opt-exercises-files)
                                    (set! opt-exercises-files
                                      (cons f opt-exercises-files)))]
                                 [(string=? directive "printable-exercise")
                                  (unless (member f workbook-exercises-files)
                                    (set! workbook-exercises-files
                                      (cons f workbook-exercises-files)))]
                                 [(string=? directive "handout")
                                  (unless (member f handout-exercises-files)
                                    (set! handout-exercises-files
                                      (cons f handout-exercises-files)))]))))]
                    [(string=? directive "scrub")
                     (read-group i directive)]
                    [(string=? directive "ifproglang")
                     (let ([proglang1 (read-group i directive)])
                       (unless (string=? proglang1 proglang)
                         (read-group i directive)))])))
          (loop))))
    (set! opt-exercises-files (reverse opt-exercises-files))
    (values opt-exercises-files workbook-exercises-files handout-exercises-files)))

(define (add-aspect x lsn o)
  (let ([file (format "distribution/~a/lessons/~a/pages/~a" *natlang* lsn x)])
    (when (file-exists? file)
      (call-with-input-file file
        (lambda (i)
          (let loop ([n 5])
            (unless (< n 0)
              (let ([x (read-line i)])
                (unless (eof-object? x)
                  (if (regexp-match "^ *\\[\\.landscape\\] *$" x)
                      (display "landscape" o)
                      (loop (- n 1))))))))))))

(define (collect-exercises f)
  ; (printf "doing collect-exercises ~s~%" f)
  (call-with-input-file f
    (lambda (i)
      (let loop ()
        (let ([x (read i)])
          (unless (eof-object? x)
            (let* ([lsn (car x)]
                   [proglang (cadr x)]
                   [opt-exercises-list-file
                     (format
                       "distribution/~a/lessons/~a/pages/.cached/.exercises-pages-ls.txt.kp"
                       *natlang* lsn)]
                   [opt-exercises-asp-list-file
                     (format
                       "distribution/~a/lessons/~a/pages/.cached/.exercises-pages.txt.kp"
                       *natlang* lsn)]
                   [workbook-exercises-list-file
                     (format
                       "distribution/~a/lessons/~a/pages/.cached/.workbook-exercises-pages-ls.txt.kp"
                       *natlang* lsn)]
                   [handout-exercises-list-file
                     (format
                       "distribution/~a/lessons/~a/pages/.cached/.handout-exercises-pages-ls.txt.kp"
                       *natlang* lsn)]
                   [lsn-plan-file (format "distribution/~a/lessons/~a/index.adoc" *natlang* lsn)])
              ; (printf "collecting exx for ~s ~s~%" lsn proglang)
              (let-values ([(opt-exercises-files
                              workbook-exercises-files
                              handout-exercises-files)
                            (call-with-input-file lsn-plan-file
                              (lambda (i) (scan-exercise-directives i proglang)))])
                (call-with-output-file opt-exercises-list-file
                  (lambda (o)
                    (for ([f opt-exercises-files])
                      (display f o) (newline o)))
                  #:exists 'replace)
                (call-with-output-file workbook-exercises-list-file
                  (lambda (o)
                    (for ([f workbook-exercises-files])
                      (display f o) (newline o)))
                  #:exists 'replace)
                (call-with-output-file handout-exercises-list-file
                  (lambda (o)
                    (for ([f handout-exercises-files])
                      (display f o) (newline o)))
                  #:exists 'replace)

                (call-with-input-file opt-exercises-list-file
                  (lambda (i)
                    (call-with-output-file opt-exercises-asp-list-file
                      (lambda (o)
                        (let loop ()
                          (let ([x (read i)])
                            (unless (eof-object? x)
                              (display x o)
                              (add-aspect x lsn o)
                              (newline o)
                              (loop)))))
                      #:exists 'replace)))))
            (loop)))))))

(collect-exercises (getenv "EXERCISE_COLLECTOR_INPUT"))

;

;(printf "doing collect-workbook-pages.rkt\n")

(define (write-pages-info lesson-dir o ol oe #:pageno [pageno "true"]
                          #:back-matter-port [back-matter-port #f])
  ; (printf "doing write-pages-info lesson-dir= ~s pageno= ~s\n" lesson-dir pageno)
  (let* ([workbook-pages-file
           (format "distribution/~a/lessons/~a/pages/.cached/.workbook-pages.txt.kp"
                   *natlang* lesson-dir)]
         [exercise-pages-file
           (format "distribution/~a/lessons/~a/pages/.cached/.exercises-pages.txt.kp"
                   *natlang* lesson-dir)]
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
                   ; (printf "WARNING: missing ~a\n\n" exercise-pages-file)
                   '()])])
    ; (printf "workbook-pages= ~s\n" workbook-pages)
    ; (printf "exercise-pages= ~s\n" exercise-pages)
    (with-handlers ([exn:fail?
                      (lambda (e)
                        (printf "WARNING: collect-workbook-pages.rkt failed at ~s\n" lesson-dir)
                        ; (printf "EXN: ~s\n"  e)
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

(define (collect-workbooks f)
  (call-with-input-file f
    (lambda (i)
      (let loop ()
        (let ([course (read i)])
          ; (printf "collecting workbooks for ~s~%" course)
          (unless (eof-object? course)
            (let ([lesson-order
                    (read-data-file
                      (format "distribution/~a/courses/~a/.cached/.workbook-lessons.txt.kp"
                              *natlang* course))]
                  [workbook-page-index-file
                    (format "distribution/~a/courses/~a/.cached/.workbook-page-index.rkt"
                            *natlang* course)]
                  [workbook-long-page-index-file
                    (format "distribution/~a/courses/~a/.cached/.workbook-long-page-index.rkt"
                            *natlang* course)]
                  [opt-exercises-index-file
                    (format "distribution/~a/courses/~a/.cached/.opt-exercises-index.rkt"
                            *natlang* course)])
              ; (printf "lesson-order is ~s~%" lesson-order)
              (call-with-output-file workbook-page-index-file
                (lambda (o)
                  (call-with-output-file workbook-long-page-index-file
                    (lambda (ol)
                      (call-with-output-file opt-exercises-index-file
                        (lambda (oe)
                          (fprintf o "(\n")
                          (fprintf ol "(\n")
                          (fprintf oe "(\n")
                          ;TODO skip if dir nonexistent
                          (write-pages-info "front-matter" o ol oe #:pageno "false")
                          (for ([lsn lesson-order])
                            (write-pages-info lsn o ol oe))
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
                #:exists 'replace))
            (loop)))))))

(collect-workbooks (getenv "COURSE_INPUT"))
