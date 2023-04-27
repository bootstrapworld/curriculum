#!/usr/bin/env racket

#lang racket

(require json)
(require "readers.rkt")
(require "utils.rkt")
(require "function-directives.rkt")

(define-namespace-anchor *slides-namespace-anchor*)

(define *slides-namespace* (namespace-anchor->namespace *slides-namespace-anchor*))

(define *use-mathjax-for-math?* #f)

;if md2gslides can't handle too many images, set this to a small number, e.g., 6
(define *max-images-processed* #f)

(define *num-images-processed* 0)

(define *in-file* "doesnt-exist")

(define *topdir* (getenv "topdir"))

(define *progdir* (getenv "PROGDIR"))

(define *proglang* (or (getenv "PROGLANG") "pyret"))

(define *proglang-sym* (string->symbol *proglang*))

(define *starter-files*
  (let ([starter-files-file (build-path *progdir* "starter-files.js")])
    (if (file-exists? starter-files-file)
        (call-with-input-file starter-files-file
          (lambda (i)
            (read i) (read i) (read i)
            (read-json i)))
        '())))

(define *bootstrap-prefix* (or (getenv "BOOTSTRAPPREFIX")
                               "https://bootstrapworld.org/materials/latest/en-us"))

(define *lesson* (or (getenv "LESSON") "__sample-lesson"))

(define *images-hash* #f)

(define *missing-image-json-files* '())

(define (massage-arg arg)
  (eval arg *slides-namespace*))

(define (errmessage-file-context)
  *in-file*)

(define (make-image img width)
  ; (printf "make-image ~s in ~s\n" img (current-directory))
  (set! *num-images-processed* (+ *num-images-processed* 1))

  (unless *images-hash*
    (let ([json-file "images/lesson-images.json"])
      (cond [(file-exists? json-file)
             (set! *images-hash* (call-with-input-file json-file read-json))]
            [else
              (unless (member json-file *missing-image-json-files*)
                (set! *missing-image-json-files* (cons json-file *missing-image-json-files*))
                (printf "!! WARNING: Image json file ~a not found\n" json-file))
              (set! *images-hash* #t)])))

  ; (printf "*images-hash* = ~s\n" *images-hash*)

  (let* ([image-file (call-with-values (lambda () (split-path img)) (lambda (x base y) base))]
         [image-file (string->symbol (path->string image-file))]
         [image-attribs (and (hash? *images-hash*) (hash-ref *images-hash* image-file #f))]
         [text (if (hash? image-attribs) (hash-ref image-attribs 'description "") "")])

    ; (printf "image-attribs = ~s\n" image-attribs)

    (unless (file-exists? img)
      ; (printf "image ~s doesnt exist\n" img)
      (let ([img-anonymized (anonymize-filename img)])
        ; (printf "anon image file is ~s\n" img-anonymized)
        (when img-anonymized
          (set! img img-anonymized))))

    (when (hash? *images-hash*)
      (cond [(not image-attribs)
             (printf "** WARNING: Image ~a missing from dictionary\n" image-file)]
            [(string=? text "")
             (printf "WARNING: Image ~a missing metadata\n" image-file)]))

    (if (and *max-images-processed* (> *num-images-processed* *max-images-processed*))
        (format "**-- INSERT IMAGE ~a HERE --**" img)
        (format "![~a](~a)~a" text img
                (if (string=? width "") "" (format "{width=~a}" width))))))

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
  (set! text (regexp-replace* "\\\\frac{([^}]+)}{([^}]+)}" text "\\1/\\2"))
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
                                           [(equal? w '(#\t #\g))
                                            (loop s-rest (cons #\> r))]
                                           [(equal? w '(#\t #\l))
                                            (loop s-rest (cons #\< r))]
                                           [(or (equal? w '(#\e #\l))
                                                (equal? w '(#\q #\e #\l)))
                                            (loop s-rest (cons #\≤ r))]
                                           [(or (equal? w '(#\e #\g))
                                                (equal? w '(#\q #\e #\g)))
                                            (loop s-rest (cons #\≥ r))]
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
    (set! x (regexp-replace* "{zwsp}" x ""))
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
            (if (symbol? exp)
                (wescheme-symbol->pyret exp)
                (format "~s" exp))
            "</span>\n")]))

(define math code)

(define (contract funname domain-list range [purpose #f])
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
             range)]
        [s2 (and purpose
                 (string-append
                   prefix purpose))])
    (if purpose
        (format "<code>~a</code>\n\n<code>~a</code>" s s2)
        (format "<code>~a</code>" s))))

(define (make-dist-link f link-text)

  (cond [(regexp-match "^ *$" f)
         (set! f "./index.adoc")]
        [(regexp-match "/$" f)
         (set! f (string-append f "index.adoc"))]
        [(regexp-match "^[^/]+$" f)
         (set! f (string-append f "/index.adoc"))])

  (let* ([m (regexp-match "^(.*)/([^/]*)$" f)]
         [dir (second m)]
         [snippet (third m)]
         [dir-compts (regexp-split #rx"/" dir)]
         [local-dir #f]
         [local-f #f])

    (set! local-dir (build-path 'up 'up dir))
    (set! local-f (build-path local-dir snippet))

    ; (printf "local-f = ~s in ~s\n" local-f (current-directory))

    (let* ([f.titletxt (path-replace-extension
                         (build-path local-dir ".cached" snippet)
                         ".titletxt")]
           [page-title (and (file-exists? f.titletxt)
                            (call-with-input-file f.titletxt read-line))]
           [existent-file? #f])
      (cond [(or (path-has-extension? snippet ".adoc")
                 (path-has-extension? snippet ".html")
                 (path-has-extension? snippet ".shtml"))
             (let ([local-f.adoc (path-replace-extension local-f ".adoc")]
                   [local-f.html (path-replace-extension local-f ".html")]
                   [local-f.shtml (path-replace-extension local-f ".shtml")]
                   [local-f.pdf (path-replace-extension local-f ".pdf")])
               (cond [(file-exists? local-f.html)
                      (set! f (path-replace-extension f ".html"))
                      (set! existent-file? #t)]
                     [(file-exists? local-f.shtml)
                      (set! f (path-replace-extension f ".shtml"))
                      (set! existent-file? #t)]
                     [(file-exists? local-f.adoc)
                      (set! f (path-replace-extension
                                f (if (= (length dir-compts) 1) ".shtml" ".html")))
                      (set! existent-file? #t)]
                     [(file-exists? local-f.pdf)
                      (set! f (path-replace-extension f ".pdf"))
                      (set! existent-file? #t)]
                     [(path-has-extension? snippet ".adoc")
                      (set! f (path-replace-extension
                                f (if (= (length dir-compts) 1) ".shtml" ".html")))]))]
            [(path-has-extension? snippet ".pdf")
             (when (file-exists? local-f)
               (set! existent-file? #t))])

      (unless existent-file?
        (printf "WARNING: @dist-link: Missing file ~a\n\n" f))
      (when (and (or (not link-text) (string=? link-text "")) page-title)
        (set! link-text page-title))
      (let ([link-output
              (format "[~a](~a)" link-text (build-path *bootstrap-prefix* f))])
        link-output))))

(define (make-lesson-link f link-text)

  (cond [(regexp-match "^ *$" f)
         (set! f "./index.adoc")]
        [(regexp-match "/$" f)
         (set! f (string-append f "index.adoc"))]
        [(regexp-match "^[^/]+$" f)
         (set! f (string-append f "/index.adoc"))])

  (let* ([m (regexp-match "^(.*)/([^/]*)$" f)]
         [dir (second m)]
         [snippet (third m)]
         [dir-compts (regexp-split #rx"/" dir)]
         [local-dir #f]
         [local-f #f])

    (let* ([first-compt (first dir-compts)]
           [q (qualify-proglang first-compt 'up *proglang*)])
      (unless (string=? q first-compt)
        (set! dir
          (string-join (cons q (rest dir-compts)) "/"))))

    (set! local-dir (build-path 'up dir))
    (set! local-f (build-path local-dir snippet))

    (let* ([f.titletxt (path-replace-extension
                         (build-path local-dir ".cached" snippet)
                         ".titletxt")]
           [page-title (and (file-exists? f.titletxt)
                            (call-with-input-file f.titletxt read-line))]
           [existent-file? #f])
      (cond [(or (path-has-extension? snippet ".adoc")
                 (path-has-extension? snippet ".html")
                 (path-has-extension? snippet ".shtml"))
             (let ([local-f.adoc (path-replace-extension local-f ".adoc")]
                   [local-f.html (path-replace-extension local-f ".html")]
                   [local-f.shtml (path-replace-extension local-f ".shtml")]
                   [local-f.pdf (path-replace-extension local-f ".pdf")])
               (cond [(file-exists? local-f.html)
                      (set! f (path-replace-extension f ".html"))
                      (set! existent-file? #t)]
                     [(file-exists? local-f.shtml)
                      (set! f (path-replace-extension f ".shtml"))
                      (set! existent-file? #t)]
                     [(file-exists? local-f.adoc)
                      (set! f (path-replace-extension
                                f (if (= (length dir-compts) 1) ".shtml" ".html")))
                      (set! existent-file? #t)]
                     [(file-exists? local-f.pdf)
                      (set! f (path-replace-extension f ".pdf"))
                      (set! existent-file? #t)]
                     [(path-has-extension? snippet ".adoc")
                      (set! f (path-replace-extension
                                f (if (= (length dir-compts) 1) ".shtml" ".html")))]))]
            [(path-has-extension? snippet ".pdf")
             (when (file-exists? local-f)
               (set! existent-file? #t))])

      (unless existent-file?
        (printf "WARNING: @lesson-link: Missing file ~a\n\n" f))
      (when (and (or (not link-text) (string=? link-text "")) page-title)
        (set! link-text page-title))
      (let ([link-output
              (format "[~a](~a)" link-text (build-path *bootstrap-prefix* "lessons" f))])
        link-output))))

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
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/lessons/" *lesson* "/pages"))]
      [(2)
       (set! local-dir (first page-components))
       (set! local-file (second page-components))
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/lessons/" *lesson* "/" local-dir))]
      [(3)
       (set! local-dir (build-path 'up (first page-components) (second page-components)))
       (set! local-file (third page-components))
       (set! fq-uri-dir (string-append *bootstrap-prefix* "/lessons/" (first page-components) "/" (second page-components)))]
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

(define (starter-file-link lbl link-text)
  (let ([c (hash-ref *starter-files* lbl #f)])
    (cond [(not c) (printf "WARNING: Ill-named starter file ~a\n\n" lbl)
                   ""]
          [else
            (let ([p (hash-ref c *proglang-sym* #f)])
              (cond [(not p)
                     (printf "WARNING: Missing starter file ~a for ~a\n\n" lbl *proglang*)
                     ""]
                    [else
                      (let ([title (or link-text (hash-ref p 'title #f)
                                       (hash-ref c 'title))])
                        (format "[~a](~a)" title (hash-ref p 'url)))]))])))

(define read-group
  (*make-read-group (lambda z (first z)) errmessage-file-context))

(define (preproc-slides-file in-file)
  (set! *in-file* in-file)
  (let ([out-file (path-replace-extension in-file ".mkd")])

    (define (expand-directives i o)
      (let ([table-header-newlines #f]
            [num-table-columns 0]
            )
        (let loop ()
          (let ([c (read-char i)])
            (unless (eof-object? c)
              (cond
                [(and table-header-newlines (char=? c #\newline))
                 (set! table-header-newlines (- table-header-newlines 1))
                 (when (= table-header-newlines 0)
                   (set! table-header-newlines #f)
                   (newline o)
                   (let loop ([j num-table-columns])
                     (unless (<= j 0)
                       (display "|---" o)
                       (loop (- j 1)))))
                 (newline o)]
                [(char=? c #\@)
                 (let ([directive (read-word i)])
                   ; (printf "directive is ~s\n" directive)
                   (cond [(string=? directive "") (display c o)]
                         [(string=? directive "@") (display c o)]
                         [(string=? directive "image")
                          (let ([args (read-commaed-group i directive read-group)])
                            (display (make-image (first args)
                                                 (if (>= (length args) 2) (second args) ""))
                                     o))]
                         [(member directive '("printable-exercise" "opt-printable-exercise" "handout"))
                          (let ([args (read-commaed-group i directive read-group)])
                            (display (fully-qualify-link args directive) o))]
                         [(string=? directive "dist-link")
                          (let* ([args (read-commaed-group i directive read-group)]
                                 [n (length args)]
                                 [page (first args)]
                                 [link-text (if (> n 1) (second args) "")])
                            (display (make-dist-link page link-text) o))]
                         [(string=? directive "lesson-link")
                          (let* ([args (read-commaed-group i directive read-group)]
                                 [n (length args)]
                                 [page (first args)]
                                 [link-text (if (> n 1) (second args) "")])
                            (display (make-lesson-link page link-text) o))]
                         [(string=? directive "opt-project")
                          (let* ([arg1 (read-commaed-group i directive read-group)]
                                 [project-file (first arg1)]
                                 [rubric-file (and (> (length arg1) 1) (second arg1))])
                            (display (fully-qualify-link (list project-file) directive) o)
                            (when rubric-file
                              (display " [" o)
                              (display (fully-qualify-link (list rubric-file "rubric") directive) o)
                              (display "]" o)))]
                         [(member directive '("link" "online-exercise" "opt-online-exercise"))
                          (let ([args (read-commaed-group i directive read-group)])
                            (display (external-link args directive) o)) ]
                         [(member directive '("starter-file" "opt-starter-file"))
                          (let* ([lbl+text (read-commaed-group i directive read-group)]
                                 [lbl (string->symbol (first lbl+text))]
                                 [link-text (and (>= (length lbl+text) 2) (second lbl+text))])
                            (display (starter-file-link lbl link-text) o))]
                         [(string=? directive "ifproglang")
                          (let* ([proglang (read-group i directive)]
                                 [fragment (read-group i directive #:multiline? #t)])
                            ; (printf "ifproglang ** ~s ** ~s **\n" proglang fragment)
                            (when (string-ci=? proglang *proglang*)
                              (call-with-input-string fragment
                                (lambda (i)
                                  (expand-directives i o)))))]
                         [(member directive '("left" "right" "center"))
                          (let ([fragment (read-group i directive #:multiline? #t)])
                            (call-with-input-string fragment
                              (lambda (i)
                                (expand-directives i o))))]
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
                            (cond [(>= n-args 2)
                                   (set! table-header-newlines 2)
                                   (set! num-table-columns n)]
                                  [else (let loop ([j n])
                                          (unless (<= j 0)
                                            (display (if (= j n) "|DELETE THIS ROW" "|_") o)
                                            (loop (- j 1))))
                                        (newline o)
                                        (let loop ([j n])
                                          (unless (<= j 0)
                                            (display "|---" o)
                                            (loop (- j 1))))]))]
                         [(string=? directive "vocab")
                          (let ([arg (read-group i directive)])
                            (display "<b><i>" o)
                            (display arg o)
                            (display "</i></b>" o))]
                         [(string=? directive "scrub")
                          (read-group i directive)]
                         [(string=? directive "slideLayout")
                          (let ([x (read-group i directive)])
                            (fprintf o "\n---\n{Layout=\"~a\"}\n" x))]
                         [else (display c o) (display directive o)]))]
                [else
                  (display c o)])
              (loop))))))

    (call-with-input-file in-file
      (lambda (i)
        (call-with-output-file out-file
          (lambda (o)
            (expand-directives i o))
          #:exists 'replace)))))

(let ([in-file (vector-ref (current-command-line-arguments) 0)])
  (preproc-slides-file in-file))

(void)

