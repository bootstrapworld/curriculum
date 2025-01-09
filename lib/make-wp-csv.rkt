#! /usr/bin/env racket

#lang racket

(require file/sha1)
(require racket/date)

(define *dist-en-us* "distribution/en-us")

(define *season* "spring")
(define *year* (number->string (date-year (current-date))))

(define *official-date*
  (format "~a-~a-01" *year* (if (string=? *season* "fall") "09" "01")))

(define *lessons-dir* (format "~a/lessons" *dist-en-us*))
(define *courses-dir* (format "~a/courses" *dist-en-us*))

(define *csv-file* (build-path *dist-en-us* "curriculum.csv"))

(define (string->uniqid s)
  (when (path? s)
    (set! s (path->string s)))
  (string->number
    (substring
      (bytes->hex-string
        (call-with-input-string s sha1-bytes))
      0 13) 16))

(define (escape-html s #:kill-newlines? [kill-newlines? #f] #:static-prefix [static-prefix #f])
  (let ([lib-prefix #f])
    (when static-prefix
      (set! lib-prefix (regexp-replace #rx"/lessons/[^/]*?/" static-prefix "/")))
    (when kill-newlines?
      (set! s (regexp-replace* #rx"\n" s " ")))
    (set! s (regexp-replace* #rx"href=\"index.pdf\"" s
              (format "href=\"~aindex.pdf\"" static-prefix)))
    (set! s (regexp-replace* #rx"href=\"[^\"]*?/lessons/([^/]*?)/index\\.shtml\"" s
              (format "href=\"/materials/lessons/~a/\\1/\"" *season-year*)))
    (set! s (regexp-replace* #rx"href=\"[^\"]*?/lessons/([^/]*?)/pages/([^/]*?)\\.(html|pdf)\"" s
              (format "href=\"/materials/lessons/~a/\\1/\\2/\"" *season-year*)))
    (set! s (regexp-replace* #rx"href=\"[^\"]*?/lessons/([^/]*?)/solution-pages/([^/]*?)\\.(html|pdf)\"" s
              (format "href=\"/materials/lessons/~a/\\1/\\2-solution/\"" *season-year*)))

    (set! s (regexp-replace* #rx"href=\"[^\"]*?\\./Contracts\\.shtml\"" s
              (format "href=\"/wp-content/themes/pro-child/static-resources/~a/lib/Contracts.shtml\"" *season-year*)))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?/lib/([^/]*?\\.js)\"" s
              (format "src=\"/wp-content/themes/pro-child/static-resources/~a/lib/js/\\1\"" *season-year*)))
    (set! s (regexp-replace* #rx"src=\"[.][^\"]*?/([^/]*?\\.js)\"" s
              (format "src=\"/wp-content/themes/pro-child/static-resources/~a/lib/js/\\1\"" *season-year*)))

    (set! s (regexp-replace* #rx"href=\"[^\"]*?/lib/([^/]*?\\.css)\"" s
              (format "href=\"/wp-content/themes/pro-child/static-resources/~a/lib/css/\\1\"" *season-year*)))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?/lib/images/([^/]*?\\.png)\"" s
              (format "src=\"/wp-content/themes/pro-child/static-resources/~a/lib/images/\\1\"" *season-year*)))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?(images/[^/]*?\\.(png|svg))\"" s (format "src=\"~a\\1\"" static-prefix)))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?/extlib/mathjax/[^/]*?\\.js\"" s
              "src=\"https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-mml-chtml.min.js\""))

    (set! s (regexp-replace #rx"src=\"[^\"]*?/images/CCbadge.png\"" s
                            (format "src=\"~aimages/CCbadge.png\"" lib-prefix)))

    ;double double-quotes
    (set! s (regexp-replace* #rx"\"" s "\"\""))
    s))

(define (escaped-file-content f #:kill-newlines? [kill-newlines? #f] #:static-prefix [static-prefix #f])
  (escape-html (file->string f) #:kill-newlines? kill-newlines? #:static-prefix static-prefix))

(define (make-lesson-permalink f)
  ; (printf "doing make-lesson-permalink ~a\n" f)
  (when (path? f) (set! f (path->string f)))
  (format "/materials/lessons/~a/~a/"
          *season-year*
          f))

(define (make-lesson-static-url f)
  (when (path? f) (set! f (path->string f)))
  (format "/wp-content/themes/pro-child/static-resources/~a/lib/lessons/~a/" *season-year* f))

(define (convert-top-pages o #:umbrella-dir [umbrella-dir #f])
  (for ([lesson-dir (directory-list umbrella-dir)])
    (let ([lesson-plan-file (path->string (build-path umbrella-dir lesson-dir "index.shtml"))]
          [title-file (path->string (build-path umbrella-dir lesson-dir ".cached/.index.titletxt"))])
      (when (file-exists? lesson-plan-file)
        ;id, title, permalink, archive, parent, seasons, type, child-categories, curriculum-materials-raw-code, post status, date
        (fprintf o "~a,\"~a\",~a,~a,~a,~a,~a,~a,\"~a\",~a,~a\n"
                 (string->uniqid lesson-dir) ;id
                 (string-trim
                   (if (file-exists? title-file)
                       (escaped-file-content title-file #:kill-newlines? #t)
                       (path->string lesson-dir)
                       )) ;title
                 lesson-dir
                 ;(make-lesson-permalink lesson-dir) ;permalink
                 "" ; parent
                 *archive* ; archive
                 (format "~a ~a" (string-titlecase *season*) *year*) ;season
                 *type* ; type
                 "" ; child categories
                 (escaped-file-content lesson-plan-file #:static-prefix (make-lesson-static-url lesson-dir)) ; raw code
                 "public"
                 *official-date*
                 )))))

(define (convert-sub-pages o #:umbrella-dir [umbrella-dir #f] #:pages [pages #f])
  ; (printf "doing convert-sub-pages ~a\n" pages)
  (let ([solutions? (regexp-match "solution-pages" pages)]
        [protected? (regexp-match "protected" pages)])
  (for ([lesson-dir (directory-list umbrella-dir)])
    (let* ([lesson-id (string->uniqid lesson-dir)]
           [static-prefix (make-lesson-static-url lesson-dir)]
           [lesson-dir-path (build-path umbrella-dir lesson-dir)]
           [lesson-plan-file (path->string (build-path lesson-dir-path "index.shtml"))])
      (let ([pages-dir-path (build-path lesson-dir-path pages)])
        (when (directory-exists? pages-dir-path)
          (for ([p (directory-list pages-dir-path)])
            ; (printf "doing p = ~a\n" p)
            (set! p (path->string p))
            (when (regexp-match #rx"\\.html" p)
              ;id, title, permalink, lesson-parent, unit-raw-code
              (let* ([p-base (regexp-replace #rx"\\.html" p "")]
                     [p-prime (format "~a~a" p-base
                                (if (not solutions?) "" "-solution"))]
                     [lesson/p (format "~a/~a" lesson-dir p-prime)]
                     [page-file (path->string (build-path pages-dir-path p))]
                     [page-title-file (path->string (build-path pages-dir-path ".cached"
                                                                (string-append "."
                                                                  (regexp-replace #rx"\\.html" p ".titletxt"))))])
                ; (printf "page-title-file is ~a\n" page-title-file)
                (when (file-exists? page-title-file)
                  ; (printf "going ahead with ~a\n" p)
                  ;id, title, permalink, archive, parent, seasons, type, child-categories, curriculum-materials-raw-code, post status, date
                  (fprintf o "~a,\"~a\",~a,~a,~a,~a,~a,~a,\"~a\",~a,~a\n"
                           (string->uniqid lesson/p) ;id
                           (string-trim (escaped-file-content page-title-file #:kill-newlines? #t)) ;title
                           p-prime
                           ;(make-lesson-permalink lesson/p) ; permalink
                           *archive* ; archive
                           lesson-id ; parent
                           (format "~a ~a" (string-titlecase *season*) *year*) ;season
                           *type* ; type
                           (if (not solutions?) "Xyz" "Xyz Solution") ; child categ
                           (escaped-file-content page-file #:static-prefix static-prefix) ; raw code
                           (if solutions? "private" "publish")
                           *official-date*
                           )))))))))))

(let* ([cla (current-command-line-arguments)]
       [n (vector-length cla)])
  (when (>= n 1)
    (set! *season* (vector-ref cla 0)))
  (when (>= n 2)
    (set! *year* (vector-ref cla 1))))

; (printf "season = ~s; year = ~s\n" *season* *year*)

(define *season-year* (format "~a-~a" *season* *year*))

(define *archive* "FALSE")
(define *type* #f)

(call-with-output-file *csv-file*
  (lambda (o)
    (fprintf o "ID,Title,Slug,Archive,Parent,Seasons,Type,Child Categories,Curriculum Materials Raw Code,Post Status,Date\n")
    (set! *type* "lesson")
    (convert-top-pages o #:umbrella-dir *lessons-dir*)
    (set! *type* "course")
    (convert-top-pages o #:umbrella-dir *courses-dir*)
    (set! *type* "workbook-page")
    (convert-sub-pages o #:umbrella-dir *lessons-dir* #:pages "pages")
    (set! *type* "solution-page")
    (convert-sub-pages o #:umbrella-dir *lessons-dir* #:pages "solution-pages")
    (set! *type* "resource")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "front-matter/pages")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "front-matter/solution-pages")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "back-matter/pages")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "back-matter/solution-pages")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "resources")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "resources/pages")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "resources/solution-pages")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "resources/protected")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "resources/protected/pages")
    (convert-sub-pages o #:umbrella-dir *courses-dir* #:pages "resources/protected/solution-pages")
    )
  #:exists 'replace)
