#!/usr/bin/env racket

#lang racket

(define *admin-file*
  (let* ((args (current-command-line-arguments))
         (n (vector-length args)))
    (cond ((= n 0)
           (error 'make-questionnaire.rkt
                  "Missing filename argument:\nSupply name of datasheet spec file, e.g., datasheet-for-datasets-admin.adoc"))
          (else
            (let ((adminf (vector-ref args 0)))
            (when (> n 1)
              (printf "make-questionnaire.rkt given too many arguments: Only first one, ~s, used\n" adminf))
            adminf)))))

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
    "// PLEASE MODIFY TEXT BELOW THIS LINE FOR YOUR ANSWER.\n\n"))

(define *nudge-required*
  (string-append
    "//\n"
    "// PLEASE WRITE YOUR ANSWER BELOW THIS LINE.\n\n"))

(define *nudge-common*
  (string-append
    "//\n"
    "// PLEASE WRITE YOUR ANSWER BELOW.\n"
    "// (TO INSERT STANDARD REPLY, PLEASE WRITE :common:.)\n\n"))

(define *lineno* 0)

(define (read-a-line i)
  (let ((ln (read-line i)))
    (unless (eof-object? ln) (set! *lineno* (+ *lineno* 1)))
    ln))

(define (read-graf i #:non-trivial? [non-trivial? #f])
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
    (if (null? lines) (read-graf i #:non-trivial? non-trivial?)
        (values lines start-line stop-line))))

(define (tagged-graf? p)
  (let ((line0 (list-ref p 0)))
    (regexp-match "^:[^ ]+: *$" line0)))

(define (common-answer? p)
  (let ((line0 (list-ref p 0)))
    (regexp-match "^\\[.answer\\] *$" line0)))

(define (write-uncomment p o)
  ;(printf "XXX doing write-comment ~s\n" p)
  (let ((n (length p)))
    (let loop ((i 0))
      (unless (>= i n)
        (display (regexp-replace "^// *" (list-ref p i) "") o)
        (newline o)
        (loop (+ i 1))))))

(define (write-snippet p line1 line-last o i)
  (let* ((n (length p))
         (s1 (list-ref p 0))
         (s2 "")
         (question? #f)
         (required? #f)
         (common? #f)
         (next-snippet #f)
         (tag (regexp-replace "^(:.+:) *$" s1 "\\1")))
    (when (>= n 2) (set! s2 (list-ref p 1))
      (set! question? (regexp-match "\\.question" s2))
      (set! required? (regexp-match "\\.required" s2))
      (set! common? (regexp-match "\\.common" s2)))
    (fprintf o "include::~a[lines=~a..~a]\n" *admin-file* line1 line-last)
    (when common?
      ;(printf "XXX reading stock answer\n")
      (let-values (((ans-p ans-line0 ans-line-last) (read-graf i #:non-trivial? #t)))
        ;(printf "XXX stock ans = ~s\n" ans-p)
        (cond ((common-answer? ans-p)
               (fprintf o "// common-answer::~a[lines=~a..~a]\n"
                        *admin-file* (+ ans-line0 1) ans-line-last))
              (else
                (printf "Question ~a lacks stock answer\n" tag)
                (set! next-snippet (lambda ()
                                     (process-graf ans-p ans-line0 ans-line-last o i)))))))
    (display "//\n// " o)
    (display (cond (common? "Common Question")
                   (required? "Required Question")
                   (question? "Question")
                   (else "_")) o)
    (display " " o) (display s1 o) (newline o)
    (display "//" o) (newline o)
    (let loop ((i (if question? 2 1)))
      (unless (>= i n)
        (let ((s (list-ref p i)))
          (display "// " o) (display s o) (newline o))
        (loop (+ i 1))))
    (display "//\n" o)
    (when question?
      (display (cond (common? *nudge-common*)
                     (required? *nudge-required*)
                     (else *nudge*)) o)
      (unless (or common? required?)
        (display *lorem* o)))
    (newline o)
    (when next-snippet (next-snippet))))

(define (process-graf p line0 line-last o i)
  (cond ((null? p) #t)
        ((tagged-graf? p)
         (write-snippet p (+ line0 1) line-last o i))
        ((common-answer? p)
         (printf "Stray stock answer above line ~a\n" *lineno*))
        (else (write-uncomment p o)))
  (newline o))

(define (gen-student-file)
  (call-with-input-file *admin-file*
    (lambda (i)
      (call-with-output-file *student-file*
        (lambda (o)
          (let loop ()
            (let-values (((p line0 line-last) (read-graf i)))
              ;(printf "XXX ~s ~s ~s\n" p line0 line-last)
              (unless (eof-object? p)
                (process-graf p line0 line-last o i)
                (loop)))))
        #:exists 'replace))))

(gen-student-file)

