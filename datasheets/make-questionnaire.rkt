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

(define *author-file*
  (string-append *datasheet-name* "-author.adoc"))

(define *lineno* 0)

(define (read-a-line i)
  (let ((ln (read-line i)))
    (unless (eof-object? ln) (set! *lineno* (+ *lineno* 1)))
    ln))

(define (read-graf i)
  (let* ([start-line (+ *lineno* 1)]
         [stop-line -1]
         [inside-double-dash? #f]
         [lines (let loop ([ss '()])
                  (let ([ln (read-a-line i)])
                    (cond [(eof-object? ln)
                           (if (null? ss) ln (reverse ss))]
                          [(regexp-match "^ *$" ln)
                           (set! stop-line *lineno*)
                           (reverse ss)]
                          [(regexp-match "^-- *$" ln)
                           (set! inside-double-dash? (not inside-double-dash?))
                           (loop (cons ln ss))]
                          [else (loop (cons ln ss))])))])
    (if (null? lines)
        (read-graf i)
        (values lines start-line stop-line))))

(define (question-graf? p)
  (let ([n (length p)])
    (if (<= n 2) #f
        (let ([l1 (list-ref p 0)]
              [l2 (list-ref p 1)])
          (and (regexp-match "^:[^ ]+: *$" l1)
               (and
                 (regexp-match "\\.question" l2)
                 (not (regexp-match "\\.common" l2))))))))

(define (header-graf? p)
  (and (= (length p) 1)
       (regexp-match "^=" (list-ref p 0))))

(define (write-graf p o)
  (display "\n" o)
  (let ([n (length p)])
    (let loop ([i 0])
      (unless (>= i n)
        (display (list-ref p i) o) (display "\n" o)
        (loop (+ i 1))))))

(define (write-question p line0 line-last o i)
  (let* ([n (length p)]
         [s1 (list-ref p 0)]
         [s2 ""]
         [tag (regexp-replace "^(:.+:) * $" s1 "\\1")])
    (when (>= n 2) (set! s2 (list-ref p 1)))
    (write-include p (+ line0 1) line-last o)
    (flush-includes o)
    (display "// " o)
    (display "Question " o)
    (display s1 o) (display "\n" o)
    (display "//\n" o)
    (let loop ([i 2])
      (unless (>= i n)
        (let ([s (list-ref p i)])
          (display "// " o) (display s o) (display "\n" o))
        (loop (+ i 1))))
    (display "//\n\n\n\n" o)))

(define *accumulating-includes?* #f)
(define *include-start* #f)
(define *include-stop* #f)

(define (write-include p line0 line-last o)
  (cond [*accumulating-includes?* (set! *include-stop* line-last)]
        [else (set! *accumulating-includes?* #t)
              (set! *include-start* line0)
              (set! *include-stop* line-last)]))

(define (flush-includes o)
  (when *accumulating-includes?*
    (fprintf o "include::~a[lines=~a..~a]\n" *admin-file* *include-start* *include-stop*)
    (set! *accumulating-includes?* #f)))

(define (process-graf p line0 line-last o i)
  (cond [(null? p) (flush-includes o) #t]
        [(question-graf? p)
         (write-question p line0 line-last o i)]
        [(header-graf? p)
         (flush-includes o)
         (write-graf p o)]
        [else (write-include p line0 line-last o)])
  )

(define (gen-author-file)
  (call-with-input-file *admin-file*
    (lambda (i)
      (call-with-output-file *author-file*
        (lambda (o)
          (let loop ()
            (let-values (((p line0 line-last) (read-graf i)))
              ;(printf "XXX ~s ~s ~s\n" p line0 line-last)
              (unless (eof-object? p)
                (process-graf p line0 line-last o i)
                (loop)))))
        #:exists 'replace))))

(gen-author-file)

