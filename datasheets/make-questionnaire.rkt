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
  (let loop ((ss '()))
    (let ((ln (read-a-line i)))
      (cond ((eof-object? ln)
             (if (null? ss) ln (reverse ss)))
            ((regexp-match "^ *$" ln)
             (reverse ss))
            (else
              (loop (cons ln ss)))))))

(define (tagged-question? p)
  (let ((line0 (list-ref p 0)))
    (regexp-match "^:[^ ]+: *$" line0)))

(define (tagged-guideline? p)
  (let ((line0 (list-ref p 0)))
    (regexp-match "^:_[^ ]+: *$" line0)))

(define (header? p)
  (and (= (length p) 1)
       (regexp-match "^// *= *" (list-ref p 0))))

(define (write-snippet p o #:guideline? [guideline? #f])
  (let* ((n (length p))
         (s1 (list-ref p 0))
         (tag (regexp-replace "^:(.+): *$" s1 "\\1"))
         (tag-file (format ".~a-~a.adoc" *datasheet-name* tag)))
    ;(printf "doing tag ~a, tag-file ~a\n" tag tag-file)
    (call-with-output-file tag-file
      (lambda (tfo)
        (fprintf o "include::~a[]\n//\n" tag-file)
        (display (if guideline? "[.guideline]" "[.question]") tfo)
        (display "\n--\n" tfo)
        (let loop ((i 1))
          (unless (>= i n)
            (let ((s (list-ref p i)))
              (display s tfo) (newline tfo)
              (display "// " o) (display s o) (newline o))
            (loop (+ i 1))))
        (display "--\n" tfo))
      #:exists 'replace))
  (display "//\n" o)
  (unless guideline?
    (display *nudge* o)
    (display *lorem* o))
  (newline o))

(define (write-header p o)
  (display (regexp-replace "^// *" (list-ref p 0) "") o)
  (newline o)
  )

(define (gen-student-file)
  (call-with-input-file *admin-file*
    (lambda (i)
      (call-with-output-file *student-file*
        (lambda (o)
          (let loop ()
            (let ((p (read-graf i)))
              (unless (eof-object? p)
                (cond ((null? p) #t)
                      ((tagged-guideline? p) (write-snippet p o #:guideline? #t))
                      ((tagged-question? p) (write-snippet p o))
                      ((header? p) (write-header p o))
                      (else (printf "Ill-formed paragraph at l. ~a; discarding ~s\n" *lineno* p)))
                (newline o)
                (loop)))))
        #:exists 'replace))))

(gen-student-file)

