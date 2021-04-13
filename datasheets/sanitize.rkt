#!/usr/bin/env racket

#lang racket

(define *args* (current-command-line-arguments))

(define *author-file* #f)
(define *admin-file* #f)

(let ((n (vector-length *args*)))
  (cond ((<= n 0)
         (error 'sanitize.rkt "Missing filename argument"))
        (else
          (set! *author-file* (vector-ref *args* 0))
          )))

(define *author-file-basename*
  (regexp-replace "([^ ]+)-author.adoc" *author-file* "\\1"))

(when (string=? *author-file-basename* *author-file*)
  (set! *author-file-basename* (regexp-replace "(.*).adoc" *author-file* "\\1")))

(define *final-file* (string-append *author-file-basename* "-final.adoc"))

(define (question-asked? ln)
  (let ([m (regexp-match
             "^// +Question +:(.+?): *$"
             ln)])
    (and m (list-ref m 1))))

(define (skip-to-answer i)
  (let loop ()
    (let ([ln (read-line i)])
      (cond [(eof-object? ln) #f]
            [(regexp-match "^//" ln) (loop)]
            [(regexp-match "^ *$" ln) (loop)]
            [else (string-trim ln)]))))

(define (collect-tags #:admin? [admin? #f])
  (let ([tags '()])
    (call-with-input-file (if admin? *admin-file* *author-file*)
      (lambda (i)
        (let loop ()
          (let ([ln (read-line i)])
            (unless (eof-object? ln)
              (cond [admin?
                      (when (regexp-match "^:[^ ]+: *$" ln)
                        (let ([ln2 (read-line i)])
                          (when (and (string? ln2)
                                     (and (regexp-match "\\.question" ln2)
                                          (not (regexp-match "\\.common" ln2))))
                            (let ([tag (regexp-replace "^:([^ ]+):.*" ln "\\1")])
                              (set! tags (cons tag tags))))))]
                    [else (when (question-asked? ln)
                            (let ([tag (regexp-replace
                                         "^// +Question +:(.+?): *$" ln "\\1")])
                              (when (string=? tag "dataset-name")
                                (let ([ans (skip-to-answer i)])
                                  (when ans
                                    (let ([prefix
                                            (cond [*admin-file*
                                                    (let ([admin-prefix
                                                            (regexp-replace
                                                              "([^ ]+)-dataset-admin.adoc"
                                                              *admin-file* "\\1")])
                                                      (if (string=? admin-prefix *admin-file*)
                                                          "datasheet-for" admin-prefix))]
                                                  [else "datasheet-for"])])
                                      (set! *final-file*
                                        (string-append prefix "-" ans ".adoc"))))))
                              (set! tags (cons tag tags))))])
              (loop))))))
    (reverse tags)))

(define (find-admin-file)
  (call-with-input-file *author-file*
    (lambda (i)
      (let ([ln (read-line i)])
        (unless (eof-object? ln)
          (let ([x (regexp-replace ".*from ([^ ]+) *$" ln "\\1")])
            (unless (string=? x ln)
              (set! *admin-file* x)))))))
  (unless *admin-file*
    (set! *admin-file* "datasheet-for-dataset-admin.adoc")))

(define (check-tag-integrity)
  (let ((admin-tags (collect-tags #:admin? #t))
        (author-tags (collect-tags)))
    ;(printf "a-tags = ~a\n" admin-tags)
    ;(printf "s-tags = ~a\n" author-tags)
    (cond ((equal? admin-tags author-tags)
           (printf "Author file has all the tags in the right order\n")
           #t)
          (else
            (let ((num-admin-tags (length admin-tags))
                  (num-author-tags (length author-tags)))
              (cond ((< num-admin-tags num-author-tags)
                     (printf "Author file has extra tags\n"))
                    ((> num-admin-tags num-author-tags)
                     (printf "Author file missing tags\n")))
              (let loop ((i 0) (j 0))
                (unless (or (>= i num-admin-tags)
                            (>= j num-author-tags))
                  (let ((a-tag (list-ref admin-tags i))
                        (s-tag (list-ref author-tags j)))
                    (if (not (equal? a-tag s-tag))
                        (cond ((not (member s-tag admin-tags))
                               (printf "Author file has unrecognized tag ~a\n" s-tag)
                               (loop i (+ j 1)))
                              (else
                                (printf "Author file has tag ~a where admin file has ~a\n"
                                        s-tag a-tag)
                                (loop (+ i 1) (+ j 1))))
                        (loop (+ i 1) (+ j 1)))))))
            #f))))

(define (check-questions-answered)
  (call-with-input-file *author-file*
    (lambda (i)
      (let ([optional-q-answered? #t])
        (let loop ()
          (let ((ln (read-line i)))
            (unless (eof-object? ln)
              ;(printf "ZZZ ln = ~s\n" ln)
              (when (regexp-match "^// +Question +:.+?: *$" ln)
                (let ([tag (regexp-replace "^// +Question +(:.+?:) *$" ln "\\1")]
                      [answered? #f])
                  (let loop2 ()
                    (let ([ln (read-line i)])
                      (unless (or (eof-object? ln)
                                  (regexp-match "^include::" ln))
                        (cond [(regexp-match "^//" ln) #f]
                              [(regexp-match "^ *$" ln) #f]
                              [else (set! answered? #t)])
                        (unless answered? (loop2)))))
                  (unless answered?
                    (set! optional-q-answered? #f)
                    (printf "Author file has unanswered optional question ~a\n" tag))
                  )
                )
              (loop))))
        (when optional-q-answered?
          (printf "All optional questions answered\n"))
        #t
        ))))

(define (include-call? ln)
  (regexp-match "^include::(.*)\\[lines=([0-9]+)\\.\\.([-0-9]+)\\]" ln))

(define (include-file-fragment x o)
  (let ((f (list-ref x 1))
        (start-line (string->number (list-ref x 2)))
        (stop-line (string->number (list-ref x 3))))
    (call-with-input-file f
      (lambda (i)
        (let loop ((k 1))
          (when (or (= stop-line -1) (<= k stop-line))
            (let ((x (read-line i)))
              (unless (eof-object? x)
                (when (>= k start-line)
                  (unless (regexp-match "^:[^ ]+: *$" x)
                    (display x o) (newline o)))
                (loop (+ k 1))))))))))

(define (comment? ln)
  (regexp-match "^//" ln))

(define (section-header? ln)
  (regexp-match "^=+ " ln))

(define (create-final-file)
  (call-with-input-file *author-file*
    (lambda (i)
      (printf "Final file is ~a\n" *final-file*)
      (call-with-output-file *final-file*
        (lambda (o)
          (fprintf o "// Do not edit this file! Regenerate instead!\n")
          (fprintf o "// Generated by `sanitize.rkt ~a` in the datasheets/ directory.\n" 
                   *author-file*)
          (fprintf o "//\n")
          (fprintf o "[.datasheet]\n")
          (let ([track-question #f])
            (let loop ()
              (let ([ln (read-line i)])
                (unless (eof-object? ln)
                  (cond [(section-header? ln)
                         (when (eq? track-question 'within-answer)
                           (set! track-question #f)
                           (fprintf o "--\n\n"))
                         (fprintf o "\n[.datasheet]\n")
                         (display ln o) (newline o)]
                        [(include-call? ln)
                         (when (eq? track-question 'within-answer)
                           (set! track-question #f)
                           (fprintf o "--\n\n"))
                         (display ln o) (newline o)]
                        [(comment? ln)
                         (display ln o) (newline o)
                         (let ([tag (question-asked? ln)])
                           (when tag (set! track-question 'within-question))
                           )]
                        [else
                          (when (eq? track-question 'within-question)
                            (set! track-question 'within-answer)
                            (fprintf o "\n[.answer]\n--\n"))
                          (display ln o) (newline o)])
                  (loop))))
            (when (eq? track-question 'within-answer)
              (fprintf o "--\n"))
            ))
        #:exists 'replace))))

(define (sanitize)
  (find-admin-file)
  (when (and (check-tag-integrity)
             (check-questions-answered)
             (create-final-file))
    (call-with-output-file ".expanded-file"
      (lambda (o)
        (display *final-file* o) (newline o))
      #:exists 'replace)
    (printf "Sanitized form of ~s written to ~s\n" *author-file* *final-file*)))

(sanitize)

