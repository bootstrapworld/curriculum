#!/usr/bin/env racket

#lang racket

(require "readers.rkt")
(require "starter-files.rkt")

(define *in-file* "doesnt-exist")

(define *proglang* (or (getenv "PROGLANG") "pyret"))

(define (errmessage-file-context)
  *in-file*)

(define *bootstrap-prefix* (or (getenv "BOOTSTRAPPREFIX")
                               "https://bootstrapworld.org/materials/latest/en-us/lessons"))

(define *lesson* (or (getenv "LESSON") "__sample-lesson"))

(define (make-image img text)
  (format "![~a](~a)" text img))

(define (make-math text)
  (string-append
    "$$$ math\n"
    text
    "\n"
    "$$$\n"))

(define (fully-qualify-link args directive)
  (let* ([num-args (length args)]
         [page (car args)]
         [link-text (if (> num-args 1) (cadr args) "")]
         [page-components (regexp-split #rx"/" page)]
         [fq-uri (case (length page-components)
                   [(1)
                    (apply build-path *bootstrap-prefix* *lesson* "pages" page-components)]
                   [(2)
                    (apply build-path *bootstrap-prefix* *lesson* page-components)]
                   [(3)
                    (apply build-path *bootstrap-prefix* page-components)]
                   [else
                     (printf "WARNING: Incorrect @~a ~a\n\n" directive page-components)
                     ""])])
    (format "[~a](~a)" link-text fq-uri)))

(define (external-link args directive)
  (let* ([num-args (length args)]
         [link (car args)]
         [link-text (if (> num-args 1) (cadr args) "")])
    (format "[~a](~a)" link-text link)))

(define (starter-file-link lbl)
  (let ([c (assoc lbl *starter-files*)])
    (cond [(not c) (printf "WARNING: Ill-named starter file ~a\n\n" lbl)
                   ""]
          [else
            (let ([title (cadr c)]
                  [p (assoc *proglang* (cddr c))])
              (cond [(not p)
                     (printf "WARNING: Missing starter file ~a for ~a\n\n" lbl *proglang*)
                     ""]
                    [else
                      (format "[~a](~a)" title (cadr p))]))])))

(define read-group
  (*make-read-group (lambda z (car z)) errmessage-file-context))

(define (preproc-slides-file in-file)
  (set! *in-file* in-file)
  (let ([out-file (path-replace-extension in-file ".mkd")])

    (define (expand-directives i o)
      (let loop ()
        (let ([c (read-char i)])
          (unless (eof-object? c)
            (cond
              [(char=? c #\@)
               (let ([directive (read-word i)])
                 (cond [(string=? directive "") (display c o)]
                       [(string=? directive "@") (display c o)]
                       [(string=? directive "image")
                        (let ([args (read-commaed-group i directive read-group)])
                          (display (make-image (car args) (cadr args)) o))]
                       [(member directive '("printable-exercise" "opt-printable-exercise"))
                        (let ([args (read-commaed-group i directive read-group)])
                          (display (fully-qualify-link args directive) o))]
                       [(member directive '("link" "online-exercise" "opt-online-exercise" "ext-exercise-link"))
                        (let ([args (read-commaed-group i directive read-group)])
                        (display (external-link args directive) o)) ]
                       [(member directive '("starter-file" "opt-starter-file"))
                        (let ([lbl (read-group i directive)])
                          (display (starter-file-link lbl) o))]
                       [(string=? directive "ifproglang")
                        (let* ([proglang (read-group i directive)]
                               [fragment (read-group i directive)])
                          (when (string-ci=? proglang *proglang*)
                            (call-with-input-string fragment
                              (lambda (i)
                                (expand-directives i o)))))]
                       [(string=? directive "math")
                        (let ([text (read-group i directive)])
                          (display (make-math text) o))]
                       [else (display c o) (display directive o)]))]
              [else
                (display c o)])
            (loop)))))

    (call-with-input-file in-file
      (lambda (i)
        (call-with-output-file out-file
          (lambda (o)
            (expand-directives i o))
          #:exists 'replace)))))

(let ([in-file (vector-ref (current-command-line-arguments) 0)])
  (preproc-slides-file in-file))

(void)

