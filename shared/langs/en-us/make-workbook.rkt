#!/usr/bin/env racket

#lang racket

(define (make-workbook protected?)

  (define *workbook-page-specs*
    (call-with-input-file "workbook-page-index.rkt" read))

  ;(printf "*workbook-page-specs* = ~s~n" *workbook-page-specs*)

  (define *lessons* '())

  (for ((spec *workbook-page-specs*))
    (let ((lesson (car spec)))
      (unless (member lesson *lessons*)
        (set! *lessons* (cons lesson *lessons*)))))

  (define *pdf-pages*
    (map (lambda (f)
           (let ((f (string-append "lessons/" (car f)
                                   (if protected? "/workbook-sols-pages/" "/workbook-pages/")
                                   (cadr f))))
             (when (path-has-extension? f #".adoc")
               (set! f (path-replace-extension f ".pdf")))
             f))
         *workbook-page-specs*))

  (set! *pdf-pages*
    (filter (lambda (f)
              (if (file-exists? f) #t
                  (begin
                    (printf "ERROR: ~a is not present\n" f)
                    #f)))
            *pdf-pages*))

  ;(printf "*pdf-pages* = ~s~n" *pdf-pages*)

  (define *pdflatex* (find-executable-path "pdflatex"))

  (unless (null? *pdf-pages*)
    (printf "~nbuilding workbook-no-pagenums.pdf from PDF pages ~a~n" *pdf-pages*)

    (when (file-exists? "workbook-no-pagenums.pdf") (delete-file "workbook-no-pagenums.pdf"))

    (let ((pdftk-args (append *pdf-pages* (list "output" "workbook-no-pagenums.pdf" "dont_ask"))))
      (apply system* (cons (find-executable-path "pdftk") pdftk-args)))

    (when (file-exists? "workbook-no-pagenums.pdf")
      (when (file-exists? "workbook-numbered.pdf") (delete-file "workbook-numbered.pdf"))

      (when *pdflatex*
        (apply system* (list *pdflatex* "workbook-numbered")))

      (unless (file-exists? "workbook-numbered.pdf")
        (system (format "mv workbook-no-pagenums.pdf workbook-numbered.pdf")))

      (system (format "mv workbook-numbered.pdf ~a.pdf"
                      (if protected?
                          "resources/protected/workbook-sols"
                          "workbook/workbook")))

      ))

  )

(make-workbook #f)

(make-workbook #t)

(void)
