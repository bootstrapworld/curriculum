#!/usr/bin/env racket

#lang racket

(require "utils.rkt")

(define *pathway-root-dir* (getenv "PATHWAYROOTDIR"))

(define *force* (not (string=? (getenv "FORCE") "false")))

(define *pdflatex* (find-executable-path "pdflatex"))

(define *pdftk* (find-executable-path "pdftk"))

(define *workbook-page-specs*
  (call-with-input-file "workbook-page-index.rkt" read))

;(printf "*workbook-page-specs* = ~s\n" *workbook-page-specs*)

; *workbook-page-specs* is listof (lesson docfile handle aspect)

(define (make-workbook dest #:teacher-version [teacher-version #f] #:include-lesson [include-lesson #f])

  (define dest.pdf (format "~a.pdf" dest))

  (define dest.pdf.mtime
    (if *force* 0 (file-mtime dest.pdf)))

  (define do-it? *force*)

  (define *pdf-page-specs*
    (map (lambda (f)
           (let* ([lesson-basename (list-ref f 0)]
                  [lesson-workbook-page (list-ref f 1)]
                  [lesson-handle (list-ref f 2)]
                  [lesson-aspect (list-ref f 3)]
                  [lesson-pagenum (list-ref f 4)]
                  [lesson-dir (string-append "lessons/" lesson-basename)]
                  [lesson-title-file (string-append lesson-dir "/index-title.txt")]
                  [lesson-title (if (file-exists? lesson-title-file)
                                    (call-with-input-file lesson-title-file read-line)
                                    "")]
                  [g (string-append lesson-dir
                                    (if teacher-version "/workbook-sols-pages/" "/workbook-pages/")
                                    lesson-workbook-page)]
                  [g (if (path-has-extension? g #".adoc")
                         (path-replace-extension g ".pdf") g)]
                  )
             (unless do-it?
               (when (> (file-mtime g) dest.pdf.mtime) (set! do-it? #t)))
             (list g lesson-basename lesson-handle lesson-aspect lesson-pagenum lesson-title)))
         *workbook-page-specs*))

  (when do-it?

    (printf "building workbooks\n")

    ; *pdf-page-specs* is listof (docfile basename handle aspect title)

    (set! *pdf-page-specs*
      (filter (lambda (f)
                (let ([docfile (car f)])
                  (if (file-exists? docfile) #t
                      (begin
                        (printf "ERROR: ~a is not present\n" docfile)
                        #f))))
              *pdf-page-specs*))

    ;(printf "*pdf-page-specs* = ~s\n" *pdf-page-specs*)

    (for ([pdf-page-spec *pdf-page-specs*])
      ;(printf "pdf-page-spec = ~s\n" pdf-page-spec)
      (let ([docfile (list-ref pdf-page-spec 0)]
            [basename (list-ref pdf-page-spec 1)]
            [handle (list-ref pdf-page-spec 2)]
            [aspect (list-ref pdf-page-spec 3)]
            [pagneum (list-ref pdf-page-spec 4)]
            [title (list-ref pdf-page-spec 5)])
        (system* *pdftk*
                 (format "Q=~a" docfile)
                 "cat"
                 (if (char-ci=? (string-ref aspect 0) #\l)
                     "Qwest" "Q")
                 "output"
                 (format "~a.pdf" handle)
                 "dont_ask")))

    (call-with-output-file "workbook-numbered.tex"
      (lambda (o)
        (display (mstring
                   "\\documentclass{article}"
                   "\\usepackage{pdfpages}"
                   "\\usepackage{fancyhdr}"
                   "%"
                   "\\setlength\\topmargin{-0.375in}"
                   "\\setlength\\headheight{0in}"
                   "\\setlength\\headsep{0in}"
                   "\\setlength\\textheight{9.5in}"
                   "\\setlength\\textwidth{7.0in}"
                   "\\setlength\\oddsidemargin{-0.25in}"
                   "\\setlength\\evensidemargin{-0.25in}"
                   "%"
                   "\\pagestyle{fancy}"
                   "\\renewcommand{\\headrulewidth}{0pt}"
                   "\\lhead{}\\rhead{}"
                   "\\fancyhf{}"
                   "%"
                   "\\begin{document}\n\n"
                   ) o)
        (let ([cover-page (string-append *pathway-root-dir*
                            (if (or teacher-version include-lesson)
                                "front-cover-teacher.pdf" "front-cover-student.pdf"))])
          (when (file-exists? cover-page)
            (fprintf o "\\includepdf[pages=-,pagecommand={\\lfoot{}\\rfoot{}}]{~a}\n"
                     cover-page)))
        ;(fprintf o "\\includepdf[pages=-,pagecommand={\\lfoot{}\\rfoot{}}]{BSABigIdeas.pdf}\n")
        (let ([curr-lesson #f])
          (let loop ([i 1] [pdf-page-specs *pdf-page-specs*])
            (unless (null? pdf-page-specs)
              (let* ([pdf-page-spec (car pdf-page-specs)]
                     [basename (list-ref pdf-page-spec 1)]
                     [handle (list-ref pdf-page-spec 2)]
                     ;[aspect (list-ref pdf-page-spec 3)]
                     [paginate (list-ref pdf-page-spec 4)]
                     [title (list-ref pdf-page-spec 5)]
                     [page-num i]
                     [fresh-lesson (not (equal? basename curr-lesson))])
                (set! title (regexp-replace* "&" title "\\\\&"))
                (set! paginate (if (char-ci=? (string-ref paginate 0) #\y) #t #f))
                (unless paginate
                  (set! page-num "") (set! title "") (set! i (- i 1)))
                (cond [fresh-lesson
                        (set! curr-lesson basename)
                        (fprintf o "\n\\includepdf[pagecommand={\\lfoot{~a}\\rfoot{~a}}]{~a.pdf}\n"
                                 "" page-num handle)
                        (when include-lesson
                          (let ([lesson-plan-pdf (format "lessons/~a/index.pdf" curr-lesson)])
                            (when (file-exists? lesson-plan-pdf)
                              (fprintf o "\\includepdf[pages=-,pagecommand={\\lfoot{}\\rfoot{}}]{~a}\n"
                                       lesson-plan-pdf))))]
                      [else
                        (fprintf o "\\includepdf[pagecommand={\\lfoot{~a}\\rfoot{~a}}]{~a.pdf}\n"
                                 title page-num handle)])
                (loop (+ i 1) (cdr pdf-page-specs))))))
        (fprintf o "\n\\end{document}\n")
        )
      #:exists 'replace)

    (system (format "cp -p workbook-numbered.tex ~a.tex" dest))

    (when (file-exists? "workbook-numbered.pdf") (delete-file "workbook-numbered.pdf"))

    (when *pdflatex* (system* *pdflatex* "workbook-numbered"))

    (for ([pdf-page-spec *pdf-page-specs*])
      (let ([handle (list-ref pdf-page-spec 2)])
        (delete-file (format "~a.pdf" handle))))

    (when (file-exists? "workbook-numbered.pdf")
      (system (format "mv workbook-numbered.pdf ~a" dest.pdf)))

    )
)

(make-workbook "workbook/workbook")

(make-workbook "resources/protected/pd-workbook" #:include-lesson #t)

(make-workbook "resources/protected/pd-workbook" #:teacher-version #t)

(void)
