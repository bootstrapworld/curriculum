#!/usr/bin/env racket

#lang racket

(require "utils.rkt")

;(printf "Doing make-workbook.rkt\n")

(define *pathway-root-dir* (getenv "PATHWAYROOTDIR"))

(define *force* (truthy-getenv "FORCE"))

(define *debug* (truthy-getenv "DEBUG"))

;(printf "force= ~s; debug= ~s\n" *force* *debug*)

(define *pdflatex* (find-executable-path "pdflatex"))

(define *pdftk* (find-executable-path "pdftk"))

(unless *pdflatex*
  (printf "WARNING: pdflatex not installed on your system\n"))

(unless *pdftk*
  (printf "WARNING: pdftk not installed on your system\n"))

(define (make-workbook tgt )

  (define teacher-version
    (member tgt '("workbook-sols" "bm-contracts")))

  (define dest
    (cond [(string=? tgt "workbook") "workbook/workbook"]
          [(string=? tgt "pd-workbook") "resources/protected/pd-workbook"]
          [(string=? tgt "workbook-sols") "resources/protected/workbook-sols"]
          [(string=? tgt "bm-contracts") "resources/contracts"]
          [else (error 'ERROR "deadc0de")]))

  (define workbook-page-specs
    (call-with-input-file
      (if (string=? tgt "bm-contracts")
          "back-matter-contracts-index.rkt"
          "workbook-page-index.rkt") read))

  (define dest.pdf (format "~a.pdf" dest))

  (define dest.pdf.mtime
    (if *force* 0 (file-mtime dest.pdf)))

  (define do-it? *force*)

  (for ([f workbook-page-specs])
    (let* ([lesson-dir (list-ref f 0)]
           [lesson-workbook-page (list-ref f 1)]
           [g (build-path lesson-dir
                          (if teacher-version "solution-pages" "pages")
                          lesson-workbook-page)]
           [g (if (path-has-extension? g #".adoc")
                  (path-replace-extension g ".pdf") g)])
      (unless do-it?
        (when (> (file-mtime g) dest.pdf.mtime) (set! do-it? #t)))))

  ;(printf "workbook-page-specs = ~s\n" workbook-page-specs)

  ;(printf "building workbooks\n")

  ; workbook-page-specs is listof (lessondir docfile handle aspect)

  ; 0=lessondir 1=docfile 2=handle 3=aspect

  ;  (printf "starting pdftk\n")

  (when do-it?
    (for ([pdf-page-spec workbook-page-specs])
      ;(printf "pdf-page-spec = ~s\n" pdf-page-spec)
      (let* ([lessondir (list-ref pdf-page-spec 0)]
             [docfile (list-ref pdf-page-spec 1)]
             [handle (list-ref pdf-page-spec 2)]
             [aspect (list-ref pdf-page-spec 3)])

        (set! docfile (build-path lessondir
                                  (if teacher-version "solution-pages" "pages")
                                  docfile))

        (when (or (path-has-extension? docfile #".adoc")
                  (path-has-extension? docfile #".html"))
          (set! docfile (path-replace-extension docfile ".pdf")))

        ;(printf "XXX doing ~s\n" docfile)

        (unless (file-exists? docfile)
          ;(printf "cwd= ~s ~s\n" (current-directory) (getenv "ABYSS"))
          (printf "WARNING: Page ~s not found; subbing blank page\n\n" docfile)
          (set! docfile (format "../../lib/~a.pdf" (getenv "ABYSS"))))

        (system* *pdftk*
                 (format "Q=~a" docfile)
                 "cat"
                 (if (char-ci=? (string-ref aspect 0) #\l)
                     "Qwest" "Q")
                 "output"
                 (format "~a-~a.pdf" tgt handle)
                 "dont_ask"))))
  ;  (printf "pdftk done\n")

  (when do-it?
    (let ([tex-jobname.tex (format "~a.tex" tgt)]
          [tex-jobname.pdf (format "~a.pdf" tgt)])

      (when (file-exists? tex-jobname.pdf) (delete-file tex-jobname.pdf))

      (when *pdflatex*
        (when (file-exists? tex-jobname.tex)
          (system* *pdflatex* tex-jobname.tex)))

      (when (file-exists? tex-jobname.pdf)
        (system (format "mv ~a ~a" tex-jobname.pdf dest.pdf)))
      )

    )

  )

;(printf "building workbook\n")

(let ([arg (vector-ref (current-command-line-arguments) 0)])
  (unless (member arg '("workbook" "pd-workbook" "workbook-sols" "bm-contracts"))
    (error 'ERROR "make-workbook.rkt: bad argument ~a" arg))
  (make-workbook arg))

(void)
