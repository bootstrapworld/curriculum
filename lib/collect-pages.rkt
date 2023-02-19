#!/usr/bin/env racket

#lang racket

;last modified 2023-02-19

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
                      (display ", 'landscape'" o)
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
                       "distribution/~a/lessons/~a/pages/.cached/.exercise-pages-ls.txt.kp"
                       *natlang* lsn)]
                   [opt-exercises-asp-list-file
                     (format
                       "distribution/~a/lessons/~a/pages/.cached/.exercise-pages.lua"
                       *natlang* lsn)]
                   [workbook-exercises-list-file
                     (format
                       "distribution/~a/lessons/~a/pages/.cached/.workbook-exercise-pages-ls.txt.kp"
                       *natlang* lsn)]
                   [handout-exercises-list-file
                     (format
                       "distribution/~a/lessons/~a/pages/.cached/.handout-exercise-pages-ls.txt.kp"
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
                        (display "return {\n" o)
                        (let loop ()
                          (let ([x (read i)])
                            (unless (eof-object? x)
                              (display "  { '" o)
                              (display x o)
                              (display "'" o)
                              (add-aspect x lsn o)
                              (display " },\n" o)
                              (loop))))
                        (display "}\n" o))
                      #:exists 'replace)))))
            (loop)))))))

(collect-exercises (getenv "EXERCISE_COLLECTOR_INPUT"))
