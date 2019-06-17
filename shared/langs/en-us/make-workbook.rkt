#!/usr/bin/env racket

#lang racket

(define (make-workbook protected?)

  (define *workbook-page-specs*
    (call-with-input-file "workbook-page-index.rkt" read))

  ;(printf "*workbook-page-specs* = ~s~n" *workbook-page-specs*)

  (define *pdf-page-specs*
    (map (lambda (f)
           (let ((g (string-append "lessons/" (car f)
                                   (if protected? "/workbook-sols-pages/" "/workbook-pages/")
                                   (cadr f))))
             (when (path-has-extension? g #".adoc")
               (set! g (path-replace-extension g ".pdf")))
             (list g (caddr f))))
         *workbook-page-specs*))

  (set! *pdf-page-specs*
    (filter (lambda (f)
              (let ((g (car f)))
                (if (file-exists? g) #t
                    (begin
                      (printf "ERROR: ~a is not present\n" g)
                      #f))))
            *pdf-page-specs*))

  ;(printf "*pdf-page-specs* = ~s~n" *pdf-page-specs*)

  (define *pdf-pages-w-handles*
    (map (lambda (f)
           (format "~a=~a" (cadr f) (car f)))
         *pdf-page-specs*))

  (define *handle-specs*
    (map (lambda (f)
           (cadr f))
         *pdf-page-specs*))

  (define *pdflatex* (find-executable-path "pdflatex"))

  (unless (null? *pdf-page-specs*)
    (printf "~nbuilding workbook-no-pagenums.pdf from PDF pages ~a~n" *pdf-page-specs*)

    (when (file-exists? "workbook-no-pagenums.pdf") (delete-file "workbook-no-pagenums.pdf"))

  (let ((pdftk-args (append *pdf-pages-w-handles* (list "cat")
                            *handle-specs*
                            (list "output" "workbook-no-pagenums.pdf" "dont_ask"))))
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
