#lang racket

(require json)
; (require file/sha1)
(require "readers.rkt")
(require "utils.rkt")
(require "html-tag-gen.rkt")
(require "defines.rkt")
(require "common-defines.rkt")
(require "function-directives.rkt")
(require "collect-lang-prereq.rkt")

(provide
  preproc-adoc-file
  rearrange-args
  )

(define *progdir* (getenv "PROGDIR"))

(define *book* (truthy-getenv "BOOK"))

(define *only-some-courses* (truthy-getenv "COURSE"))

; (define *math-unicode?* (truthy-getenv "MATHUNICODE"))

(define *math-unicode?* #t)

(define *proglang* "pyret")

(define *proglang-sym* 'pyret)

(define *natlang* 'en-us)

(define *optional-flag?* #f)

(define *other-proglangs* #f)

(define *all-lessons* '())

(define *containing-directory* "")

(define *pyret?* #f)

(define *solutions-mode?* #f)

(define *possibly-invalid-page?* #f)

(define *pathway* "BOGUSPATHWAY")

(define *lesson-plan* #f)

(define *lesson-plan-base* #f)

;(printf "LESSONPLAN is ~s\n" *lesson-plan*)

(define *other-dir* #f)

(define *lesson* #f)

;(printf "LESSON is ~s\n" *lesson*)

(define *lesson-subdir* (truthy-getenv "LESSONSUBDIR")) ;FIXME

;(printf "LESSONSUBDIR is ~s\n" *lesson-subdir*)

(define *narrative* #f)

(define *teacher-resources* #f)

(define *autonumber-index* 1)

(define *internal-links-port* #f)
(define *external-links-port* #f)

(define *first-level-section-titles* '())

(define *natlang-glossary-list* '())

(define *simple-directives*
  (call-with-input-file (build-path *progdir* "simple-directives.json")
    read-json))

(define-namespace-anchor *adoc-namespace-anchor*)

(define *adoc-namespace* (namespace-anchor->namespace *adoc-namespace-anchor*))

(when *progdir*
  (let ([pathway-local-file (build-path *progdir* "pathway-local.rkt")])
    (when (file-exists? pathway-local-file)
      (call-with-input-file pathway-local-file
        (lambda (i)
          (let loop ()
            (let ([x (read i)])
              (unless (eof-object? x)
                (eval x *adoc-namespace*)
                (loop)))))))))

(define *pathway-root-dir* (or (getenv "PATHWAYROOTDIR") "")) ;FIXME

;(define *dist-root-dir* (getenv "DISTROOTDIR"))

(define *dist-root-dir* "")

;(printf "distrootdir= ~s\n" *dist-root-dir*)

(define *target-pathway* "notDoingPathway")

(define *in-file* #f)

(define *workbook-pagenums*
  (if *lesson-plan*
      (let ([f (string-append *pathway-root-dir* ".cached/.workbook-page-index.rkt")])
        (if (file-exists? f)
            (let ([xx (call-with-input-file f read)])
              (map (lambda (x) (list (list (list-ref x 0) (list-ref x 1)) (list-ref x 3))) xx)
              )
            '()))
      '()))

(define *workbook-pages* '())

;(printf "*workbook-pagenums* = ~s\n" *workbook-pagenums*)

(define *definitions* '())

(define *local-scheme-definitions* '())

(define *enclosing-directive* #f)

(define *external-url-index*
  (let ([f (string-append *pathway-root-dir* "external-index.rkt")])
    (if (file-exists? f)
        (call-with-input-file f read)
        '())))

;default values
(define *copyright-name* "Bootstrap")

(define *copyright-info-file* (string-append *pathway-root-dir* "copyright-info.rkt"))

(define *copyright-info*
  (if (file-exists? *copyright-info-file*)
      (call-with-input-file *copyright-info-file* read)
      '()))

(cond [(assoc "name" *copyright-info*)
       => (lambda (c) (set! *copyright-name* (second c)))])

(define *glossary-list*
  (let ([glossary-terms-file "lib/glossary-terms.json"])
    (if (file-exists? glossary-terms-file)
        (call-with-input-file glossary-terms-file read-json)
        '())))

(define *glossary-items* '())

(define *missing-glossary-items* '())

(define *lesson-prereqs* '())

(define *lesson-keywords* '())

(define *exercises-done* '())

(define *prereqs-used* '())

(define *common-text*
  (call-with-input-file
    (build-path *progdir* "common-text.json")
    read-json))

(define *starter-files*
  (let ([starter-files-file (format "distribution/~a/starterFiles.js" *natlang*)])
    (if (file-exists? starter-files-file)
        (call-with-input-file starter-files-file
          (lambda (i)
            (read i) (read i) (read i)
            (read-json i)))
        '())))

(define *assessments*
  (let ([assessments-file (format "distribution/~a/assessments.js" *natlang*)])
    (if (file-exists? assessments-file)
        (call-with-input-file assessments-file
          (lambda (i)
            (read i) (read i) (read i)
            (read-json i)))
        '())))

(define *learning-objectives*
  (let ([learning-objectives-file (format "distribution/~a/learningObjectives.js" *natlang*)])
    (if (file-exists? learning-objectives-file)
        (call-with-input-file learning-objectives-file
          (lambda (i)
            (read i) (read i) (read i)
            (read-json i)))
        '())))

(define *citations*
  (let ([citations-file (format "distribution/~a/citations.js" *natlang*)])
    (if (file-exists? citations-file)
        (call-with-input-file citations-file
          (lambda (i)
            (read i) (read i) (read i)
            (read-json i)))
        '())))

(define *objectives-met* '())
(define *assessments-met* '())

(define *starter-files-used* '())
(define *opt-starter-files-used* '())

(define *online-exercise-links* '())
(define *opt-online-exercise-links* '())
(define *printable-exercise-links* '())
(define *opt-printable-exercise-links* '())
(define *handout-exercise-links* '())
(define *starter-file-links* '())
(define *opt-starter-file-links* '())
(define *opt-project-links* '())
(define *project-lessons* '())

(define *images-hash-list* '())

(define *missing-image-json-files* '())

(define (errmessage-context)
  (let ([s ""])
    (cond [*narrative* (set! s "Pathway narrative ")]
          [*lesson-plan* (set! s "Lesson plan ")]
          [*lesson* (set! s "Lesson ")])
    (string-append s (errmessage-file-context))))

(define (errmessage-file-context)
  ;(format "~a/~a" (current-directory) *in-file*)
  (format "~a" *in-file*)
  )

(define read-group (*make-read-group #:code (lambda z (apply code z))
                                     #:errmessage-file-context errmessage-file-context))

(define (skip-1-newline-if-possible i o)
  (let loop ()
    (let ([c (peek-char i)])
      (cond [(eof-object? c) #f]
            [(or (char=? c #\space) (char=? c #\tab)) (display (read-char i) o) (loop)]
            [(char=? c #\newline) (read-char i) #t]
            [else #f]))))

(define (assoc-glossary term)
  ; (printf "doing assoc-glossary ~s ~n" term)
  (let ([terms (cons term
                     (case *natlang*
                       [(en-us)
                        (cond [(regexp-match "(.*)ies$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list (string-append root "y"))))]
                              [(regexp-match "(.*)es$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list root (string-append root "e"))))]
                              [(regexp-match "(.*)s$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list root)))]
                              [(regexp-match "(.*)ied$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list (string-append root "y"))))]
                              [(regexp-match "(.*)ed$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list root (string-append root "e"))))]
                              [(regexp-match "(.*)ing$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list root (string-append root "e"))))]
                              [else '()])]
                       [(es-mx)
                        (cond [(regexp-match "(.*)iones$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list (string-append root "ión"))))]
                              [(regexp-match "(.*)ques$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list (string-append root "c"))))]
                              [(regexp-match "(.*)gues$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list (string-append root "g"))))]
                              [(regexp-match "(.*)ces$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list (string-append root "z"))))]
                              [(regexp-match "(.*)es$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list root)))]
                              [(regexp-match "(.*)s$" term)
                               => (lambda (x)
                                    (let ([root (second x)])
                                      (list root)))]
                              [else '()])]
                       [else '()]))])
    ; (printf "terms = ~s\n" terms)
    (let loop ([L *natlang-glossary-list*])
      (if (null? L) #f
          (let* ([c (first L)]
                 [lhs (first c)] [rhs (second c)])
            (or (cond [(string? lhs)
                       (ormap (lambda (term)
                                (and (string-ci=? term lhs) c))
                              terms)]
                      [(list? lhs)
                       (let ([headword (car lhs)])
                         (unless (string? headword) (set! headword #f))
                         (ormap (lambda (lhs1)
                                  (cond [(string? lhs1)
                                         (ormap (lambda (term)
                                                  (and (string-ci=? term lhs1) (list (or headword lhs1) rhs)))
                                                terms)]
                                        [(list? lhs1)
                                         (ormap (lambda (term)
                                                  (ormap (lambda (lhs2)
                                                           (and (string-ci=? term lhs2) (list (car lhs1) rhs)))
                                                         lhs1))
                                                terms)]
                                        [else #f]))
                                lhs))]
                      [else #f])
                (loop (cdr L))))))))

(define (check-first-subsection i o)
  (let ([c (peek-char i)])
    (if (eof-object? c) #f
        (char=? c #\=))))

(define (display-section-markup i o)
  (let ([section-level
          (let loop ([section-level 0])
            (let ([c (peek-char i)])
              (cond [(eof-object? c) section-level]
                    [(char=? c #\=) (read-char i) (loop (+ section-level 1))]
                    [else section-level])))]
        [title (string-trim (read-line i))])
    (when (and *lesson-plan* (= section-level 1))
      (let ([section-title (string-trim (regexp-replace "@duration{(.*)}" title "(\\1)"))])
        (set! *first-level-section-titles* (cons section-title *first-level-section-titles*))))
    (fprintf o "[.lesson-section-~a]~n" section-level)
    (for ([i section-level])
      (display #\= o))
    (display "= " o)
    (expand-directives:string->port title o)
    (newline o)))

(define (massage-arg arg)
  ;(printf "doing massage-arg ~s\n" arg)
  (eval arg *adoc-namespace*))

(define (massage-arg-def arg)
  (when (and (list? arg) (eq? (car arg) 'define) (> (length arg) 2))
    (let ([x (cadr arg)])
      (when (list? x) (set! x (car x)))
      (set! *local-scheme-definitions* (cons x *local-scheme-definitions*))))
  (massage-arg arg))

(define (erase-local-scheme-definitions)
  (for ([n *local-scheme-definitions*])
    ; (printf "erasing ~a\n" n)
    (namespace-undefine-variable! n *adoc-namespace*)
    ; (eval `(define ,n "NOT A VALID DEFINITION") *adoc-namespace*)
    ))

(define (rearrange-args args)
  ;(printf "doing rearrange-args ~s\n" args)

  (define (sort-keyword-args args)
    (let ([args-paired (let loop ([args args] [r '()])
                         (if (null? args) r
                               (loop (rest (rest args))
                                     (cons (list (first args) (massage-arg (second args)))
                                         r))))])
      (sort args-paired keyword<? #:key first)))

  (let loop ([args args] [r '()])
    (if (null? args)
        (values '() '() (reverse r))
        (let ([arg (first args)])
          (cond [(keyword? arg)
                 (let ([kvkv (sort-keyword-args args)])
                   (values (map first kvkv) (map second kvkv) (reverse r)))]
                [else
                  (loop (rest args) (cons arg r))])))))

(define (qualify-lesson-dir this-lesson)
  ; (printf "doing qualify-lesson-dir ~s ~s\n" this-lesson *proglang*)
  ; (printf "all-lessons = ~s\n" *all-lessons*)
  (let ([result #f]
        [this-lesson-wo-proglang (regexp-replace "-(codap|wescheme)$" this-lesson "")])
    (cond [(string=? *proglang* "pyret")
           ; (printf "this-lesson-wo-proglang= ~s\n" this-lesson-wo-proglang)
           (when (member this-lesson-wo-proglang *all-lessons*)
             (set! result this-lesson-wo-proglang))]
          [(string=? *proglang* "wescheme")
           (when (member this-lesson-wo-proglang *all-lessons*)
             (let ([this-lesson-in-wescheme (string-append this-lesson-wo-proglang "-wescheme")])
               ; (printf "this-lesson-in-wescheme = ~s\n" this-lesson-in-wescheme)
               (set! result this-lesson-in-wescheme)))]
          [else
            (let ([this-lesson-with-our-proglang (string-append this-lesson-wo-proglang "-" *proglang*)])
              ; (printf "this-lesson-w-our-proglang= ~s\n" this-lesson-with-our-proglang)
              (when (member this-lesson-with-our-proglang *all-lessons*)
                (set! result this-lesson-with-our-proglang)))])
    (unless result
      (printf "WARNING: Referring to nonexistent lesson ~s\n\n" this-lesson)
      (set! result this-lesson))
    result))

(define (this-proglang-lesson? this-lesson)
  ; (printf "doing this-proglang-lesson? ~s \n\n" this-lesson )
  (let ([result 0])
    (cond [(string=? *proglang* "pyret")
           (set! result #t)
           ;if lesson has suffix -otherproglang and deleting that suffix
           ;gives a lesson that is present, then don't include
           (for ([-other-proglang '("-codap$" "-wescheme$")])
             (when (regexp-match -other-proglang this-lesson)
               (let ([this-lesson-delete-proglang
                       (regexp-replace -other-proglang this-lesson "")])
                 (when (member this-lesson-delete-proglang *all-lessons*)
                   (set! result #f)))))]
          [else
            (set! result #f)
            (let ([-this-proglang (string-append "-" *proglang* "$")])
              ;if lesson has suffix -thisproglang, include
              (cond [(regexp-match -this-proglang this-lesson)
                     (set! result #t)]
                    [else
                      (set! result #t)
                      ;if lesson has suffix -otherproglang, and deleting
                      ;that suffix gives a lesson that is present, don't include
                      (for ([-other-proglang '("-codap$" "-wescheme$")])
                        (unless (string=? -this-proglang -other-proglang)
                          (when (regexp-match -other-proglang this-lesson)
                            (let ([this-lesson-delete-proglang
                                    (regexp-replace -other-proglang this-lesson "")])
                              (when (member this-lesson-delete-proglang *all-lessons*)
                                (set! result #f))))))
                      (when result
                        ;if lesson with suffix -thisproglang exists, don't include
                        (let ([lesson-proglang (string-append this-lesson "-" *proglang*)])
                          (when (member lesson-proglang *all-lessons*)
                            (set! result #f))))]))])
    result))

(define (display-prereqs-bar o)
  ; (printf "doing display-prereqs-bar in ~s\n" *in-file* )
  (let ([relevant-lessons (filter (lambda (x) (this-proglang-lesson? x))
                                  *all-lessons*)])
    ;(printf "f : ~s\n" (file-exists? (format "../../lesson-order.txt")))
    ;(printf "doing display-prereqs-bar ~s\n" all-lessons )
    ;(printf "*lesson-prereqs* = ~s\n" *lesson-prereqs*)
    (display (create-begin-tag "div" ".sidebarlessons") o)
    (display "*Lessons*\n" o)

    (display (create-begin-tag "ul" "") o)

    (display (create-end-tag "ul") o)
    (display (create-end-tag "div") o)
    (newline o)
    ))

(define (display-standards-bar o)
  ;(printf "doing display-standards-bar\n")
  (display "\n[.sidebarstandards,cols=\"a\"]" o)
  (display "\n|===\n" o)
  (display "| " o)
  (display "*Aligns to:*\n" o)
  (display-standards-selection o *narrative*)
  (display " | \n" o)
  (display "\ninclude::.index-standards.asc[]\n" o)
  (display "|===\n" o))

(define (exercise-title f)
  (if (and (file-exists? f) (path-has-extension? f ".adoc"))
      (call-with-input-file f
        (lambda (i)
          (let loop ()
            (let ([x (read-line i)])
              (cond [(eof-object? x) #f]
                    [(regexp-match #rx"^= " x)
                     (regexp-replace "^= *" x "")]
                    [else (loop)])))))
      #f))

(define (dispatch-make-workbook-link page-compts link-text directive)
  ; (printf "doing dispatch-make-workbook-link ~s ~s ~s\n" page-compts link-text directive)
  (let ([first-compt (first page-compts)])
    (case (length page-compts)
      [(1)
       (cond [*lesson*
               (make-workbook-link #f
                 (if *solutions-mode?* "solution-pages" "pages")
                 first-compt
                 link-text
                 #:link-type directive)]
             [else
               (printf "WARNING: Incorrect¹ @~a ~a\n\n"
                       directive page-compts)
               ""])]
      [(2)
       (let ([second-compt (second page-compts)])
         (cond [(and (or (string=? first-compt "pages")
                         (string=? first-compt "solution-pages"))
                     (or *lesson* *lesson-plan*))
                (make-workbook-link #f
                  first-compt
                  (second page-compts)
                  link-text
                  #:link-type directive)]
               [else
                 ;TODO should these just be warnings
                 ;with the @workbook-link converted to plain @link ?
                 ;(printf "*lesson* is ~s\n" *lesson*)
                 (printf "WARNING: Incorrect² @~a ~a\n\n"
                         directive page-compts)
                 ""]))]
      [(3)
       (let ([second-compt (second page-compts)]
             [third-compt (third page-compts)])
         (cond [(or (string=? second-compt "pages")
                    (string=? second-compt "solution-pages"))
                (make-workbook-link
                  first-compt
                  ;(string-append "lessons/" first-compt)
                  second-compt
                  third-compt link-text
                  #:link-type directive)]
               [else
                 (printf "WARNING: Incorrect³ @~a ~a\n\n"
                         directive page-compts)
                 ""]))]
      [else
        (printf "WARNING: Incorrect⁴ @~a ~a\n\n"
                directive page-compts)
        ""])))

(define (make-workbook-link lesson-dir pages-dir snippet link-text #:link-type [link-type #f])
  ; (printf "make-workbook-link ~s ~s ~s ~s ~s\n" lesson-dir pages-dir snippet link-text link-type)
  ; (printf "lesson-dir= ~s\n*lesson*= ~s\n*pwydir= ~s\n" lesson-dir *lesson* *pathway-root-dir*)
  (let* ([lesson (cond [(equal? lesson-dir *lesson*) (set! lesson-dir #f) *lesson*]
                       [lesson-dir (qualify-lesson-dir lesson-dir)]
                       [else *lesson*])]
         [g (string-append lesson "/" pages-dir "/" snippet)]
         [g-in-pages (string-append lesson "/pages/" snippet)]
         [f (format "distribution/~a/lessons/~a" *natlang* g)]
         [f.src f]
         [f.titletxt (path-replace-extension
                       (format "distribution/~a/lessons/~a/~a/.cached/.~a"
                               *natlang* lesson pages-dir snippet)
                       ".titletxt")]
         [page-title (and (file-exists? f.titletxt)
                       (call-with-input-file f.titletxt read-line))]
         [existent-file? #f]
         [non-workbook-page? #f]
         [error-cascade? #f])
    ;g = relative pathname of the linked file from pathway-root-dir
    ;f = its fully qualified pathname
    ; (printf "f= ~s in ~s: ~s\n" f (current-directory) (file-exists? f))
    (cond [(or (path-has-extension? f ".adoc") (path-has-extension? f ".html"))
           (let ([f.adoc (path-replace-extension f ".adoc")]
                 [f.html (path-replace-extension f ".html")]
                 [f.pdf (path-replace-extension f ".pdf")])
             (cond [(or (file-exists? f.html) (file-exists? f.adoc))
                    ; (printf "I\n")
                    (set! f f.html)
                    (set! existent-file? #t)
                    (when (and existent-file? (equal? link-type "printable-exercise")
                               (not lesson-dir)
                               (not (member snippet *workbook-pages*)))
                      (set! non-workbook-page? #t)
                      (set! existent-file? #f))
                    (set! g-in-pages (path-replace-extension g-in-pages ".html"))
                    (set! g (path-replace-extension g ".html"))]
                   [(file-exists? f.pdf)
                    ; (printf "II\n")
                    (set! f f.pdf)
                    (set! existent-file? #t)
                    (set! g-in-pages (path-replace-extension g-in-pages ".pdf"))
                    (set! g (path-replace-extension g ".pdf"))]))]
          [(path-has-extension? f ".pdf")
           (when (file-exists? f)
             (set! existent-file? #t))]
          [else (set! f.src (path-replace-extension f ".adoc"))])
    ; (printf "f'= ~s exf= ~s\n" f existent-file?)
    (unless existent-file?
      (set! error-cascade? #t)
      (check-link f)
      (printf "WARNING: Lesson ~a: ~a refers to ~a file ~a\n\n" lesson link-type
              (if non-workbook-page? "non-workbook" "nonexistent")
              f))
    (when (member link-type '("printable-exercise" "opt-printable-exercise" "handout"))
      (let ([f (format "~a" g-in-pages)])
        (unless lesson-dir
          (unless (ormap (lambda (e) (equal? (first e) f)) *exercises-done*)
            (let ([ex-ti (or (exercise-title f.src) link-text *page-title*)])
              (set! *exercises-done*
                (cons (list f ex-ti) *exercises-done*)))))))
    (when (and (or (not link-text) (string=? link-text "")) page-title)
      ;FIXME: is link-text ever #f
      (set! link-text page-title))
    (let ([link-output
            (format "link:~alessons/pass:[~a][~a~a]"
                    *dist-root-dir* g link-text
                    (if (or *lesson-plan*
                            (member link-type '("printable-exercise" "opt-printable-exercise" "handout")))
                        ", window=\"&#x5f;blank\"" ""))]
          [materials-link-output
            (format "link:~alessons/pass:[~a][~a~a]"
                    *dist-root-dir* g (or page-title link-text)
                    (if (or *lesson-plan*
                            (member link-type '("printable-exercise" "opt-printable-exercise" "handout")))
                        ", window=\"&#x5f;blank\"" ""))])
      (when *lesson-plan*
        (cond [(or (equal? link-type "opt-printable-exercise")
                   (and (equal? link-type "printable-exercise") *optional-flag?*))
               (let ([styled-link-output (string-append "[.Optional.PrintableExercise]##"
                                           materials-link-output "##")])
                 (unless (member styled-link-output *opt-printable-exercise-links*)
                   (set! *opt-printable-exercise-links*
                     (cons styled-link-output *opt-printable-exercise-links*))))]

              [(equal? link-type "printable-exercise")
               (let* ([styled-link-output
                        (let ([tack-on ", window=\"&#x5f;blank\""])
                          (format "[.PrintableExercise]##link:~alessons/pass:[~a][~a~a] ##"
                                  *dist-root-dir* g (or page-title link-text) tack-on))]
                     ; [styled-link-output
                     ;   (string-append "[.PrintableExercise]##" materials-link-output-with-pdf "##")]
                     )
                 (unless (findf (lambda (L) (equal? (second L) styled-link-output))
                                *printable-exercise-links*)
                   (set! *printable-exercise-links*
                     (cons (list snippet styled-link-output) *printable-exercise-links*))))]

              [(equal? link-type "handout")
               (let ([styled-link-output (string-append "[.handout]##"
                                           materials-link-output "##")])
                 (unless (member styled-link-output *handout-exercise-links*)
                   (set! *handout-exercise-links*
                     (cons styled-link-output *handout-exercise-links*))))]))
      link-output)))

(define (display-header-comment prose o)
  (call-with-output-file ".index-comment.txt"
    (lambda (o)
      (display "<!--" o)
      (display prose o)
      (display "-->" o)
      (newline o))
    #:exists 'append))

(define (clean-up-image-text text)
  ; (printf "doing clean-up-image-text ~s\n" text)
  (let ([n (string-length text)])
    (when (>= n 1)
      (when (char=? (string-ref text 0) #\")
        (set! text (substring text 1)))
      (when (char=? (string-ref text (- n 1)) #\")
        (set! text (substring text 0 (- n 1))))))
  ; (set! text (regexp-replace* #rx"," text "%CURRICULUMCOMMA%"))
  text)

(define (clean-up-url-in-image-text text)
  ; (printf "doing clean-up-url-in-image-text ~s\n" text)
  (regexp-replace* #rx"https://" text ""))

(define (read-image-json-file-in image-dir)
  (let ([json-file (build-path image-dir "lesson-images.json")]
        [images-hash #f]
        [missing-image-log-file #f]
        [missing-images '()])

    (when *lesson*
      (set! missing-image-log-file
        (format "distribution/~a/lessons/~a/.cached/.missing-image-files.txt"
                *natlang* *lesson*)))

    (cond [(file-exists? json-file)
           (set! images-hash (call-with-input-file json-file read-json))
           ; (printf "images-hash is ~s\n" images-hash)
           (set! *images-hash-list*
             (cons (cons *containing-directory* images-hash) *images-hash-list*))
           (unless (or *narrative* *target-pathway* *teacher-resources*)
             (hash-for-each images-hash
               (lambda (key val)
                 (let* ([image-file (build-path image-dir (symbol->string key))]
                        [anon-image-file (anonymize-filename image-file)])
                   (unless (file-exists? anon-image-file)
                     (cond [(file-exists? image-file)
                            (rename-file-or-directory image-file anon-image-file #t)]
                           [else
                             (unless (member key missing-images)
                               (set! missing-images (cons key missing-images)))
                             #;(printf "WARNING: ~a: Image file ~a not found\n" (errmessage-context) image-file)
                             ]))))))]
          [else
            (when (or *lesson-plan* *lesson*)
              (unless (member json-file *missing-image-json-files*)
                (set! *missing-image-json-files* (cons json-file *missing-image-json-files*))
                (printf "!! WARNING: Image json file ~a not found\n" json-file)))])

    (when missing-image-log-file
      (call-with-output-file missing-image-log-file
        (lambda (o)
          (for ([f missing-images])
            (write f o) (newline o)))
        #:exists 'append))

    images-hash
    ))

(define (make-image img width #:text [author-supplied-text #f] #:centered? [centered? #f])
  ; (printf "doing make-image ~s ~s\n" img width)
  (let* ([img-qn (build-path *containing-directory* img)]
         [images-hash-cell (assoc *containing-directory* *images-hash-list*)]
         [images-hash (and images-hash-cell (cdr images-hash-cell))])
    (let-values ([(image-dir image-file ign) (split-path img-qn)])

      (unless images-hash
        (set! images-hash (read-image-json-file-in image-dir)))

      (unless (or *narrative* *target-pathway* *teacher-resources*)
        (let* ([img-anonymized (anonymize-filename img)]
               [img-anonymized-qn (build-path *containing-directory* img-anonymized)])
          (set! img img-anonymized)
          (unless (file-exists? img-anonymized-qn)
            (cond [(file-exists? img-qn)
                   (rename-file-or-directory img-qn img-anonymized-qn #t)]
                  [else (printf "WARNING: ~a: Image file ~a not found\n\n"
                                (errmessage-context) img-qn)]))))

      (let ([image-attribs (and (hash? images-hash)
                                (hash-ref images-hash
                                          (string->symbol (path->string image-file))
                                          #f))]
            [image-caption ""]
            [image-description ""]
            [image-license ""]
            [image-source ""])

        (when image-attribs
          (set! image-caption (hash-ref image-attribs 'caption ""))
          (set! image-description (hash-ref image-attribs 'description ""))
          (set! image-license (hash-ref image-attribs 'license ""))
          (set! image-source (hash-ref image-attribs 'source "")))

        (unless (or *narrative* *target-pathway* *teacher-resources*)
          (when (hash? images-hash)
            (cond [(not image-attribs)
                   (printf "WARNING**: Image ~a missing from dictionary ~a/lesson-images.json\n"
                           img-qn image-dir)]
                  [(or (string=? image-description "")
                       (string=? image-license "")
                       (string=? image-source ""))
                   (printf "WARNING: Image ~a missing metadata in ~a/lesson-images.json\n"
                           img-qn image-dir)])))

        (when author-supplied-text (set! image-description author-supplied-text))

        (let* ([text (clean-up-image-text image-description)]
               [width-arg (unquote-string width)]
               [height-arg ""]
               [text-wo-url (clean-up-url-in-image-text text)]
               [commaed-opts (string-append
                               ", "
                               width-arg
                               ", "
                               height-arg
                               (if (string=? text "") ""
                                   (format ", title=~s" text-wo-url)))]
               [adoc-img
                 (cond [*lesson-subdir*
                         (format "image:~a[~s~a]" img text-wo-url commaed-opts)]
                       [else
                         (format "image:~a[~s~a]" img text-wo-url commaed-opts)])]
               [img-id (format "img_id_~a" (gen-new-id))]
               [adoc-img (enclose-span ".image-figure"
                           (string-append
                             ; (if (string=? text "") "" (enclose-span ".tooltiptext" text))
                             adoc-img
                             (if image-caption
                                 (enclose-span ".image-caption"
                                   (expand-directives:string->string image-caption)
                                   #:attribs (format "id=~s" img-id))
                                 ""))
                           #:attribs
                           (and image-caption
                                (format "aria-describedby=~s" img-id)))])

          ; (printf "adoc-img = ~s\n" adoc-img)

          (if centered?
              (enclose-span ".centered-image" adoc-img)
              adoc-img))))))

(define (check-link f #:external? [external? #f])
  ; (unless external? (printf "doing check-link ~s \n" f))
  (cond [external? (display f *external-links-port*)
                   (newline *external-links-port*)]
        [(not (file-exists? f))
         (display f *internal-links-port*)
         (newline *internal-links-port*)]))

(define (abbreviated-index-page? f)
  (and (directory-exists? f)
       (ormap (lambda (x) (file-exists? (build-path f x)))
              (list "index.html"
                    "index.shtml"
                    "index.adoc"
                    "index.asciidoc"))))

(define (make-dist-link f link-text)
  ; (printf "doing make-dist-link ~s ~s\n" f link-text)
  (let ([url-has-query-string? #f])
    (cond [(regexp-match "\\?.*=" f) (set! url-has-query-string? #t)
                                     (unless (regexp-match "/" f) (set! f (string-append "./" f)))]
          [(regexp-match "^ *$" f) (set! f "./index.adoc")]
          [(regexp-match "/$" f) (set! f (string-append f "index.adoc"))]
          [(regexp-match "html$" f) (unless (regexp-match "/" f) (set! f (string-append "./" f)))]
          [(regexp-match "^[^/]+$" f) (set! f (string-append f "/index.adoc"))])
    (let* ([m (regexp-match "^(.*)/([^/]*)$" f)]
           [dir (second m)] [snippet (third m)]
           [dir-compts (regexp-split #rx"/" dir)]
           [dist-natlang-dir (format "distribution/~a" *natlang*)]
           [f.titletxt (format "~a/~a/.cached/.~a"
                               dist-natlang-dir dir
                               (path-replace-extension snippet ".titletxt"))]
           [page-title (and (file-exists? f.titletxt)
                            (call-with-input-file f.titletxt read-line))]
           [existent-file? #f]
           [url-without-query-string #f])
      (cond [url-has-query-string?
              (set! url-without-query-string (regexp-replace "\\?.*" f ""))
              (when (file-exists? (build-path dist-natlang-dir url-without-query-string))
                (set! existent-file? #t))]
            [(or (path-has-extension? f ".adoc")
                 (path-has-extension? f ".html") (path-has-extension? f ".shtml"))
             (let ([f.adoc (path-replace-extension f ".adoc")]
                   [f.html (path-replace-extension f ".html")]
                   [f.shtml (path-replace-extension f ".shtml")]
                   [f.pdf (path-replace-extension f ".pdf")])
               (cond [(file-exists? (build-path dist-natlang-dir f.html))
                      (set! f f.html) (set! existent-file? #t)]
                     [(file-exists? (build-path dist-natlang-dir f.shtml))
                      (set! f f.shtml) (set! existent-file? #t)]
                     [(file-exists? (build-path dist-natlang-dir f.adoc))
                      (set! f (if (= (length dir-compts) 2) f.shtml f.html))
                      (set! existent-file? #t)]
                     [(file-exists? (build-path dist-natlang-dir f.pdf))
                      (set! f f.pdf) (set! existent-file? #t)]
                     [(path-has-extension? f ".adoc")
                      (set! f (if (= (length dir-compts) 2) f.shtml f.html))]))]
            [(path-has-extension? f ".pdf")
             (when (file-exists? (build-path dist-natlang-dir f)) (set! existent-file? #t))])
      (unless existent-file?
        (check-link f) ;move inside next unless?
        (unless (and *only-some-courses* (regexp-match "courses/" f))
          (printf "WARNING: ~a: @dist-link: Missing file ~a\n\n" (errmessage-context) f)))
      (when (and (or (not link-text) (string=? link-text "")) page-title)
        (set! link-text page-title))
      (let ([link-output (format "link:~apass:[~a][~a~a]"
                                 "{fromlangroot}"
                                 f link-text
                                 (if *lesson-plan* ", window=\"&#x5f;blank\"" ""))])
        link-output))))

(define (make-lesson-link f link-text)
  ; (printf "doing make-lesson-link ~s ~s\n\n" f link-text)
  (cond [(regexp-match "^ *$" f)
         ;just to avoid error
         (set! f "./index.adoc")]
        [(regexp-match "(.*)/#([^/]+)$" f)
         => (lambda (m)
              (let ([dir (second m)] [sec (third m)])
                (set! f (format "~a/index.adoc#~a" dir sec))))]
        [(regexp-match "/$" f)
         (set! f (string-append f "index.adoc"))]
        [(regexp-match "^[^/]+$" f)
         (set! f (string-append f "/index.adoc"))])

  ; (printf "doing make-lesson-link ii ~s ~s\n\n" f link-text)

  (let* ([m (regexp-match "^(.*)/([^/#]*)(#?[^/]*)$" f)]
         [dir (second m)]
         [fyle (third m)]
         [sec (fourth m)]
         [dir-compts (regexp-split #rx"/" dir)]
         [project-lesson? #f]
         )

    (when (regexp-match "project-" dir)
      (set! project-lesson? #t))

    (unless (string=? sec "")
      (set! f (string-append dir "/" fyle)))

    (let* ([first-compt (first dir-compts)]
           [q (qualify-proglang first-compt (format "distribution/~a/lessons" *natlang*)
                                *proglang*)])
      (unless (string=? q first-compt)
        (set! dir
          (string-join
            (cons q (rest dir-compts)) "/"))
        (set! f (string-append dir "/" fyle))))

    (set! f (format "distribution/~a/lessons/~a" *natlang* f))
    (set! dir (format "distribution/~a/lessons/~a" *natlang* dir))

    (let* ([f.titletxt (path-replace-extension
                         (string-append dir "/.cached/." fyle)
                         ".titletxt")]
           [page-title (and (file-exists? f.titletxt)
                            (call-with-input-file f.titletxt read-line))]
           [existent-file? #f]
           [f.adoc (path-replace-extension f ".adoc")]
           [f.html (path-replace-extension f ".html")]
           [f.shtml (path-replace-extension f ".shtml")]
           [f.pdf (path-replace-extension f ".pdf")])
      (cond [(or (path-has-extension? f ".adoc")
                 (path-has-extension? f ".html") (path-has-extension? f ".shtml"))
             (cond [(file-exists? f.html)
                    (set! f f.html)
                    (set! existent-file? #t)]
                   [(file-exists? f.shtml)
                    (set! f f.shtml)
                    (set! existent-file? #t)]
                   [(file-exists? f.adoc)
                    (set! f
                      (if (= (length dir-compts) 1) f.shtml f.html))
                    (set! existent-file? #t)]
                   [(file-exists? f.pdf)
                    (set! f f.pdf)
                    (set! existent-file? #t)]
                   [(path-has-extension? f ".adoc")
                    (set! f
                      (if (= (length dir-compts) 1) f.shtml f.html))])]
            [(path-has-extension? f ".pdf")
             (when (or (file-exists? f)
                       (file-exists? f.adoc)
                       (file-exists? f.html) (file-exists? f.shtml))
               (set! existent-file? #t))])
      (unless existent-file?
        (check-link f)
        (printf "WARNING: ~a: @lesson-link: Missing file ~a\n\n" (errmessage-context) f))
      (when (and (or (not link-text) (string=? link-text "")) page-title)
        (set! link-text page-title))
      (when (path? f) (set! f (path->string f)))
      (when project-lesson?
        (unless (member f *project-lessons*)
          (set! *project-lessons*
            (cons (regexp-replace "distribution/[^/]+/lessons/" dir "")
                  *project-lessons*))))
      (let ([link-output

              (format "link:{fromlangroot}pass:[~a~a][~a~a]"
                      (regexp-replace "distribution/[^/]+/" f "")
                      sec
                      link-text
                      (if *lesson-plan* ", window=\"&#x5f;blank\"" ""))

              ])
        ;(printf "outputting link-output= ~s\n\n" link-output)
        link-output))))

(define (make-link f link-text #:include? [include? #f] #:link-type [link-type #f])
  ; (printf "doing make-link f= ~s ltxt= ~s inc= ~s ltyp= ~s\n" f link-text include? link-type)
  (let ([external-link? #f]
        [g f])
    (cond [(string=? f "") #f]
          [(regexp-match #rx"://" f) (set! external-link? #t)]
          [(regexp-match #rx"^mailto:" f) (set! external-link? #t)]
          [(regexp-match #rx"^javascript:" f) #f]
          [(regexp-match #rx"^#" f) #f]
          [else (set! f (string-append *containing-directory* "/" f))])
    ; (printf "ext link = ~s\n" external-link?)
    (cond [(not include?)
           (cond [(string=? f "")
                  (printf "WARNING: ~a: @link with no file argument\n\n"
                          (errmessage-context))]
                 [(regexp-match #rx"://" f)
                  (check-link f #:external? #t)]
                 [(regexp-match #rx"^mailto:" f) #f]
                 [(regexp-match #rx"^javascript:" f) #f]
                 [(regexp-match #rx"^#" f) #f]
                 [else
                   (let ([existent-file? #f])
                     (cond [(file-exists? (path-replace-extension f ".html"))
                            (set! existent-file? #t)
                            (set! g (path-replace-extension g ".html"))]
                           [(file-exists? (path-replace-extension f ".shtml"))
                            (set! existent-file? #t)
                            (set! g (path-replace-extension g ".shtml"))]
                           [(file-exists? (path-replace-extension f ".pdf"))
                            (set! existent-file? #t)
                            (set! g (path-replace-extension g ".pdf"))]
                           [(and (file-exists? f)
                                 (equal? (path-get-extension f) #".adoc"))
                            (set! existent-file? #t)
                            (set! g (path-replace-extension g ".html"))]
                           [(file-exists? f)
                            (set! existent-file? #t)]
                           )
                     (when existent-file?
                       (set! f (build-path *containing-directory* g)))
                     ; (printf "link ~a refers to ~a\n\n" g f)
                     (let ([short-ref? (abbreviated-index-page? f)])
                       ; (printf "g = ~s is valid short-ref\n" g)
                       (unless (or existent-file?
                                   (string=? g "pathway-standards.shtml");remove ;FIXME
                                   short-ref?)
                         (check-link f)
                         ; This warning is too eager. Leave it to --lint
                         ; (printf "WARNING: ~a: @link refers to nonexistent file ~a\n\n"
                         ;         (errmessage-context)
                         ;         f)
                         )
                       (when short-ref? (set! g (build-path g "index.shtml")))))])

           (when (and (member link-type '("online-exercise" "opt-online-exercise"))
                      external-link?)
             (let ([domain-name (extract-domain-name f)])
               (when domain-name
                 (set! link-text (string-append link-text " (" domain-name ")")))))

           (when (and *lesson-plan* (not external-link?) (equal? link-type "link") (equal? link-text ""))
             (let ([lesson-title-file (find-relative-path (simple-form-path f)
                                                          (build-path ".cached" ".index.titletxt"))])
               (when (file-exists? lesson-title-file)
                 (set! link-text (call-with-input-file lesson-title-file read-line)))))

           (let ([link-output
                   (cond [(or *lesson-plan* *teacher-resources*
                              (member link-type '("online-exercise" "opt-online-exercise")))
                          (format "link:pass:[~a][~s, window=\"&#x5f;blank\"]" g link-text)]
                         [else (format "link:pass:[~a][~a]" g link-text)])])

             (when (and *lesson-plan* external-link?)
               (when (equal? link-type "online-exercise")
                 (let ([styled-link-output (string-append "[.OnlineExercise]##" link-output "##")])
                   (unless (assoc g *online-exercise-links*)
                     (set! *online-exercise-links*
                       (cons (cons g styled-link-output) *online-exercise-links*)))))

               (when (or (equal? link-type "opt-online-exercise")
                         (and (equal? link-type "online-exercise")
                              *optional-flag?*))
                 (let ([styled-link-output (string-append "[.Optional.OnlineExercise]##"
                                             link-output "##")])
                   (unless (assoc g *opt-online-exercise-links*)
                     (set! *opt-online-exercise-links*
                       (cons (cons g styled-link-output) *opt-online-exercise-links*)))))
               )

             ; (printf "make-link outputting ~s\n" link-output)

             link-output)

           ]
          [else
            (let* ([f.asc (regexp-replace "([^/]+)\\.adoc" f ".cached/.\\1.asc")]
                   [f.uses-mathjax (string-append f.asc ".uses-mathjax")])
              ;(printf "make-link checking ~s vs ~s\n" f.asc f)
              ;TODO: probably not needed anymore

              (when (file-exists? f.uses-mathjax)
                (set! *uses-mathjax?* #t)
                ; (create-zero-file (format "~a.uses-mathjax" *out-file*))
                )

              ;FIXME: avoid erroring include: if file doesn't exist?
              (format "include::~a[~a]"
                      f.asc link-text))])))

(define *lesson-summary-file* #f)

(define *page-title* #f)

(define (display-alternative-proglang o)
  ; (printf "doing display-alternative-proglang op= ~s; tp=~s; n= ~s; lp= ~s\n" *other-proglangs* *target-pathway* *narrative* *lesson-plan*)
  (when (and *other-proglangs*
             (not (null? *other-proglangs*))
             (or *narrative* *lesson-plan*))
    ; (printf "doing display-alternative-proglang really\n")
    (let ([other-proglang-links
            (filter (lambda (x) x)
                    (map (lambda (x)
                           (cond [(or (not x) (string=? x "none") (string=? x *proglang*)) #f]
                                 [(and (string=? x "pyret") *narrative* (string=? *target-pathway* "algebra-wescheme"))
                                  (format "link:pass:[~acourses/algebra-pyret][Pyret]" *dist-root-dir*)]
                                 [(and (string=? x "wescheme") *narrative* (string=? *target-pathway* "algebra-pyret"))
                                  (format "link:pass:[~acourses/algebra-wescheme][WeScheme]" *dist-root-dir*)]
                                 [(and (string=? x "pyret") *lesson-plan*)
                                  (format "link:pass:[~alessons/~a/index.shtml][Pyret]" *dist-root-dir*
                                          (regexp-replace "-[a-z]+$" *lesson-plan* ""))]
                                 [*lesson-plan*
                                   (format "link:pass:[~alessons/~a/index.shtml][~a]" *dist-root-dir*
                                           (if (string=? *proglang* "pyret")
                                               (string-append *lesson-plan* "-" x)
                                               (regexp-replace "-[a-z]+$" *lesson-plan* (string-append "-" x)))
                                           (nicer-case x))]
                                 [else #f]))
                         *other-proglangs*))])
      (unless (null? other-proglang-links)
        (display
          (enclose-span ".other-proglang"
            (natlang:also-available-in
              (string-join
                other-proglang-links
                ", "))) o)
        (newline o)))
    (newline o)))

(define (store-title title-txt)
  (unless *other-dir*
    (let ([title-file (path-replace-extension *out-file* ".titletxt")]
          [title-txt (regexp-replace* #rx"," (regexp-replace* #rx"\\[.*?\\]##(.*?)##" title-txt "\\1") "\\&#x2c;")])
      (call-with-output-file title-file
        (lambda (o)
          (display title-txt o) (newline o))
        #:exists 'replace))))

(define (display-title i o)
  (let* ([title (read-line i)]
         [title-txt (string-trim (regexp-replace "^=+ *" title ""))])
    (when *lesson-plan*
      (set! *first-level-section-titles* '()))
    (set! *page-title* title-txt)
    (store-title title-txt)
    (fprintf o "[.~a]\n" *proglang*)
    (display #\= o)
    (display title o)
    (newline o)
    (newline o)

    (when (and *lesson-subdir* (not *lesson-plan*) (not *narrative*))
      (let ([lesson-title-file
              (build-path "lessons" *lesson* ".cached" ".index.titletxt")]
            [lesson-title *lesson*])
        (when (file-exists? lesson-title-file)
          (set! lesson-title (call-with-input-file lesson-title-file read-line)))
        (when lesson-title
          (display
            (enclose-span ".web-page-only"
              (format
                "Referenced from lesson link:{pathwayrootdir}~a/index.shtml[~a] (~a, ~a)"
                *lesson* lesson-title
                (string-titlecase (getenv "SEMESTER")) (getenv "YEAR"))) o)
          (display "\n\n" o)
          )))))

(define (display-lesson-description desc auxfile o)
  ; (printf "doing display-lesson-description ~s\noutputting to ~s\n" desc auxfile)
  (call-with-output-file auxfile
    (lambda (o)
      (display desc o) (newline o))
    #:exists 'replace)
  (display "\n\n[.description]\n" o)
  (display desc o)
  (display "\n\n" o)
  )

(define (link-to-opt-projects o)
  ; (printf "doing link-to-opt-projects\n")
  (let ([lessons (read-data-file
                   (format "distribution/~a/courses/~a/lesson-order.txt"
                           *natlang* *target-pathway*))]
        [projects-title-done? #f])
    (for ([lesson lessons])
      (let ([lesson-opt-links (read-data-file
                                (format "distribution/~a/lessons/~a/.cached/.index-opt-proj.rkt.kp"
                                        *natlang* lesson)
                                #:mode 'forms)])
        ; (printf "lesson-opt-links for ~s is ~s\n" lesson lesson-opt-links)
        (for ([x lesson-opt-links])
          (let* ([proj-link (first x)]
                 [proj-desc proj-link])
            (set! proj-desc (regexp-replace "^link:\\.\\./\\.\\./" proj-desc ""))
            (set! proj-desc (regexp-replace "\\]\\[.*\\]$" proj-desc ""))
            (set! proj-desc (regexp-replace "pass:\\[" proj-desc ""))
            (set! proj-desc (regexp-replace "pages/" proj-desc "pages/.cached/."))
            (set! proj-desc (regexp-replace "\\.html$" proj-desc "-desc.txt.kp"))
            (unless projects-title-done?
              (set! projects-title-done? #t)
              (fprintf o "\n\n*Single-Lesson Projects*\n\n"))
            (fprintf o "- *~a* {startsb}~a{endsb}\n~a\n"
                     (regexp-replace "^link:" proj-link "link:../")
                     (regexp-replace "^link:" (second x) "link:../")
                     (if (file-exists? proj-desc)
                         (string-append " "
                           (call-with-input-file proj-desc port->string))
                         ""))))))))

(define (link-to-notes-pages o)
  (let ([lessons (read-data-file
                   (format "distribution/~a/courses/~a/lesson-order.txt"
                           *natlang* *target-pathway*))]
        [notes-title-done? #f])
    (for ([lesson lessons])
      (let ([lesson-notes-pages
              (read-data-file
                (format "distribution/~a/lessons/~a/pages/.cached/.workbook-notes-pages-ls.txt.kp"
                        *natlang* lesson))])
        (for ([page lesson-notes-pages])
          ; (unless notes-title-done?
          ;   (set! notes-title-done? #t)
          ;   (fprintf o "\n\n- *All Lesson Notes*\n"))
          (set! page (regexp-replace ".adoc$" page ""))
          (let ([title-file (format "distribution/~a/lessons/~a/pages/.cached/.~a.titletxt"
                                    *natlang* lesson page)]
                [link-text page])
            (when (file-exists? title-file)
              (set! link-text (call-with-input-file title-file read-line)))
            (fprintf o "\n** link:../../../lessons/~a/pages/~a.html[~a]\n" lesson page link-text)))))))

(define (link-to-project-lessons-short-form header project-lessons o)
  ; (printf "doing link-to-project-lessons-short-form\n")
  (when (pair? project-lessons)
    (fprintf o "\n\n== Projects Available for this ~a\n\n" header)
    (let ([firstp #t])
      (for ([project-lesson project-lessons])
        (let* ([link-title-file (format
                                  "distribution/~a/lessons/~a/.cached/.index.titletxt"
                                  *natlang* project-lesson)]
               [link-text (if (file-exists? link-title-file)
                              (call-with-input-file link-title-file port->string)
                              project-lesson)])
          (set! link-text (regexp-replace "Project: " link-text ""))
          (if firstp (set! firstp #f)
              (display ", " o))
          (fprintf o "link:~apass:[lessons/~a/index.shtml][~a]"
                   "{fromlangroot}"
                   project-lesson link-text))))
    (display "\n\n" o)))

(define (link-to-project-lessons-long-form header project-lessons o)
  (when (pair? project-lessons)
    (newline o)
    (for ([project-lesson project-lessons])
      (let* ([link-title-file (format
                                "distribution/~a/lessons/~a/.cached/.index.titletxt"
                                *natlang* project-lesson)]
             [link-desc-file (format
                               "distribution/~a/lessons/~a/.cached/.index-desc.txt.kp"
                               *natlang* project-lesson)]
             [link-text (if (file-exists? link-title-file)
                            (call-with-input-file link-title-file port->string)
                            project-lesson)]
             [link-desc (if (file-exists? link-desc-file)
                            (call-with-input-file link-desc-file port->string)
                            project-lesson)])
        (set! link-text (regexp-replace "Project: " link-text ""))
        (fprintf o "\n* link:~apass:[~a][~a]: ~a"
                 "{fromlangroot}"
                 project-lesson link-text link-desc)))
    (display "\n\n" o)))

(define (link-to-project-lessons-in-lesson-plan o)
  ; (printf "doing link-to-project-lessons-in-lesson-plan\n")
  (let ([project-lessons (reverse *project-lessons*)])
    (link-to-project-lessons-short-form "Lesson" project-lessons o)))

(define (link-to-project-lessons-in-pathway o)
  ; (printf "doing link-to-project-lessons-in-pathway\n")
  (let ([lessons (read-data-file
                   (format "distribution/~a/courses/~a/.cached/.workbook-lessons.txt.kp"
                           *natlang* *target-pathway*))]
        [project-lessons '()])
    (for ([lesson lessons])
      (let ([lesson-pl-file
              (format "distribution/~a/lessons/~a/.cached/.index-projectlessons.rkt.kp" *natlang* lesson)])
        (when (file-exists? lesson-pl-file)
          (let ([lesson-project-lessons (call-with-input-file lesson-pl-file read)])
            (set! project-lessons
              (append project-lessons lesson-project-lessons))))))
    (set! project-lessons (remove-duplicates project-lessons))
    ((if *teacher-resources*
         link-to-project-lessons-long-form
         link-to-project-lessons-short-form)
      "Course" project-lessons o)
    ))

(define (link-to-lessons-in-pathway o)
  ; (printf "link-to-lessons-in-pathway\n")
  ;
  (let ([lessons (read-data-file
                   (format "distribution/~a/courses/~a/.cached/.workbook-lessons.txt.kp"
                           *natlang* *target-pathway*))])
    ;(printf "lessons = ~s\n" lessons)
    ;
    ;(fprintf o "~n.Lessons Used in This Pathway\n")
    (print-lessons-intro o)
    (fprintf o "[#lesson-list]\n")
    (for ([lesson lessons])
      ;(printf "tackling lesson ~s\n" lesson)
      (let* ([lesson-index-file (format "lessons/~a/index.shtml" lesson)]
             [lesson-directory (format "distribution/~a/lessons/~a" *natlang* lesson)]
             [lesson-title-file (format "~a/.cached/.index.titletxt"
                                        lesson-directory)]
             [lesson-desc-file (format "~a/.cached/.index-desc.txt.kp"
                                       lesson-directory)]
             [lesson-title lesson]
             [lesson-description #f])
        (unless (directory-exists? lesson-directory)
          (printf "WARNING: Course ~a referring to nonexistent lesson ~a\n\n"
                  *target-pathway* lesson))
        (when (file-exists? lesson-title-file)
          ;(printf "~a exists\n" lesson-title-file)
          (set! lesson-title (call-with-input-file lesson-title-file read-line)))
        ;(printf "lesson-title is ~s\n" lesson-title)
        (when (file-exists? lesson-desc-file)
          ;(printf "~a exists\n" lesson-desc-file)
          (set! lesson-description
            (call-with-input-file lesson-desc-file
              (lambda (i)
                (let ([r ""])
                  (let loop ()
                    (let ([x (read-line i)])
                      (unless (eof-object? x)
                        (set! r (string-append r "\n" x))
                        (loop))))
                  r)))))
        ;(printf "lesson-description is ~s\n" lesson-description)
        ;lesson-index-file (shtml) doesn't exist yet, but shd we at least check for index.adoc?
        (if (string-prefix? lesson "project-")
          (fprintf o "link:pass:[~a~a?pathway=~a][~a, role=project] ::" *dist-root-dir* lesson-index-file *target-pathway* lesson-title)
          (fprintf o "link:pass:[~a~a?pathway=~a][~a] ::" *dist-root-dir* lesson-index-file *target-pathway* lesson-title)
          )

        (if lesson-description
            (display lesson-description o)
            (display " {nbsp}" o))
        ;(when lesson-description
        ;(display lesson-description o)
        ;(newline o))
        (newline o)))
      (for ([lesson lessons])
        ;(printf "tackling lesson i ~s\n" lesson)
        (let ([lesson-asc-file
                (format "distribution/~a/lessons/~a/.cached/.index.asc" *natlang* lesson)]
              [lesson-glossary-file
                (format "distribution/~a/lessons/~a/.cached/.index-glossary.json"
                        *natlang* lesson)]
              [lesson-title-file
                (format "distribution/~a/lessons/~a/.cached/.index.titletxt" *natlang* lesson)]
              [lesson-title lesson]
              )

          (when (file-exists? lesson-title-file)
            ;(printf "~a exists i\n" lesson-title-file)
            (set! lesson-title (call-with-input-file lesson-title-file read-line)))

          (when (file-exists? lesson-glossary-file)
            ; (printf "~a exists i\n" lesson-glossary-file)
            (for ([s (call-with-input-file lesson-glossary-file read-json)])
              (unless (member s *glossary-items*)
                (set! *glossary-items*
                  (cons s *glossary-items*)))))
          ;(printf "took care of pw glossary~n")
          )
    )
    (newline o)))

(define (create-vspace ht)
  (let ([num (regexp-replace #rx"([0-9]*)ex" ht "\\1")])
    (when (string=? num ht) (set! num "10"))
    (set! num (inexact->exact (floor (string->number num))))
    (set! num (quotient num 4))
    (string-append (create-begin-tag "span" ".vspace" #:attribs
                                     (format "style=\"height: ~a\"" ht))
      (create-end-tag "span"))))

(define (add-lesson-keywords kwds)
  (for ([k (reverse kwds)])
    (unless (member k *lesson-keywords*)
      (set! *lesson-keywords* (cons k *lesson-keywords*)))))

(define (add-lesson-prereqs immediate-prereqs)
  ; (printf "doing add-lesson-prereqs ~s ~s ~s\n" *lesson-plan* immediate-prereqs *proglang*)
  ; (printf "lesson-prereq dir = ~s\n" (current-directory))
  (cond [(and (not (string=? *proglang* "pyret")) (not (string=? *proglang* "none")))
         (set! *lesson-prereqs* (map (lambda (x) (string-append x "-" *proglang*)) immediate-prereqs))]
        [else
          (set! *lesson-prereqs* immediate-prereqs)])
  (for ([lsn *lesson-prereqs*])
    (let ([lsn-prereq-file (build-path *containing-directory* 'up lsn ".cached" ".lesson-prereq.txt.kp")])
      ; (printf "lsn-prereq-file is ~s ~s\n" lsn-prereq-file (file-exists? lsn-prereq-file))
      (when (file-exists? lsn-prereq-file)
        (let ([pp (read-data-file lsn-prereq-file)])
          ; (printf "pp are ~s\n" pp)
          (for ([p pp])
            ; (printf "trying p = ~s\n" p)
            (unless (member p *lesson-prereqs*)
              ; (printf "adding p = ~s\n" p)
              (set! *lesson-prereqs* (cons p *lesson-prereqs*))))))))
  (let ([this-lsn-prereq-file (build-path *containing-directory* ".cached" ".lesson-prereq.txt.kp")])
    ; (printf "writing to prereq-file = ~s\n" this-lsn-prereq-file)
    (call-with-output-file this-lsn-prereq-file
      (lambda (o)
        (for ([p *lesson-prereqs*])
          (display p o) (newline o)))
      #:exists 'replace)))


(define (init-flags in-file)
  ;(printf "doing init-flags\n")
  (set! *autonumber-index* 1)
  (set! *glossary-items* '())
  (set! *missing-glossary-items* '())
  (set! *lesson-prereqs* '())
  (set! *lesson-keywords* '())
  (set! *online-exercise-links* '())
  (set! *opt-online-exercise-links* '())
  (set! *printable-exercise-links* '())
  (set! *opt-printable-exercise-links* '())
  (set! *handout-exercise-links* '())
  (set! *starter-file-links* '())
  (set! *opt-starter-file-links* '())
  (set! *opt-project-links* '())
  (set! *project-lessons* '())
  (set! *exercises-done* '())
  (set! *objectives-met* '())
  (set! *assessments-met* '())
  (set! *starter-files-used* '())
  (set! *opt-starter-files-used* '())
  (set! *workbook-pages* '())
  (set! *natlang-glossary-list* '())
  (set! *natlang* (string->symbol (getenv "NATLANG")))
  (set! *optional-flag?* #f)
  (set! *first-level-section-titles* '())
  (set! *possibly-invalid-page?* #f)
  (set! *definitions* '())
  (set! *local-scheme-definitions* '())
  (set! *enclosing-directive* #f)

  (set! *pyret?* (string=? *proglang* "pyret"))

  (set! *proglang-sym* (string->symbol *proglang*))

  (when (and *lesson-plan* (not *lesson*))
    (set! *lesson* *lesson-plan*))

  (set! *lesson-plan-base* *lesson-plan*)
  (when *lesson-plan*
    (unless *pyret?*
      (let ([x (regexp-replace (format "-~a$" *proglang*) *lesson-plan* "")])
        (unless (string=? *lesson-plan* x)
          (set! *lesson-plan-base* x)))))

  (when (or *lesson* *lesson-plan*)
    (let ([workbook-pages-ls-file
            (format "distribution/~a/lessons/~a/pages/.cached/.workbook-pages-ls.txt.kp"
                    *natlang* *lesson*)])
      (unless (file-exists? workbook-pages-ls-file)
        (error 'ERROR "File ~a not found" workbook-pages-ls-file))
      (set! *workbook-pages*
        (read-data-file workbook-pages-ls-file #:mode 'files))))

  (set! *in-file* (build-path *containing-directory* in-file))

  (when (and *lesson* (not *lesson-plan*) (not *other-dir*))
    (let* ([exercise-pages-ls-file
            (format "distribution/~a/lessons/~a/pages/.cached/.opt-exercise-pages-ls.txt.kp"
                    *natlang* *lesson*)]
           [exercise-pages (read-data-file exercise-pages-ls-file)]
           [handout-pages-ls-file
            (format "distribution/~a/lessons/~a/pages/.cached/.handout-exercise-pages-ls.txt.kp"
                    *natlang* *lesson*)]
           [handout-pages (read-data-file handout-pages-ls-file)]
           )
      (unless (or (member in-file *workbook-pages*)
                  (member in-file exercise-pages)
                  (member in-file handout-pages))
        (set! *possibly-invalid-page?* #t))))

  ; (printf "lesson-plan= ~s; lesson-plan-base= ~s\n\n" *lesson-plan* *lesson-plan-base*)

  (let ([gl *glossary-list*])
    ;
    (when (or *lesson* *lesson-plan*)
      (let ([f (format "distribution/~a/lessons/~a/shadow-glossary.txt" *natlang* *lesson*)])
        (when (file-exists? f)
          (let ([ff (read-data-file f #:mode 'files)])
            (when (pair? ff)
              (let ([shadow-glossary-file (build-path "lib" (first ff))])
                (when (file-exists? shadow-glossary-file)
                  (set! gl
                    (append gl (call-with-input-file shadow-glossary-file read-json))))))))))
    ;
    (for ([entry gl])
      (let ([h (hash-ref entry *natlang* #f)])
        (when h
          (set! *natlang-glossary-list*
            (cons (list (hash-ref h 'keywords '())
                        (hash-ref h 'description ""))
                  *natlang-glossary-list*))))))

  (when (or *lesson-plan* *lesson*)
    (set! *all-lessons* (read-data-file (getenv "LESSONS_LIST_FILE"))))

  (erase-span-stack!)

  (set! *out-file* (build-path *containing-directory* ".cached"
                               (path-replace-extension (string-append "." in-file) ".asc")))
  )

(define *title-reached?* #f)
(define *first-subsection-reached?* #f)
(define *out-file* #f)
(define *supplemental-materials-needed?* #f)

(define *uses-codemirror?* #f)
(define *uses-mathjax?* #f)

(define *needs-objectives?* #f)
(define *uses-objectives?* #f)

(define (expand-directives i o)
        ;(printf "doing expand-directives\n")
        (let ([beginning-of-line? #t]
              [possible-beginning-of-line? #f])
          (let loop ()
            (let ([c (read-char i)])
              (unless (eof-object? c)
                (cond
                  [(char=? c #\@)
                   (set! beginning-of-line? #f)
                   (set! possible-beginning-of-line? #f)
                   (let ([directive (read-word i)])
                     ;(printf "directive = ~s~%" directive)
                     (cond [(string=? directive "") (display c o)]
                           [(string=? directive "@") (display c o)]
                           [(string=? directive "span")
                            (display-begin-span (read-group i directive) o)
                            ]
                           [(string=? directive "left")
                            (display-begin-span ".left" o)]
                           [(string=? directive "right")
                            (display-begin-span ".right" o)]
                           [(string=? directive "center")
                            (display-begin-span ".center" o)]
                           [(string=? directive "big")
                            (display-begin-span ".big" o)]
                           [(string=? directive "clear")
                            (display (enclose-span "" "" #:attribs "style=\"clear: both;display: block\"") o)]
                           [(string=? directive "link-instructions")
                            (let ([prose (read-group i directive #:multiline? #t)])
                              (display
                                (enclose-span ".linkInstructions"
                                  (expand-directives:string->string prose)) o))]
                           [(string=? directive "define")
                            (let* ([id (read-group i directive)]
                                   [prose (read-group i directive #:multiline? #t)])
                              (set! *definitions*
                                (cons (cons id prose) *definitions*)))]
                           [(string=? directive "comment")
                            (let ([prose (read-group i directive)])
                              (if *title-reached?*
                                  #f
                                  (display-header-comment prose o)
                                  ))]
                           [(member directive '("scrub" "slidestyle"))
                            (read-group i directive)]
                           [(member directive '("ifslide" "pd-slide" "ifpdslide"))
                            (let ([text (read-group i directive #:multiline? #t)])
                              (when (or (regexp-match "\\|===" text)
                                        (regexp-match "@image{" text)
                                        (regexp-match "@centered-image{" text)
                                        (regexp-match "@show{ *\\(coe" text))
                                (display "\n[.actually-openblock.hiddenblock]\n====\n" o)
                                (expand-directives:string->port text o #:enclosing-directive directive)
                                (display "\n====\n" o)))]
                           [(member directive '("ifnotslide" "preparation"))
                            (let ([text (read-group i directive #:multiline? #t)])
                              (expand-directives:string->port text o #:enclosing-directive directive))]
                           [(string=? directive "blanklines")
                            (let* ([n (string->number (read-group i directive))]
                                   [height (* n 2.2)] ; each line is 2.2rem tall (see shared.less)
                                   [text (read-group i directive #:multiline? #t)])
                              ; (printf "doing @blanklines ~s\n" n)
                              (display
                                (enclose-openblock
                                  ".blanklines"
                                  (lambda ()
                                    (expand-directives:string->string
                                      text #:enclosing-directive directive))
                                  #:attribs
                                  (format "style=\"height: ~arem\"" height))
                                o))]
                           [(string=? directive "duration")
                            (let ([txt (read-group i directive)])
                              (display (string-append
                                         (create-begin-tag "span" ".duration")
                                         txt
                                         (create-end-tag "span")) o))]
                           [(string=? directive "vocab")
                            (let* ([arg (read-group i directive)]
                                   [s (assoc-glossary arg)])
                              (when (string=? arg "")
                                (printf "WARNING: Directive @vocab has ill-formed argument\n\n"))
                              (display (enclose-span ".vocab" arg) o)
                              (cond [s (unless (member s *glossary-items*)
                                         (set! *glossary-items* (cons s *glossary-items*)))]
                                    [else
                                      (unless (member arg *missing-glossary-items*)
                                        (set! *missing-glossary-items* (cons arg *missing-glossary-items*)))
                                      (printf "WARNING: Item ~s not found in glossary\n\n"
                                              arg)]))]
                           [(string=? directive "lesson-prereqs")
                            (add-lesson-prereqs (read-commaed-group i directive read-group))]
                           [(string=? directive "keywords")
                            (add-lesson-keywords (read-commaed-group i directive read-group))]
                           [(string=? directive "proglang")
                            (fprintf o "~a" (nicer-case *proglang*))]
                           [(string=? directive "year")
                            (fprintf o "~a" (getenv "YEAR"))]
                           [(string=? directive "season")
                            (fprintf o "~a" (string-titlecase (getenv "SEMESTER")))]
                           [(string=? directive "empty")
                            (read-group i directive)]
                           [(string=? directive "n")
                            (fprintf o "{empty}[.autonum]##~a##" *autonumber-index*)
                            (set! *autonumber-index* (+ *autonumber-index* 1))]
                           [(string=? directive "nfrom")
                            (let* ([arg (read-group i directive)]
                                   [n (string->number arg)])
                              (unless n
                                (printf "WARNING: @nfrom given non-number ~s\n\n" arg))
                              (set! *autonumber-index* n))]
                           [(string=? directive "image")
                            (let ([args (read-commaed-group i directive read-group)])
                              (display (make-image (first args)
                                                   (if (>= (length args) 2) (second args) ""))
                                       o))]
                           [(string=? directive "centered-image")
                            (let ([args (read-commaed-group i directive read-group)])
                              (display (make-image (first args)
                                                       (if (>= (length args) 2)
                                                           (second args) "")
                                                        #:centered? #t)
                                       o))]
                           [(string=? directive "math")
                            (let ([text (string-trim (read-group i directive))])
                              (display (math->string text) o))]
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
                                   [link-text (string-join (map string-trim (rest args)) ", ")])
                              (set! link-text (string-trim link-text "\""))
                              (display (make-lesson-link page link-text) o))]
                           [(string=? directive "project-list")
                            (cond [*lesson-plan*
                                    (link-to-project-lessons-in-lesson-plan o)]
                                  [(or *narrative* *teacher-resources*)
                                    (link-to-project-lessons-in-pathway o)])]
                           [(or (string=? directive "printable-exercise")
                                (string=? directive "opt-printable-exercise")
                                (string=? directive "handout")
                                )
                            ;(printf "doing ~s\n" directive)
                            (let* ([args (read-commaed-group i directive read-group)]
                                   [n (length args)]
                                   [page (first args)]
                                   [link-text (if (> n 1) (string-join (rest args) "&#x2c; ") "")]
                                   [page-compts (regexp-split #rx"/" page)])
                              ;
                              (display (dispatch-make-workbook-link page-compts link-text directive) o)
                              )]
                           [(string=? directive "pathway-only")
                            (let ([text (read-group i directive)])
                              (display
                                (string-append
                                  (create-begin-tag "span" ".pathway-only")
                                  (expand-directives:string->string text #:enclosing-directive directive)
                                  (create-end-tag "span")) o))]
                           [(or (string=? directive "link")
                                (string=? directive "online-exercise")
                                (string=? directive "opt-online-exercise"))
                            (let* ([args (read-commaed-group i directive read-group)]
                                   [adocf (first args)]
                                   [link-text (string-join
                                                (map string-trim (rest args)) ", ")])
                              (set! link-text (string-trim link-text "\"")) ;XXX:
                              (display (make-link adocf link-text #:link-type directive) o))]
                           [(string=? directive "include")
                            (let* ([args (read-commaed-group i directive read-group)]
                                   [adocf (first args)] ;only one right? FIXME:
                                   [rest-args (string-join
                                                (map string-trim (rest args)) ",")]
                                   )
                              (display (make-link adocf rest-args #:include? #t) o))]
                           [(string=? directive "add-to-lang")
                            ; (printf "doing add-to-lang\n")
                            (unless *lesson-plan*
                              (error 'ERROR
                                     "WARNING: @add-to-lang (~a, ~a) valid only in lesson plan"
                                     *lesson-subdir* *in-file*))
                            (let ([args (map string->symbol (read-commaed-group i directive read-group))])
                              ;(printf "args = ~s\n" args)
                              (for-each add-prereq/check args))]
                           [(string=? directive "material-links")
                            (unless *lesson-plan*
                              (error 'ERROR
                                     "WARNING: @material-links (~a, ~a) valid only in lesson plan"
                                     *lesson-subdir* *in-file*))
                            (fprintf o "\n[#material-links]\n&nbsp;\n")
                            ; The line below can be deleted, once langTable links are generated via their own directive
                            #;(when (member *proglang* '("pyret" "wescheme"))
                              (fprintf o "* *Classroom visual:* link:javascript:showLangTable()[Language Table]"))
                            ]
                           [(string=? directive "opt-material-links")
                            (unless *lesson-plan*
                              (error 'ERROR
                                     "WARNING: @opt-material-links (~a, ~a) valid only in lesson plan"
                                     *lesson-subdir* *in-file*))
                            (set! *supplemental-materials-needed?* #t)
                            (fprintf o "\n[#opt-material-links]\n&nbsp;\n")]
                           [(string=? directive "language-table")
                            (let ([link-text (string-trim (read-group i directive))])
                              (unless *lesson-plan*
                                (error 'ERROR
                                       "WARNING: @language-table (~a, ~a) valid only in lesson plan"
                                       *lesson-subdir* *in-file*))
                              (when (member *proglang* '("pyret" "wescheme"))
                                (set! link-text (regexp-replace* #rx"," link-text "\\&#x2c;"))
                                (fprintf o "* *Classroom visual:* link:javascript:showLangTable()[~a]"
                                         link-text)))]
                           [(string=? directive "lesson-slides")
                            (display-lesson-slides o)]

                           [(or (string=? directive "lesson-description")
                                (string=? directive "description"))
                            (let* ([text (read-group i directive #:multiline? #t)]
                                   [converted-text (expand-directives:string->string text #:enclosing-directive directive)])
                              (display-lesson-description converted-text
                                                          (path-replace-extension *out-file* "-desc.txt.kp")
                                                          o))]

                           [(string=? directive "pathway-logo")
                            (unless *narrative*
                              (error 'ERROR
                                     "adoc-preproc: @pathway-logo valid only in pathway narrative"))
                            (print-pathway-logo *target-pathway* make-image o)]
                           [(string=? directive "pathway-lessons")
                            (unless *narrative*
                              (error 'ERROR
                                     "adoc-preproc: @pathway-lessons valid only in pathway narrative"))
                            (link-to-lessons-in-pathway o)]
                           [(string=? directive "workbooks")
                            (unless *narrative*
                              (error 'ERROR
                                     "adoc-preproc: @workbooks valid only in pathway narrative"))
                            (check-link (build-path *containing-directory* "workbook" "workbook.pdf"))
                            (check-link (build-path *containing-directory* "workbook" "workbook-long.pdf"))
                            (print-workbook-info *target-pathway* o)]
                           [(string=? directive "other-resources")
                            (unless *narrative*
                              (error 'ERROR
                                     "adoc-preproc: @other-resources valid only in pathway narrative"))
                            (print-other-resources-intro o)
                            (print-other-resources *target-pathway* *proglang* o)]
                           [(string=? directive "starter-file-list")
                            (display
                              (enclose-div ".starterFileList" "") o)
                            (newline o)]
                           [(string=? directive "all-exercises")
                            ; (printf "doing all-exercises ~a\n" (errmessage-context))
                            (unless *teacher-resources*
                              (error 'ERROR
                                     "adoc-preproc: @all-exercises valid only in teacher resources"))
                            (fprintf o "\n[#exercises_and_solutions]\n&nbsp;\n")]
                           [(string=? directive "all-projects")
                            ; (printf "doing all-projects ~a\n" (errmessage-context))
                            (unless *teacher-resources*
                              (error 'ERROR
                                     "adoc-preproc: @all-projects valid only in teacher resources"))
                            (link-to-opt-projects o)]
                           [(string=? directive "lesson-info")
                            (unless *teacher-resources*
                              (error 'ERROR
                                     "adoc-predoc: @lesson-info valid only in teacher resources"))
                            (display (enclose-tag "div" "" "" #:attribs "id=\"lesson-info-table\"") o)
                            (newline o)]
                           [(string=? directive "solutions-workbook")
                            ;TODO: don't need this anymore -- link is autogen'd
                            (unless *teacher-resources*
                              (error 'ERROR
                                     "adoc-preproc: @solutions-workbook valid only in teacher resources"))
                            (fprintf o "link:./protected/workbook-sols.pdf[Workbook (w/Solutions)]")
                            ]
                           [(string=? directive "do")
                            (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                              (for-each massage-arg-def exprs))]
                           [(string=? directive "show")
                            (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                              (for ([s exprs])
                                (display (massage-arg s) o)))]
                           [(string=? directive "showsoln")
                            (let ([exprs (read-group i directive #:scheme? #t)])
                              (when *solutions-mode?*
                                (for ([s (string-to-form exprs)])
                                  (display (enclose-span ".solution" (format "~a" (massage-arg s))) o))))]
                           [(string=? directive "smath")
                            (set! *uses-mathjax?* #t)
                            ; (create-zero-file (format "~a.uses-mathjax" *out-file*))
                            (let ([exprs (string-to-form (format "(math '~a)"
                                                                 (read-group i directive #:scheme? #t)))])
                              (for ([s exprs])
                                (display (massage-arg s) o)))]
                           [(string=? directive "clear")
                            (read-group i directive)
                            (newline o)
                            (display (enclose-span ".clear" " ") o)]
                           [(string=? directive "vspace")
                            (let ([height (read-group i directive)])
                              (display
                                (create-vspace height)
                                 o))]
                           [(string=? directive "hspace")
                            (let ([width (read-group i directive)])
                              (display
                                (string-append
                                  (create-begin-tag "span" ".quad" #:attribs
                                                    (format "style=\"width: ~a\"" width))
                                  (create-end-tag "span")) o))]
                           [(string=? directive "fitb")
                            (let ([width (read-group i directive)])
                              (unless (char=? (ignorespaces-peek-char i) #\{)
                                (printf "WARNING: ~a: @fitb{~a} requires second arg\n\n"
                                       (errmessage-context) width))
                              (if (string=? width "")
                                (display-begin-span
                                  ".fitb.stretch" o)
                                (display-begin-span
                                  ".fitb" o #:attribs (format "style=\"width: ~a\"" width))))]
                           [(string=? directive "fitbruby")
                            ;FIXME: text should be processed, see fitb above
                            (let* ([width (read-group i directive)]
                                   [text (read-group i directive)]
                                   [ruby (read-group i directive)])
                              (display
                                (string-append
                                  (if (string=? width "")
                                      (create-begin-tag "span" ".fitbruby.stretch")
                                      (create-begin-tag "span" ".fitbruby" #:attribs
                                                        (format "style=\"width: ~a\"" width)))
                                  (string-append
                                    (expand-directives:string->string text #:enclosing-directive directive)
                                    (create-begin-tag "span" ".ruby")
                                    (expand-directives:string->string ruby #:enclosing-directive directive)
                                    (create-end-tag "span"))
                                  (create-end-tag "span")) o))]
                           [(string=? directive "teacher")
                            (let* ([text (read-group i directive #:multiline? #t)]
                                   [contains-blocks? (or (regexp-match "\n[-*] " text)
                                                         (regexp-match "\n[0-9]+\\. " text))]
                                   [contains-nl? (regexp-match "\n *\n" text)]
                                   [converted-text (expand-directives:string->string text #:enclosing-directive directive)])
                              (set! contains-blocks? #t) ; assume always block for now
                              (display
                                (cond [(or contains-blocks? contains-nl?)
                                        (string-append "\n\n[.teacherNote]\n--\n"
                                          converted-text
                                          "\n--\n\n")]
                                      [else (enclose-span
                                             ".teacherNote" converted-text)]) o))]
                           [(string=? directive "indented")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (display-openblock ".indentedpara" text directive o))]
                           [(string=? directive "ifproglang")
                            (let* ([proglang (read-group i directive)]
                                   [text (read-group i directive #:multiline? #t)])
                              (cond [(string-ci=? proglang *proglang*)
                                     (expand-directives:string->port text o #:enclosing-directive #f)]
                                    [else (set! possible-beginning-of-line?
                                            (skip-1-newline-if-possible i o))]))]

                           [(string=? directive "ifsoln")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (cond [*solutions-mode?*
                                      (let* ([contains-nl? (regexp-match "^ *\n" text)]
                                             [converted-text (expand-directives:string->string text #:enclosing-directive directive)])
                                        (display
                                          (cond [contains-nl?
                                                  (string-append
                                                    "\n\n[.solution]\n"
                                                    "--"
                                                    converted-text
                                                    "\n--\n\n")]
                                                [else (enclose-span ".solution" converted-text)])
                                          o))]
                                    [else (set! possible-beginning-of-line?
                                            (skip-1-newline-if-possible i o))]))]

                           [(string=? directive "ifsoln-choice")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (let* ([contains-nl? (regexp-match "^ *\n" text)]
                                     [converted-text (expand-directives:string->string text #:enclosing-directive directive)])
                                (display (enclose-span
                                           (string-append ".choice"
                                             (if *solutions-mode?* ".chosen" ""))
                                           converted-text)
                                         o)))]

                           [(string=? directive "ifnotsoln")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (cond [(not *solutions-mode?*)
                                     (let* ([contains-nl? (regexp-match "^ *\n" text)]
                                            [converted-text (expand-directives:string->string text #:enclosing-directive directive)])
                                       (display
                                         (cond [contains-nl?
                                                 (string-append
                                                   "\n\n[.notsolution]\n"
                                                   "--"
                                                   converted-text
                                                   "\n--\n\n")]
                                               [else (enclose-span ".notsolution" converted-text)])
                                         o))]
                                    [else (set! possible-beginning-of-line?
                                            (skip-1-newline-if-possible i o))]))]
                           [(or (string=? directive "ifpathway")
                                (string=? directive "ifnotpathway"))
                            (let ([pathways (read-commaed-group i directive read-group)]
                                  [pfx (if (string=? directive "ifpathway") ".pathway-"
                                           ".notpathway-")])
                              (display-begin-span
                                (apply string-append
                                  (map (lambda (p) (string-append pfx (string-trim p)))
                                       pathways)) o))]
                           [(string=? directive "funname")
                            (fprintf o "`~a`" (get-function-name))]
                           [(string=? directive "slidebreak")
                            (display (enclose-span ".slidebreak" "") o)
                            (let ([c (peek-char i)])
                              (when (and (char? c) (char=? c #\{))
                                (read-group i directive)))]
                           [(string=? directive "Bootstrap")
                            (fprintf o "https://www.bootstrapworld.org/[Bootstrap]")]
                           [(hash-ref *simple-directives* (string->symbol directive) #f)
                            => (lambda (s)
                                 (when (string=? directive "lesson-intro-table")
                                   (set! *needs-objectives?* #t))
                                 (display s o))]
                           [(member directive '("assess-design-recipe" "design-recipe-exercise" "design-codap-recipe" "data-cycle"))
                            (let ([f (cond [(string=? directive "assess-design-recipe") assess-design-recipe]
                                           [(string=? directive "design-recipe-exercise") design-recipe-exercise]
                                           [(string=? directive "design-codap-recipe") design-codap-recipe]
                                           [(string=? directive "data-cycle") data-cycle]
                                           [else (error 'ERROR "preproc-adoc-file: deadc0de")])])
                              (let ([g (read-group i directive)])
                                (let ([args (string-to-form g)])
                                  (set! args (append args
                                                     (list '#:proglang *proglang*
                                                           '#:dist-root-dir *dist-root-dir*
                                                           '#:solutions-mode? *solutions-mode?*
                                                           '#:store-title store-title)))
                                  (let-values ([(key-list key-vals args)
                                                (rearrange-args args)])
                                    (let ([s (keyword-apply f key-list key-vals args)])
                                      (expand-directives:string->port s o #:enclosing-directive directive)
                                      )))))]
                           [(string=? directive "opt")
                            (let ([text (read-group i directive #:multiline? #t)]
                                  [old-optional-flag? *optional-flag?*])
                              (set! *optional-flag?* #t)
                              (display
                                (enclose-span ".optionaltag"
                                  (expand-directives:string->string
                                    text #:enclosing-directive directive)) o)
                              ;(display "\n" o)
                              (set! *optional-flag?* old-optional-flag?))]
                           [(string=? directive "opt-block")
                            (let ([text (read-group i directive #:multiline? #t)]
                                  [old-optional-flag? *optional-flag?*])
                              (set! *optional-flag?* #t)
                              (display-openblock ".optpara" text  directive o)
                              (set! *optional-flag?* old-optional-flag?))]
                          [(or (string=? directive "starter-file")
                                (string=? directive "opt-starter-file"))
                            (let* ([lbl+text (read-commaed-group i directive read-group)]
                                   [lbl (string->symbol (first lbl+text))]
                                   [c (hash-ref *starter-files* lbl #f)])
                              (cond [(not c)
                                     (printf "WARNING: ~a: Ill-named @~a ~a\n\n"
                                             (errmessage-context) directive lbl)]
                                    [else
                                      (let* ([link-text (and (>= (length lbl+text) 2)
                                                             (string-join (rest lbl+text) "&#x2c; "))]
                                             ; [opt? (or (string=? directive "opt-starter-file") *optional-flag?*)]
                                             [opt? (string=? directive "opt-starter-file")]
                                             [p (hash-ref c *proglang-sym* #f)])
                                        (cond [(not p)
                                               (unless *possibly-invalid-page?*
                                               (printf "WARNING: ~a: @~a ~a missing for ~a\n\n"
                                                       (errmessage-context) directive lbl *proglang*))]
                                              [else
                                                (let* ([newly-added? (add-starter-file lbl #:opt? opt?)]
                                                       [starter-file-title
                                                         (regexp-replace* #rx","
                                                           (or (and p (hash-ref p 'title #f))
                                                               (hash-ref c 'title)
                                                               "missing-starter-file-title")
                                                           "\\&#x2c;")]
                                                       [title (or link-text
                                                                  starter-file-title)]
                                                       [url (let ([url (hash-ref p 'url "")])
                                                              (cond [(string=? url "")
                                                                     (printf "WARNING: ~a: @~a ~a missing URL\n\n"
                                                                             (errmessage-context) directive lbl)
                                                                     "starter-file-missing-URL.html"]
                                                                    [else url]))]
                                                       [link-output
                                                         (format
                                                           "link:pass:[~a][~a~a]"
                                                           url
                                                           title
                                                           ", window=\"&#x5f;blank\""
                                                           )])
                                                  (when (and newly-added?
                                                             (hash-ref c 'autoinclude #t))
                                                    (let* ([materials-link-output
                                                             (format
                                                               "link:pass:[~a][~a~a]"
                                                               url
                                                               starter-file-title
                                                               ", window=\"&#x5f;blank\""
                                                               )]
                                                           [styled-link-output
                                                             (format "[StarterFile~a]##~a##"
                                                                     (if opt? " Optional" "")
                                                                     materials-link-output)])
                                                      (cond [opt?
                                                              (unless (member
                                                                        styled-link-output
                                                                        *opt-starter-file-links*)
                                                                (set! *opt-starter-file-links*
                                                                  (cons styled-link-output
                                                                        *opt-starter-file-links*)))]
                                                            [else
                                                              (unless (member styled-link-output
                                                                              *starter-file-links*)
                                                                (set! *starter-file-links*
                                                                  (cons styled-link-output
                                                                        *starter-file-links*)))])))
                                                  (display link-output o))]))]))]
                          [(string=? directive "assessments")
                           (fprintf o "\ninclude::~a/{cachedir}.index-assessments.asc[]\n" *containing-directory*)]
                          [(string=? directive "assessment")
                           (let* ([lbl (string->symbol (read-group i directive))]
                                  [c (hash-ref *assessments* lbl #f)]
                                  [title (and c (hash-ref c 'title #f))]
                                  [url (and c (hash-ref c 'url #f))]
                                  [pl-specific (and c (hash-ref c *proglang-sym* #f))])
                             (when pl-specific
                               (let ([x (hash-ref pl-specific 'title #f)])
                                 (when x (set! title x)))
                               (let ([x (hash-ref pl-specific 'url #f)])
                                 (when x (set! url x))))
                             (unless title (set! title url))
                             (cond [(not c)
                                    (printf "WARNING: ~a: Ill-named @~a ~a\n\n" (errmessage-context) directive lbl)]
                                   [(not url)
                                    (printf "WARNING: ~a: @~a ~a missing for ~a\n\n"
                                            (errmessage-context) directive
                                            lbl *proglang*)]
                                   [else
                                     (unless (assoc url *assessments-met*)
                                       (set! *assessments-met*
                                         (cons (cons url title)
                                               *assessments-met*)))
                                     (fprintf o "link:pass:[~a][~a]" url title)]))]
                          [(string=? directive "citation")
                           (let* ([args (read-commaed-group i directive read-group)]
                                  [args-len (length args)]
                                  [lbl (string->symbol (first args))]
                                  [c (hash-ref *citations* lbl #f)]
                                  [in-text (and c (hash-ref c 'in-text #f))]
                                  [link (string-append "link:" (hash-ref c 'public-url) "[" in-text "]")]
                                  [apa (and c (hash-ref c 'apa #f))])
                             (cond [(> (length args) 1)
                                    (set! in-text
                                      (expand-directives:string->string
                                        (second args)))]
                                   [in-text
                                     (set! in-text
                                       (expand-directives:string->string in-text))]
                                   [else lbl])
                             (unless apa (set! apa lbl))
                             (cond [(not c)
                                    (printf "WARNING: ~a: Undefined @~a ~a\n\n"
                                            (errmessage-context) directive lbl)]
                                   [(not in-text)
                                    (printf "WARNING: ~a: @~a ~a missing\n\n"
                                            (errmessage-context) directive lbl)]
                                   [else (display
                                           (enclose-span ".citation"
                                            (string-append link (enclose-span ".apa-citation" apa)))
                                           o)]))]
                          [(string=? directive "objectives")
                           (set! *uses-objectives?* #t)
                           (fprintf o "\ninclude::~a/{cachedir}.index-objectives.asc[]\n" *containing-directory*)]
                          [(string=? directive "objective")
                           (let ([lbl (string->symbol (read-group i directive))])
                             (unless (member lbl *objectives-met*)
                               (set! *objectives-met*
                                 (cons lbl *objectives-met*))))]
                           [(string=? directive "opt-project")
                            (let* ([arg1 (read-commaed-group i directive read-group)]
                                   [project-file (first arg1)]
                                   [rubric-file (if (> (length arg1) 1) (second arg1) "")]
                                   [project-file-compts (regexp-split #rx"/" project-file)]
                                   [rubric-file-compts (regexp-split #rx"/" rubric-file)]
                                   [rubric-link-output
                                     (cond [(string=? rubric-file "")
                                            (printf "WARNING: ~a: rubric file empty for @~a{~a}\n\n"
                                                    (errmessage-context) directive project-file)
                                            ""]
                                           [else
                                             (dispatch-make-workbook-link
                                               rubric-file-compts "rubric" "rubric-file")])]
                                   [project-link-output (dispatch-make-workbook-link
                                                          project-file-compts #f directive)])
                              (unless (assoc project-link-output *opt-project-links*)
                                (set! *opt-project-links*
                                  (cons (list project-link-output rubric-link-output) *opt-project-links*)))
                              (display (enclose-span ".prefix" "Optional Project: ") o)
                              (display project-link-output o)
                              (display " __{startsb}" o)
                              (display rubric-link-output o)
                              (display "{endsb}__" o))]
                           [(string=? directive "QandA")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (display-openblock
                                (format ".q-and-a~a"
                                        (if *optional-flag?* ".Optional" ""))
                                text directive o))]
                           [(string=? directive "Q")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (display "\n* " o)
                              (expand-directives:string->port text o #:enclosing-directive directive))]
                           [(string=? directive "A")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (display "\n** " o)
                              (expand-directives:string->port text o #:enclosing-directive directive))]
                           [(member directive '("strategy" "strategy-basic"))
                            (let* ([title (read-group i directive)]
                                   [text (read-group i directive #:multiline? #t)])
                              (display "\n[.strategy-box]\n--\n" o)
                              (display "[.title]\n" o)
                              (expand-directives:string->port title o #:enclosing-directive directive)
                              (display "\n\n" o)
                              (expand-directives:string->port text o #:enclosing-directive directive)
                              (display "\n--\n" o))]
                           [(string=? directive "lesson-point")
                            (let ([text (read-group i directive #:multiline? #t)])
                              ; caution: correlations*/index.adoc
                              ; (display-openblock ".lesson-point" text directive o)
                              (display "\n[.lesson-point]\n--\n" o)
                              (expand-directives:string->port text o #:enclosing-directive directive)
                              (display "\n--\n" o)
                              )]
                           [(string=? directive "lesson-instruction")
                            (let ([text (read-group i directive #:multiline? #t)])
                              (display-openblock ".lesson-instruction" text directive o))]
                           [(string=? directive "lesson-roleplay")
                            (let ([text (read-group i directive #:multiline? #t)])
                              ; caution: filtering-and-buidling/index.adoc
                              ; (display-openblock ".lesson-roleplay" text directive o)
                              (display "\n[lesson-roleplay]\n--\n" o)
                              (expand-directives:string->port text o #:enclosing-directive directive)
                              (display "\n--\n" o)
                              )
                            ]
                           [(assoc directive *definitions*)
                            => (lambda (c)
                                 (expand-directives:string->port (cdr c) o #:enclosing-directive directive))]
                           [else
                             ; (printf "WARNING: Unrecognized directive @~a\n\n" directive)
                             (display c o) (display directive o)
                             #f]))]
                  [(and possible-beginning-of-line? (member c '(#\| #\! #\-)))
                   (set! beginning-of-line? #f) ;FIXME check if needed
                   (set! possible-beginning-of-line? #f)
                   (newline o)
                   (display c o)]
                  [(and beginning-of-line? (char=? c #\+))
                   (let ([n (process-as-many-pluses-as-possible i o)])
                     (when (>= n 4)
                       (process-passthrough-lines i o)))]
                  [(and beginning-of-line? (char=? c #\=))
                   ; (set! beginning-of-line? #f)
                   ; (set! possible-beginning-of-line? #f)
                   (when (span-stack-present?)
                     (printf "WARNING: ~a: Header can't be inside span\n\n"
                             (errmessage-context)))
                   (cond [*title-reached?*
                           (cond [*first-subsection-reached?* #f]
                                 [(check-first-subsection i o)
                                  (set! *first-subsection-reached?* #t)]
                                 [else #f])
                           (cond [*lesson*
                                   (display-section-markup i o)]
                                 [else (display c o)])]
                         [else
                           (set! *title-reached?* #t)
                           (display-title i o)
                           (display-alternative-proglang o)
                           (when *teacher-resources*
                             ; (printf "teacher resource autoloading stuff\n")
                             (fprintf o "\nlink:../index.shtml[Click here to return to lessons]\n\n")
                             ; (link-to-opt-projects o)
                             ; (link-to-notes-pages o)
                             ;(display-exercise-collation o)
                             )])]
                  [(char=? c #\newline)
                   (newline o)
                   (set! beginning-of-line? #t)
                   (set! possible-beginning-of-line? #f)]
                  [(and (char=? c #\`) (not *uses-codemirror?*))
                   (let ([backticked-text (read-backticked-text i)])
                     (when (or (string=? backticked-text "``")
                               (regexp-match " " backticked-text))
                       (set! *uses-codemirror?* #t))
                     (display backticked-text o))]
                  [else
                    (set! beginning-of-line? #f)
                    (set! possible-beginning-of-line? #f)
                    (cond [(and (span-stack-present?) (or (char=? c #\{) (char=? c #\})))
                           (cond [(char=? c #\{)
                                  (unless (= (top-span-stack) 0)
                                    (display c o))
                                  (increment-top-span-stack)]
                                 [(char=? c #\})
                                  (decrement-top-span-stack)
                                  (cond [(= (top-span-stack) 0)
                                         (display-end-span o)]
                                        [else (display c o)])]
                                 [else (error 'ERROR "preproc-adoc-file: deadc0de")])]
                          [else (display c o)])])
                (loop))))))

(define (expand-directives:string->string s #:enclosing-directive [enclosing-directive #t])
  (call-with-output-string
    (lambda (o)
      (expand-directives:string->port s o #:enclosing-directive enclosing-directive))))

(define (expand-directives:string->port s o #:enclosing-directive [enclosing-directive #t])
  (call-with-input-string s
    (lambda (i)
      (let ([old-enclosing-directive *enclosing-directive*])
        (set! *enclosing-directive* enclosing-directive)
        (expand-directives i o)
        (set! *enclosing-directive* old-enclosing-directive)))))

(define (preproc-adoc-file in-file
                           #:all-pathway-lessons [all-pathway-lessons #f]
                           #:containing-directory [containing-directory ""]
                           #:dist-root-dir [dist-root-dir ""]
                           #:lesson [lesson #f]
                           #:lesson-plan [lesson-plan #f]
                           #:narrative [narrative #f]
                           #:other-dir [other-dir #f]
                           #:resources [resources #f]
                           #:target-pathway [target-pathway #f]
                           #:proglang [proglang "pyret"]
                           #:other-proglangs [other-proglangs #f]
                           #:solutions-mode? [solutions-mode? #f]
                           )
  ; (printf "doing preproc-adoc-file ~s cd=~s\n" in-file containing-directory)

  (set! *containing-directory* containing-directory)
  (set! *dist-root-dir* dist-root-dir)
  (set! *lesson* lesson)
  (set! *lesson-plan* lesson-plan)
  (set! *narrative* narrative)
  (set! *other-dir* other-dir)
  (set! *proglang* proglang)
  (set! *other-proglangs* other-proglangs)
  (set! *solutions-mode?* solutions-mode?)
  (set! *target-pathway* target-pathway)
  (set! *teacher-resources* resources)

  (init-flags in-file)

  ;(printf "doing preproc-adoc-file ~s; lesson-plan= ~s; lesson-plan-base= ~s\n\n" in-file *lesson-plan* *lesson-plan-base*)

  (with-handlers ([exn:fail? (lambda (e)
                               (printf "~a in ~a\n\n"
                                       (exn-message e) (errmessage-file-context)))])
    (set! *in-file* (build-path containing-directory in-file))
    ; (printf "doing preproc-adoc-file ~a\n" *in-file*)

      (set! *first-subsection-reached?* #f)
      (set! *title-reached?* #f)
      (set! *supplemental-materials-needed?* #f)
      (set! *uses-codemirror?* #f)
      (set! *uses-mathjax?* #f)
      (set! *needs-objectives?* #f)
      (set! *uses-objectives?* #f)
      ; (printf "preproc ~a to ~a\n" *in-file* *out-file*)
      ;
      (let ([internal-links-file (path-replace-extension *out-file* ".internal-links.txt.kp")]
            [external-links-file (path-replace-extension *out-file* ".external-links.txt.kp")])
        ;(printf "*ternal links ports set up ~a, ~a\n" internal-links-file external-links-file)
        (set! *internal-links-port* (open-output-file internal-links-file #:exists 'replace))
        (set! *external-links-port* (open-output-file external-links-file #:exists 'replace)))
      ;
      (when (or *lesson-plan*
                *narrative*
                *teacher-resources*)
        (print-menubar (build-path *containing-directory* ".cached" ".index-comment.txt")))
      ;

      ;
      (call-with-input-file *in-file*
        (lambda (i)
          (call-with-output-file *out-file*
            (lambda (o)

              (cond [*lesson-plan* (display "[.LessonPlan]\n" o)]
                    [*narrative* (display "[.narrative]\n" o)]
                    [*solutions-mode?* (display "[.solution-page]\n" o)]
                    )
              (fprintf o "ifndef::fromlangroot[:fromlangroot: ~a]\n\n" *dist-root-dir*)

              (expand-directives i o)

              (when (and *narrative* (not *title-reached?*))
                (print-course-title-and-logo *target-pathway* make-image store-title o)
                (display-alternative-proglang o)
                (print-course-banner *target-pathway* o)
                (link-to-lessons-in-pathway o)
                (check-link (build-path *containing-directory* "workbook" "workbook.pdf"))
                (check-link (build-path *containing-directory* "workbook" "workbook-long.pdf"))
                (print-workbook-info *target-pathway* o)
                (print-other-resources-intro o)
                (print-other-resources *target-pathway* *proglang* o))

              (unless *other-dir*
                (fprintf o "\n\n"))

              (unless (or *other-dir* (truthy-getenv "NOCOLOPHON"))
                ;(fprintf o "\n\n")
                (fprintf o "[.acknowledgmentsect]\n")
                (fprintf o "== BOGUSACKNOWLEDGMENTSECTIONHEADER\n")
                (fprintf o "[.acknowledgment]\n")
                (fprintf o "--\n")
                (fprintf o (hash-ref *common-text* 'acknowledgment))
                (fprintf o "link:https://www.creativecommons.org/licenses/by-nc-nd/4.0/[image:~alib/images/CCbadge.png[], window=\"&#x5f;blank\"]\n" *dist-root-dir*)
                (fprintf o "~a " *copyright-name*)
                (fprintf o (hash-ref *common-text* 'copyright))
                (fprintf o "\n--\n")
                )

              (when *lesson-plan*
                (store-assessments)
                (store-objectives)

                (fprintf o "include::~a/{cachedir}.index-sidebar.asc[]\n\n" *containing-directory*)
                (call-with-output-file (build-path *containing-directory* ".cached" ".index-sidebar.asc")
                  (lambda (o)
                    (display
                      (enclose-openblock
                        ".sidebar"
                        (lambda ()
                          (call-with-output-string
                            (lambda (o)
                            (display-prereqs-bar o)
                            (display-standards-bar o)
                            (display "%ENDSIDEBARCONTENT%" o))))) o))
                  #:exists 'replace)

                )

              )

            #:exists 'replace)))
      ;

      (when *lesson-plan*
        (add-exercises))

      (when (or *lesson-plan* *narrative*)
        ;no longer possible to append to pathway's file, as there
        ;is no pathway at this stage
        ;(add-exercises)
        (create-glossary-subfile (string-append *containing-directory* "/.cached/."
                                   (if *lesson-plan* "index" "pathway")
                                   "-glossary"
                                   )))

      (when (pair? *prereqs-used*)
        ; (printf "lessonplan?= ~s; lesson?= ~s\n\n" *lesson-plan* *lesson*)
        (let ([prim-file (if *lesson-plan*
                             (build-path *containing-directory* ".cached" ".index.primtxt")
                             (if *lesson*
                                 (make-temporary-file ".pageprim-~a.primtxt" #f
                                                      (format "distribution/~a/lessons/~a/.cached"
                                                              *natlang*
                                                              *lesson*)
                                                      )
                                 #f))])
          (when prim-file
            ; (printf "writing prereqs-used to ~s\n\n" prim-file)
            (store-functions-used *prereqs-used* prim-file))))

      ; (printf "nulling out prereqs-used\n\n")
      (set! *prereqs-used* '())

      (when *lesson-plan*

        (call-with-output-file (path-replace-extension *out-file* "-extra-mat.asc")
          (lambda (o)
            ; REQUIRED PRINTABLE PAGES
            #;(unless (and (empty? *handout-exercise-links*) (empty? *printable-exercise-links*))
              (fprintf o "\n* link:javascript:downloadLessonPDFs(false)[PDF of all Handouts and Pages]")
              (fprintf o " [.showPageLinks]#link:javascript:showPageLinks(false)[ ]#")
              (for ([x (reverse *handout-exercise-links*)])
                (fprintf o "\n** ~a\n\n" x))
              (let ([xx (sort *printable-exercise-links*
                              (lambda (x y)
                                (let ([x-i (index-of *workbook-pages* (first x))]
                                      [y-i (index-of *workbook-pages* (first y))])
                                  (unless x-i (set! x-i -1))
                                  (unless y-i (set! y-i -1))
                                  (cond [(and (= x-i -1) (= y-i -1)) #t]
                                        [else (< x-i y-i)]))))])

                (for ([x xx])
                  (fprintf o "\n** ~a\n\n" (second x)))
                )
              )
            ; STARTER FILES
            (for ([x (reverse *starter-file-links*)])
              (fprintf o "\n* ~a\n\n" x))
            ; ONLINE EXERCISES --- to be removed onces all required online exercises
            ; have been turned into starter files
            #;(for ([x (map cdr (reverse *online-exercise-links*))])
              (fprintf o "\n* ~a\n\n" x))
            ; SLIDES
            (display-lesson-slides o)
            ; GLOSSARY REFERENCE
            (unless (empty? *glossary-items*)
              (fprintf o "\n* link:~aGlossary.shtml?lesson=~a[Lesson Glossary]\n" *dist-root-dir* *lesson*))
            ; LESSON PLAN
            (when (or (string=? *proglang* "pyret") (string=? *proglang* "wescheme"))
              (fprintf o "\n* link:index.pdf[Printable Lesson Plan] (a PDF of this web page)\n"))
            ; STATUS BAR FOR PRINTING PDFS
            (fprintf o "\n\n+++<span id=\"status\" style=\"display:none;\"><label for=\"file\">Assembling Pages:</label><progress id=\"file\"></progress></span>+++")

            )
          #:exists 'replace)

        (call-with-output-file (path-replace-extension *out-file* "-extra-opt-mat.asc")
          (lambda (o)

            ; OPTIONAL PRINTED PAGES
            (unless (empty? *opt-printable-exercise-links*)
              (fprintf o "\n* link:javascript:downloadLessonPDFs(true)[Additional Printable Pages for Scaffolding and Practice]\n")
              (fprintf o " [.showPageLinks]#link:javascript:showPageLinks(true)[ ]#")
              (for ([x (reverse *opt-printable-exercise-links*)])
                (fprintf o "\n** ~a\n\n" x))
            )
            ; OPTIONAL STARTER FILES
            (for ([x (reverse *opt-starter-file-links*)])
              (fprintf o "\n* ~a\n\n" x))
            ; OPTIONAL PROJECTS
            (let ([opt-proj-links (reverse *opt-project-links*)])
              (call-with-output-file (path-replace-extension *out-file* "-opt-proj.rkt.kp")
                (lambda (o)
                  (for ([link-pair opt-proj-links])
                    (write link-pair o)
                    (newline o)))
                #:exists 'replace)
            (for ([x opt-proj-links])
              (fprintf o "\n* [.OptProject]##~a {startsb}~a{endsb}##\n\n" (first x) (second x))))
            ; OPTIONAL ONLINE EXERCISES
            (for ([x (map cdr (reverse *opt-online-exercise-links*))])
              (fprintf o "\n* ~a\n\n" x))
            ; CONTRACTS REFERENCE
            (fprintf o "\n* link:~aContracts.shtml[Contracts Reference]\n" *dist-root-dir* )
            ; NO OPTIONAL ANYTHING - display a helpful message
            (when (and *supplemental-materials-needed?*
                       (empty? *opt-printable-exercise-links*)
                       (empty? *opt-starter-file-links*)
                       (empty? *opt-online-exercise-links*))
              (printf "WARNING: ~a has no supplemental materials yet!\n" (errmessage-context))
              ; (fprintf o "_This lesson has no supplemental materials (yet!)_")
              )

            )
          #:exists 'replace)

        (call-with-output-file (build-path *containing-directory* ".cached" ".lesson-keywords.json")
          (lambda (o)
            (let ([first? #t])
              (display "[" o)
              (for ([k *lesson-keywords*])
                (cond [first? (set! first? #f)]
                      [else (display ",\n" o)])
                (fprintf o "  ~s" k))
              (display " ]\n" o)))
          #:exists 'replace)

        (call-with-output-file (build-path *containing-directory* ".cached" ".lesson-sections.txt.kp")
          (lambda (o)
            (for ([s (reverse *first-level-section-titles*)])
              (set! s (regexp-replace* #rx" *\\([0-9]* +minutes\\)" s ""))
              (write s o) (newline o)))
          #:exists 'replace)

        (when (pair? *project-lessons*)
          (let ([pl-file (build-path *containing-directory* ".cached" ".index-projectlessons.rkt.kp")]
                [project-lessons (reverse *project-lessons*)])

            (call-with-output-file pl-file
              (lambda (o)
                (display "(\n" o)
                (for ([pl project-lessons])
                  (fprintf o "~s\n" pl))
                (display ")\n" o)
                )
              #:exists 'replace)

            ))

        (when *needs-objectives?*
          (cond [(not *uses-objectives?*)
                 (printf "WARNING: ~a: Table missing @objectives\n\n" (errmessage-context))]
                [(null? *objectives-met*)
                 (printf "WARNING: ~a: No @objective provided\n\n" (errmessage-context))]
                [else #f]))

        (when (and (or (pair? *opt-starter-files-used*)
                       (pair? *opt-online-exercise-links*))
                   (not *supplemental-materials-needed?*))
          (printf "WARNING: ~a: @opt-material-links missing\n\n" (errmessage-context)))

        )

      (when (or *lesson-plan* *lesson*)
        (when (pair? *starter-files-used*)
          (let ([sf-file (if *lesson-plan*
                             (build-path *containing-directory* ".cached" ".index.starterfiles")
                             (format "distribution/~a/lessons/~a/.cached/.page.starterfiles"
                                     *natlang* *lesson*))])
            (call-with-output-file sf-file
              (lambda (o)
                (for ([sf (reverse *starter-files-used*)])
                  (display sf o) (newline o)))
              #:exists (if *lesson-plan* 'replace 'append))))

        (when (pair? *opt-starter-files-used*)
          (let ([sf-file (if *lesson-plan*
                             (build-path *containing-directory* ".cached" ".index.optstarterfiles")
                             (format "distribution/~a/lessons/~a/.cached/.page.optstarterfiles"
                                     *natlang* *lesson*))])
            (call-with-output-file sf-file
              (lambda (o)
                (for ([sf (reverse *opt-starter-files-used*)])
                  (unless (member sf *starter-files-used*)
                    (display sf o) (newline o))))
              #:exists (if *lesson-plan* 'replace 'append)))))

      (when *internal-links-port* (close-output-port *internal-links-port*))
      (when *external-links-port* (close-output-port *external-links-port*))

      (when *uses-codemirror?* (create-zero-file (format "~a.uses-codemirror" *out-file*)))
      (when *uses-mathjax?* (create-zero-file (format "~a.uses-mathjax" *out-file*)))

      (erase-local-scheme-definitions)
      )

  ;(printf "done preproc-adoc-file ~s\n\n" in-file)

  )

(define (display-openblock class text directive o)
  (display
    (enclose-openblock
      class
      (lambda ()
        (expand-directives:string->string
          text #:enclosing-directive directive)))
    o))

(define (display-lesson-slides o)
  (let ([id-file (build-path *containing-directory* (format "slides-~a.id" *proglang*))])
    (cond [(file-exists? id-file)
           (let* ([id (call-with-input-file id-file read-line)]
                  [pres-uri (format "https://docs.google.com/presentation/d/~a/" id)])
             (check-link pres-uri #:external? #t)
             (fprintf o "\n* link:pass:[~a][Lesson Slides, window=\"&#x5f;blank\"]\n\n" pres-uri))]
          [else
            #;(printf "WARNING: ~a: File ~a not found\n\n" (errmessage-context) id-file)
            #f])))

#;(define (display-exercise-collation o)
  ; (printf "doing display-exercise-collation\n" )
  ; (printf "pwrd = ~s\n" *pathway-root-dir*)
  ; (printf "cwd is ~s\n" (current-directory))
  (let* ([pathway-lesson-order
           (format "distribution/~a/courses/~a/.cached/.workbook-lessons.txt.kp"
                   *natlang* *target-pathway*)]
         [all-lessons (read-data-file pathway-lesson-order #:mode 'files)]
         ;fixme -- why following?
         ; [all-lessons (map (lambda (s) (regexp-replace "^\\.\\./\\.\\./" s "")) all-lessons)]
         [lessons-with-exx
           (filter (lambda (f)
                      (file-exists?
                        (format "distribution/~a/lessons/~a/.cached/.lesson-exercises.rkt.kp"
                                *natlang* f)))
                   all-lessons)]
         [exx (map (lambda (lsn)
                     (list lsn
                           (read-data-file
                             (format "distribution/~a/lessons/~a/.cached/.lesson-exercises.rkt.kp"
                                     *natlang* lsn)
                             #:mode 'forms)))
                   lessons-with-exx)])
    ; (printf "pathway-lesson-order is ~s (~s)\n" pathway-lesson-order (file-exists? pathway-lesson-order))
    ; (printf "lessons-with-exx is ~s\n" lessons-with-exx)
    ; (printf "exx is ~s\n" exx)
    ; (printf "lessons= ~s\n\nexercises= ~s\n" all-lessons exx)

    ; (link-to-opt-projects o)

    (unless (null? exx)
      (display "\n\n" o)
      (display (hash-ref *common-text* 'workbook-links) o)
      (display "\n\n" o)
      (display (create-vspace "1ex") o)
      (for ([lsn-exx exx])
        ; (printf "lsn-exx is ~s\n" lsn-exx)
        (let ([lsn (first lsn-exx)]
              [exx (second lsn-exx)])
          (fprintf o "\n\n**link:~alessons/~a/index.shtml[~a]**\n"
                   *dist-root-dir*
                   lsn
                   (call-with-input-file
                     (format "distribution/~a/lessons/~a/.cached/.index.titletxt"
                             *natlang* lsn)
                     port->string))
          (for ([ex exx])
            (let* ([ti (list-ref ex 1)]
                   [exer (list-ref ex 0)]
                   ; [exer (regexp-replace "\\.adoc" exer ".html")]
                   [soln (regexp-replace "/pages/" exer "/solution-pages/")])

              (when (string=? ti "")
                (let ([exer.titletxt
                        (build-path
                          (format "distribution/~a/lessons" *natlang*)
                          (path-replace-extension
                            (regexp-replace "/pages/" exer "\\0.cached/.")
                            ".titletxt"))])
                  (when (file-exists? exer.titletxt)
                    (set! ti (call-with-input-file exer.titletxt read-line)))))

              (fprintf o "\n- ~a [ link:~alessons/~a[exercise] : link:~alessons/~a[solution] ]\n"
                       ti *dist-root-dir* exer *dist-root-dir* soln)))
          ))
      )))

(define (add-exercises)
  ; (printf "doing add-exercises ~s\n" *exercises-done*)
  (when (cons? *exercises-done*)
    ; (printf "doing add-exercises I\n")
    (set! *exercises-done* (reverse *exercises-done*))
    (let ([lesson-exercises-file
            (build-path *containing-directory* ".cached" ".lesson-exercises.rkt.kp")])
      (call-with-output-file lesson-exercises-file
        (lambda (o)
          (for ([ex *exercises-done*])
            (fprintf o "~s\n" ex)))
        #:exists 'replace)
      )))

(define (create-glossary-subfile file)
  ; (printf "doing create-glossary-subfile ~s ~s\n" file *narrative*)
  ; (print-menubar (string-append file "-comment.txt"))
  (unless (empty? *glossary-items*)
    (set! *glossary-items*
      (sort *glossary-items* #:key first string-ci<=?))
    (call-with-output-file (string-append file ".json")
      (lambda (op)
        (display "[\n" op)
        (let ([first? #t])
          (for ([s *glossary-items*])
            (cond [first? (display "  " op) (set! first? #f)]
                  [else (display ",  " op)])
            (fprintf op "[~s, ~s]\n" (first s) (second s))))
        (display "]\n" op))
      #:exists 'replace))

  )

(define (store-assessments)
  (call-with-output-file
    (build-path *containing-directory* ".cached" ".index-assessments.asc")
    (lambda (o)
      (unless (null? *assessments-met*)
        (for ([asst (reverse *assessments-met*)])
          (fprintf o "- link:pass:[~a][~a]\n"
                   (car asst) (cdr asst)))))
    #:exists 'replace))

(define (store-objectives)
  (call-with-output-file
    (build-path *containing-directory* ".cached" ".index-objectives.asc")
    (lambda (o)
      (unless (null? *objectives-met*)
        (for ([lbl (reverse *objectives-met*)])
          (let* ([c (hash-ref *learning-objectives* lbl #f)]
                 [x #f])
            (when c (set! x (hash-ref c 'text #f)))
            (cond [(not c)
                   (set! x lbl)
                   (printf "WARNING: ~a: Undefined @objective ~a\n\n" (errmessage-context) lbl)]
                  [(not x)
                   (set! x lbl)
                   (printf "WARNING: ~a: Ill-defined @objective ~a\n\n" (errmessage-context) lbl)]
                  [else (set! x (expand-directives:string->string x))])
            (display "- " o)
            (display x o)
            (newline o)))))
    #:exists 'replace))

(define (display-standards-selection o *narrative*)
  ;(printf "doing display-standards-selection ~a\n" *narrative*)
  (let ([narrative? *narrative*])
    (when narrative? (fprintf o "= Standards\n\n"))
    (when narrative? (print-standards-js o))
    (when narrative? (display (create-begin-tag "div" ".standard-menu-container") o))
    (cond [narrative?
            (display
              (enclose-div ""
                (string-append
                  "\nBootstrap lessons align with several important teaching standards,\n"
                  "practices, and popular textbooks in multiple states. Make a \n"
                  "selection from the menu below to see the alignment of your choice.\n"))
              o)]
          [else #f ;(display ".Relevant Standards\n" o)
                ])
    (when narrative? (display (create-begin-tag "div" "") o))
    (display (enclose-tag "select" ".alignmentSelect"
               #:attribs
               " onchange=\"showAlignment(this.value)\""
               "") o)
    (newline o)
    (when narrative?
      (display (create-end-tag "div") o)
      (display (create-end-tag "div") o))
    ;(display "\n\n" o)
    ))

(define (sanitize-css-id id)
  (regexp-replace* "[. ]" id "_"))

(define (display-alignments-selection o)
  ; (printf "doing display-alignments-selection\n")
  (fprintf o "= Alignments\n\n")
  (print-coverage-js o)
  (display (create-begin-tag "div" ".standard-menu-container") o)
  (display (enclose-div ""
             (string-append
               "\nBootstrap lessons align with several important teaching standards, textbooks, and practices.\n"
               "Select from the following menu to see\n"
               "which lessons meet those alignments.\n")) o)
  (display (create-begin-tag "div" "") o)
  (display (enclose-tag "select" ".alignmentSelect"
             #:attribs
             "onchange=\"showAlignment(this.value)\""
             "") o)
  (newline o)
  (display (create-end-tag "div") o)
  (display (create-end-tag "div") o)
  )

;coe
(define (hspace n)
  (enclose-span ".hspace"
                (string-join (build-list n (lambda (i) "{nbsp}")) "")))

(define (intersperse-spaces args funargs?)
  (define (intersperse-spaces-aux args)
    (if (null? args) args
        (let ([a (first args)] [d (rest args)])
          (if (null? d) (list a)
              (cons a
                    (cons (hspace 1)
                          (intersperse-spaces-aux d)))))))
  (let ([ans (intersperse-spaces-aux args)])
    (apply string-append
           (if (and funargs? (not (null? args)))
               (cons (hspace 1) ans)
               ans))))

(define (coe e)
  ;(printf "coe ~s\n" e)
  ; (create-zero-file (format "~a.uses-codemirror" *out-file*))
  (set! *uses-codemirror?* #t)
  (enclose-div ".circleevalsexp"
    (sexp->block e #:pyret (string=? *proglang* "pyret"))))

(define *hole-symbol* '++_______++)
(define *hole2-symbol* '++____________________++)
(define *hole3-symbol* *hole2-symbol*)

(define *list-of-hole-symbols*
  (list *hole-symbol* *hole2-symbol* *hole3-symbol*))

(define (answer? e)
  (and (list? e) (memq (first e) '(?ANSWER ?ANS))))

(define (fitb? e)
  (and (list? e) (memq (first e) '(?FITB))))

(define *common-infix-ops*
 '(+ - * / and or < > = <= >= <> frac
     string=? string<? string<=? string>? string>=? string<>?))

(define *pyret-infix-ops*
  (append *common-infix-ops*))

(define *arith-infix-ops*
  (append *common-infix-ops* '(expt)))

(define (infix-op? e #:pyret [pyret #f])
  (cond [(not (list? e)) (memq e (if pyret *pyret-infix-ops* *arith-infix-ops*))]
        [(memq (first e) '(?ANSWER ?ANS))
         (let ([a (second e)])
           (memq a (if pyret *pyret-infix-ops* *arith-infix-ops*)))]
        [else #f]))

(define (answer->hole e)
  (let ([n (string-length (format "~a" e))])
    (cond [(< n 3) 'BSLeaveAHoleHere]
          [(< n 10) 'BSLeaveAHoleHere2]
          [else 'BSLeaveAHoleHere3])))

(define (answer-fill-length e)
  (let ([n (string-length (format "~a" e))])
    (cond [(< n 3) ".studentAnswerShort"]
          [(< n 10) ".studentAnswerMedium"]
          [else ".studentAnswerLong"])))

(define answer-block-fill-length answer-fill-length)

(define (infix-sexp->math a e #:wrap [wrap #t] #:encloser [encloser #f]
                          #:parens [parens #f] #:firstarg [firstarg #f])
  ; (printf "doing infix-sexp->math ~s ~s w:~s e:~s p:~s f:~s\n" a e wrap encloser parens firstarg)
  (let ([n (length e)])
    (if (and (eq? a 'frac) (= n 2))
        (format "{{~a} \\over {~a}}"
                (sexp->arith (list-ref e 0) #:parens parens #:tex #t)
                (sexp->arith (list-ref e 1) #:parens parens #:tex #t))
        (let* ([am (cond [(eq? a '*) "\\;\\times\\;"]
                         [(eq? a '/) "\\div"]
                         [(eq? a 'frac) "\\div"]
                         [(eq? a 'expt) "^"]
                         [else a])]
               [e1 (if (>= n 1) (first e) #f)]
               [rest-e (if (>= n 1) (rest e) '())]
               [arg1 (and e1
                         (sexp->arith e1 #:pyret #f #:wrap #t
                                      #:encloser a #:parens parens #:firstarg #t #:tex #t))]
               [args (map (lambda (e1) (sexp->arith e1 #:pyret #f #:wrap #t
                                                    #:encloser a #:parens parens #:tex #t)) rest-e)]
               [args (if e1 (cons arg1 args) args)]
               [x (string-join args (format " ~a " am))])
          ; (printf "IIII w:~s e:~s p:~s f:~s on x:~s\n" wrap encloser parens firstarg x)
          (let ([ans (if (and wrap (or (not encloser)
                                       parens
                                       (and (eq? encloser '+)
                                            (if firstarg
                                                (not (memq a '(+ - * / frac expt)))
                                                (not (memq a '(* / frac expt)))))
                                       (and (eq? encloser '-)
                                            (if firstarg
                                                (not (memq a '(+ - * / frac expt)))
                                                (not (memq a '(* / frac expt)))))
                                       (and (eq? encloser '*) (not (memq a '(* / frac expt))))
                                       (and (eq? encloser '/) (not (memq a '(*))))
                                       ))
                         (format "( ~a )" x)
                         x)])
            ; (printf "infix ret'd ~s\n" ans)
            ans)))))

(define (sexp->arith e #:pyret [pyret #f] #:wrap [wrap #f]
                     #:encloser [encloser #f] #:parens [parens #f] #:firstarg [firstarg #f] #:tex [tex #f])
  ; (printf "doing sexp->arith ~s l:~s w:~s e:~s p:~s\n" e pyret wrap encloser parens)
  (cond [(member e '(true false)) (let ([x (format "~a" e)])
                                    (if (or pyret tex) x (enclose-span ".value.wescheme-boolean" x)))]
        [(number? e) (let ([x (format "~a" e)])
                       (if (or pyret tex) x (enclose-span ".value.wescheme-number" x)))]
        [(and (symbol? e) pyret
              (memq e '(BSLeaveAHoleHere BSLeaveAHoleHere2 BSLeaveAHoleHere3)))
         (enclose-span ".fitb" (format "~a" e))] ;CHECK
        [(symbol? e) (let ([x (sym-to-adocstr e #:pyret pyret #:tex tex)])
                       (if (or pyret tex) x (enclose-span ".value.wescheme-symbol" x)))]
        [(string? e) (let ([x (format "~s" e)])
                       (if (or pyret tex) x (enclose-span ".value.wescheme-string" x)))]
        [(answer? e) (let* ([e (second e)]
                            [fill-len (answer-fill-length e)])
                       ;(printf "answer frag found: ~s\n" e)
                       (if *solutions-mode?*
                           (enclose-span (format ".fitb~a" fill-len)
                             (sexp->arith e #:pyret pyret #:wrap wrap #:parens parens #:tex tex))
                           (enclose-span (format ".fitb~a" fill-len)
                             "{nbsp}"
                             ;(symbol->string *hole-symbol*)
                             )))]
        [(fitb? e)
         ; (printf "found fitb ~s\n" e)
         (let ([e (second e)])
                     (enclose-span ".fitb" "{nbsp}" #:attribs (format "style=\"min-width: ~a\"" e)))]
        [(list? e) (let ([a (first e)])
                     (cond [(and pyret (or (memq a *list-of-hole-symbols*) ;XXX:
                                           (infix-op? a #:pyret #t)
                                           ))
                            (let* ([a (sexp->arith a #:pyret #t)]
                                   [lft (sexp->arith (list-ref e 1) #:pyret #t #:wrap #t
                                                     #:parens parens #:tex tex)]
                                   [rt (sexp->arith (list-ref e 2) #:pyret #t #:wrap #t
                                                    #:parens parens #:tex tex)]
                                   [x (format "~a ~a ~a" lft a rt)])
                              (if (or wrap parens) (format "({zwsp}~a{zwsp})" x) x)) ]
                           [(and (not pyret) (or (memq a *list-of-hole-symbols*) ;XXX:
                                                 (infix-op? a #:pyret #f)
                                                 ))
                            (infix-sexp->math a (rest e) #:wrap wrap #:encloser encloser
                                              #:parens parens #:firstarg firstarg)]
                           [(and (eq? a 'define) (= (length e) 3) pyret)
                            (let* ([lhs (list-ref e 1)]
                                   [rhs (list-ref e 2)]
                                   [lhs-c (sexp->arith lhs #:pyret #t #:tex tex)]
                                   [rhs-c (sexp->arith rhs #:pyret #t #:tex tex)])
                              (cond [(cons? lhs)
                                     (format "fun ~a: ~a end" lhs-c rhs-c)]
                                    [else
                                      (format "~a = ~a" lhs-c rhs-c)]))]
                           [(and (eq? a 'EXAMPLE) pyret)
                            (let ([num-examples (/ (length (rest e)) 2)])
                              (let loop ([n num-examples] [e (rest e)] [r "examples:"])
                                (if (= n 0)
                                    (string-append r "\nend")
                                    (let* ([lhs (first e)]
                                           [rhs (second e)]
                                           [lhs-s (sexp->arith lhs #:pyret #t)]
                                           [rhs-s (sexp->arith rhs #:pyret #t)]
                                           [tot-len (+ (string-length (format "~s" lhs))
                                                       (string-length (format "~s" rhs)))])
                                      (loop (- n 1) (rest (rest e))
                                            (string-append r "\n"
                                              "  "
                                              lhs-s " is "
                                              rhs-s))))))]
                           [(and (eq? a 'list) pyret)
                            (let* ([args (rest e)]
                                   [args-c (map (lambda (x) (sexp->arith x #:pyret #t)) args)])
                              (format "[list: ~a]" (string-join args-c ", ")))]
                           [(and (eq? a 'sqrt) (= (length e) 2) (not pyret))
                            (format "\\sqrt{ ~a }" (sexp->arith (second e) #:parens parens #:tex tex))]
                           [(and (eq? a 'sqr) (= (length e) 2) (not pyret))
                            (let* ([x (second e)]
                                   [xm (sexp->arith x #:parens parens #:tex tex)])
                              (format
                                (if (list? x)
                                    " { ( ~a ) }^ 2 "
                                    " { ~a }^ 2 ") xm))]
                           [else
                             (format (if pyret "~a{zwsp}({zwsp}~a{zwsp})" "~a(~a)")
                                     (sexp->arith a #:pyret pyret #:parens parens #:tex tex)
                                     (string-join
                                       (map (lambda (e1)
                                              (sexp->arith e1 #:pyret pyret #:parens parens #:tex tex))
                                            (rest e))
                                       ", "))]
                           ))]
        [else (error 'ERROR "sexp->arith: unknown s-exp ~s" e)]))

(define (add-prereq sym #:check? [check? (lambda (x) #t)])
  ; (printf "doing add-prereq ~s\n" sym)
  (when (and (or *lesson-plan* *lesson*) (symbol? sym))
    ;use conditional here if you want to exclude some symbols
    ; (printf "it's happening\n")
    (unless (member sym *prereqs-used*)
      (cond [(check? sym)
             (set! *prereqs-used* (cons sym *prereqs-used*))]
            [else
              (printf "WARNING: ~a in ~a not mentioned in langtable.js (are you sure you're using the WeScheme name?)\n\n"
                      sym (errmessage-file-context))]))))

(define (add-prereq/check sym)
  ; (printf "doing add-prereq/check ~s\n\n" sym)
  (add-prereq sym #:check? check-in-langtable?))

(define (add-starter-file sf #:opt? [opt? #f])
  (when (or *lesson-plan*
            (and *lesson*
                 (or
                   (regexp-match "/pages$" *containing-directory*)
                   (regexp-match "/solution-pages$" *containing-directory*))))
    ((if opt? add-opt-starter-file add-reqd-starter-file) sf)))

(define (add-reqd-starter-file sf)
  (cond [(member sf *starter-files-used*) #f]
        [else (set! *starter-files-used* (cons sf *starter-files-used*))
              #t]))

(define (add-opt-starter-file sf)
  (cond [(member sf *opt-starter-files-used*) #f]
        [else (set! *opt-starter-files-used* (cons sf *opt-starter-files-used*))
              #t]))

(define holes-to-underscores
  (let* ([hole *hole-symbol*]
         [hole2 *hole2-symbol*]
         [hole3 hole2])
    (lambda (e #:wescheme [wescheme #f])
      ; (printf "doing holes-to-underscores ~s\n" e)
      (cond [(or (null? e) (number? e) (string? e)) e]
            [(eq? e 'BSLeaveAHoleHere) hole] ;XXX: used anymore?
            [(eq? e 'BSLeaveAHoleHere2) hole2]
            [(eq? e 'BSLeaveAHoleHere3) hole3]
            [(and (eq? e 'frac) wescheme)
             (add-prereq '/)
             '/]
            [(pair? e) (cons (holes-to-underscores (first e) #:wescheme wescheme)
                             (holes-to-underscores (rest e) #:wescheme wescheme))]
            [else
              (add-prereq e)
              e]))))

(define (sexp->wescheme e #:multiline? [multiline? #f])
  ; (printf "doing sexp->wescheme ~s\n" e)
  (set! *uses-codemirror?* #t)
  ; (create-zero-file (format "~a.uses-codemirror" *out-file*))
  (let ([h (holes-to-underscores e #:wescheme #t)])
    ; (printf "h2u retn'd ~s\n" h)

    ; (enclose-textarea ".racket" (sexp->block h #:wescheme #t))
    (enclose-textarea-2 ".racket" (sexp->block h #:wescheme #t) #:multiline? multiline?)

    ))

(define (sexp->pyret e #:parens [parens #f] #:multiline? [multiline? #f])
  ; (printf "\ndoing sexp->pyret ~s\n" e)
  (let ([h (holes-to-underscores e)])
    ; (printf "h2u retn'd ~s\n" h)
    ; (enclose-textarea ".pyret" (sexp->arith h #:pyret #t #:parens parens))
    (enclose-textarea-2 ".pyret" (sexp->arith h #:pyret #t #:parens parens) #:multiline? multiline?)
    ))

(define (math e #:parens [parens #f])
  ; (printf "doing math ~s p:~s\n" e parens)
  ; (create-zero-file (format "~a.uses-mathjax" *out-file*))
  (math->string (sexp->arith e #:parens parens #:tex #t)))

(define (math->mathjax-string text)
  (set! *uses-mathjax?* #t)
  ; (create-zero-file (format "~a.uses-mathjax" *out-file*))
  (enclose-math text))

(define (math->string text)
  ; (printf "doing math->string ~s\n" text)
  (cond [(and *math-unicode?* (math-unicode-if-possible text))
         => (lambda (mu)
              (enclose-span ".mathunicode" mu))]
        [else
          (set! text (regexp-replace* "\\\\over([a-z])" text "\\\\SAVEDOVER\\1"))
          (set! text (regexp-replace* "\\\\over" text "\\\\over\\\\displaystyle"))
          (set! text (regexp-replace* "\\\\SAVEDOVER" text "\\\\over"))
          (math->mathjax-string text)]))

(define (sexp->code e #:parens [parens #f] #:multiline? [multiline? #f])
  ; (printf "doing sexp->code ~s\n" e)
  (if (string=? *proglang* "pyret")
      (sexp->pyret e #:parens parens #:multiline? multiline?)
      (sexp->wescheme e #:multiline? multiline?)))

(define (sym-to-adocstr e #:pyret [pyret #f] #:tex [tex #f])
  ;(printf "sym-to-adocstr ~s p:~a t:~a\n" e pyret tex)
  (cond [pyret (cond [(eq? e '+) "{plus}"]
                     [(memq e '(* -)) (format "{zwsp}~a" e)]
                     [else (wescheme-symbol->pyret e)])]
        [(not tex) (cond [(eq? e '<=) "\\<="]
                         [(eq? e '+) "{plus}"]
                         [(eq? e 'frac) "/"]
                         [(memq e '(* -)) (format "{zwsp}~a" e)]
                         [else (format "~a" e)])]
        [else (cond [(eq? e '<=) " \\le "]
                    [(eq? e 'pi) " \\pi "]
                    [else
                      (format "~a" e)])]))

(define (sexp->block e #:pyret [pyret #f] #:wescheme [wescheme #f])
  ; (printf "doing sexp->block ~s ~a\n" e pyret)
  (cond [(member e '(true false)) (enclose-span (if pyret ".value" ".value.wescheme-boolean") (format "~a" e))]
        [(eq? e 'else) (enclose-span (if pyret "" ".wescheme-keyword") "else")]
        [(number? e) (enclose-span (if pyret ".value" ".value.wescheme-number") (format "~a" e))]
        [(string? e) (enclose-span (if pyret ".value" ".value.wescheme-string") (format "~s" e))]
        [(boolean? e) (enclose-span (if pyret ".value" ".value.wescheme-boolean") (format "~a" e))]
        [(symbol? e)
         (enclose-span (if pyret ".value" ".value.wescheme-symbol")
           (cond [(memq e '(BSLeaveAHoleHere BSLeaveAHoleHere2 BSLeaveAHoleHere3))
                  "{nbsp}{nbsp}{nbsp}"]
                 [else (sym-to-adocstr e #:pyret pyret)]))]
        [(answer? e) (let* ([e (second e)]
                            [fill-len (answer-block-fill-length e)])
                       (if *solutions-mode?*
                           (enclose-span
                             (if wescheme
                                 (format ".fitb~a" fill-len)
                                 (format ".studentBlockAnswerFilled~a" fill-len))
                             (sexp->block e #:pyret pyret #:wescheme wescheme))
                           (enclose-span
                             (if wescheme
                                 (format ".value.wescheme-symbol.fitb~a" fill-len)
                                 (format ".value.fitb~a" fill-len))
                             "{nbsp}{nbsp}{nbsp}")))]
        [(fitb? e) (let ([e (second e)])
                     (enclose-span ".fitb" "{nbsp}"
                       #:attribs (format "style=\"min-width: ~a\"" e)))]
        [(list? e) (let ([a (first e)])
                     (cond [(and (eq? a 'EXAMPLE) wescheme)
                            (let ([num-examples (/ (length (rest e)) 2)])
                              (let loop ([n num-examples] [e (rest e)] [r ""])
                                (if (= n 0) r
                                    (let* ([lhs (first e)]
                                           [rhs (second e)]
                                           [lhs-s (sexp->block lhs #:wescheme #t)]
                                           [rhs-s (sexp->block rhs #:wescheme #t)])
                                      (loop (- n 1) (rest (rest e))
                                            (string-append r
                                              (if (= n num-examples) "" "\n")
                                              (enclose-span ".lParen" "(")
                                              (sexp->block 'EXAMPLE #:wescheme #t)
                                              " "
                                              lhs-s "\n  "
                                              rhs-s
                                              (enclose-span ".rParen" ")")))))))]
                           [(eq? a 'BEGIN)
                            (string-join
                              (map (lambda (e) (sexp->block e #:pyret pyret #:wescheme wescheme)) (rest e))
                              "\n")]
                           [(and (eq? a 'COMMENT) (or wescheme pyret))
                            (string-append (if wescheme "; " "# ") (second e))]
                           [else
                             (enclose-span ".expression"
                               (if (or (symbol? a) (answer? a))
                                   (let ([args (intersperse-spaces
                                                 (map (lambda (e1)
                                                        (sexp->block e1 #:pyret pyret #:wescheme wescheme))
                                                      (rest e)) 'args)])
                                     (string-append
                                       (enclose-span ".lParen" "(")
                                       (enclose-span ".operator"
                                         (sexp->block a #:pyret pyret #:wescheme wescheme))
                                       args
                                       (enclose-span ".rParen" ")")))
                                   (let ([parts (intersperse-spaces
                                                  (map (lambda (e1)
                                                         (sexp->block e1 #:pyret pyret #:wescheme wescheme))
                                                       e) #f)])
                                     (string-append
                                       (enclose-span ".lParen" "(")
                                       parts
                                       (enclose-span ".rParen" ")")))))]))]
        [else (error 'ERROR "sexp->block: unknown s-exp")]))

(define (sexp exp #:form [form "circofeval"])
  (when (string? exp)
    (set! exp (with-input-from-string exp read)))
  (cond [(string=? form "circofeval")
         (coe exp)]
        [(member form (list "code" "text"))
                 (sexp->block exp #:pyret (string=? *proglang* "pyret"))]
        [else (sexp->block exp #:pyret (string=? *proglang* "pyret"))]))

(define (cm-code x #:multiline? [multiline? #t] #:parens [parens #f]) ;TODO or #f?
  ; (printf "doing cm-code ~s\n" x)
  (let ([pyret? (string=? *proglang* "pyret")])
    (unless (string? x)
      (set! x ((if pyret? wescheme->pyret wescheme->wescheme) x #:parens parens #:indent 0)))
    (set! *uses-codemirror?* #t)
    ; (create-zero-file (format "~a.uses-codemirror" *out-file*))
    (enclose-textarea #:multiline? multiline?
      (if pyret? ".pyret" ".racket")
      (if pyret? (regexp-replace* " :: " x " :{zwsp}: ")
          x))))

(define (tree-member? xx tree)
  (cond [(list? tree) (ormap (lambda (subtree) (tree-member? xx subtree)) tree)]
        [(list? xx) (ormap (lambda (x) (eq? x tree)) xx)]
        [else (eq? xx tree)]))

(define (code x #:multiline? [multiline? #t] #:parens [parens #f])
  ; (printf "doing code ~s ~s\n" x parens)
  (if (tree-member? '(?ANS ?ANSWER ?FITB) x)
      (sexp->code x #:multiline? multiline? #:parens parens)
      (cm-code x #:multiline? multiline? #:parens parens)))

(define (contract-type x)
  ; (printf "doing contract-type ~s\n" x)
  (cond [(list? x)
         (let ([name (first x)] [type (second x)])
           (unless (string? name) (set! name (format "~a" name)))
           (if (list? type)
               (format "~a {two-colons} ~a" name
                       (string-append (contract-type (first type))
                         "&nbsp;-> "
                         (contract-types-to-commaed-string (rest type))))
               (let* ([type (if (string? type) type (format "~a" type))]
                      ; [name-w (string-length name)]
                      ; [type-w (string-length type)]
                      ; [w (+ 0 (max name-w type-w))]
                      )
                 (string-append (create-begin-tag "span" ".fitbruby"
                                                  ; #:attribs (format "style=\"width: ~aem\"" w)
                                                  )
                   type
                   (create-begin-tag "span" ".ruby")
                   name
                   (create-end-tag "span")
                   (create-end-tag "span")))))]
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

(define (contract funname domain-list range [purpose #f] #:single? [single? #t])
  ;FIXME: do we need a keyword to avoid the prefix character
  ; (printf "doing contract ~s ~s ~s ~s ~s\n" funname domain-list range purpose single?)
  (let ([funname-sym (if (symbol? funname) funname (string->symbol funname))]
        [funname-str (if (string? funname) funname (format "~a" funname))])
    (add-prereq funname-sym)
    (let* (
      [prefix (cond
                [(string=? *proglang* "pyret") "# "]
                [(string=? *proglang* "wescheme") "; "]
                [(string=? *proglang* "codap") ""])]
      [s (string-append
          prefix
          (if *pyret?* (wescheme->pyret funname-sym) funname-str)
          " "
          ; used to be single colon for WeScheme
          "{two-colons}"
          " "
          ; used to not have commas in WeScheme
          (contract-types-to-commaed-string domain-list)
          "&nbsp;-> "
          range
          (if purpose
              (string-append "\n"
                prefix
                purpose)
              "")
          ;(if single? "\n```\n" "")
          )])
      (if single?
          (begin
            ; (create-zero-file (format "~a.uses-codemirror" *out-file*))
            (enclose-textarea (if *pyret?* ".pyret-comment" ".racket-comment") s #:multiline? #t))
          s))))

(define (contracts . args)
  (let ([res (string-join (map (lambda (arg)
                                 (keyword-apply contract '(#:single?) '(#f) arg))
                               args) "\n")])
    ; (create-zero-file (format "~a.uses-codemirror" *out-file*))
    (enclose-textarea (if *pyret?* ".pyret-comment" ".racket-comment") res #:multiline? #t)))
