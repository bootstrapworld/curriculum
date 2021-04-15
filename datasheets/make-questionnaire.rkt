#!/usr/bin/env racket

#lang racket

(define *version* 3)

(define *admin-file*
  (let* ((args (current-command-line-arguments))
         (n (vector-length args)))
    (cond ((= n 0)
           (error 'make-questionnaire.rkt
                  "Missing filename argument:\nSupply name of datasheet spec file, e.g., datasheet-for-dataset-admin.adoc"))
          (else
            (let ((adminf (vector-ref args 0)))
            (when (> n 1)
              (printf "make-questionnaire.rkt given too many arguments: Only first one, ~s, used\n" adminf))
            adminf)))))

(define *datasheet-name*
  (regexp-replace "([^ ]+)-admin.adoc" *admin-file* "\\1"))

(define *author-file*
  (string-append *datasheet-name* "-author.adoc"))

(define tag-re "^// +tag::(.+?)\\[\\] *$")
(define common-answer-tag-re "^// +tag::(.+?-common-answer)\\[\\] *$")

(define (read-block i)
  (let ([line (read-line i)])
    (if (eof-object? line) (values 'eof #f #f)
        (cond [(regexp-match common-answer-tag-re line)
               => (lambda (r)
                    (let ([tag (cadr r)])
                      (read-tag-block i tag) (values 'admin #f #f)))]
              [(regexp-match tag-re line)
               => (lambda (r)
                    (let ([tag (cadr r)])
                      (values 'tag tag (read-tag-block i tag))))]
              [(regexp-match "^\\[\\.admin] *$" line) (read-admin-block i) (values 'admin #f #f)]
              [else (values 'passthru #f line)]))))

(define (end-tag-line? line tag)
  ;not really checking tag value for now
  (regexp-match "^// +end(.+?)\\[\\] *$" line))

(define (read-tag-block i tag)
  (let loop ([r '()])
    (let ([line (read-line i)])
      (cond [(eof-object? line) (error 'make-questionnaire.rkt "Unclosed tag ~a" tag)]
            [(end-tag-line? line tag) (reverse r)]
            [else (loop (cons line r))]))))

(define (read-admin-block i)
  (let ([line1 (read-line i)])
    (unless (eof-object? line1)
      (if (regexp-match "^-- *$" line1)
          (let loop ()
            (let ([line (read-line i)])
              (unless (or (eof-object? line) (regexp-match "^-- *$" line))
                (loop))))
          (let loop ()
            (let ([line (read-line i)])
              (unless (or (eof-object? line) (regexp-match "^ *$" line))
                (loop))))))))

(define (display-commented-tag tag lines o)
  (newline o)
  (fprintf o "include::~a[tag=~a]\n" *admin-file* tag)
  (for ([line lines])
    (fprintf o "// ~a\n" line))
  (newline o)
  )

(define (gen-author-file)
  (printf "Making questionnaire ~a from ~a\n" *author-file* *admin-file*)
  (call-with-input-file *admin-file*
    (lambda (i)
      (call-with-output-file *author-file*
        (lambda (o)
          (fprintf o "// Questionnaire generated from ~a by make-questionnaire.rkt v. ~a\n\n"
                   *admin-file* *version*)
          (let loop ()
            (let-values ([(type tag block) (read-block i)])
              (unless (eq? type 'eof)
                (case type
                  [(tag) (display-commented-tag tag block o)]
                  [(admin) #f]
                  [(passthru) (display block o) (newline o)]
                  [else (error ' gen-author-file "read-block returned illegal block type")])
                (loop)))))
        #:exists 'replace))))

(gen-author-file)

