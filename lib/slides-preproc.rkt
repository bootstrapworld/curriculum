#!/usr/bin/env racket

#lang racket

(require "readers.rkt")
(require "starter-files.rkt")

(define *in-file* "doesnt-exist")

(define *proglang* "pyret")

(define (errmessage-file-context)
  *in-file*)

(define *bootstrap-root* "https://bootstrapworld.org/materials/latest/en-us/lessons/")

(define *lesson* "noname")

(define (fully-qualify-link args directive)
  (let* ([num-args (length args)]
         [page (car args)]
         [link-text (if (> num-args 1) (cadr args) "")]
         [page-components (regexp-split #rx"/" page)]
         [fq-uri (case (length page-components)
                   [(1)
                    (apply build-path *bootstrap-root* *lesson* "pages" page-components)]
                   [(2)
                    (apply build-path *bootstrap-root* *lesson* page-components)]
                   [(3)
                    (apply build-path *bootstrap-root* page-components)]
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
                       [(string=? directive "bootstraproot")
                        (let ([x (read-group i directive)])
                          (set! *bootstrap-root* x)) ]
                       [(string=? directive "lesson")
                        (let ([x (read-group i directive)])
                          (set! *lesson* x))]
                       [(member directive '("printable-exercise" "opt-printable-exercise"))
                        (let ([args (read-commaed-group i directive read-group)])
                          (display (fully-qualify-link args directive) o))]
                       [(member directive '("link" "online-exercise" "opt-online-exercise" "ext-exercise-link"))
                        (let ([args (read-commaed-group i directive read-group)])
                        (display (external-link args directive) o)) ]
                       [(member directive '("starter-file" "opt-starter-file"))
                        (let ([lbl (read-group i directive)])
                          (display (starter-file-link lbl) o))]
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

