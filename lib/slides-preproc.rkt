#!/usr/bin/env racket

#lang racket

(require json)
(require racket/hash)
(require "readers.rkt")
(require "utils.rkt")
(require "function-directives.rkt")

(define-namespace-anchor *slides-namespace-anchor*)

(define *slides-namespace* (namespace-anchor->namespace *slides-namespace-anchor*))

; slides should generally have fewer than 100 images
(define *max-images-processed* 200)

(define *num-images-processed* 0)

(define *in-file* "doesnt-exist")

(define *topdir* (getenv "TOPDIR"))

(define *progdir* (getenv "PROGDIR"))

(define *proglang* (or (truthy-getenv "PROGLANG") "pyret"))

(define *proglang-sym* (string->symbol *proglang*))

(define *triple-backtick-proglang* (if (string=? *proglang* "wescheme") "scheme" "pyret"))

(define *natlang* (or (getenv "NATLANG") "en-us"))

(define *pd?* (getenv "PD"))

(define *citations*
  (let ([citations-file (format "~a/distribution/~a/lib/citations.js" *topdir* *natlang*)])
    (if (file-exists? citations-file)
        (call-with-input-file citations-file
          (lambda (i)
            (read i) (read i) (read i)
            (read-json i)))
        '())))

(define *starter-files*
  (let ([starter-files-file (format "~a/distribution/~a/lib/starterFiles.js"
                                    *topdir* *natlang*)])
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

(define *output-answers?* #f)

(define *outputting-table?* #f)

(define *single-question?* #f)

(define *definitions* '())

(define *teacher-notes* #f)

(define *slurping-up-teacher-notes* #f)

(define *autonumber-index* 1)

(define (massage-arg arg)
  (eval arg *slides-namespace*))

(define (errmessage-file-context)
  (format "~a/~a" *lesson* *in-file*))

(define (combine-json-files json-files)
  (let ([h-obj #f])
    (for ([json-file json-files])
      (let ([new-hash (call-with-input-file json-file read-json)])
        (unless h-obj (set! h-obj (make-hash)))
        (hash-union! h-obj new-hash #:combine/key (lambda (k v1 v2) v1))
        ))
    (unless h-obj (set! h-obj #t))
    h-obj))

(define (make-image img width)
  ; (printf "make-image ~s (w ~s) in ~s\n" img width (current-directory))
  (set! *num-images-processed* (+ *num-images-processed* 1))

  (unless *images-hash*
    (let ([json-list-file "images/.cached/.image-list.txt.kp"]
          [json-files '()])

      (when (file-exists? json-list-file)
        (set! json-files (map (lambda (f) (build-path "images" f))
                              (read-data-file json-list-file))))

      (set! *images-hash* (combine-json-files json-files))))


  ; (printf "*images-hash* = ~s\n" *images-hash*)

  (let* ([image-file (call-with-values
                       (lambda () (split-path img))
                       (lambda (x base y)
                         (string->symbol (path->string base))))]
         [image-attribs (and (hash? *images-hash*) (hash-ref *images-hash* image-file #f))]
         [caption (if (hash? image-attribs) (hash-ref image-attribs 'caption "") "")]
         [text (if (hash? image-attribs) (hash-ref image-attribs 'description "") "")])

    ; (printf "image-attribs = ~s\n" image-attribs)

    (unless (file-exists? img)
      ; (printf "image ~s doesnt exist\n" img)
      (let ([img-anonymized (anonymize-filename img)])
        ; (printf "anon image file is ~s\n" img-anonymized)
        (when img-anonymized
          (set! img img-anonymized))))

    (when (and (hash? *images-hash*) image-attribs (string=? text ""))
      (printf "WARNING: Image ~a missing metadata\n" image-file))

    (cond [(and *max-images-processed* (> *num-images-processed* *max-images-processed*))
           (format "**-- INSERT IMAGE ~a HERE --**" img)]
          [*outputting-table?*
            (format "<img src=\"~a\" alt=\"~a\"~a>"
                    (fully-qualify-image img)
                    text
                    (if (string=? width "") ""
                        (format " width=\"~a\"" width)))]
          [else
            (string-append
              (format "![~a](~a)~a" text img
                      (if (string=? width "") "" (format "{width=~a}" width)))
              (if (and caption #f)
                  (format " _~a_" caption)
                  ""))])))

(define (variable-or-number? s)
  (let ([result #t])
    (for ([c s])
      (when (not (or (char-alphabetic? c) (char-numeric? c)))
        (set! result #f)))
    result))

(define (make-math text)
  ; (printf "doing make-math ~s\n" text)
  (or (math-unicode-if-possible text #:asciidoc? #f)
      (let ([use-mathjax?
              (cond [(regexp-match "\\\\frac" text)
                     (cond [(regexp-match "\\\\div" text) #t]
                           [(regexp-match "\\^" text) #t]
                           [(>= (string-length text) 40) #t]
                           [(regexp-match* "\\\\frac{(.+?)}" text)
                            => (lambda (mm)
                                 (cond [(null? mm) #f]
                                       [else (let ([use-mathjax? #f])
                                               (for ([m mm])
                                                 (let ([frac-arg (regexp-replace "\\\\frac{(.+?)}" m "\\1")])
                                                   (unless (variable-or-number? frac-arg)
                                                     (set! use-mathjax? #t))))
                                               use-mathjax?)]))])]
                    [(regexp-match "\\\\sqrt" text) #t]
                    [(regexp-match "\\\\\\\\" text) #t]
                    [(regexp-match "\\\\text" text) #t]
                    [(regexp-match "\\\\mbox" text) #t]
                    [(regexp-match "\\\\over" text) #t]
                    [else #f])])
        ;
        ((if use-mathjax?
             make-mathjax-math
             make-ascii-math) text))))

(define (make-mathjax-math text)
  (string-append
    "\n$" text "$\n"))

(define (read-math-rev-word s)
  (let loop ([s (rest s)] [r (list (first s))])
    (if (null? s) (values r s)
        (let ([a (first s)])
          (cond [(or (char-alphabetic? a) (char-numeric? a)) (loop (rest s) (cons a r))]
                [else (values r s)])))))

(define (read-math-rev-token s)
  (let ([first-s (first s)] [s (rest s)])
    (cond [(char=? first-s #\{)
           (let loop ([s s] [r '()])
             (let ([a (first s)])
               (cond [(char=? a #\}) (values r (rest s))]
                     [else (loop (rest s) (cons a r))])))]
          [else (values s (list first-s))])))

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
                            [(#\^) (let-values ([(w s-rest) (read-math-rev-token s)])
                                     (loop s-rest (append '(#\> #\p #\u #\s #\/ #\<) w '(#\> #\p #\u #\s #\<) r)))]
                            [(#\_) (let-values ([(w s-rest) (read-math-rev-token s)])
                                     (loop s-rest (append '(#\> #\b #\u #\s #\/ #\<) w '(#\> #\b #\u #\s #\<) r)))]
                            [else (loop s (cons a r))]))]))])
    ; (printf "returning ~s\n" ans)
    (string-append "<code>" (list->string ans) "</code>")))

(define (cm-code x #:multiline? [multiline? #t] #:parens [parens #f])
  (let ([pyret? (string=? *proglang* "pyret")])
    (unless (string? x)
      (set! x ((if pyret? wescheme->pyret wescheme->wescheme) x #:parens parens #:indent 0)))
    (set! x (regexp-replace* "{zwsp}" x ""))
    x))

(define (code x #:multiline? [multiline? #t] #:parens [parens #f])
  (let ([x (cm-code x #:multiline? multiline? #:parens parens)])
    (if (regexp-match "\n" x)
        (string-append "```" *triple-backtick-proglang* "\n" x "\n```")
        (string-append "``" x "``"))))

(define (iii-dollar-html x)
  (string-append "\n\nhtml\n"
    "<link rel=\"stylesheet\" href=\"https://bootstrapworld.org/materials/latest/en-us/lib/curriculum.css\"/>\n"
    "<link rel=\"stylesheet\" href=\"https://bootstrapworld.org/materials/latest/en-us/lib/codemirror.css\"/>\n"
    "<link rel=\"stylesheet\" href=\"https://bootstrapworld.org/materials/latest/en-us/lib/style.css\"/>\n"
    "<link rel=\"stylesheet\" href=\"https://bootstrapworld.org/materials/latest/en-us/lib/asciidoctor.css\"/>\n"
    "<style>\n"
    ".circleevalsexp { width: unset !important; }\n"
    "</style>\n"
    "<div id=\"DOMtoImage\" class=\"circleevalsexp\">\n"
    x
    "</div>\n"
    "@@@\n"))

(define (make-html-table cells n #:head? [head? #f])
  ; (printf "doing make-html-table ~a ~a ~a\n" cells n head?)
  (let ([tag (if head? "thead" "tbody")])
    (string-append (format "<~a>" tag)
      (let loop ([cells cells] [res ""])
        (let* ([m (length cells)]
               [row (if (>= m n) (take cells n) cells)]
               [cells2 (if (>= m n) (drop cells n) '())])
          (if (null? cells) res
              (loop cells2
                    (string-append res
                      "<tr>"
                      (apply string-append
                        (map (lambda (c) (string-append "<td>" c "</td>"))
                             (map expand-directives:string->string row)))
                      "</tr>")))))
      (format "</~a>" tag))))

(define (coe exp)
  (let ([x (coe-spans exp)])
    (if *outputting-table?* x
        (iii-dollar-html x))))

(define (enclose-span class s)
  (string-append "<span class=\""
    (substring class 1) "\">" s "</span>"))

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

(define (old-code exp #:parens [parens #f])
  (let ([x ((if (string=? *proglang* "wescheme") wescheme->wescheme wescheme->pyret) exp)])
    ;what about codap
    (set! x (regexp-replace* "{zwsp}" x ""))
    (string-append "<code>" x "</code>")))

(define math old-code)

(define (contract-type x)
  ; (printf "doing contract-type ~s\n" x)
  (cond [(list? x)
         (let ([name (first x)] [type (second x)])
           (unless (string? name) (set! name (format "~a" name)))
           (if (list? type)
               (begin
                 (format "~a :: ~a" name
                         (string-append (contract-type (first type))
                           " -> "
                           (contract-types-to-commaed-string (rest type)))))
               (let* ([type (if (string? type) type (format "~a" type))]
                      [name-w (string-length name)]
                      [type-w (string-length type)]
                      [w (+ 0 (max name-w type-w))])
                 (format "~a :: ~a" name type))))]
        [(string? x) x]
        [else (format "~a" x)]))

(define (contract-types-to-commaed-string xx)
  ; (printf "doing contract-types-to-commaed-string ~s\n" xx)
  (let* ([n (length xx)]
         [contains-parens? (ormap list? xx)]
         [s
           (string-join
             (map contract-type xx)
             ", ")])
    (if contains-parens?
        (string-append "(" s ")")
        s)))

; replace characters with html entities
; there's probably a better way to do this...
(define (htmlize str)
  (string-replace (string-replace str "<" "&lt;") ">" "&gt;"))

(define (contract funname domain-list range [purpose #f])
  (let* ([funname-sym (if (symbol? funname) funname (string->symbol funname))]
         [funname-str (if (string? funname) funname (format "~a" funname))]
         [funname-str (if (string=? *proglang* "pyret") (wescheme->pyret funname-sym) funname-str)]
         [prefix (cond [(string=? *proglang* "pyret") "# "]
                       [(string=? *proglang* "wescheme") "; "]
                       [(string=? *proglang* "codap") ""])]
         [s (string-append
              prefix
              funname-str
              " :: "
              (contract-types-to-commaed-string domain-list)
              " -> "
              (htmlize range))]
         [s2 (and purpose
                  (string-append
                    prefix purpose))])
    (if purpose
        (format "<code>~a</code>\n\n<code>~a</code>" s s2)
        (format "<code>~a</code>" s))))

(define (contracts . args)
  (let ([res ""])
    (let loop ([args args])
      (unless (null? args)
        (set! res (string-append res "\n\n"
                    (apply contract (append (first args)))))
        (loop (rest args))))
    res))

(define (make-dist-link f link-text)

  (cond [(regexp-match "^ *$" f)
         (set! f "./index.adoc")]
        [(regexp-match "/$" f)
         (set! f (string-append f "index.adoc"))]
        [(regexp-match "html$" f)
         (unless (regexp-match "/" f) (set! f (string-append "./" f)))]
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
                            (adoc-to-md
                              (call-with-input-file f.titletxt read-line)))]
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

(define (adoc-to-md x)
  (set! x (regexp-replace* #rx"\\^(.*?)\\^" x "<sup>\\1</sup>"))
  (set! x (regexp-replace* #rx"~(.*?)~" x "<sub>\\1</sub>"))
  x)

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
          (string-join (cons q (rest dir-compts)) "/"))
        (set! f (string-append dir "/" snippet))))

    (set! local-dir (build-path 'up dir))
    (set! local-f (build-path local-dir snippet))

    (let* ([f.titletxt (path-replace-extension
                         (build-path local-dir ".cached" (string-append "." snippet))
                         ".titletxt")]
           [page-title (and (file-exists? f.titletxt)
                            (adoc-to-md
                              (call-with-input-file f.titletxt read-line)))]
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

(define (fully-qualify-image img-file)
  (build-path
    *bootstrap-prefix* "lessons" *lesson*
    img-file))

(define (fully-qualify-link args directive)
  (let* ([num-args (length args)]
         [page (first args)]
         [link-text (if (> num-args 1) (string-join (rest args) ", ") #f)]
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
                 (adoc-to-md
                   (call-with-input-file local-title-file read-line))]
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
         [link-text (if (> num-args 1) (second args) "")]
         [external-link? #f]
         [domain-name #f])
    (when (regexp-match #rx"://" link) (set! external-link? #t))
    ; If there's no custom link-text, add the domain in parens
    (when (and external-link? (string=? link-text ""))
      (set! domain-name (extract-domain-name link)))
    (when domain-name
      (set! link-text (string-append link-text " (" domain-name ")")))
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
  (*make-read-group #:code identity #:errmessage-file-context errmessage-file-context))

(define (ensure-teacher-notes)
  ; (printf "doing ensure-teacher-notes\n")
  (set! *slurping-up-teacher-notes* #t)
  (unless *teacher-notes*
    ; (printf "setting *teacher-notes*\n")
    (set! *teacher-notes* (open-output-string))))

(define (exit-teacher-notes)
  (set! *slurping-up-teacher-notes* #f))

(define (display-teacher-notes o)
  ; (printf "doing display-teacher-notes ~s\n" o)
  (when *teacher-notes*
    (display "\n<!--\n" o)
    (display (get-output-string *teacher-notes*) o)
    (display "\n-->\n" o)
    ; (printf "setting *teacher-notes* to #f\n")
    (set! *teacher-notes* #f)))

(define (expand-directives i o)
  ; (printf "doing expand-directives ~s ~s\n" i o)
  (let ([table-header-newlines #f]
        [num-table-columns 0])

    (let loop ()
      (let ([c (read-char i)])
        (cond [(eof-object? c)
               ; (printf "end of file\n")
               ; (display-teacher-notes o)
               ; (printf "final display-teacher-notes done\n")
               #f

               ]
              [else
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
                           [(string=? directive "slidebreak")
                            (display-teacher-notes o)
                            (display "\n---\n" o)]
                           [(member directive '("image" "centered-image"))
                            (let* ([args (read-commaed-group i directive read-group)]
                                   [img-file (first args)])
                              (display (spaces-till-newline-inclusive i) o)
                              (cond [(not *slurping-up-teacher-notes*)
                                     (display (make-image img-file
                                                          (if (>= (length args) 2) (second args) ""))
                                              o)]
                                    [else
                                      (fprintf o "[[click here for image]](~a)"
                                               (fully-qualify-image (anonymize-filename img-file)))]
                              ))]
                           [(string=? directive "autogen-image")
                            (let* ([text (read-group i directive)] [img (read-group i directive)])
                              (cond [(not *slurping-up-teacher-notes*)
                                     (fprintf o "![~a](~a)" text img)]
                                    [else (fprintf o "[[click here for image]](~a)"
                                                   (fully-qualify-image img))]))]
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
                              (fprintf o "<span class=\"prefix\">Optional Project: </span>")
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
                           [(string=? directive "proglang")
                            (fprintf o "~a" (nicer-case *proglang*))]
                           [(string=? directive "n")
                            (fprintf o "~a\\)" *autonumber-index*)
                            (set! *autonumber-index* (+ *autonumber-index* 1))]
                           [(string=? directive "nfrom")
                            (let* ([arg (read-group i directive)]
                                   [n (string->number arg)])
                              (unless n
                                (printf "WARNING: @nfrom given non-number ~s\n\n" arg))
                              (set! *autonumber-index* n))]
                           [(string=? directive "star")
                            (display "★" o)]
                           [(string=? directive "strategy-basic")
                            (let* ([title (begin0 (read-group i directive) (ignorespaces i))]
                                   [text (read-group i directive #:multiline? #t)]
                                   [o o])
                              (unless *pd?* (ensure-teacher-notes)
                                (set! o *teacher-notes*))
                              (newline o)
                              (newline o)
                              (display "**" o)
                              (expand-directives:string->port title o)
                              (display "**\n" o)
                              (expand-directives:string->port text o)
                              (newline o)
                              (unless *pd?* (exit-teacher-notes)))]
                           [(string=? directive "opt-block")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (expand-directives:string->port text o))]
                           [(member directive '("opt" "teacher"))
                            (let ([text (read-group i directive #:multiline? #t)])
                              (when (member directive '("opt" "opt-block"))
                                (set! text (string-append "_Optional:_ " text)))
                              (ensure-teacher-notes)
                              (newline *teacher-notes*)
                              (newline *teacher-notes*)
                              (expand-directives:string->port text *teacher-notes*)
                              (newline *teacher-notes*)
                              (exit-teacher-notes))]
                           [(string=? directive "ifpdslide")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (when *pd?*
                                (expand-directives:string->port text o)))]
                           [(string=? directive "big")
                            (let ([text (string-trim (read-group i directive #:multiline? #t))])
                              (display "<span style=\"font-size: 22pt\">" o)
                              (expand-directives:string->port text o)
                              (display "</span>" o))]
                           [(string=? directive "lesson-point")
                            (let ([text (string-trim (read-group i directive #:multiline? #t))])
                              (display ":pushpin: " o)
                              (expand-directives:string->port text o))]
                           [(member directive '("lesson-instruction" "lesson-roleplay" "indented"))
                            (let ([text (string-trim (read-group i directive #:multiline? #t))])
                              (expand-directives:string->port text o))]
                           [(member directive '("left" "right" "center"))
                            (let ([fragment (string-trim (read-group i directive #:multiline? #t))])
                              (display (spaces-till-newline-inclusive i) o)
                              (expand-directives:string->port fragment o))]
                           [(string=? directive "math")
                            (let ([text (read-group i directive)])
                              (display (make-math text) o))]
                           [(string=? directive "blockmath")
                            (let ([text (read-group i directive)])
                              (display (make-mathjax-math text) o))]
                           [(string=? directive "smath")
                            (let* ([text (read-group i directive #:scheme? #t)]
                                   [exprs (string-to-form (format "(math '~a)" text))])
                              (for ([s exprs])
                                (display (massage-arg s) o)))]
                           [(string=? directive "do")
                            (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                              (for-each massage-arg exprs))]
                           [(string=? directive "show")
                            (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                              (for ([s exprs])
                                (display (massage-arg s) o)))]
                           [(string=? directive "vocab")
                            (let ([arg (read-group i directive)])
                              (display "<b><i>" o)
                              (display arg o)
                              (display "</i></b>" o))]
                           [(string=? directive "hspace")
                            (let* ([arg (read-group i directive)]
                                  [match (regexp-match (pregexp "([\\d]+)(em|ex)") arg)]
                                  [num (string->number (second match))]
                                  [unit (if (string=? (third match) "ex") 2 3)]
                                  [spaces (string-append* (make-list (* num unit) "&nbsp;"))])
                              (display spaces o))]
                           [(string=? directive "define")
                            (let* ([id (read-group i directive)]
                                   [prose (read-group i directive #:multiline? #t)])
                              (set! *definitions*
                                (cons (cons id prose) *definitions*)))]
                           [(string=? directive "QandA")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (set! *single-question?* (= (length (regexp-match* "@Q{" text)) 1))
                              (expand-directives:string->port text o)
                              (set! *single-question?* #f)
                              (ensure-teacher-notes)
                              (set! *output-answers?* #t)
                              (expand-directives:string->port text *teacher-notes*)
                              (set! *output-answers?* #f)
                              (exit-teacher-notes))]
                           [(string=? directive "Q")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (display "\n" o)
                              (unless *single-question?*
                                (display "* " o))
                              (when *output-answers?*
                                (display "<b>" *teacher-notes*))
                              (expand-directives:string->port text o)
                              (when *output-answers?*
                                (display "</b>\n" *teacher-notes*)))]
                           [(string=? directive "A")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (when *output-answers?*
                                (display "\n* <i>" o)
                                (expand-directives:string->port text o)
                                (display "</i>\n" o)))]
                           [(string=? directive "ifproglang")
                            (let* ([proglang (read-group i directive)]
                                   [text (read-group i directive #:multiline? #t)])
                              (when (string-ci=? proglang *proglang*)
                                (expand-directives:string->port text o)))]
                           [(string=? directive "ifslide")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (expand-directives:string->port text o))]
                           [(string=? directive "ifnotslide")
                            (read-group i directive)]
                           [(string=? directive "citation")
                            (let* ([args (read-commaed-group i directive read-group)]
                                   [lbl (string->symbol (first args))]
                                   [c (hash-ref *citations* lbl #f)]
                                   [in-text (and c (hash-ref c 'in-text #f))]
                                   [url (hash-ref c 'public-url)]
                                   [link #f])
                              (cond [(> (length args) 1)
                                     (set! in-text
                                       (expand-directives:string->string
                                         (second args)))]
                                    [in-text
                                      (set! in-text
                                        (expand-directives:string->string in-text))]
                                    [else lbl])
                              (cond [(not c)
                                     (printf "WARNING: ~a: Undefined @~a ~a\n\n"
                                             (errmessage-file-context) directive lbl)]
                                    [(not in-text)
                                     (printf "WARNING: ~a: @~a ~a missing\n\n"
                                             (errmessage-file-context) directive lbl)]
                                    [(string=? url "")
                                     (printf "WARNING: ~a: @~a ~a missing URL\n\n"
                                             (errmessage-file-context) directive lbl)]
                                    [else (fprintf o "[~a](~a)" in-text url)]))]
                           [(assoc directive *definitions*)
                            => (lambda (c)
                                 (expand-directives:string->port (cdr c) o))]
                           [else (display c o) (display directive o)]))]
                  [else
                    (display c o)])
                (loop)])))
    ; (printf "expand-directives done\n")

    ))

(define (expand-directives:string->string s)
  (call-with-output-string
    (lambda (o)
      (expand-directives:string->port s o))))

(define (expand-directives:string->port s o)
  ; (printf "doing expand-directives:string->port ~s\n\n" s )
  (call-with-input-string s
    (lambda (i)
      (expand-directives i o))))

(define (preproc-slides-file in-file out-file)
  ; (printf "\ndoing preproc-slides-file ~s ~s\n" in-file out-file)
  (system (string-append
    "node " *topdir*
    "/lib/maker/screenshot-elts.js " *topdir* "/distribution"))
  (set! *in-file* in-file)
  (call-with-input-file in-file
    (lambda (i)
      (call-with-output-file out-file
        (lambda (o)
          (expand-directives i o)
          (display-teacher-notes o))
        #:exists 'replace))))

(let* ([cla (current-command-line-arguments)]
       [in-file (vector-ref cla 0)]
       [out-file (vector-ref cla 1)])
  (preproc-slides-file in-file out-file))

(void)
