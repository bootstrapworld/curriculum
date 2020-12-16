#!/usr/bin/env racket

#lang racket

(define *admin-file*
  (vector-ref (current-command-line-arguments) 0))

(define *datasheet-name*
  (regexp-replace "([^ ]+)-admin.adoc" *admin-file* "\\1"))

(define *student-file*
  (string-append *datasheet-name* "-student.adoc"))

(define *lorem*
  (string-append
    "Ad rem est vero cum ratione. Optio dolor molestiae consequatur\n"
    "perferendis sint amet eligendi. Minus unde odit quod officia sit\n"
    "ut impedit facilis. Voluptatum alias illo et dolore impedit aut\n"
    "vitae qui. Laborum itaque ipsa possimus et.\n"))

(define *nudge*
  (string-append
    "//\n"
    "// PLEASE MODIFY TEXT BELOW THIS LINE FOR YOUR ANSWER.\n"
    "//\n"))

(define *lineno* 0)

(define (read-a-line i)
  (let ((ln (read-line i)))
    (unless (eof-object? ln) (set! *lineno* (+ *lineno* 1)))
    ln))

(define (read-graf i)
  (let* ((start-line (+ *lineno* 1))
         (stop-line -1)
         (inside-double-dash? #f)
         (lines
           (let loop ((ss '()))
             (let ((ln (read-a-line i)))
               (cond ((eof-object? ln)
                      (if (null? ss) ln (reverse ss)))
                     ((regexp-match "^ *$" ln)
                      (cond (inside-double-dash? (loop (cons ln ss)))
                            (else (set! stop-line *lineno*) 
                                  (reverse ss))))
                     ((regexp-match "^-- *$" ln)
                      (set! inside-double-dash? (not inside-double-dash?))
                      (loop (cons ln ss)))
                     (else
                       (loop (cons ln ss))))))))
    (values lines start-line stop-line)))

(define (tagged-graf? p)
  (let ((line0 (list-ref p 0)))
    (regexp-match "^:[^ ]+: *$" line0)))

(define (write-uncomment p o)
  (let ((n (length p)))
    (let loop ((i 0))
      (unless (>= i n)
        (display (regexp-replace "^// *" (list-ref p 0) "") o)
        (newline o)
        (loop (+ i 1))))))

(define (write-snippet p line1 line-last o)
  (let* ((n (length p))
         (s1 (list-ref p 0))
         (question? (let ((s2 ""))
                      (when (>= n 2) (set! s2 (list-ref p 1)))
                      (regexp-match "question" s2)))
         (tag (regexp-replace "^:(.+): *$" s1 "\\1")))
    (fprintf o "include::~a[lines=~a..~a]\n//\n" *admin-file* line1 line-last)
    (when question?
      (display "// Question " o) (display s1 o) (newline o)
      (display "//" o) (newline o))
    (let loop ((i (if question? 2 1)))
      (unless (>= i n)
        (let ((s (list-ref p i)))
          (display "// " o) (display s o) (newline o))
        (loop (+ i 1))))
    (display "//\n" o)
    (when question?
      (display *nudge* o)
      (display *lorem* o))
    (newline o)))

(define (gen-student-file)
  (call-with-input-file *admin-file*
    (lambda (i)
      (call-with-output-file *student-file*
        (lambda (o)
          (let loop ()
            (let-values (((p line0 line-last) (read-graf i)))
              (unless (eof-object? p)
                (cond ((null? p) #t)
                      ((tagged-graf? p) (write-snippet p (+ line0 1) line-last o))
                      (else (write-uncomment p o)))
                (newline o)
                (loop)))))
        #:exists 'replace))))

(gen-student-file)

