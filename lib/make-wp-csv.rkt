#! /usr/bin/env racket

#lang racket

(require file/sha1)
(require racket/date)

(define *dist-en-us* "distribution/en-us")

(define *season* "fall")
(define *year* (number->string (date-year (current-date))))

(define *lessons-dir* (format "~a/lessons" *dist-en-us*))
(define *courses-dir* (format "~a/courses" *dist-en-us*))

(define *lesson-csv-file* "lessons.csv")
(define *page-csv-file* "xyz-pages.csv")
(define *solution-page-csv-file* "xyz-solution-pages.csv")

(define (string->uniqid s)
  (when (path? s)
    (set! s (path->string s)))
  (string->number
    (substring
      (bytes->hex-string
        (call-with-input-string s sha1-bytes))
      0 15) 16))

(define (escape-html s #:kill-newlines? [kill-newlines? #f])
  (when kill-newlines? ;FIXME
    (set! s (regexp-replace* #rx"\n" s " ")))
  (set! s (regexp-replace* #rx"\"" s "\"\""))
  s)

(define (escaped-file-content f #:kill-newlines? [kill-newlines? #f])
  (escape-html (file->string f) #:kill-newlines? kill-newlines?))

(define (make-lesson-permalink f)
  (when (path? f) (set! f (path->string f)))
  (format "https://bootstrap3dev.wpenginepowered.com/materials/lesson/~a-~a/~a/"
          *season* *year*
          f))

(define (make-page-permalink f)
  (when (path? f) (set! f (path->string f)))
  (format "https://bootstrap3dev.wpenginepowered.com/unit/~a/"
          f))

(define (convert-lessons o)
  (for ([lesson-dir (directory-list *lessons-dir*)])
    (let ([lesson-plan-file (path->string (build-path *lessons-dir* lesson-dir "index.shtml"))]
          [title-file (path->string (build-path *lessons-dir* lesson-dir ".cached/.index.titletxt"))])
      (when (and (file-exists? lesson-plan-file) (file-exists? title-file))
        ;id, title, permalink, lesson-raw-code, lesson-categories, lesson-season
        (fprintf o "~a,\"~a\",~a,\"~a\",,~a ~a\n"
                 (string->uniqid lesson-plan-file)
                 (string-trim (escaped-file-content title-file #:kill-newlines? #t))
                 (make-lesson-permalink lesson-dir)
                 (escaped-file-content lesson-plan-file)
                 ;
                 (string-titlecase *season*)
                 *year*)))))

(define (convert-workbook-pages o #:pages [pages "pages"])
  ; (printf "doing convert-workbook-pages ~a\n" pages)
  (for ([lesson-dir (directory-list *lessons-dir*)])
    (let* ([lesson-dir-path (build-path *lessons-dir* lesson-dir)]
           [lesson-plan-file (path->string (build-path lesson-dir-path "index.shtml"))]
           [pages-dir (build-path lesson-dir "pages")]
           [solution-pages-dir (build-path lesson-dir "solution-pages")])
      (let ([pages-dir-path (build-path lesson-dir-path pages)])
        (when (directory-exists? pages-dir-path)
          (for ([p (directory-list pages-dir-path)])
            ; (printf "doing p = ~a\n" p)
            (set! p (path->string p))
            (when (regexp-match #rx"\\.html" p)
              ;id, title, permalink, lesson-parent, unit-raw-code
              (let* ([q-p (build-path pages p)]
                     [page-file (path->string (build-path pages-dir-path p))]
                     [page-title-file (path->string (build-path pages-dir-path ".cached"
                                                                (string-append "."
                                                                  (regexp-replace #rx"\\.html" p ".titletxt"))))])
                ; (printf "page-title-file is ~a\n" page-title-file)
                (when (file-exists? page-title-file)
                  ; (printf "going ahead with ~a\n" p)
                  (fprintf o "~a,\"~a\",~a,\"a:1:{i:0;s:2:\"\"~a\"\";}\",\"~a\"\n"
                           (string->uniqid q-p)
                           (string-trim (escaped-file-content page-title-file #:kill-newlines? #t))
                           (make-page-permalink q-p)
                           (string->uniqid lesson-plan-file)
                           (escaped-file-content page-file)))))))))))

(let* ([cla (current-command-line-arguments)]
       [n (vector-length cla)])
  (when (>= n 1)
    (set! *season* (vector-ref cla 0)))
  (when (>= n 2)
    (set! *year* (vector-ref cla 1))))

; (printf "season = ~s; year = ~s\n" *season* *year*)

(call-with-output-file *lesson-csv-file* convert-lessons
  #:exists 'replace)

(call-with-output-file *page-csv-file* convert-workbook-pages
  #:exists 'replace)

(call-with-output-file *solution-page-csv-file*
  (lambda (o) (convert-workbook-pages o #:pages "solution-pages"))
  #:exists 'replace)

