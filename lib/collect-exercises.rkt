#!/usr/bin/env racket

#lang racket

(define (read-word i)
  (let loop ([r '()])
    (let ([c (peek-char i)])
      (if (or (char-alphabetic? c) (char=? c #\-))
          (loop (cons (read-char i) r))
          (if (null? r) ""
              (list->string (reverse r)))))))

(define *exercises-list-file* "pages/exercise-pages.txt.kp")

(define *exercises-files* '())

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
            (when (string=? directive "exercise-link")
              (let* ([page (read-first-arg i directive)]
                     [compts (string-split page "/")])
                (when (= (length compts) 2)
                  (set! *exercises-files*
                    (cons (cadr compts) *exercises-files*)))))))
        (loop)))))

(define (collect-exercises lesson-plan-file)
  ;(printf "doing collect-exercises ~s\n" lesson-plan-file)
  (call-with-input-file lesson-plan-file
    (lambda (i)
      (scan-exercise-directives i)))
  (unless (null? *exercises-files*)
    ;(printf "writing collected exercises\n")
    (set! *exercises-files* (reverse *exercises-files*))
    (call-with-output-file *exercises-list-file*
      (lambda (o)
        (for ([f *exercises-files*])
          (display f o) (newline o)))
      #:exists 'replace)))

(collect-exercises
  (vector-ref (current-command-line-arguments) 0))
