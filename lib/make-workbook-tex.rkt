#!/usr/bin/env racket

#lang racket

(define *pathway-root-dir* (getenv "PATHWAYROOTDIR"))

(define *workbook-page-specs*
  (call-with-input-file "workbook-page-index.rkt" read))

(define (make-workbook.tex)
  (call-with-output-file "workbook.tex"
    (lambda (o)
      (call-with-output-file "pd-workbook.tex"
        (lambda (pd-o)
          (call-with-output-file "workbook-sols.tex"
            (lambda (tw-o)

              (define (display3 x)
                (display x o)
                (display x pd-o)
                (display x tw-o)
                )

              (display3 (string-append
                          "\\documentclass{article}\n"
                          "\\usepackage{pdfpages}\n"
                          "\\usepackage{fancyhdr}\n"
                          "%\n"
                          "\\setlength\\topmargin{-0.375in}\n"
                          "\\setlength\\headheight{0in}\n"
                          "\\setlength\\headsep{0in}\n"
                          "\\setlength\\textheight{9.5in}\n"
                          "\\setlength\\textwidth{7.25in}\n"
                          "\\setlength\\oddsidemargin{-0.5in}\n"
                          "\\setlength\\evensidemargin{-0.5in}\n"
                          "%\n"
                          "\\pagestyle{fancy}\n"
                          "\\renewcommand{\\headrulewidth}{0pt}\n"
                          "\\lhead{}\\rhead{}\n"
                          "\\fancyhf{}\n"
                          "%\n"
                          "\\begin{document}\n\n"
                          ))

              (let ([curr-lesson #f]
                    [pagenum-list '()])
                (let loop ([i 1] [pdf-page-specs *workbook-page-specs*])
                  (unless (null? pdf-page-specs)
                    (let* ([pdf-page-spec (car pdf-page-specs)]
                           [lessondir (list-ref pdf-page-spec 0)]
                           [workbook-page (list-ref pdf-page-spec 1)]
                           [handle (list-ref pdf-page-spec 2)]
                           ;[aspect (list-ref pdf-page-spec 3)]
                           [paginate (list-ref pdf-page-spec 4)]
                           [paginate (if (char-ci=? (string-ref paginate 0) #\y) #t #f)]
                           [lesson-title-file (string-append lessondir "/index-title.txt")]
                           [lesson-title (if (file-exists? lesson-title-file)
                                             (call-with-input-file lesson-title-file read-line)
                                             "")]
                           [pagenum i]
                           [fresh-lesson (not (equal? lessondir curr-lesson))])
                      (set! lesson-title (regexp-replace* "&" lesson-title "\\\\&"))
                      (unless paginate
                        (set! pagenum "") (set! lesson-title "") (set! i (- i 1)))
                      (when paginate
                        (set! pagenum-list
                          (cons (list (list lessondir workbook-page) pagenum) pagenum-list)))
                      (cond [fresh-lesson
                              (set! curr-lesson lessondir)
                              (display3
                                (format "\n\\includepdf[pagecommand={\\lfoot{}\\cfoot{~a}\\rfoot{}}]{==TARGET==-~a.pdf}\n"
                                        pagenum handle))
                              (when (regexp-match #rx"^lessons/" curr-lesson)
                                (let ([lesson-plan-pdf (format "~a/index.pdf" curr-lesson)])
                                  (fprintf pd-o "\\includepdf[pages=-,pagecommand={\\lfoot{}\\rfoot{}}]{~a}\n"
                                           lesson-plan-pdf)))]
                            [else
                              (display3
                                (format "\\includepdf[pagecommand={\\lfoot{~a}\\cfoot{~a}\\rfoot{}}]{==TARGET==-~a.pdf}\n"
                                        "" ;title
                                        pagenum handle))])
                      (loop (+ i 1) (cdr pdf-page-specs)))))
                ;(printf "*** creating workbook-pagenum-index.rkt.kp\n")
                (call-with-output-file "workbook-pagenum-index.rkt.kp"
                  (lambda (o)
                    (display "(" o) (newline o)
                    (for-each
                      (lambda (x)
                        (write x o) (newline o)
                        )
                      (reverse pagenum-list))
                    (display ")" o) (newline o)
                    )
                  #:exists 'replace)
                )
              (display3 (format "\n\\end{document}\n"))
              )
            #:exists 'replace))
        #:exists 'replace))
    #:exists 'replace))

(make-workbook.tex)
