#!/usr/bin/env racket

#lang racket

(define *args* (current-command-line-arguments))

(define *student-file* #f)
(define *admin-file* #f)
(define *final-file* #f)

(let ((n (vector-length *args*)))
  (cond ((<= n 0)
         (error 'sanitize.rkt "Missing filename argument"))
        (else
          (set! *student-file* (vector-ref *args* 0))
          (when (>= n 2)
            (set! *admin-file* (vector-ref *args* 1))
            (when (>= n 3)
              (set! *final-file* (vector-ref *args* 2)))))))

(define *student-file-basename*
  (regexp-replace "([^ ]+)-student.adoc" *student-file* "\\1"))

(when (string=? *student-file-basename* *student-file*)
  (set! *student-file-basename* (regexp-replace "(.*).adoc" *student-file* "\\1")))

(unless *admin-file*
  (set! *admin-file* (string-append *student-file-basename* "-admin.adoc")))

(unless *final-file*
  (set! *final-file* (string-append *student-file-basename* "-final.adoc")))

(define (question-asked? ln)
  (regexp-match
    "^// +(Required Question|Common Question|Question|_) +:.+?: *$"
    ln))

(define (collect-tags #:admin? [admin? #f])
  (let ((tags '()))
    (call-with-input-file (if admin? *admin-file* *student-file*)
      (lambda (i)
        (let loop ()
          (let ((ln (read-line i)))
            (unless (eof-object? ln)
              (cond (admin?
                      (when (regexp-match "^:[^ ]+: *$" ln)
                        (let ((tag (regexp-replace "^:([^ ]+):.*" ln "\\1")))
                          (set! tags (cons tag tags)))))
                    (else
                      (when (question-asked? ln)
                        (let ((tag
                                (regexp-replace
                                  "^// +(Required Question|Common Question|Question|_) +:(.+?): *$"
                                  ln "\\2")))
                          (set! tags (cons tag tags))))))
              (loop))))))
    (reverse tags)))

(define (check-tag-integrity)
  (let ((admin-tags (collect-tags #:admin? #t))
        (student-tags (collect-tags)))
    ;(printf "a-tags = ~a\n" admin-tags)
    ;(printf "s-tags = ~a\n" student-tags)
    (cond ((equal? admin-tags student-tags)
           (printf "Student file has all the tags in the right order\n")
           #t)
          (else
            (let ((num-admin-tags (length admin-tags))
                  (num-student-tags (length student-tags)))
              (cond ((< num-admin-tags num-student-tags)
                     (printf "Student file has extra tags\n"))
                    ((> num-admin-tags num-student-tags)
                     (printf "Student file missing tags\n")))
              (let loop ((i 0) (j 0))
                (unless (or (>= i num-admin-tags)
                            (>= j num-student-tags))
                  (let ((a-tag (list-ref admin-tags i))
                        (s-tag (list-ref student-tags j)))
                    (if (not (equal? a-tag s-tag))
                        (cond ((not (member s-tag admin-tags))
                               (printf "Student file has unrecognized tag ~a\n" s-tag)
                               (loop i (+ j 1)))
                              (else
                                (printf "Student file has tag ~a where admin file has ~a\n"
                                        s-tag a-tag)
                                (loop (+ i 1) (+ j 1))))
                        (loop (+ i 1) (+ j 1)))))))
            #f))))

(define (check-questions-answered)
  (call-with-input-file *student-file*
    (lambda (i)
      (let ((ok? #t))
        (let loop ()
          (let ((ln (read-line i)))
            (unless (eof-object? ln)
              ;(printf "XXX ln = ~s\n" ln)
              (when (regexp-match "^// +(Common|Required) Question +:.+:?: *$" ln)
                ;(printf "XXX found a common/reqd q ~s\n" ln)
                (let ((tag (regexp-replace "^// +(Common|Required) Question +(:.+?:) *$" ln "\\2"))
                      (answered? #f))
                  (let loop2 ()
                    (let ((ln (read-line i)))
                      ;(printf "XXX loop2 ln = ~s\n" ln)
                      (unless (or (eof-object? ln)
                                  (regexp-match "^include::" ln))
                        (cond ((regexp-match "^//" ln) #f)
                              ((regexp-match "^ *$" ln) #f)
                              (else (set! answered? #t)))
                        (unless answered? (loop2)))))
                  (unless answered?
                    (set! ok? #f)
                    (printf "Student file has unanswered question ~a\n" tag))))
              (loop))))
        (when ok?
          (printf "All required/common questions answered\n"))
        ok?))))

(define (common-answer-include? ln)
  (let ((x (regexp-match "^// +common-answer::(.*)" ln)))
    (and x
         (string-append "include::" (list-ref x 1)))))

(define (include-call? ln)
  (regexp-match "^include::(.*)\\[lines=([0-9]+)\\.\\.([-0-9]+)\\]" ln))

(define (include-file-fragment x o)
  (let ((f (list-ref x 1))
        (start-line (string->number (list-ref x 2)))
        (stop-line (string->number (list-ref x 3))))
    (set! f *admin-file*)
    (call-with-input-file f
      (lambda (i)
        (let loop ((k 1))
          (when (or (= stop-line -1) (<= k stop-line))
            (let ((x (read-line i)))
              (unless (eof-object? x)
                (when (>= k start-line)
                  (display x o) (newline o))
                (loop (+ k 1))))))))))

(define (insert-common? ln)
  (regexp-match "^ *:common: *$" ln))

(define (comment? ln)
  (regexp-match "^//" ln))

(define (section-header? ln)
  (regexp-match "^=+ " ln))

(define (check-common-answers)
  (let ((common-answer-inserted? #f)
        (common-answer-fragment #f))
    (call-with-input-file *student-file*
      (lambda (i)
        (call-with-output-file *final-file*
          (lambda (o)
            (fprintf o "[.datasheet]\n")
            (let ((track-question #f))
              (let loop ()
                (let ((ln (read-line i)))
                  (unless (eof-object? ln)
                    (cond ((common-answer-include? ln)
                           => (lambda (x) (set! common-answer-fragment x)))
                          ((section-header? ln)
                           (when (eq? track-question 'within-answer)
                             (set! track-question #f)
                             (fprintf o "--\n\n"))
                           (fprintf o "\n[.datasheet]\n")
                           (display ln o) (newline o))
                          ((include-call? ln)
                           => (lambda (x)
                                ;(printf "x = ~s\n" x)
                                (when (eq? track-question 'within-answer)
                                  (set! track-question #f)
                                  (fprintf o "--\n"))
                                (include-file-fragment x o)))
                          ((insert-common? ln)
                           (cond (common-answer-fragment
                                   (set! common-answer-inserted? #t)
                                   (include-file-fragment
                                     (include-call? common-answer-fragment) o)
                                   )
                                 (else
                                   (printf "WARNING: :common: used incorrectly\n"))))
                          ((comment? ln)
                           (when (question-asked? ln)
                             (set! track-question 'within-question))
                           #f)
                          (else
                            (when (eq? track-question 'within-question)
                              (set! track-question 'within-answer)
                              (fprintf o "\n[.answer]\n--\n"))
                            (display ln o) (newline o)))
                    (loop))))
              (when (eq? track-question 'within-answer) (fprintf o "--\n"))
              ))
          #:exists 'replace)))
    (when common-answer-inserted?
      (printf "Stock answers needed to be inserted\n"))
    #t))

(define (sanitize)
  (when (and (check-tag-integrity)
             (check-questions-answered)
             (check-common-answers))
    (printf "Sanitized form of ~s written to ~s\n" *student-file* *final-file*)))

(sanitize)

