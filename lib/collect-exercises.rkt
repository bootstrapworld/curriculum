#!/usr/bin/env racket

#lang racket

(require "readers.rkt")

(define read-group
  (*make-read-group (lambda z "")
                    (lambda ()
                      (format "Collecting exercises in ~a" (current-directory)))))

; (define *proglang* (string-downcase (getenv "PROGLANG")))

(define *proglang* "pyret")

(define *opt-exercises-list-file* "pages/.cached/.exercise-pages-ls.txt.kp")

(define *workbook-exercises-list-file* "pages/.cached/.workbook-exercise-pages-ls.txt.kp")

(define *handout-exercises-list-file* "pages/.cached/.handout-exercise-pages-ls.txt.kp")

(define *opt-exercises-files* '())

(define *workbook-exercises-files* '())

(define *handout-exercises-files* '())

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

(define (scan-exercise-directives i)
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
                                (unless (member f *opt-exercises-files*)
                                  (set! *opt-exercises-files*
                                    (cons f *opt-exercises-files*)))]
                               [(string=? directive "printable-exercise")
                                (unless (member f *opt-exercises-files*)
                                  (set! *opt-exercises-files*
                                    (cons f *opt-exercises-files*)))]
                               [(string=? directive "handout")
                                (unless (member f *handout-exercises-files*)
                                  (set! *handout-exercises-files*
                                    (cons f *handout-exercises-files*)))]))))]
                  [(string=? directive "scrub")
                   (read-group i directive)]
                  [(string=? directive "ifproglang")
                   (let ([proglang (read-group i directive)])
                     (unless (string=? proglang *proglang*)
                       (read-group i directive)))])))
        (loop)))))

(define (collect-exercises lesson-plan-file proglang)
  (set! *proglang* proglang)
  ; (printf "doing collect-exercises ~s ~s\n" *proglang* lesson-plan-file)
  (call-with-input-file lesson-plan-file scan-exercise-directives)
  ; (printf "writing collected exercises ~s ~s\n" *opt-exercises-files* *workbook-exercises-files* *handout-exercises-files*)
  (set! *opt-exercises-files* (reverse *opt-exercises-files*))
  (call-with-output-file *opt-exercises-list-file*
    (lambda (o)
      (for ([f *opt-exercises-files*])
        (display f o) (newline o)))
    #:exists 'replace)
  (call-with-output-file *workbook-exercises-list-file*
    (lambda (o)
      (for ([f *workbook-exercises-files*])
        (display f o) (newline o)))
    #:exists 'replace)
  (call-with-output-file *handout-exercises-list-file*
    (lambda (o)
      (for ([f *handout-exercises-files*])
        (display f o) (newline o)))
    #:exists 'replace)
  )

(apply collect-exercises
  (vector->list (current-command-line-arguments)))
