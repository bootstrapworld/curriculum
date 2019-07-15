#!/usr/bin/env racket

#lang racket

(define *pdflatex* (find-executable-path "pdflatex"))

(define *pdftk* (find-executable-path "pdftk"))

(define *lessons*
  (call-with-input-file "workbook-index.rkt" read))

(define *workbook-page-specs*
  (call-with-input-file "workbook-page-index.rkt" read))

;(printf "*workbook-page-specs* = ~s~n" *workbook-page-specs*)

; *workbook-page-specs* is listof (lesson docfile handle aspect)

(define (make-workbook #:teacher-version [teacher-version #f] #:include-lesson [include-lesson #f])

  (define *pdf-page-specs*
    (map (lambda (f)
           (let* ((lesson-dir (string-append "lessons/" (car f)))
                  (lesson-title (call-with-input-file
                                  (string-append lesson-dir "/index-title.txt")
                                  read-line))
                  (g (string-append lesson-dir
                                    (if teacher-version "/workbook-sols-pages/" "/workbook-pages/")
                                    (cadr f))))
             (when (path-has-extension? g #".adoc")
               (set! g (path-replace-extension g ".pdf")))
             (list g (caddr f) (cadddr f) lesson-title)))
         *workbook-page-specs*))

  ; *pdf-page-specs* is listof (docfile handle aspect title)

  (set! *pdf-page-specs*
    (filter (lambda (f)
              (let ((g (car f)))
                (if (file-exists? g) #t
                    (begin
                      (printf "ERROR: ~a is not present\n" g)
                      #f))))
            *pdf-page-specs*))

  ;(printf "*pdf-page-specs* = ~s~n" *pdf-page-specs*)

  (for ((pdf-page-spec *pdf-page-specs*))
    (let ((docfile (list-ref pdf-page-spec 0))
          (handle (list-ref pdf-page-spec 1))
          (aspect (list-ref pdf-page-spec 2))
          (title (list-ref pdf-page-spec 3)))
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
      (fprintf o
               "\\documentclass{article}
\\usepackage{pdfpages}
\\usepackage{fancyhdr}
%
\\setlength\\topmargin{-0.375in}
\\setlength\\headheight{0in}
\\setlength\\headsep{0in}
\\setlength\\textheight{9.5in}
\\setlength\\textwidth{7.0in}
\\setlength\\oddsidemargin{-0.25in}
\\setlength\\evensidemargin{-0.25in}
%
\\begin{document}\n
\\pagestyle{empty}\n\n")
      (when teacher-version
        (fprintf o "\\includepdf{front-cover-teacher.pdf}\n"))
      (when include-lesson
        (for ((lesson *lessons*))
          (fprintf o "\\includepdf[pages=-]{lessons/~a/index.pdf}\n" lesson)))
      (let loop ((i 1) (pdf-page-specs *pdf-page-specs*))
        (unless (null? pdf-page-specs)
          (let* ((pdf-page-spec (car pdf-page-specs))
                 (handle (list-ref pdf-page-spec 1))
                 (title (list-ref pdf-page-spec 3)))
            (set! title (regexp-replace* "&" title "\\\\&"))
            (when (<= i 2)
              (fprintf o "\\includepdf{~a.pdf}\n"
                       handle))
            (when (= i 3)
              (fprintf o "\\pagenumbering{arabic}
\\pagestyle{fancy}
\\fancyhf{}
\\rfoot{\\thepage}
\n\n"))
            (when (>= i 3)
              (fprintf o "\\includepdf[pagecommand={\\thispagestyle{fancy}\\lfoot{~a}}]{~a.pdf}\n"
                       title handle)))
          (loop (+ i 1) (cdr pdf-page-specs))))
      (fprintf o "\n\\end{document}\n")
      )
    #:exists 'replace)

  (when (file-exists? "workbook-numbered.pdf") (delete-file "workbook-numbered.pdf"))

  (when *pdflatex* (system* *pdflatex* "workbook-numbered"))

  (for ((pdf-page-spec *pdf-page-specs*))
    (let ((handle (list-ref pdf-page-spec 1)))
      (delete-file (format "~a.pdf" handle))))

  (when (file-exists? "workbook-numbered.pdf")
    (system (format "mv workbook-numbered.pdf ~a.pdf"
                    (if teacher-version
                        "resources/protected/workbook-sols"
                        (if include-lesson
                            "workbook/pd-workbook"
                            "workbook/workbook")))))

  )

(make-workbook)

(make-workbook #:include-lesson #t)

(make-workbook #:teacher-version #t)

(void)
