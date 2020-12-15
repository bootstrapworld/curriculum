#!/usr/bin/env racket

#lang racket

(define *student-file*
  (vector-ref (current-command-line-arguments) 0))

(define *datasheet-name*
  (regexp-replace "([^ ]+)-student.adoc" *student-file* "\\1"))

(define *admin-file*
  (string-append *datasheet-name* "-admin.adoc"))

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
                              (format "^include::\\.~a-([^ ]+)\\.adoc\\[\\]" *datasheet-name*) ln)
                        (let ((tag (regexp-replace
                                     (format "^include::\\.~a-([^ ]+)\\.adoc.*" *datasheet-name*)
                                     ln "\\1")))
                          (set! tags (cons tag tags))))))
              (loop))))))
    (reverse tags)))

(define (sanitize)
  (let ((admin-tags (collect-tags #:admin? #t))
        (student-tags (collect-tags)))
    ;(printf "a-tags = ~a\n" admin-tags)
    ;(printf "s-tags = ~a\n" student-tags)
    (if (equal? admin-tags student-tags)
        (printf "Student file is OK\n")
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
                  (loop (+ i 1) (+ j 1))))))))))

(sanitize)

