#! /usr/bin/env racket

#lang racket

(require file/sha1)
(require racket/date)

(define *dist-en-us* "distribution/en-us")
(define *archive* "False")
(define *season* (or (getenv "SEMESTER") "spring"))
(define *year* (or (getenv "YEAR") (number->string (date-year (current-date)))))

(define *current-date* (current-date))

(define *official-date*
  ; (format "~a-~a-01" *year* (if (string=? *season* "fall") "09" "01"))
  (let* ([x *current-date*]
         [y (date-year x)] [m (date-month x)] [d (date-day x)])
    (format "~a-~a~a-~a~a" y
            (if (< m 10) "0" "") m
            (if (< d 10) "0" "") d)))

(define *timestamp*
  (format "~a-~a" *official-date*
          (+ (* 60 (date-hour *current-date*)) (date-minute *current-date*))))

(define *natlang* "en-us")

(define *lessons-dir* (format "~a/lessons" *dist-en-us*))
(define *courses-dir* (format "~a/courses" *dist-en-us*))

(define *csv-file*
  (build-path *dist-en-us*
              (format "curriculum-~a.csv" *timestamp*)))

(define *csv-archive-file*
  (build-path *dist-en-us*
              (format "curriculum-archive-~a.csv" *timestamp*)))

(define (string->uniqid s)
  (when (path? s)
    (set! s (path->string s)))
  (set! s (string-append s "-" *season* "-" *year*))
  (string->number
    (substring
      (bytes->hex-string
        (call-with-input-string s sha1-bytes))
      0 13) 16))

