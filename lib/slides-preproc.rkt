#!/usr/bin/env racket

#lang racket

(require "readers.rkt")
(require "utils.rkt")
(require "starter-files.rkt")
(require "function-directives.rkt")

(define-namespace-anchor *slides-namespace-anchor*)

(define *slides-namespace* (namespace-anchor->namespace *slides-namespace-anchor*))

(define *use-mathjax-for-math?* #f)

(define *max-images-processed* 6)

(define *num-images-processed* 0)

(define *in-file* "doesnt-exist")

(define *progdir* (getenv "PROGDIR"))

(define *proglang* (or (getenv "PROGLANG") "pyret"))

(define *bootstrap-prefix* (or (getenv "BOOTSTRAPPREFIX")
                               "https://bootstrapworld.org/materials/latest/en-us/lessons"))

(define *lesson* (or (getenv "LESSON") "__sample-lesson"))

(define (massage-arg arg)
  (eval arg *slides-namespace*))

(define (errmessage-file-context)
  *in-file*)

(define (make-image img text)
  ; (printf "make-image ~s\n" img)
  (set! *num-images-processed* (+ *num-images-processed* 1))
  (unless (file-exists? img)
    ; (printf "image ~s doesnt exist\n" img)
    (let ([img-anonymized
            (system-echo (format "~a/anonymize-filename" *progdir*) img)])
      ; (printf "anon image file is ~s\n" img-anonymized)
      (when img-anonymized
        (set! img img-anonymized))))
  (if (> *num-images-processed* *max-images-processed*)
      (format "**-- INSERT IMAGE ~a HERE --**" img)
      (format "![~a](~a)" text img)))

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
                                           [(equal? w '(#\s #\e #\m #\i #\t))
                                            (loop s-rest (cons #\× r))]
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

(define (coe exp)
  (format "<code>~s</code>" exp))

(define math code)

(define (fully-qualify-link args directive)
  (let* ([num-args (length args)]
         [page (car args)]
         [link-text (if (> num-args 1) (cadr args) #f)]
         [page-components (regexp-split #rx"/" page)]
         [local-dir ""]
         [local-file ""]
         [fq-uri-dir ""]
         [local-dir-file ""]
         )
    (case (length page-components)
      [(1)
       (set! local-dir "pages")
       (set! local-file (car page-components))
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/" *lesson* "/pages"))]
      [(2)
       (set! local-dir (car page-components))
       (set! local-file (cadr page-components))
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/" *lesson* "/" local-dir))]
      [(3)
       (set! local-dir (build-path 'up (car page-components) (cadr page-components)))
       (set! local-file (caddr page-components))
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/" (car page-components) "/" (cadr page-components)))]
      [else
        (printf "WARNING: Incorrect @~a ~a\n\n" directive page-components)
        ""])
    (set! local-dir-file (build-path local-dir local-file))
    (unless link-text
      (let* ([local-cached-file (build-path local-dir ".cached" (string-append "." local-file))]
             [local-title-file (path-replace-extension local-cached-file ".titletxt")])
        ; (printf "title file is ~s\n" local-title-file)
        (set! link-text
          (cond [(file-exists? local-title-file)
                 (call-with-input-file local-title-file read-line)]
                [(file-exists? local-dir-file) local-dir-file]
                [else (format "<broken link: ~a>" local-dir-file)]))))
    (when (path-has-extension? local-file ".adoc")
      (let* ([f.pdf (path-replace-extension local-dir-file ".pdf")]
             [f.html (path-replace-extension local-dir-file ".html")])
        ; (printf "III ~s in ~s\n" local-dir-file (current-directory))
        ; (printf "III f.pdf is ~s\n" f.pdf)
        ; (printf "III f.html is ~s\n" f.html)
        (cond [(file-exists? f.html)
               (set! local-file (path->string (path-replace-extension local-file ".html")))]
              [(file-exists? f.pdf)
               (set! local-file (path->string (path-replace-extension local-file ".pdf")))])))
    (let ([fq-uri (string-append fq-uri-dir "/" local-file)])
      (format "[~a](~a)" link-text fq-uri))))

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
                       [(string=? directive "smath")
                        (let* ([text (read-group i directive #:scheme? #t)]
                               [exprs (string-to-form (format "(math '~a)" text))])
                          (for ([s exprs])
                            (display (massage-arg s) o)))]
                       [(string=? directive "show")
                        (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                          (for ([s exprs])
                            (display (massage-arg s) o)))]
                       [(string=? directive "table")
                        (let ([n (string->number (read-group i directive))])
                          (let loop ([j n])
                            (unless (<= j 0)
                              (display (if (= j n) "|DELETE THIS ROW" "|_") o)
                              (loop (- j 1))))
                          (newline o)
                          (let loop ([j n])
                            (unless (<= j 0)
                              (display "|---" o)
                              (loop (- j 1)))))]
                       [(string=? directive "vocab")
                        (let ([arg (read-group i directive)])
                          (display "<b><i>" o)
                          (display arg o)
                          (display "</i></b>" o))]
                       [(string=? directive "scrub")
                        (read-group i directive)]
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

