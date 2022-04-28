#!/usr/bin/env racket

#lang racket

(require "readers.rkt")
(require "starter-files.rkt")
(require "function-directives.rkt")

(define-namespace-anchor *slides-namespace-anchor*)

(define *slides-namespace* (namespace-anchor->namespace *slides-namespace-anchor*))


(define *use-mathjax-for-math?* #f)

(define *in-file* "doesnt-exist")

(define *proglang* (or (getenv "PROGLANG") "pyret"))

(define *bootstrap-prefix* (or (getenv "BOOTSTRAPPREFIX")
                               "https://bootstrapworld.org/materials/latest/en-us/lessons"))

(define *lesson* (or (getenv "LESSON") "__sample-lesson"))

(define (massage-arg arg)
  (eval arg *slides-namespace*))

(define (errmessage-file-context)
  *in-file*)

(define (make-image img text)
  (format "![~a](~a)" text img))

(define (make-math text)
  ; (printf "doing make-math ~s\n" text)
  ((if *use-mathjax-for-math?* make-mathjax-math make-ascii-math) text))

(define (make-mathjax-math text)
  (string-append
    "$$$ math\n"
    text
    "\n"
    "$$$\n"))

(define (read-math-rev-word s)
  (let loop ([s (cdr s)] [r (list (car s))])
    (if (null? s) (values r s)
        (let ([a (car s)])
          (cond [(or (char-alphabetic? a) (char-numeric? a)) (loop (cdr s) (cons a r))]
                [else (values r s)])))))

(define (make-ascii-math text)
  ; (printf "doing make-ascii-math ~s\n" text)
  (let ([ans (let loop ([s (string->list text)] [r '()])
            (cond [(null? s) (reverse r)]
                  [else (let ([a (car s)] [s (cdr s)])
                          ; (printf "tackling ~s, ~s\n" a s)
                          (case a
                            [(#\\) (let-values ([(w s-rest) (read-math-rev-word s)])
                                     ; (printf "tackling2 ~s ~s\n" w s-rest)
                                     (cond [(equal? w '(#\v #\i #\d))
                                            (loop s-rest (cons #\÷ r))]
                                           [else (loop s-rest (append w r))]))]
                            [(#\^) (let-values ([(w s-rest) (read-math-rev-word s)])
                                     (loop s-rest (append '(#\> #\p #\u #\s #\/ #\<) w '(#\> #\p #\u #\s #\<) r)))]
                            [(#\_) (let-values ([(w s-rest) (read-math-rev-word s)])
                                     (loop s-rest (append '(#\> #\b #\u #\s #\/ #\<) w '(#\> #\b #\u #\s #\<) r)))]
                            [else (loop s (cons a r))]))]))])
    ; (printf "returning ~s\n" ans)
    (string-append "<code>" (list->string ans) "</code>")))

(define (code exp)
  (let ([x ((if (string=? *proglang* "wescheme") wescheme->wescheme wescheme->pyret) exp)])
    ;what about codap
    (set! x (regexp-replace* "{empty}" x ""))
    (string-append "<code>" x "</code>")))

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
                 ; (printf "directive is ~s\n" directive)
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
                       [(string=? directive "show")
                        (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                          (for ([s exprs])
                            (display (massage-arg s) o)))]
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

