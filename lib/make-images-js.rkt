#!/usr/bin/env racket

#lang racket

(require "readers.rkt")

(define read-group
  (*make-read-group identity 
                    (lambda ()
                      (format "Collecting images"))))

(define (expand-some-directives i o)
  (let loop ()
    (let ([c (read-char i)])
      (unless (eof-object? c)
        (cond [(char=? c #\@)
               (let ([directive (read-word i)])
                 (cond [(string=? directive "link")
                        (let* ([args (read-commaed-group i directive read-group)]
                               [link (first args)]
                               [text (string-join (rest args) ", ")])
                          (fprintf o "<a href=~s>~a</a>"
                                   link text))]
                       [else (display #\@ o) (display directive)]))]
              [else (display c o)])
        (loop)))))

(let ([image-files (getenv "IMAGE_LIST_FILE")]
      [json-file (getenv "IMAGE_JS_FILE")])
  (call-with-input-file image-files
    (lambda (i)
      (call-with-output-file json-file
        (lambda (o)
          (let ([first-lesson-p #t])
            (display "var images = {\n" o)
            (for ([bi (read i)])
              (let ([lesson-basename (first bi)]
                    [lesson-image-file (second bi)])
                (cond [first-lesson-p (set! first-lesson-p #f)]
                      [else (display ",\n" o)])
                (write lesson-basename o)
                (display ": " o)
                (call-with-input-file lesson-image-file
                  (lambda (i)
                    (expand-some-directives i o)))))
            (display "}\n" o)))
        #:exists 'replace))))
