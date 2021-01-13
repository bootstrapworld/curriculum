#!/usr/bin/env racket

#lang racket

(define *student-file*
  (vector-ref (current-command-line-arguments) 0))

(define *datasheet-name*
  (regexp-replace "([^ ]+)-student.adoc" *student-file* "\\1"))

(define *admin-file*
  (string-append *datasheet-name* "-admin.adoc"))

(define *final-file*
  (string-append *datasheet-name* "-final.adoc"))

;(printf "student-file = ~a\n" *student-file*)
;(printf "admin-file = ~a\n" *admin-file*)
;(printf "datasheet-name = ~a\n" *datasheet-name*)

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
                      (when (regexp-match
                              "^// +(Required Question|Common Question|Question|_) +:.+?: *$"
                              ln)
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

(define (insert-common? ln)
  (regexp-match "^ *:common: *$" ln))

(define (check-common-answers)
  (let ((common-answer-inserted? #f)
        (common-answer-fragment #f))
    (call-with-input-file *student-file*
      (lambda (i)
        (call-with-output-file *final-file*
          (lambda (o)
            (let loop ()
              (let ((ln (read-line i)))
                (unless (eof-object? ln)
                  (cond ((common-answer-include? ln)
                         => (lambda (x) (set! common-answer-fragment x)))
                        ((insert-common? ln)
                         (cond (common-answer-fragment
                                 (set! common-answer-inserted? #t)
                                 (fprintf o "\n~a\n\n" common-answer-fragment))
                               (else
                                 (printf "WARNING: :common: used incorrectly\n"))))
                        (else (display ln o) (newline o)))
                  (loop)))))
          #:exists 'replace)))
    (when common-answer-inserted?
      (printf "Stock answers needed to be inserted\n")
      )))

(define (sanitize)
  (and
    (check-tag-integrity)
    (check-questions-answered)
    (check-common-answers))
  (void))

(sanitize)

