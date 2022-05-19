#!/usr/bin/env racket

#lang racket

(require "readers.rkt")
(require "utils.rkt")
(require "starter-files.rkt")
(require "function-directives.rkt")

(define-namespace-anchor *slides-namespace-anchor*)

(define *slides-namespace* (namespace-anchor->namespace *slides-namespace-anchor*))

(define *use-mathjax-for-math?* #f)

;if md2gslides can't handle too many images, set this to a small number, e.g., 6
(define *max-images-processed* #f)

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

(define (make-image img text [width #f])
  ; (printf "make-image ~s\n" img)
  (set! *num-images-processed* (+ *num-images-processed* 1))
  (unless (file-exists? img)
    ; (printf "image ~s doesnt exist\n" img)
    (let ([img-anonymized
            (system-echo (format "~a/anonymize-filename" *progdir*) img)])
      ; (printf "anon image file is ~s\n" img-anonymized)
      (when img-anonymized
        (set! img img-anonymized))))
  (if (and *max-images-processed* (> *num-images-processed* *max-images-processed*))
      (format "**-- INSERT IMAGE ~a HERE --**" img)
      (format "![~a](~a)~a" text img
              (if width (format "{width=~a}" width) ""))))

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
  (let loop ([s (rest s)] [r (list (first s))])
    (if (null? s) (values r s)
        (let ([a (first s)])
          (cond [(or (char-alphabetic? a) (char-numeric? a)) (loop (rest s) (cons a r))]
                [else (values r s)])))))

(define (make-ascii-math text)
  ; (printf "doing make-ascii-math ~s\n" text)
  (let ([ans (let loop ([s (string->list text)] [r '()])
            (cond [(null? s) (reverse r)]
                  [else (let ([a (first s)] [s (rest s)])
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

(define (old-coe exp)
  (format "<code>~s</code>" exp))

(define (coe exp)
  (string-append "$$$ html\n"
    "<link rel=\"stylesheet\" href=\"https://bootstrapworld.org/materials/latest/en-us/lib/curriculum.css\"/>\n"
    "<link rel=\"stylesheet\" href=\"https://bootstrapworld.org/materials/latest/en-us/lib/codemirror.css\"/>\n"
    "<link rel=\"stylesheet\" href=\"https://bootstrapworld.org/materials/latest/en-us/lib/style.css\"/>\n"
    "<style>\n"
    ".circleevalsexp { width: unset !important; }\n"
    "</style>\n"
    "<div id=\"DOMtoImage\" class=\"circleevalsexp\">\n"
    (coe-spans exp)
    "</div>\n"
    "$$$\n"))

(define (coe-spans exp)
  (cond [(list? exp)
         (let ([opr (first exp)] [opds (rest exp)])
           (string-append "<span class=\"expression\">\n"
             "<span class=\"lParen\">(</span>\n"
             "<span class=\"operator\">\n"
             (coe-spans opr)
             "</span>\n"
             (if (null? opds) "" "<span class=\"hspace\">&nbsp;</span>\n")
             (string-join
               (map coe-spans opds)
               "<span class=\"hspace\">&nbsp;</span>\n")
             "<span class=\"rParen\">)</span>\n"
             "</span>\n"))]
        [else
          (string-append "<span class=\"value\">"
            (wescheme-symbol->pyret exp)
            "</span>\n")]))

(define math code)

(define (contract funname domain-list range)
  (let* ([funname-sym (if (symbol? funname) funname (string->symbol funname))]
         [funname-str (if (string=? *proglang* "pyret") (wescheme->pyret funname-sym) funname)]
        [prefix (cond [(string=? *proglang* "pyret") "# "]
                      [(string=? *proglang* "wescheme") "; "]
                      [(string=? *proglang* "codap") ""])]
        [s (string-append
             prefix
             funname-str
             " :: "
             (vars-to-commaed-string domain-list)
             " -> "
             range)])
    (format "<code>~a</code>" s)))

(define (fully-qualify-link args directive)
  (let* ([num-args (length args)]
         [page (first args)]
         [link-text (if (> num-args 1) (second args) #f)]
         [page-components (regexp-split #rx"/" page)]
         [local-dir ""]
         [local-file ""]
         [fq-uri-dir ""]
         [local-dir-file ""]
         )
    (case (length page-components)
      [(1)
       (set! local-dir "pages")
       (set! local-file (first page-components))
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/" *lesson* "/pages"))]
      [(2)
       (set! local-dir (first page-components))
       (set! local-file (second page-components))
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/" *lesson* "/" local-dir))]
      [(3)
       (set! local-dir (build-path 'up (first page-components) (second page-components)))
       (set! local-file (third page-components))
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/" (first page-components) "/" (second page-components)))]
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
         [link (first args)]
         [link-text (if (> num-args 1) (second args) "")])
    (format "[~a](~a)" link-text link)))

(define (starter-file-link lbl)
  (let ([c (assoc lbl *starter-files*)])
    (cond [(not c) (printf "WARNING: Ill-named starter file ~a\n\n" lbl)
                   ""]
          [else
            (let ([title (second c)]
                  [p (assoc *proglang* (rest (rest c)))])
              (cond [(not p)
                     (printf "WARNING: Missing starter file ~a for ~a\n\n" lbl *proglang*)
                     ""]
                    [else
                      (format "[~a](~a)" title (second p))]))])))

(define read-group
  (*make-read-group (lambda z (first z)) errmessage-file-context))

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
                        (let* ([args (read-commaed-group i directive read-group)]
                               [n (length args)])
                          (display (make-image (first args) (second args) (and (>= n 3) (third args))) o))]
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
                               [fragment (read-group i directive #:multiline? #t)])
                          ; (printf "ifproglang ** ~s ** ~s **\n" proglang fragment)
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
                        (let* ([args (read-commaed-group i directive read-group)]
                               [n-args (length args)]
                               [n (if (= n-args 0) 0 (or (string->number (first args)) 0))])
                          (when (>= n-args 2) (set! n 0))
                          (when (> n 0)
                            (let loop ([j n])
                              (unless (<= j 0)
                                (display (if (= j n) "|DELETE THIS ROW" "|_") o)
                                (loop (- j 1))))
                            (newline o)
                            (let loop ([j n])
                              (unless (<= j 0)
                                (display "|---" o)
                                (loop (- j 1))))))]
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