(define (escape-html s #:kill-newlines? [kill-newlines? #f] #:static-prefix [static-prefix #f])
  (let ([lib-prefix #f])
    (when static-prefix
      (set! lib-prefix (regexp-replace #rx"/(courses|lessons)/[^/]*?/" static-prefix "/")))
    (when kill-newlines?
      (set! s (regexp-replace* #rx"\n" s " ")))
    (set! s (regexp-replace* #rx"href=\"index.pdf\"" s
              (format "href=\"~aindex.pdf\"" static-prefix)))
    (set! s (regexp-replace* #rx"(href=\"[^\"]*/curriculum)(\\.css\")" s
              "\\1-wp\\2"))

    (unless (regexp-match #rx"href=\"[^\"]*/images/" s)
      (set! s (regexp-replace* #rx"(href=\"[^\"]*)/courses/" s "\\1/lessons/")))

    (set! s (regexp-replace* #rx"href=\"[^\"]*?/lessons/" s (format "href=\"/materials/~a/lessons/" *season-year*)))

    (set! s (regexp-replace* #rx"(href=\"[^\"]*?/lessons/[^/]*?/)index\\.shtml\"" s
              (format "\\1\"")))
    (set! s (regexp-replace* #rx"(href=\"[^\"]*?/lessons/[^/]*?/)pages/([^/]*?)\\.(html|pdf)\"" s
              (format "\\1\\2/\"")))
    (set! s (regexp-replace* #rx"(href=\"[^\"]*?/lessons/[^/]*?/)solution-pages/([^/]*?)\\.(html|pdf)\"" s
              (format "\\1\\2-solution/\"")))

    (set! s (regexp-replace* #rx"(href=\")[^\"]*?(assessments/[^\"]*\")" s (format "\\1~a\\2" static-prefix)))

    (set! s (regexp-replace* #rx"(href=\"[^\"]*?/)index.shtml" s "\\1"))

    (set! s (regexp-replace* #rx"href=\"[^\"]*?\\./(Alignments|Contracts|Glossary)\\.shtml" s
              (format "href=\"/wp-content/themes/pro-child/static-resources/~a/~a/\\1.shtml" *season-year* *natlang*)))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?/lib/([^/]*?\\.js)\"" s
              (format "src=\"/wp-content/themes/pro-child/static-resources/~a/~a/lib/\\1\"" *season-year* *natlang*)))
    (set! s (regexp-replace* #rx"src=\"[.][^\"]*?/([^/]*?\\.js)\"" s
              (format "src=\"/wp-content/themes/pro-child/static-resources/~a/~a/lib/\\1\"" *season-year* *natlang*)))
    (set! s (regexp-replace* #rx"(src=\"[^\"]*/lib/bootstraplesson)\\.js" s
              "\\1-wp.js"))

    (set! s (regexp-replace* #rx"href=\"[^\"]*?/lib/([^/]*?\\.css)\"" s
              (format "href=\"/wp-content/themes/pro-child/static-resources/~a/~a/lib/\\1\"" *season-year* *natlang*)))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?/lib/images/([^/]*?\\.png)\"" s
              (format "src=\"/wp-content/themes/pro-child/static-resources/~a/~a/lib/images/\\1\"" *season-year* *natlang*)))

    (set! s (regexp-replace* #rx"href=\"[^\"]*?(workbook/[^/]*?\\.(pdf))\"" s (format "href=\"~a\\1\"" static-prefix)))

    ; (set! s (regexp-replace* #rx"src=\"[^\"]*?(images/[^/]*?\\.(png|svg))\"" s (format "src=\"/wp-content/themes/pro-child/static-resources/~a/~a/lib/\\1\"" *season-year* *natlang*)))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?(images/[^/]*?\\.(png|svg))\"" s (format "src=\"~a\\1\"" static-prefix)))

    (set! s (regexp-replace*
              #rx"src=\"([^\"]*?)/lib/([^\"]*?/images/[^/]*?\\.png)\"" s
              (format "src=\"\\1/~a/\\2\"" *natlang*)))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?/extlib/mathjax/[^/]*?\\.js\"" s
              "src=\"https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-mml-chtml.min.js\""))

    (set! s (regexp-replace* #rx"src=\"[^\"]*?/images/CCbadge.png\"" s
                            (format "src=\"~alib/images/CCbadge.png\"" lib-prefix)))

    ;double double-quotes
    (set! s (regexp-replace* #rx"\"" s "\"\""))
    s))

(define (escape-backslash-in-mathjax-line y)
  (if (regexp-match #rx"\\$\\$.*?\\$\\$" y)
      (regexp-replace* #rx"\\\\" y "\\\\\\\\")
      y))

(define (escape-backslash-in-mathjax s)
  (let ([x-lines (string-split s "\n")])
    (string-join (map escape-backslash-in-mathjax-line x-lines) "\n")))

(define (escaped-file-content f #:kill-newlines? [kill-newlines? #f]
                              #:static-prefix [static-prefix #f])
  (escape-backslash-in-mathjax
    (escape-html (file->string f)
                 #:kill-newlines? kill-newlines? #:static-prefix static-prefix)))

(define (make-lesson-permalink f)
  ; (printf "doing make-lesson-permalink ~a\n" f)
  (when (path? f) (set! f (path->string f)))
  (format "/materials/lessons/~a/~a/"
          *season-year*
          f))

(define (make-lesson-static-url f coursep)
  (when (path? f) (set! f (path->string f)))
  (format "/wp-content/themes/pro-child/static-resources/~a/~a/~a/~a/" *season-year* *natlang*
          (if coursep "courses" "lessons")
          f))

(define (get-curriculum-group course)
  (let ([course (path->string course)])
    (cond [(member course '("algebra-pyret" "algebra-wescheme")) "algebra"]
          [(member course '("data-science" "data-literacy" "data-literacy-codap")) "data-science"]
          [(member course '("videogame" "reactive")) "game"]
          [(member course '("expressions-and-equations" "expressions-and-equations-wescheme")) "expressions-and-equations"]
          [else course])))

(define (multilingual? dir)
  (let ([proglangs (build-path dir "proglang.txt")])
    (if (and (file-exists? proglangs)
         (let ([n 0])
           (call-with-input-file proglangs
             (lambda (i)
               (let loop ()
                 (let ([x (read-line i)])
                   (cond [(eof-object? x) 1]
                         [else (set! n (+ n 1))])
                   (unless (or (eof-object? x) (>= n 2))
                     (loop))))))
           (>= n 2)))
        "true" "false")))

(define (get-proglang dir)
  (let ([f (build-path dir ".cached" ".record-proglang")])
    (cond [(not (file-exists? f)) "Pyret"]
          [else (call-with-input-file f read-line)])))

(define (convert-top-pages o oa #:umbrella-dir [umbrella-dir #f])
  (let ([coursep (regexp-match "courses$" umbrella-dir)])
    (for ([lesson-dir (directory-list umbrella-dir)])
      ; (printf "lesson-dir = ~s; umbrella-dir = ~s; coursep = ~s\n" lesson-dir umbrella-dir coursep)
      (let* ([uniqid (string->uniqid lesson-dir)]
             [curr-group (if coursep (get-curriculum-group lesson-dir) "")]
             [lesson-dir-path (build-path umbrella-dir lesson-dir)]
             [lesson-plan-file (path->string (build-path lesson-dir-path "index.shtml"))]
             [title-file (path->string (build-path lesson-dir-path ".cached/.index.titletxt"))])
        ; (printf "lesson-dir = ~s; umbrella-dir = ~s\n" lesson-dir umbrella-dir)
        (when (file-exists? lesson-plan-file)
          ;id, title, slug, archive, parent, seasons, type, child-categories, curriculum-materials-raw-code, post status, date, curriculum-group, multilingual, proglang
          (fprintf o "~a,\"~a\",~a,~a,~a,~a,~a,~a,\"~a\",~a,~a,~a,~a,~a\n"
                   uniqid                                        ; id
                   (string-trim
                     (if (file-exists? title-file)
                         (escaped-file-content title-file #:kill-newlines? #t)
                         (path->string lesson-dir)
                         ))                                                           ; title
                   lesson-dir
                   ;(make-lesson-permalink lesson-dir) ;permalink (unused)
                   *archive*                                                          ; archive
                   ""                                                                 ; parent
                   (format "~a ~a" (string-titlecase *season*) *year*)                ; season
                   *type*                                                             ; type
                   ""                                                                 ; child categories
                   (escaped-file-content lesson-plan-file #:static-prefix
                                         (make-lesson-static-url lesson-dir coursep)) ; raw code
                   "publish"                                                          ; post status
                   get-curriculum-group                                               ; curriculum-group
                   *official-date*                                                    ; ???
                   (multilingual? lesson-dir-path)                                    ; multilingual
                   (get-proglang lesson-dir-path)                                     ; proglang
                   )
          (fprintf oa "~a,True\n" uniqid)
          )))))

(define (convert-sub-pages o oa #:umbrella-dir [umbrella-dir #f] #:pages [pages #f])
  ; (printf "doing convert-sub-pages ~a\n" pages)
  (let ([coursep (regexp-match "courses$" umbrella-dir)]
        [solutions? (regexp-match "solution-pages" pages)]
        [protected? (regexp-match "protected" pages)])
  (for ([lesson-dir (directory-list umbrella-dir)])
    (let* ([curr-group (if coursep (get-curriculum-group lesson-dir) "")]
           [lesson-id (string->uniqid lesson-dir)]
           [static-prefix (make-lesson-static-url lesson-dir coursep)]
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
                     [uniqid (string->uniqid lesson/p)]
                     [page-file (path->string (build-path pages-dir-path p))]
                     [page-title-file (path->string (build-path pages-dir-path ".cached"
                                                                (string-append "."
                                                                  (regexp-replace #rx"\\.html" p ".titletxt"))))])
                ; (printf "page-title-file is ~a\n" page-title-file)
                (when (file-exists? page-title-file)
                  ; (printf "going ahead with ~a\n" p)
                  ;id, title, permalink, archive, parent, seasons, type, child-categories, curriculum-materials-raw-code, post status, date, curriculum-group, multilingual, proglang
                  (fprintf o "~a,\"~a\",~a,~a,~a,~a,~a,~a,\"~a\",~a,~a,~a,~a,~a\n"
                           uniqid ;id
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
                           curr-group
                           *official-date*
                           (multilingual? lesson-dir-path)
                           (get-proglang lesson-dir-path)
                           )
                  (fprintf oa "~a,True\n" uniqid)
                  ))))))))))

(let* ([cla (current-command-line-arguments)]
       [n (vector-length cla)])
  (when (>= n 1)
    (set! *season* (vector-ref cla 0)))
  (when (>= n 2)
    (set! *year* (vector-ref cla 1))))

; (printf "season = ~s; year = ~s\n" *season* *year*)

(define *season-year* (format "~a-~a" *season* *year*))

(define *type* #f)

(call-with-output-file *csv-file*
  (lambda (o)
    (call-with-output-file *csv-archive-file*
      (lambda (oa)
        (fprintf o "ID,Title,Slug,Archive,Parent,Seasons,Type,Child Categories,Curriculum Materials Raw Code,Post Status,Curriculum Group,Date,Multilingual,Proglang\n")
        (fprintf oa "ID,Archive\n")
        (set! *type* "lesson")
        (convert-top-pages o oa #:umbrella-dir *lessons-dir*)
        (set! *type* "course")
        (convert-top-pages o oa #:umbrella-dir *courses-dir*)
        (set! *type* "workbook-page")
        (convert-sub-pages o oa #:umbrella-dir *lessons-dir* #:pages "pages")
        (set! *type* "solution-page")
        (convert-sub-pages o oa #:umbrella-dir *lessons-dir* #:pages "solution-pages")
        (set! *type* "resource")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "front-matter/pages")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "front-matter/solution-pages")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "back-matter/pages")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "back-matter/solution-pages")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "resources")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "resources/pages")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "resources/solution-pages")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "resources/protected")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "resources/protected/pages")
        (convert-sub-pages o oa #:umbrella-dir *courses-dir* #:pages "resources/protected/solution-pages")
        )
      #:exists 'replace))
  #:exists 'replace)
