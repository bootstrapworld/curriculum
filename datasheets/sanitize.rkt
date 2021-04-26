#!/usr/bin/env racket

#lang racket

(define *version* 3)

(define *args* (current-command-line-arguments))

(define *author-file* #f)
(define *admin-file* #f)

(let ([n (vector-length *args*)])
  (cond [(<= n 0)
         (error 'sanitize.rkt "Missing filename argument")]
        [else
          (set! *author-file* (vector-ref *args* 0))]))

(define *author-file-basename*
  (regexp-replace "([^ ]+)-author.adoc" *author-file* "\\1"))

(when (string=? *author-file-basename* *author-file*)
  (set! *author-file-basename* (regexp-replace "(.*).adoc" *author-file* "\\1")))

(define *final-file* (format "~a-final.adoc" *author-file-basename*))

(define (name-final-file i)
  (let ([dataset-name #f])
    (let loop ()
      (let ([ln (read-line i)])
        (cond [(eof-object? ln) #f]
              [(regexp-match "^//" ln) (loop)]
              [(regexp-match "^ *$" ln) (loop)]
              [else (set! dataset-name (string-trim ln))])))
    (when dataset-name
      (let ([prefix
              (cond [*admin-file*
                      (let ([admin-prefix
                              (regexp-replace
                                "([^ ]+)-dataset-admin.adoc" *admin-file* "\\1")])
                        (if (string=? admin-prefix *admin-file*)
                            "datasheet-for" admin-prefix))]
                    [else "datasheet-for"])])
        (set! *final-file*
          (format "~a-~a.adoc" prefix dataset-name))
        (when (string=? *final-file* *author-file*)
          (set! *final-file* (format "final-~a" *author-file*)))
        ))))

(define (skip-to-answer i)
  (let loop ()
    (let ([ln (read-line i)])
      (cond [(eof-object? ln) #f]
            [(regexp-match "^//" ln) (loop)]
            [(regexp-match "^ *$" ln) (loop)]
            [else (string-trim ln)]))))

(define admin-tag-re "^// +tag::(.+?)\\[\\] *$")

(define author-tag-re #f)

(define (tag? ln admin?)
  (let ([x (regexp-match (if admin? admin-tag-re author-tag-re) ln)])
    (cond [(not x) #f]
          [else (if (regexp-match "-common-answer" ln) #f x)])))

(define (question-type? cblk)
  (if (= (length cblk) 0) #f
      (let ([q-line (car cblk)])
        (if (regexp-match "\\[\\.question" q-line)
            (cond [(regexp-match "\\.common" q-line) 'common]
                  [(regexp-match "\\.optional" q-line) 'optional]
                  [(regexp-match "\\.required" q-line) 'required]
                  [else #t])
            #f))))

(define (read-comment-block i)
  (let loop ([r '()])
    (let ([ln (read-line i)])
      (cond [(eof-object? ln) (values (reverse r) ln)]
            [(regexp-match "^//" ln) (loop (cons ln r))]
            [else (values (reverse r) ln)]))))

(define (read-answer-block first-line i)
  (let loop ([ln first-line] [r '()])
    (unless ln (set! ln (read-line i)))
    (cond  [(or (eof-object? ln)
                (tag? ln #f)
                (regexp-match "^=" ln))
            (values (reverse r) ln)]
           [else (loop (read-line i) (cons ln r))])))

(define (non-null-block? b)
  (ormap (lambda (ln) (not (regexp-match "^ *$" ln))) b))

(define (display-block b o)
  (for ([ln b])
    (display ln o) (newline o)))

(define (collect-tags #:admin? [admin? #f])
  (let ([tags '()])
    (call-with-input-file (if admin? *admin-file* *author-file*)
      (lambda (i)
        (let loop ()
          (let ([ln (read-line i)])
            (unless (eof-object? ln)
              (cond [(tag? ln admin?)
                     => (lambda (r)
                          (let ([tag (cadr r)])
                            (set! tags (cons tag tags))
                            (when (string=? tag "dataset-name")
                              (name-final-file i))))]
                    [else #f])
              (loop))))))
    (reverse tags)))

(define (find-admin-file)
  (call-with-input-file *author-file*
    (lambda (i)
      (let ([ln (read-line i)])
        (unless (eof-object? ln)
          (let ([x (regexp-match "Questionnaire generated from ([^ ]+)" ln)])
            (when x (set! *admin-file* (list-ref x 1))))))))
  (unless *admin-file*
    (set! *admin-file* "datasheet-for-dataset-admin.adoc"))
  ;(printf "*admin-file* is ~s\n" *admin-file*)
  (set! author-tag-re (format "^@include{~a, tag=(.+?)} *$" *admin-file*))
  ;(printf "author-tag-re is ~s\n" author-tag-re)
  )

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
        (let loop ([ln #f])
          (unless ln (set! ln (read-line i)))
          (unless (eof-object? ln)
            (let ([next-line #f])
              (cond [(tag? ln #f)
                     => (lambda (tag-holder)
                          (let-values ([(q next-ln) (read-comment-block i)])
                            ;(printf "comment-block = ~s\n" q)
                            (set! next-line next-ln)
                            (let ([q-type (question-type? q)])
                              (when q-type
                                (let-values ([(ans next-ln) (read-answer-block next-ln i)])
                                  ;(printf "ans-block = ~s\n" ans)
                                  (set! next-line next-ln)
                                  (let ([ans-given? (non-null-block? ans)])
                                    (when (not ans-given?)
                                      (cond [(eq? q-type 'optional)
                                             (printf "Author file has unanswered optional question: ~a\n"
                                                     (cadr tag-holder))
                                             (set! optional-q-answered? #f)]
                                            [(eq? q-type 'required)
                                             (printf "Author file has unanswered required question: ~a\n"
                                                     (cadr tag-holder))]
                                            [else #f]))))))))]
                    [else #f])
              (loop next-line))))
        (when optional-q-answered?
          (printf "All optional questions answered\n")))
      #t)))

(define (create-final-file)
  (call-with-input-file *author-file*
    (lambda (i)
      (printf "Final file is ~a\n" *final-file*)
      (call-with-output-file *final-file*
        (lambda (o)
          ;(fprintf o "// Do not edit this file! Regenerate instead!\n")
          (fprintf o "// Sanitized from ~a by sanitize.rkt v. ~a.\n"
                   *author-file* *version*)
          (fprintf o "//\n")
          ;(fprintf o "[.datasheet]\n")
          (let loop ([ln #f])
            (unless ln (set! ln (read-line i)))
            (unless (eof-object? ln)
              (let ([next-line #f])
                (cond [(tag? ln #f)
                       => (lambda (tag-holder)
                            (let-values ([(q next-ln) (read-comment-block i)])
                              (set! next-line next-ln)
                              (let ([q-type (question-type? q)])
                                (when q-type
                                  (let-values ([(ans next-ln) (read-answer-block next-line i)])
                                    (set! next-line next-ln)
                                    (let ([ans-given? (non-null-block? ans)])
                                      (cond [(and (eq? q-type 'common) (not ans-given?))
                                             (display ln o) (newline o)
                                             (display-block q o)
                                             (fprintf o "[.answer]\n--\n")
                                             (fprintf o
                                                      "\n@include{~a, tag=~a-common-answer}\n\n"
                                                      *admin-file*
                                                      (cadr tag-holder))
                                             (fprintf o "--\n") ]
                                            [(and (eq? q-type 'optional) (not ans-given?))
                                             #f]
                                            [else
                                              (display ln o) (newline o)
                                              (display-block q o)
                                              (fprintf o "[.answer]\n--\n")
                                              (display-block ans o)
                                              (fprintf o "--\n")
                                              ]))
                                    )))))]
                      [else
                        (display ln o) (newline o)])
                (loop next-line)))))
        #:exists 'replace))))

(define (sanitize)
  (find-admin-file)
  (when (and (check-tag-integrity)
             (check-questions-answered)
             (create-final-file))
    #t))

(sanitize)

