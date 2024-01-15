#! /usr/bin/env racket

#lang racket

(require file/sha1)
(require racket/date)

(define *dist-en-us* "distribution/en-us")

(define *season* "spring")
(define *year* (number->string (date-year (current-date))))

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
      0 15) 16))

(define (escape-html s #:kill-newlines? [kill-newlines? #f] #:static-prefix [static-prefix #f])
  (when kill-newlines?
    (set! s (regexp-replace* #rx"\n" s " ")))
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
  (set! s (regexp-replace* #rx"src=\"[^\"]*?/([^/]*?\\.js)\"" s
            (format "src=\"/wp-content/themes/pro-child/static-resources/~a/lib/js/\\1\"" *season-year*)))

  (set! s (regexp-replace* #rx"href=\"[^\"]*?/lib/([^/]*?\\.css)\"" s
            (format "href=\"/wp-content/themes/pro-child/css/~a/\\1\"" *season-year*)))

  (set! s (regexp-replace* #rx"src=\"[^\"]*?/lib/images/([^/]*?\\.png)\"" s
            (format "src=\"/wp-content/themes/pro-child/static-resources/~a/lib/images/\\1\"" *season-year*)))

  (set! s (regexp-replace* #rx"src=\"[^\"]*?(images/[^/]*?\\.(png|svg))\"" s (format "src=\"~a\\1\"" static-prefix)))

  (set! s (regexp-replace* #rx"src=\"[^\"]*?/extlib/mathjax/[^/]*?\\.js\"" s
            "src=\"https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-mml-chtml.min.js\""))
  (set! s (regexp-replace* #rx"\"" s "\"\""))
  s)

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

(define (convert-lessons o)
  (for ([lesson-dir (directory-list *lessons-dir*)])
    (let ([lesson-plan-file (path->string (build-path *lessons-dir* lesson-dir "index.shtml"))]
          [title-file (path->string (build-path *lessons-dir* lesson-dir ".cached/.index.titletxt"))])
      (when (and (file-exists? lesson-plan-file) (file-exists? title-file))
        ;id, title, permalink, parent, seasons, child-categories, curriculum-materials-raw-code
        (fprintf o "~a,\"~a\",~a,~a,~a,~a,\"~a\"\n"
                 (string->uniqid lesson-dir) ;id
                 (string-trim (escaped-file-content title-file #:kill-newlines? #t)) ;title
                 (make-lesson-permalink lesson-dir) ;permalink
                 "" ; parent
                 (format "~a ~a" (string-titlecase *season*) *year*) ;season
                 "" ; child categories
                 (escaped-file-content lesson-plan-file #:static-prefix (make-lesson-static-url lesson-dir)) ; raw code
                 )))))

(define (convert-workbook-pages o #:pages [pages "pages"])
  ; (printf "doing convert-workbook-pages ~a\n" pages)
  (for ([lesson-dir (directory-list *lessons-dir*)])
    (let* ([lesson-id (string->uniqid lesson-dir)]
           [static-prefix (make-lesson-static-url lesson-dir)]
           [lesson-dir-path (build-path *lessons-dir* lesson-dir)]
           [lesson-plan-file (path->string (build-path lesson-dir-path "index.shtml"))])
      (let ([pages-dir-path (build-path lesson-dir-path pages)])
        (when (directory-exists? pages-dir-path)
          (for ([p (directory-list pages-dir-path)])
            ; (printf "doing p = ~a\n" p)
            (set! p (path->string p))
            (when (regexp-match #rx"\\.html" p)
              ;id, title, permalink, lesson-parent, unit-raw-code
              (let* ([p-base (regexp-replace #rx"\\.html" p "")]
                     [lesson/p (format "~a/~a~a" lesson-dir p-base
                                       (if (string=? pages "pages") "" "-solution"))]
                     [page-file (path->string (build-path pages-dir-path p))]
                     [page-title-file (path->string (build-path pages-dir-path ".cached"
                                                                (string-append "."
                                                                  (regexp-replace #rx"\\.html" p ".titletxt"))))])
                ; (printf "page-title-file is ~a\n" page-title-file)
                (when (file-exists? page-title-file)
                  ; (printf "going ahead with ~a\n" p)
                  ;id, title, permalink, parent, seasons, child-categories, curriculum-materials-raw-code
                  (fprintf o "~a,\"~a\",~a,~a,~a,~a,\"~a\"\n"
                           (string->uniqid lesson/p) ;id
                           (string-trim (escaped-file-content page-title-file #:kill-newlines? #t)) ;title
                           (make-lesson-permalink lesson/p) ; permalink
                           lesson-id ; parent
                           (format "~a ~a" (string-titlecase *season*) *year*) ;season
                           (if (string=? pages "pages") "Xyz" "Xyz Solution") ; child categ
                           (escaped-file-content page-file #:static-prefix static-prefix) ; raw code
                           ))))))))))

(let* ([cla (current-command-line-arguments)]
       [n (vector-length cla)])
  (when (>= n 1)
    (set! *season* (vector-ref cla 0)))
  (when (>= n 2)
    (set! *year* (vector-ref cla 1))))

; (printf "season = ~s; year = ~s\n" *season* *year*)

(define *season-year* (format "~a-~a" *season* *year*))

(call-with-output-file *csv-file*
  (lambda (o)
    (fprintf o "ID,Title,Permalink,Parent,Seasons,Child Categories,Curriculum Materials Raw Code\n")
    (convert-lessons o)
    (convert-workbook-pages o)
    (convert-workbook-pages o #:pages "solution-pages"))
  #:exists 'replace)
