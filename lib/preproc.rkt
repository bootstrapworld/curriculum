#lang racket

(require "readers.rkt")
(require "utils.rkt")
(require "html-tag-gen.rkt")
(require "defines.rkt")
(require "create-copyright.rkt")
(require "create-acknowledgment.rkt")
(require "create-workbook-links.rkt")
(require "form-elements.rkt")
(require "function-directives.rkt")
(require "glossary-terms.rkt")
(require "the-standards-dictionaries.rkt")
(require "the-textbook-dictionaries.rkt")
(require "lessons-and-standards.rkt")
(require "lessons-and-practices.rkt")
(require "lessons-and-textbooks.rkt")
(require "collect-lang-prereq.rkt")
(require "starter-files.rkt")
;(require "draw-dep-diag.rkt")

(provide
  assoc-standards
  add-standard
  box-add-new!
  create-standards-file
  preproc-adoc-file
  rearrange-args
  )

(define *progdir* (getenv "PROGDIR"))

(define *force* (truthy-getenv "FORCE"))

(define *nopdf* (truthy-getenv "NOPDF"))

(define *book* (truthy-getenv "BOOK"))

(define *proglang* "pyret")

(define *containing-directory* "")

(unless (member *proglang* '("pyret" "wescheme" "codap"))
  (error 'ERROR "preproc.rkt: Unknown proglang ~a" *proglang*))

(define *pyret?* #f)

(define *solutions-mode?* #f)

(define *workbook-page?* (truthy-getenv "WORKBOOKPAGE"))
;FIXME

(define *pathway* (or (truthy-getenv "SRCPATHWAY") ""))

(define *lesson-plan* #f)

(define *lesson-plan-base* #f)

;(printf "LESSONPLAN is ~s\n" *lesson-plan*)

(define *other-dir* #f)

(define *lesson* #f)

;(printf "LESSON is ~s\n" *lesson*)

(define *lesson-subdir* (truthy-getenv "LESSONSUBDIR"))

;(printf "LESSONSUBDIR is ~s\n" *lesson-subdir*)

(define *narrative* #f)

(define *boilerplate* (truthy-getenv "BOILERPLATE"))

(define *teacher-resources* #f)

(define *link-lint?* (truthy-getenv "LINT"))

(define *autonumber-index* 1)

(define *internal-links-port* #f)
(define *external-links-port* #f)

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

(define *pathway-root-dir* (getenv "PATHWAYROOTDIR"))

;(define *dist-root-dir* (getenv "DISTROOTDIR"))

(define *dist-root-dir* "")

;(printf "distrootdir= ~s\n" *dist-root-dir*)

(define *target-pathway* (or (getenv "TGTPATHWAY") "notDoingPathway"))

;(printf "tgtpathway= ~s\n" *target-pathway*)

(define *lang-root-dir*
  (let ([x (truthy-getenv "LANGROOTDIR")])
    (or x (string-append *pathway-root-dir* "../../"))))

(define *pathway-lesson-order*
  (string-append *pathway-root-dir* ".cached/.workbook-lessons.txt.kp"))

(define *pathway-exercises-file*
  (string-append *dist-root-dir* "courses/" *target-pathway* "/resources/.workbook-exercises.rkt.kp"))

;(printf "pwyexf= ~s\n" *pathway-exercises-file*)

(define *pathway-lessons-containing-exercises-file*
  (string-append *dist-root-dir* "courses/" *target-pathway* "/resources/.workbook-lessons-containing-exercises.rkt.kp"))

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

;(printf "*workbook-pagenums* = ~s\n" *workbook-pagenums*)

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

(cond ((assoc "name" *copyright-info*) =>
       (lambda (c) (set! *copyright-name* (cadr c)))))

(define *glossary-items* '())

(define *missing-glossary-items* '())

(define *standards-met* '())
;FIXME

(define *practices-merited* '())

; (define *textbooks-used* '())

(define *textbooks-represented* '())

(define *chapters-used* '())

(define *lesson-prereqs* '())

(define *lesson-keywords* '())

(define *dictionaries-represented* '())

(define *exercises-done* '())

(define *prereqs-used* '())

(define *online-exercise-links* '())
(define *opt-online-exercise-links* '())
(define *printable-exercise-links* '())
(define *opt-printable-exercise-links* '())
(define *starter-file-links* '())
(define *opt-starter-file-links* '())
(define *opt-project-links* '())

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

(define read-group (*make-read-group (lambda z (apply code z))
                                     errmessage-file-context))

(define (read-space i)
  (let loop ()
    (let ([c (peek-char i)])
      (cond [(eof-object? c) #f]
            [(or (char=? c #\space) (char=? c #\tab)) (read-char i) (loop)]
            [(or (char=? c #\newline)) (read-char i) #t]
            [else #f]))))

(define (read-commaed-group i directive)
  (let* ([g (read-group i directive)]
         [n (string-length g)])
    (let loop ([i 0] [r '()])
      (if (>= i n)
          (map string-trim (reverse r))
          (let loop2 ([j i] [in-string? #f] [in-escape? #f])
            (if (>= j n) (loop j (cons (substring g i j) r))
                (let ([c (string-ref g j)])
                  (cond [(eof-object? c)
                         (error 'ERROR "read-commaed-group: Runaway directive ~a in (~a,~a)"
                                directive *lesson-subdir* *in-file*)]
                        [in-escape?
                          (loop2 (+ j 1) in-string? #f)]
                        [(char=? c #\\)
                         (loop2 (+ j 1) in-string? #t)]
                        [in-string?
                          (if (char=? c #\")
                              (loop2 (+ j 1) #f #f)
                              (loop2 (+ j 1) #t #f))]
                        [(char=? c #\")
                         (loop2 (+ j 1) #t #f)]
                        [(char=? c #\,)
                         (loop (+ j 1) (cons (substring g i j) r))]
                        [else (loop2 (+ j 1) #f #f)]))))))))

(define (assoc-glossary term L)
  ;(printf "doing assoc-glossary ~s ~n" term)
  (let ([naive-singular (if (char-ci=? (string-ref term (- (string-length term) 1)) #\s)
                             (substring term 0 (- (string-length term) 1))
                             "")])
    ;(printf "naive sing = ~s~n" naive-singular)
    (let loop ([L L])
      (if (null? L) #f
          (let* ([c (car L)]
                 [lhs (car c)])
            ;(printf "lhs = ~s~n" lhs)
            (or (cond [(string? lhs)
                       (and (or (string-ci=? lhs term)
                                (string-ci=? lhs naive-singular))
                            c)]
                      [(list? lhs)
                       (and (memf (lambda (x) (string-ci=? x term)) lhs)
                            (list (car lhs) (cadr c)))]
                      [else #f])
                (loop (cdr L))))))))

(define (assoc-standards std)
  ;(printf "doing assoc-standards ~s\n" std)
  (let* ([std-bits (regexp-split #rx"&" std)] ;TODO This is probly obsolete now
         [std (list-ref std-bits 0)]
         [sublist-item #f]
         [c #f]
         [dict #f])
    (for ((x *disallowed-standards-list*))
      (unless c
        (let ([stds-list (caddr x)])
          (set! c (assoc std stds-list)))))
    ;(printf "found ~s in disallowed? ~s\n" std (not (not c)))
    (cond (c (values #f #f #f))
          (else
            (for ([x *standards-list*])
              (unless c
                (let ([stds-list (caddr x)])
                  (set! c (assoc std stds-list))
                  (when c (set! dict (car x))))))
            ;(printf "found ~s in allowed? ~s\n" std (not (not c)))
            (when (>= (length std-bits) 3)
              (set! sublist-item (string->number (list-ref std-bits 2))))
            (unless c
              (printf "WARNING: ~a: Standard ~a not found\n\n" (errmessage-context) std))
            (values sublist-item c dict)))))

(define (assoc-textbooks chapter-label)
  ;(printf "doing assoc-textbooks ~s\n" chapter-label)
  (let ([chapter-desc #f]
        [textbook-name #f])
    (for ([x *textbooks-list*])
      (unless chapter-desc
        (let ([this-textbook-name (car x)]
              [this-textbook-chapters (cadr x)])
          ;(printf "\n t-n = ~s\n t-cc = ~s\nn" this-textbook-name this-textbook-chapters)
          (set! chapter-desc (assoc chapter-label this-textbook-chapters))
          (when chapter-desc (set! textbook-name this-textbook-name)))))
    ;(printf "chapter-desc = ~s; textbook-name = ~s\n" chapter-desc textbook-name)
    (if chapter-desc
        (values (cadr chapter-desc) textbook-name)
        (values #f #f))))

(define (add-standard x lesson-title lesson pwy o)
  ;(printf "doing add-standard x= ~s ttl= ~s lsn= ~s pwy= ~s\n" x lesson-title lesson pwy)
  (let-values (((sublist-item c dict) (assoc-standards x)))
    ;(printf "-> sbl= ~s c= ~s dict= ~s\n" sublist-item c dict)
    (when c (let ((std (list-ref c 0)))
              (when (and o *lesson*)
                (fprintf o "**~a**: ~a~n~n"
                         std (list-ref c 1)))
              (cond ((assoc std *standards-met*)
                     => (lambda (c0)
                          (when sublist-item
                            (let ((sublist-items (list-ref c0 1)))
                              (box-add-new! sublist-item sublist-items)))
                          (unless *lesson*
                            (box-add-new! (list lesson-title lesson pwy)
                                          (list-ref c0 4)))))
                    (else
                      (let ((sublist-items
                              (box (if sublist-item
                                       (list sublist-item)
                                       '()))))
                        (unless (member dict *dictionaries-represented*)
                          (set! *dictionaries-represented* (cons dict *dictionaries-represented*)))
                        (set! *standards-met*
                          (cons (list std sublist-items c dict
                                      (box (list (list lesson-title lesson pwy))))
                                *standards-met*)))))))))

(define (add-badge b)
  ;(printf "doing add-badge ~s\n" b)
  (unless (member b *practices-merited*)
    (set! *practices-merited* (cons b *practices-merited*))))

;(define (add-textbook tb)
;  ;(printf "doing add-textbook ~s\n" tb)
;  (unless (member tb *textbooks-used*)
;    (set! *textbooks-used* (cons tb *textbooks-used*))))

(define (add-textbook-chapter chapter-label)
  ;(printf "doing add-textbook-chapter ~s\n" chapter-label)
  (unless (assoc chapter-label *chapters-used*)
    (let-values ([(chapter-title textbook-label) (assoc-textbooks chapter-label)])
      (when chapter-title
        (unless (member textbook-label *textbooks-represented*)
          (set! *textbooks-represented* (cons textbook-label *textbooks-represented*)))
        (set! *chapters-used*
          (cons (list chapter-label chapter-title textbook-label) *chapters-used*))))))

(define (box-add-new! v bx)
  ;(printf "doing box-add-new! ~s ~s\n" v bx)
  (let ([vv (unbox bx)])
    (unless (member v vv)
      (let ([vv (append vv (list v))])
        (when (number? v)
          (set! vv (sort vv <)))
        (set-box! bx vv)))))

(define (check-first-subsection i o)
  (let ([c (peek-char i)])
    (if (eof-object? c) #f
        (char=? c #\=))))

(define (display-section-markup i o)
  (let ([section-level
          (let loop ([section-level 1])
            (let ([c (peek-char i)])
              (cond [(eof-object? c) section-level]
                    [(char=? c #\=) (read-char i) (loop (+ section-level 1))]
                    [else section-level])))])
    (fprintf o "[.lesson-section-~a]~n" (- section-level 1))
    (for ([i section-level])
      (display #\= o))))

(define (string-to-form s)
  (call-with-input-string s
    (lambda (i)
      (let loop ([r '()])
        (let ([x (read i)])
          (if (eof-object? x) (reverse r)
              (loop (cons x r))))))))

(define (massage-arg arg)
  ;(printf "doing massage-arg ~s\n" arg)
  (eval arg *adoc-namespace*))

(define (rearrange-args args)
  ;(printf "doing rearrange-args ~s\n" args)

  (define (sort-keyword-args args)
    (let ([args-paired (let loop ([args args] [r '()])
                         (if (null? args) r
                               (loop (cddr args)
                                     (cons (list (car args) (massage-arg (cadr args)))
                                         r))))])
      (sort args-paired keyword<? #:key car)))

  (let loop ([args args] [r '()])
    (if (null? args)
        (values '() '() (reverse r))
        (let ([arg (car args)])
          (cond [(keyword? arg)
                 (let ([kvkv (sort-keyword-args args)])
                   (values (map car kvkv) (map cadr kvkv) (reverse r)))]
                [else
                  (loop (cdr args) (cons arg r))])))))

(define (this-proglang-lesson? this-lesson all-lessons)
  (let ([result 0])
    (cond [(string=? *proglang* "pyret")
           (set! result #t)
           ;if lesson has suffix -otherproglang and deleting that suffix
           ;gives a lesson that is present, then don't include
           (for ([-other-proglang '("-codap$" "-wescheme$")])
             (when (regexp-match -other-proglang this-lesson)
               (let ([this-lesson-delete-proglang
                       (regexp-replace -other-proglang this-lesson "")])
                 (when (member this-lesson-delete-proglang all-lessons)
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
                              (when (member this-lesson-delete-proglang all-lessons)
                                (set! result #f))))))
                      (when result
                        ;if lesson with suffix -thisproglang exists, don't include
                        (let ([lesson-proglang (string-append this-lesson "-" *proglang*)])
                          (when (member lesson-proglang all-lessons)
                            (set! result #f))))]))])
    result))

(define (display-prereqs-bar o)
  ;(printf "doing display-prereqs-bar in ~s\n" *in-file* )
  (let* ([all-lessons (read-data-file (format ".cached/.do-relevant-lessons.txt.kp"))]
         [relevant-lessons (filter (lambda (x) (this-proglang-lesson? x all-lessons))
                                   all-lessons)])
    ;(printf "f : ~s\n" (file-exists? (format "../../lesson-order.txt")))
    ;(printf "doing display-prereqs-bar ~s\n" all-lessons )
    ;(printf "*lesson-prereqs* = ~s\n" *lesson-prereqs*)
    ;(display "\n\n=== Lessons\n" o)
    (display (create-begin-tag "div" ".sidebarlessons") o)
    ;(display "[.sidebarlessons]\n" o)
    (display "*Lessons* %SIDEBARLESSONSCHECKBOX%\n" o)
    ;(display "== Pathway\n" o)

    ;(newline o)
    (display (create-begin-tag "ul" "") o)
    (for ([lesson relevant-lessons])
      (let ([lesson-title lesson]
            [lesson-title-file (build-path *containing-directory* 'up lesson ".cached" ".index.titletxt")])
        (cond [(file-exists? lesson-title-file)
               (set! lesson-title (call-with-input-file lesson-title-file read-line))]
              [else
                (printf "WARNING: Lesson ~a's prerequisite ~a not found or in incorrect order\n\n" *lesson* lesson)])
        (let ([lk
                (format "link:~alessons/pass:[~a]/index.shtml[~a]"
                        *dist-root-dir*
                        lesson lesson-title)])
          (when (member lesson *lesson-prereqs*)
            ;(printf "lesson ~s is prereq\n" lesson)
              (set! lk (enclose-span ".prerequisite" lk)))
          (display (enclose-tag "li" "" lk) o)
          (newline o))))

    (display (create-end-tag "ul") o)
    (display (create-end-tag "div") o)
    (newline o)
    ))

(define (display-standards-bar o)
  ;(printf "doing display-standards-bar\n")
  (cond [(null? *standards-met*)
         (display (create-begin-tag "div" ".sidebarstandards") o)
         (display "*Standards*: _None_" o)
         (display (create-end-tag "div") o)
         (display "\n" o)]
        [else
          (display "\n[.sidebarstandards,cols=\"a\"]" o)
          (display "\n|===\n" o)
          (display "| " o)
          (display "*Standards* (click one)\n" o)
          (display-standards-selection o *narrative* *dictionaries-represented*)
          (display " | \n" o)
          (display "\ninclude::.pathway-standards.asc[]\n" o)
          (display "|===\n" o)
          ]))

(define (display-practices-bar o)
  ;(printf "doing display-practices-bar\n")
  (display (create-begin-tag "div" ".sidebarpractices") o)
  (display "*Practices*" o)
  (display (create-begin-tag "ul" "") o)
  (cond [(null? *practices-merited*)
         (when *lesson-plan*
           (printf "WARNING: ~a: No practices specified\n" (errmessage-context)))]
        [else
          ;(printf "Pracices are present for ~s\n" *lesson-plan*)
          (for ([badge *practices-merited*])
            (let ([img ;(format "image:{pathwayrootdir}../../lib/Badges/~a.png[~a]" badge badge)
                    badge])
              (display (enclose-tag "li" "" img) o)
              (newline o)))])
  (display (create-end-tag "ul") o)
  (display (create-end-tag "div") o)
  (newline o))

(define (display-textbooks-bar o)
  ;(printf "doing display-textbooks-bar\n")
  (cond [(null? *textbooks-represented*)
         (display (create-begin-tag "div" ".sidebartextbooks") o)
         (display "*Textbook Alignment*: _None_" o)
         (display (create-end-tag "div") o)
         (display "\n" o)]
        [else
          (display "\n[.sidebartextbooks,cols=\"a\"]" o)
          (display "\n|===\n" o)
          (display "| " o)
          (display "*Textbook Alignment* (click one)\n" o)
          (display-textbooks-selection o *textbooks-represented*)
          (display " | \n" o)
          ;(printf "\n\noutputting ~s\n\n" *chapters-used*)
          ;(printf "\n\ntextbooks-represented= ~s\n\n" *textbooks-represented*)
          (fprintf o "\ninclude::.index-textbooks.asc[]\n")
          (display "|===\n" o)
          ]))

;(define (display-textbooks-bar-obsolete-fixme o)
;  ;(printf "doing display-textbooks-bar\n")
;  (display (create-begin-tag "div" ".sidebartextbooks") o)
;  (display "*Textbook Alignment*" o)
;  (when (null? *textbooks-used*) (display ": _None_" o))
;  (display "\n" o)
;  (unless (null? *textbooks-used*)
;    ;(printf "Textbooks present for ~s: ~s\n" *lesson-plan* *textbooks-used*)
;    (display (create-begin-tag "ul" "") o)
;    (for ([bk *textbooks-used*])
;      (let ([title (assoc bk *textbook-list*)])
;        (set! bk (if title (cadr title) bk))
;        (display (enclose-tag "li" "" bk) o)
;        (newline o)))
;    (display (create-end-tag "ul") o)
;    )
;  (display (create-end-tag "div") o)
;  (newline o))

(define (include-glossary o)
  ;(printf "include-glossary\n")
  (fprintf o "\n\ninclude::{frompathwayroot}~a/{cachedir}.pathway-glossary.asc[]\n\n" *containing-directory*))

(define (workbook-pagenum lesson snippet)
  ;(printf "doing workbook-pagenum ~s ~s\n" lesson snippet)
  ;(printf "*workbook-pagenums* = ~s\n" *workbook-pagenums*)
  #|
  (let* ([snippet.adoc
           (path->string
             (path-replace-extension snippet ".adoc"))]
         [c (or (assoc (list lesson snippet.adoc) *workbook-pagenums*)
                (assoc (list lesson snippet) *workbook-pagenums*))])
    (if c (cadr c) #f))
  |#
  #f
  )

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
  (let ([first-compt (car page-compts)])
    (case (length page-compts)
      [(1)
       (cond [*lesson*
               (make-workbook-link #f
                 "pages"
                 first-compt
                 link-text
                 #:link-type directive)]
             [else
               (printf "WARNING: Incorrect¹ @~a ~a\n\n"
                       directive page-compts)
               ""])]
      [(2)
       (let ([second-compt (cadr page-compts)])
         (cond [(and (or (string=? first-compt "pages")
                         (string=? first-compt "solution-pages"))
                     *lesson-plan*)
                (make-workbook-link #f
                  first-compt
                  (cadr page-compts)
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
       (let ([second-compt (cadr page-compts)]
             [third-compt (caddr page-compts)])
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
  ; (printf "make-workbook-link ~s ~s ~s ~s\n" lesson-dir pages-dir snippet link-text)
  (when (equal? lesson-dir *lesson*) (set! lesson-dir #f))
  ; (printf "lesson-dir= ~s\n*lesson*= ~s\n*pwydir= ~s\n" lesson-dir *lesson* *pathway-root-dir*)
  (let* ([lesson (or lesson-dir *lesson*)]
         [g (string-append lesson "/" pages-dir "/" snippet)]
         [g-in-pages (string-append lesson "/pages/" snippet)]
         [f (string-append "lessons/" g)]
         [f.src f]
         [existent-file? #f]
         [error-cascade? #f])
    ;g = relative pathname of the linked file from pathway-root-dir
    ;f = its fully qualified pathname
    ; (printf "f= ~s in ~s: ~s\n" f (current-directory) (file-exists? f))
    (cond [(path-has-extension? f ".adoc")
           (let ([f.adoc f]
                 [f.html (path-replace-extension f ".html")]
                 [f.pdf (path-replace-extension f ".pdf")])
             (cond [(or (file-exists? f.html) (file-exists? f.adoc))
                    ;(printf "I\n")
                    (set! f f.html)
                    (set! existent-file? #t)
                    (set! g-in-pages (path-replace-extension g-in-pages ".html"))
                    (set! g (path-replace-extension g ".html"))]
                   [(file-exists? f.pdf)
                    ;(printf "II\n")
                    (set! f f.pdf)
                    (set! existent-file? #t)
                    (set! g-in-pages (path-replace-extension g-in-pages ".pdf"))
                    (set! g (path-replace-extension g ".pdf"))]))]
          [(path-has-extension? f ".pdf")
           (when (file-exists? f)
             (set! existent-file? #t))]
          [else (set! f.src (path-replace-extension f ".adoc"))])
    ; (printf "f'= ~s\n" f)
    (unless existent-file?
      (set! error-cascade? #t)
      (check-link f)
      (printf "WARNING: Lesson ~a: ~a refers to nonexistent file ~a\n\n" lesson link-type f))
    (when (member link-type '("printable-exercise" "opt-printable-exercise"))
      (let ([f (format "../~a" g-in-pages)])
        (unless (ormap (lambda (e) (and (equal? (car e) lesson)
                                        (equal? (cadr e) f))) *exercises-done*)
          (let ([ex-ti (or (exercise-title f.src) link-text *page-title*)])
            (set! *exercises-done*
              (cons (list lesson f ex-ti) *exercises-done*))))))
    (when (or (not link-text) (string=? link-text ""))
      (let ([f.titletxt (path-replace-extension
                          (string-append "lessons/" lesson "/" pages-dir "/.cached/." snippet)
                          ".titletxt")])
        (when (file-exists? f.titletxt)
          (set! link-text (call-with-input-file f.titletxt read-line)))))
    (let ([link-output
            (format "link:~alessons/pass:[~a][~a~a]"
                    *dist-root-dir* g link-text
                    (if *lesson-plan* ", window=\"_blank\"" ""))])
      (when *lesson-plan*
        (cond [(equal? link-type "opt-printable-exercise")
               (let ([styled-link-output (string-append "[.Optional.PrintableExercise]##"
                                           link-output "##")])
                 (unless (member styled-link-output *opt-printable-exercise-links*)
                   (set! *opt-printable-exercise-links*
                     (cons styled-link-output *opt-printable-exercise-links*))))]

              [(equal? link-type "printable-exercise")
                (let ([styled-link-output (string-append "[.PrintableExercise]##" link-output "##")])
                  (unless (findf (lambda (L) (equal? (cadr L) styled-link-output))
                                 *printable-exercise-links*)
                    (set! *printable-exercise-links* (cons (list snippet styled-link-output)
                                                           *printable-exercise-links*))))]))
      link-output)))

(define (display-comment prose o)
  (display "%CURRICULUMCOMMENT%\n" o)
  (display "++++\n" o)
  (display prose o)
  (display "\n++++\n" o)
  (display "%ENDCURRICULUMCOMMENT%" o))

(define (display-header-comment prose o)
  (call-with-output-file ".index-comment.txt"
    (lambda (o)
      (display "<!--" o)
      (display prose o)
      (display "-->" o)
      (newline o))
    #:exists 'append))

(define (clean-up-image-text text)
  (when (char=? (string-ref text 0) #\")
    (set! text (substring text 1)))
  (let ([n (string-length text)])
    (when (char=? (string-ref text (- n 1)) #\")
      (set! text (substring text 0 (- n 1)))))
  (set! text (regexp-replace* #rx"," text "%CURRICULUMCOMMA%"))
  text)

(define (clean-up-url-in-image-text text)
  (regexp-replace* #rx"https://" text ""))

(define (system-echo cmd . args)
  (let* ((x (apply process* cmd args))
         (i (car x))
         (result (format "~a" (read i))))
    (close-input-port i)
    (close-output-port (cadr x))
    (close-input-port (cadddr x))
    (and (not (eof-object? result))
         result)))

(define (make-image img opts #:centered? [centered? #f])
  ;(printf "doing make-image ~s\n" img)
  (let ([img-qn (string-append *containing-directory* "/" img)])
    (unless (or *narrative* *target-pathway* *teacher-resources*)
      ;(printf "anonymizing ~s\n" img)
      (let ([img-anonymized (system-echo (format "~a/anonymize-filename" *progdir*) img)])
        (cond [img-anonymized
                ;(printf "anon img is ~s\n" img-anonymized)
                (set! img img-anonymized)
                (let ([img-anonymized-qn (string-append *containing-directory* "/"
                                           img-anonymized)])
                (when (file-exists? img-qn)
                  (rename-file-or-directory img-qn
                    (string-append *containing-directory* "/" img-anonymized)
                    #t))
                (unless (file-exists? img-anonymized-qn)
                  (printf "WARNING: ~a: Image file ~a not found\n\n" (errmessage-context) img-qn)))]
              [else (printf "WARNING: Image file ~a anonymization failed\n\n" img)])))
    (let* ([text (if (pair? opts) (clean-up-image-text (car opts)) "")]
           [rest-opts (if (pair? opts) (cdr opts) '())]
           [rest-opts (map (lambda (s) (if (string=? s "\"\"") "" s)) rest-opts)]
           [commaed-opts (string-join rest-opts ", ")]
           [commaed-opts (if (string=? commaed-opts "") "" (string-append ", " commaed-opts))]
           [text-wo-url (clean-up-url-in-image-text text)]
           [img-link-txt (string-append
                           (enclose-span ".big" "&#x1f5bc;") "Show image")]
           [img-link (format "link:~a[~a,~a]" img img-link-txt "role=\"gdrive-only\"")]
           [adoc-img
             (string-append
               (cond [*lesson-subdir*
                       (format "image:~a[~s~a]" img text-wo-url commaed-opts)]
                     [else
                       (format "image:~a[~s~a]" img text-wo-url commaed-opts)])
               img-link)])
      ;(printf "text= ~s; commaed-opts= ~s\n" text commaed-opts)
      (if (string=? text "")
          (if centered?
              (enclose-span ".centered-image" adoc-img)
              adoc-img)
          (enclose-span
            (string-append ".tooltip"
              (if centered? ".centered-image" ""))
            (string-append
              (enclose-span ".tooltiptext" text) "\n"
              adoc-img))))))

(define (check-link f #:external? [external? #f])
  (when (or *link-lint?* #t)
    (cond [external? (display f *external-links-port*)
                     (newline *external-links-port*)]
          [(not (file-exists? f))
           (display f *internal-links-port*)
           (newline *internal-links-port*)])))

(define (abbreviated-index-page? f)
  (and (directory-exists? f)
       (ormap (lambda (x) (file-exists? (build-path f x)))
              (list "index.html"
                    "index.shtml"
                    "index.adoc"
                    "index.asciidoc"))))

(define (extract-domain-name f)
  (let ([x (regexp-match "[a-zA-Z][^.:/]*[.](com|org)" f)])
    (and x
         (let ([y (car x)])
           (and (not (string-ci=? y "google"))
                (string-titlecase (substring y 0 (- (string-length y) 4))))))))

(define (make-link f link-text #:include? [include? #f] #:link-type [link-type #f])
  ; (printf "doing make-link f= ~s ltxt= ~s inc= ~s ltyp= ~s\n" f link-text include? link-type)
  (let ([external-link? #f]
        [g f])
    (cond [(string=? f "") #f]
          [(regexp-match #rx"://" f) (set! external-link? #t)]
          [(regexp-match #rx"^mailto:" f) (set! external-link? #t)]
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
                 [(regexp-match #rx"^#" f) #f]
                 [else
                   (let ([existent-file? #f])
                     (cond [(file-exists? f)
                            (set! existent-file? #t)]
                           [(file-exists? (path-replace-extension f ".adoc"))
                            (set! existent-file? #t)
                            (set! g (path-replace-extension g ".adoc"))]
                           [(file-exists? (path-replace-extension f ".html"))
                            (set! existent-file? #t)
                            (set! g (path-replace-extension g ".html"))]
                           [(file-exists? (path-replace-extension f ".shtml"))
                            (set! existent-file? #t)
                            (set! g (path-replace-extension g ".shtml"))]
                           [(file-exists? (path-replace-extension f ".pdf"))
                            (set! existent-file? #t)
                            (set! g (path-replace-extension g ".pdf"))])
                     (when existent-file?
                       (set! f (build-path *containing-directory* g)))
                    ; (printf "link ~a refers to ~a\n\n" g f)
                     (let ([short-ref? (abbreviated-index-page? f)])
                       ; (printf "g = ~s is valid short-ref\n" g)
                       (unless (or existent-file?
                                   (string=? g "pathway-standards.shtml")
                                   (and *teacher-resources* (string=? g "solution-pages/contracts.pdf"))
                                   short-ref?)
                         (check-link f)
                         (printf "WARNING: ~a: @link refers to nonexistent file ~a\n\n"
                                 (errmessage-context)
                                 f))
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
                   (cond ((or *lesson-plan* *teacher-resources*)
                          (format "link:pass:[~a][~s, window=\"_blank\"]" g link-text))
                         (else (format "link:pass:[~a][~a]" g link-text)))])

             (when (and *lesson-plan* external-link? (equal? link-type "online-exercise"))
               (let ([styled-link-output (string-append "[.OnlineExercise]##" link-output "##")])
                 (unless (member styled-link-output *online-exercise-links*)
                   (set! *online-exercise-links*
                     (cons styled-link-output *online-exercise-links*)))))

             (when (and *lesson-plan* external-link? (equal? link-type "opt-online-exercise"))
               (let ([styled-link-output (string-append "[.Optional.OnlineExercise]##"
                                           link-output "##")])
                 (unless (member styled-link-output *opt-online-exercise-links*)
                   (set! *opt-online-exercise-links*
                     (cons styled-link-output *opt-online-exercise-links*)))))

             ; (printf "make-link outputting ~s\n" link-output)

             link-output)

           ]
          [else
            (let ([f.asc (regexp-replace "([^/]+)\\.adoc" f ".cached/.\\1.asc")])
              ;(printf "make-link checking ~s vs ~s\n" f.asc f)
              ;TODO: probably not needed anymore

              ;FIXME: avoid erroring include: if file doesn't exist?
              (format "include::~a~a[~a]"
                      (if *lesson-plan* "{frompathwayroot}" "")
                      f.asc link-text))])))

(define *lesson-summary-file* #f)

(define *asciidoctor*
  (format "asciidoctor -a linkcss -a proglang=~a -a pathway=~a -a stylesheet=~alib/curriculum.css"
          *proglang*
          (getenv "SRCPATHWAY")
          *lang-root-dir*))

(define *standards-dictionaries*
  (map car *standards-list*))

(define *page-title* #f)

(define (display-alternative-proglang o)
  (when (and (string=? *pathway* "algebra")
             (or *narrative* *lesson-plan*))
    ;(printf "doing display-alternative-proglang\n")
    (let ([other-proglang-cased (if (string=? *proglang* "pyret") "WeScheme" "Pyret")])
      (display
        (enclose-span ".other-proglang"
          (format "link:~a~a[(Also available for ~a)]"
                  *dist-root-dir*
                  (cond [*narrative*
                          (let ([other-proglang (if (string=? *proglang* "pyret") "-wescheme" "")])
                            (format "courses/algebra~a/index.shtml" other-proglang))]
                        [*lesson-plan*
                          (let ([other-lesson (if (string=? *proglang* "pyret")
                                                  (format "~a-wescheme" *lesson-plan*)
                                                  (regexp-replace "-wescheme$" *lesson-plan* ""))])
                            (format "lessons/~a/index.shtml" other-lesson))])
                  other-proglang-cased)) o)
      (newline o)
      (newline o))))

(define (display-title i o out-file)
  (let* ((title (read-line i))
         (title-txt (string-trim (regexp-replace "^=+ *" title ""))))
    (set! *page-title* title-txt)
    (unless *other-dir*
      (let ([title-file (path-replace-extension out-file ".titletxt")]
            [title-txt (regexp-replace* #rx"," (regexp-replace* #rx"\\[.*?\\]##(.*?)##" title-txt "\\1") "\\&#x2c;")])
        (call-with-output-file title-file
          (lambda (o)
            (display title-txt o) (newline o))
          #:exists 'replace)))
    (fprintf o "[.~a]\n" *proglang*)
    (display #\= o)
    (display title o)
    (newline o)
    (newline o)
    (when *lesson-plan*
      ;(printf "containing-dir= ~s\n" *containing-directory*)
      (fprintf o "ifndef::frompathwayroot[:frompathwayroot: ]\n\n")
      (fprintf o "include::{frompathwayroot}~a/{cachedir}.index-sidebar.asc[]\n\n" *containing-directory*)
      ;(fprintf o "include::./.index-sidebar.asc[]\n\n")
      )
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
  (display desc o)
  (newline o))

(define (link-to-opt-projects o)
  ; (printf "doing link-to-opt-projects\n")
  (let ([lessons (read-data-file (build-path "courses" *target-pathway* "lesson-order.txt"))])
    (for ([lesson lessons])
      (let ([lesson-opt-links (read-data-file (format "lessons/~a/.cached/.index-opt-proj.rkt.kp" lesson) #:mode 'forms)])
        ; (printf "lesson-opt-links for ~s is ~s\n" lesson lesson-opt-links)
        (for ([x lesson-opt-links])
          (fprintf o "\n* [.OptProject]##{startsb}~a{endsb} {startsb}~a{endsb}##\n\n"
                   (regexp-replace "^link:" (car x) "link:../")
                   (regexp-replace "^link:" (cadr x) "link:../")))))))

(define (link-to-lessons-in-pathway o)
  ;(printf "link-to-lessons-in-pathway in ~s~n" (current-directory))
  ;
  (let ([lessons (read-data-file (build-path "courses" *target-pathway* "lesson-order.txt"))])
    ;(printf "lessons = ~s\n" lessons)
    ;
    ;(fprintf o "~n.Lessons Used in This Pathway\n")
    (print-lessons-intro o)
    ;(draw-dependency-diagram lessons o)
    (fprintf o "[#lesson-list]\n")
    (for ([lesson lessons])
      ;(printf "tackling lesson ~s\n" lesson)
      (let ([lesson-index-file (format "lessons/~a/index.shtml" lesson)]
            [lesson-title-file (format "lessons/~a/.cached/.index.titletxt" lesson)]
            [lesson-desc-file (format "lessons/~a/.cached/.index-desc.txt.kp" lesson)]
            [lesson-title lesson]
            [lesson-description #f])
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
        (when #t
          ;lesson-index-file (shtml) doesn't exist yet, but shd we at least check for index.adoc?
          (fprintf o "link:pass:[~a~a?pathway=~a][~a] ::" *dist-root-dir* lesson-index-file *pathway* lesson-title)
          (if lesson-description
              (display lesson-description o)
              (display " {nbsp}" o)))
        ;(when lesson-description
        ;(display lesson-description o)
        ;(newline o))
        (newline o)))
    (fprintf o "link:./.pathway-lessons.shtml[All the lessons] :: This is a single page that contains all the lessons listed above.\n")
    (print-menubar (build-path *containing-directory* ".cached" ".pathway-lessons-comment.txt"))
    (call-with-output-file (build-path *containing-directory* ".pathway-lessons.asciidoc")
      (lambda (lo)
        (fprintf lo "= Lessons Used in This Pathway\n\n")
        (fprintf lo ":frompathwayroot: ../../../\n\n")
        (fprintf lo "include::~a/.pathway-lessons-toc.asciidoc[]\n\n" *containing-directory*)
        (call-with-output-file (build-path *containing-directory* ".pathway-lessons-toc.asciidoc")
          (lambda (toco)
            (fprintf toco "[verse]\n")
            (call-with-output-file (build-path *containing-directory* ".cached" ".standards-in-pathway.txt.kp")
              (lambda (stco)
                (for ((lesson lessons))
                  ;(printf "tackling lesson i ~s\n" lesson)
                  (let ([lesson-asc-file
                          (format "lessons/~a/.cached/.index.asc" lesson)]
                        [lesson-glossary-file
                          (format "lessons/~a/.cached/.lesson-glossary.txt" lesson)]
                        [lesson-standards-file
                          (format "lessons/~a/.cached/.lesson-standards.txt.kp" lesson)]
                        [lesson-title-file
                          (format "lessons/~a/.cached/.index.titletxt" lesson)]
                        [lesson-title lesson]
                        )

                    (when (file-exists? lesson-title-file)
                      ;(printf "~a exists i\n" lesson-title-file)
                      (set! lesson-title (call-with-input-file lesson-title-file read-line)))

                    (when (file-exists? lesson-glossary-file)
                      ;(printf "~a exists i\n" lesson-glossary-file)
                      (call-with-input-file lesson-glossary-file
                        (lambda (i)
                          (let loop ()
                            (let ([x (read i)])
                              (unless (eof-object? x)
                                (let ([s (assoc-glossary x *glossary-list*)])
                                  (cond [s (unless (member s *glossary-items*)
                                             (set! *glossary-items*
                                               (cons s *glossary-items*)))]))
                                (loop)))))))
                    ;(printf "took care of pw glossary~n")

                    (when (file-exists? lesson-standards-file)
                      ;(printf "~a exists i\n" lesson-standards-file)
                      (call-with-input-file lesson-standards-file
                        (lambda (i)
                          (let loop ()
                            (let ([x (read i)])
                              (unless (eof-object? x)
                                (add-standard x lesson-title lesson #f lo)
                                (fprintf stco "(~s ~s ~s)~n" x lesson-title lesson)
                                (loop)))))))

                    ;(printf "took care of pw stds~n")

                    ;(unless (file-exists? lesson-asc-file)
                    ;  (printf "~s doesn't exist (yet?)\n" lesson-asc-file))

                    (when (file-exists? lesson-asc-file)
                      ;(printf "~a exists i\n" lesson-asc-file)
                      (fprintf lo "[[~a]]~n" lesson)
                      (fprintf toco "<<~a>>~n" lesson)
                      (fprintf lo "== ~a\n" lesson-title)
                      (fprintf lo "\ninclude::lessons/~a/.cached/.index.asc[leveloffset=+1,2..-1]~n~n"
                               lesson)))))
              #:exists 'replace))
          #:exists 'replace))
      #:exists 'replace)
    (newline o)))

(define (create-vspace ht)
  (let ([num (regexp-replace #rx"([0-9]*)ex" ht "\\1")])
    (when (string=? num ht) (set! num "10"))
    (set! num (inexact->exact (floor (string->number num))))
    (set! num (quotient num 4))
    (let ([reg-space (string-append
                       (create-begin-tag "span" ".vspace" #:attribs
                                         (format "style=\"height: ~a\"" ht))
                       (create-end-tag "span"))]
          [gd-space (let loop ([num num] [r ""])
                      (cond [(= num 0) r]
                            [else (loop (- num 1)
                                        (string-append r
                                          (create-begin-tag "span" ".gdrive-only")
                                          (create-begin-tag "p" "")
                                          "&#xa0;"
                                          (create-end-tag "p")
                                          (create-end-tag "span")))]))])
      (string-append reg-space gd-space))))

(define (add-lesson-keywords kwds)
  (for ([k kwds])
    (unless (member k *lesson-keywords*)
      (set! *lesson-keywords* (cons k *lesson-keywords*)))))

(define (add-lesson-prereqs immediate-prereqs)
  ;(printf "immediate prereqs = ~s\n" immediate-prereqs)
  ;(printf "lesson-prereq dir = ~s\n" (current-directory))
  (set! *lesson-prereqs* immediate-prereqs)
  (for ([lsn immediate-prereqs])
    (let ([lsn-prereq-file (build-path *containing-directory* 'up lsn ".cached" ".lesson-prereq.txt.kp")])
      ;(printf "lsn-prereq-file is ~s ~s\n" lsn-prereq-file (file-exists? lsn-prereq-file))
      (when (file-exists? lsn-prereq-file)
        (let ([pp (read-data-file lsn-prereq-file)])
          ;(printf "pp are ~s\n" pp)
          (for ([p pp])
            ;(printf "trying p = ~s\n" p)
            (unless (member p *lesson-prereqs*)
              ;(printf "adding p = ~s\n" p)
              (set! *lesson-prereqs* (cons p *lesson-prereqs*))))))))
  (let ([this-lsn-prereq-file (build-path *containing-directory* ".cached" ".lesson-prereq.txt.kp")])
    ;(printf "writing to prereq-file = ~s\n" this-lsn-prereq-file)
    (call-with-output-file this-lsn-prereq-file
      (lambda (o)
        (for ([p *lesson-prereqs*])
          (display p o) (newline o)))
      #:exists 'replace)))

(define (init-flags)
  (set! *autonumber-index* 1)
  (set! *glossary-items* '())
  (set! *missing-glossary-items* '())
  (set! *standards-met* '())
  (set! *dictionaries-represented* '())
  (set! *chapters-used* '())
  (set! *textbooks-represented* '())
  (set! *practices-merited* '())
  (set! *lesson-prereqs* '())
  (set! *online-exercise-links* '())
  (set! *opt-online-exercise-links* '())
  (set! *printable-exercise-links* '())
  (set! *opt-printable-exercise-links* '())
  (set! *starter-file-links* '())
  (set! *opt-starter-file-links* '())
  (set! *opt-project-links* '())
  (erase-span-stack!)
  )

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
                           #:workbook-page [workbook-page #f]
                           #:proglang [proglang "pyret"]
                           #:solutions-mode [solutions-mode #f]
                           #:z [z -1]
                           )

  (init-flags)

  (set! *containing-directory* containing-directory)
  (set! *dist-root-dir* dist-root-dir)
  (set! *lesson* lesson)
  (set! *lesson-plan* lesson-plan)
  (set! *narrative* narrative)
  (set! *other-dir* other-dir)
  (set! *proglang* proglang)
  (set! *solutions-mode?* solutions-mode)
  (set! *target-pathway* target-pathway)
  (set! *teacher-resources* resources)

  (set! *pyret?* (string=? *proglang* "pyret"))

  (when (and *lesson-plan* (not *lesson*))  ;fixme
    (set! *lesson* *lesson-plan*))

  (set! *lesson-plan-base* *lesson-plan*)
  (when *lesson-plan*
    (unless *pyret?*
      (let ([x (regexp-replace (format "-~a$" *proglang*) *lesson-plan* "")])
        (unless (string=? *lesson-plan* x)
          (set! *lesson-plan-base* x)))))

  ; (printf "lesson-plan= ~s; lesson-plan-base= ~s\n\n" *lesson-plan* *lesson-plan-base*)

  (with-handlers ([exn:fail? (lambda (e)
                               (printf "ERROR: ~a in ~s\n\n"
                                       (exn-message e) (errmessage-file-context)))])
    (set! *in-file* (build-path containing-directory in-file))
    ;(printf "doing preproc-adoc-file ~a\n" *in-file*)
    (let* ([dot-in-file (string-append "." in-file)]
           [out-file (build-path containing-directory ".cached" (path-replace-extension dot-in-file ".asc"))]
           [first-subsection-reached? #f]
           [title-reached? #f]
           )
      ;(printf "preproc ~a to ~a\n" *in-file* out-file)
      ;
      (when (or *link-lint?* #t)
        (let ([internal-links-file (path-replace-extension out-file ".internal-links.txt.kp")]
              [external-links-file (path-replace-extension out-file ".external-links.txt.kp")])
          (when (file-exists? internal-links-file) (delete-file internal-links-file))
          (when (file-exists? external-links-file) (delete-file external-links-file))
          ;(printf "*ternal links ports set up ~a, ~a\n" internal-links-file external-links-file)
          (set! *internal-links-port* (open-output-file internal-links-file))
          (set! *external-links-port* (open-output-file external-links-file))))
      ;
      ;
      (when *lesson-plan*

        (for ([x *lessons-and-standards*])
          (when (string=? (car x) *lesson-plan-base*)
            (for ([s (cdr x)])
              (add-standard s #f *lesson-plan* #f #f))))

        (for ([x *lessons-and-practices*])
          (when (string=? (car x) *lesson-plan-base*)
            (for ([s (cdr x)])
              (add-badge s))))

        ;(printf "lessons-and-textbooks = ~s\n\n" *lessons-and-textbooks*)
        ;(printf "textbooks-list = ~s\n\n" *textbooks-list*)

        (for ([x *lessons-and-textbooks*])
          (when (string=? (car x) *lesson-plan-base*)
            (for ([s (cdr x)])
              (add-textbook-chapter s))))

        ;(printf "textbooks-represented = ~s\n" *textbooks-represented*)
        ;(printf "chapters-used = ~s\n" *chapters-used*)

        )
      ;
      (when (or *lesson-plan*
                *narrative*
                *teacher-resources*)
        (print-menubar (build-path *containing-directory* ".cached" ".index-comment.txt")))
      ;
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
                           [(string=? directive "comment")
                            (let ([prose (read-group i directive)])
                              (if title-reached?
                                  (display-comment prose o)
                                  (display-header-comment prose o)
                                  ))]
                           [(string=? directive "scrub")
                            (read-group i directive)]
                           [(string=? directive "duration")
                            (let ([txt (read-group i directive)])
                              (display (string-append
                                         (create-begin-tag "span" ".duration")
                                         txt
                                         (create-end-tag "span")) o))]
                           [(string=? directive "vocab")
                            (let* ([arg (read-group i directive)]
                                   [s (assoc-glossary arg *glossary-list*)])
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
                           [(string=? directive "std")
                            (let ([args (read-commaed-group i directive)])
                              (printf "WARNING: Directive @std is obsolete\n\n")
                              )]
                           [(or (string=? directive "prereqs-stds")
                                (string=? directive "lesson-prereqs"))
                            (add-lesson-prereqs (read-commaed-group i directive))
                            ;(display-prereqs-bar o)
                            ;(display-standards-bar o)
                            ]
                           [(string=? directive "keywords")
                            (add-lesson-keywords (read-commaed-group i directive))]
                           [(string=? directive "proglang")
                            (fprintf o "~a" (string-titlecase *proglang*))]
                           [(string=? directive "year")
                            (fprintf o "~a" (getenv "YEAR"))]
                           [(string=? directive "season")
                            (fprintf o "~a" (string-titlecase (getenv "SEMESTER")))]
                           [(string=? directive "empty")
                            (read-group i directive)]
                           [(string=? directive "n")
                            (fprintf o "[.autonum]##~a##" *autonumber-index*)
                            (set! *autonumber-index* (+ *autonumber-index* 1))]
                           [(string=? directive "nfrom")
                            (let* ([arg (read-group i directive)]
                                   [n (string->number arg)])
                              (unless n
                                (printf "WARNING: @nfrom given non-number ~s\n\n" arg))
                              (set! *autonumber-index* n))]
                           [(string=? directive "image")
                            (let ([args (read-commaed-group i directive)])
                              (display (make-image (car args) (cdr args)) o))]
                           [(string=? directive "centered-image")
                            (let ([args (read-commaed-group i directive)])
                              (display (make-image (car args) (cdr args) #:centered? #t) o))]
                           [(string=? directive "math")
                            (display (enclose-math (read-group i directive)) o)]
                           [(or (string=? directive "printable-exercise")
                                (string=? directive "opt-printable-exercise")
                                )
                            ;(printf "doing ~s\n" directive)
                            (let* ([args (read-commaed-group i directive)]
                                   [n (length args)]
                                   [page (car args)]
                                   [link-text (if (> n 1) (cadr args) "")]
                                   [page-compts (regexp-split #rx"/" page)]
                                   [first-compt (car page-compts)])
                              ;
                              (display (dispatch-make-workbook-link page-compts link-text directive) o)
                              )]
                           [(or (string=? directive "link")
                                (string=? directive "online-exercise")
                                (string=? directive "opt-online-exercise")
                                (string=? directive "ext-exercise-link"))
                            (let* ([args (read-commaed-group i directive)]
                                   [adocf (car args)]
                                   [link-text (string-join
                                                (map string-trim (cdr args)) ", ")])
                              (set! link-text (string-trim link-text "\"")) ;XXX:
                              (display (make-link adocf link-text #:link-type directive) o))]
                           [(string=? directive "include")
                            (let* ([args (read-commaed-group i directive)]
                                   [adocf (car args)] ;only one right? FIXME:
                                   [rest-args (string-join
                                                (map string-trim (cdr args)) ",")]
                                   )
                              (display (make-link adocf rest-args #:include? #t) o))]
                           [(string=? directive "lang-prereq")
                            (unless *lesson-plan*
                              (error 'ERROR
                                     "WARNING: @lang-prereq (~a, ~a) valid only in lesson plan"
                                     *lesson-subdir* *in-file*))
                            (fprintf o "\ninclude::{frompathwayroot}~a/{cachedir}.index-lang-prereq.asc[]\n\n" *containing-directory*)]
                           [(string=? directive "add-to-lang")
                            ;(printf "doing add-to-lang\n")
                            (unless *lesson-plan*
                              (error 'ERROR
                                     "WARNING: @add-to-lang (~a, ~a) valid only in lesson plan"
                                     *lesson-subdir* *in-file*))
                            (let ([args (map string->symbol (read-commaed-group i directive))])
                              ;(printf "args = ~s\n" args)
                              (for-each add-prereq args))]
                           [(string=? directive "material-links")
                            (unless *lesson-plan*
                              (error 'ERROR
                                     "WARNING: @material-links (~a, ~a) valid only in lesson plan"
                                     *lesson-subdir* *in-file*))
                            (fprintf o "\ninclude::{frompathwayroot}~a/{cachedir}.index-extra-mat.asc[]\n\n"
                                     *containing-directory*)]
                           [(or (string=? directive "lesson-description")
                                (string=? directive "description"))
                            (display-lesson-description (read-group i directive)
                                                        (path-replace-extension out-file "-desc.txt.kp")
                                                        o)]
                           [(string=? directive "all-exercises")
                            (unless *teacher-resources*
                              (error 'ERROR
                                     "adoc-preproc: @all-exercises valid only in teacher resources"))
                            (display-exercise-collation o)]
                           [(string=? directive "solutions-workbook")
                            ;TODO: don't need this anymore -- link is autogen'd
                            (unless *teacher-resources*
                              (error 'ERROR
                                     "adoc-preproc: @solutions-workbook valid only in teacher resources"))
                            ;(fprintf o "link:./protected/pd-workbook.pdf[Teacher's PD Workbook]")
                            ;(newline o)
                            (fprintf o "link:./protected/workbook-sols.pdf[Workbook (w/Solutions)]")
                            ]
                           [(string=? directive "do")
                            (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                              (for-each massage-arg exprs))]
                           [(string=? directive "show")
                            (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                              (for ([s exprs])
                                (display (massage-arg s) o)))]
                           [(string=? directive "showsoln")
                            (let ([exprs (read-group i directive #:scheme? #t)])
                              (when *solutions-mode?*
                                (for ([s (string-to-form exprs)])
                                  (display (massage-arg s) o))))]
                           [(string=? directive "smath")
                            (let ([exprs (string-to-form (format "(sexp->math '~a)"
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
                           [(string=? directive "quad")
                            (let ([width (read-group i directive)])
                              (display
                                (string-append
                                  (create-begin-tag "span" ".quad" #:attribs
                                                    (format "style=\"width: ~a\"" width))
                                  (create-end-tag "span")) o))]
                           [(string=? directive "fitb")
                            (let ([width (read-group i directive)])
                              (if (string=? width "")
                                (display-begin-span
                                  ".fitb" o #:attribs "style=\"flex-grow: 1\"")
                                (display-begin-span
                                  ".fitb" o #:attribs (format "style=\"width: ~a\"" width))))]
                           [(string=? directive "fitbruby")
                            ;FIXME: text should be processed, see fitb above
                            (let* ([width (read-group i directive)]
                                   [text (read-group i directive)]
                                   [ruby (read-group i directive)])
                              (display
                                (string-append
                                  (create-begin-tag "span" ".fitbruby" #:attribs
                                                    (format "style=\"width: ~a\"" width))
                                  (string-append
                                    text
                                    (create-begin-tag "span" ".ruby")
                                    ruby
                                    (create-end-tag "span"))
                                  (create-end-tag "span")) o))]
                           [(string=? directive "ifproglang")
                            (let ([proglang (read-group i directive)])
                              (cond [(string-ci=? proglang *proglang*)
                                     (display-begin-span #f o)]
                                    [else
                                      (read-group i directive)
                                      (set! possible-beginning-of-line? (read-space i))]))]
                           [(string=? directive "ifsoln")
                            (cond [*solutions-mode?* (display-begin-span #f o)]
                                  [else (read-group i directive)
                                        (set! possible-beginning-of-line? (read-space i))])]
                           [(string=? directive "ifnotsoln")
                            (cond [(not *solutions-mode?*) (display-begin-span #f o)]
                                  [else (read-group i directive)
                                        (set! possible-beginning-of-line? (read-space i))])]
                           [(string=? directive "ifpathway")
                            ;(printf "doing ifpathway ~s\n" *pathway*)
                            (let ([pathways (read-commaed-group i directive)])
                              (cond [(member *pathway* pathways)
                                     (display-begin-span #f o)]
                                    [else
                                      (read-group i directive)
                                      (set! possible-beginning-of-line? (read-space i))]))]
                           [(string=? directive "funname")
                            (fprintf o "`~a`" (get-function-name))]
                           [(string=? directive "Bootstrap")
                            (fprintf o "https://www.bootstrapworld.org/[Bootstrap]")]
                           [(assoc directive *macro-list*)
                            => (lambda (s)
                                 (display (cadr s) o))]
                           [(or (string=? directive "assess-design-recipe")
                                (string=? directive "design-recipe-exercise"))
                            (let ([f (cond [(string=? directive "assess-design-recipe")
                                            assess-design-recipe]
                                           [(string=? directive "design-recipe-exercise")
                                            design-recipe-exercise]
                                           [else (error 'ERROR "preproc-adoc-file: deadc0de")])])
                              (let ([g (read-group i directive)])
                                (let ([args (string-to-form g)])
                                  (set! args (append args
                                                     (list '#:proglang *proglang*
                                                           '#:solutions-mode? *solutions-mode?*)))
                                  (let-values ([(key-list key-vals args)
                                                (rearrange-args args)])
                                    (let ([s (keyword-apply f key-list key-vals args)])
                                      (call-with-input-string s
                                        (lambda (i)
                                          (expand-directives i o)
                                          )))))))]
                           [(or (string=? directive "starter-file")
                                (string=? directive "opt-starter-file"))
                            (let* ([lbl (read-group i directive)]
                                   [c (assoc lbl *starter-files*)]
                                   [opt? (string=? directive "opt-starter-file")])
                              (cond [(not c)
                                     (printf "WARNING: ~a: Ill-named @~a ~a\n\n"
                                             (errmessage-context) directive lbl)]
                                    [else
                                      (let* ([title (cadr c)]
                                             [p (assoc *proglang* (cddr c))])
                                        (cond [(not p)
                                               (printf "WARNING: ~a: @~a  ~a missing for ~a\n\n"
                                                      directive lbl *proglang*)]
                                              [else
                                                (let* ([link-output (format "link:pass:[~a][~a~a]" (cadr p) title
                                                                            (if *lesson-plan* ", window=\"_blank\"" "")
                                                                            )]
                                                       [styled-link-output
                                                         (format "[~a.StarterFile]##~a##"
                                                                 (if opt? ".Optional" "")
                                                                 link-output)])
                                                  (cond [opt?
                                                          (unless (member styled-link-output *opt-starter-file-links*)
                                                            (set! *opt-starter-file-links*
                                                              (cons styled-link-output *opt-starter-file-links*)))]
                                                        [else
                                                          (unless (member styled-link-output *starter-file-links*)
                                                            (set! *starter-file-links*
                                                              (cons styled-link-output *starter-file-links*)))])
                                                  (display link-output o))]))]))]
                           [(string=? directive "opt-project")
                            (let* ([arg1 (read-commaed-group i directive)]
                                   [project-file (car arg1)]
                                   [rubric-file (if (> (length arg1) 1) (cadr arg1) "")]
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
                              (display project-link-output o))]
                           [else
                             ;(printf "WARNING: Unrecognized directive @~a\n\n" directive)
                             (display c o) (display directive o)
                             #f]))]
                  [(and possible-beginning-of-line? (char=? c #\|))
                   (set! beginning-of-line? #f) ;FIXME check if needed
                   (set! possible-beginning-of-line? #f)
                   (newline o)
                   (display c o)]
                  [(and beginning-of-line? (char=? c #\=))
                   (set! beginning-of-line? #f)
                   (set! possible-beginning-of-line? #f)
                   (cond [title-reached?
                           (cond [first-subsection-reached? #f]
                                 [(check-first-subsection i o)
                                  (set! first-subsection-reached? #t)
                                  (when *lesson-plan*
                                    (include-glossary o))]
                                 [else #f])
                           (cond [*lesson*
                                   (display-section-markup i o)]
                                 [else (display c o)])]
                         [else
                           (set! title-reached? #t)
                           (display-title i o out-file)
                           (display-alternative-proglang o)
                           (when *teacher-resources*
                             ; (printf "teacher resource autoloading stuff\n")
                             (newline o)
                             (fprintf o (create-workbook-links))
                             (link-to-opt-projects o)
                             ;(display-exercise-collation o)
                             )])]
                  [(char=? c #\newline)
                   (newline o)
                   (set! beginning-of-line? #t)
                   (set! possible-beginning-of-line? #f)]
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
      ;
      (call-with-input-file *in-file*
        (lambda (i)
          (call-with-output-file out-file
            (lambda (o)

              (cond [*lesson-plan* (display "[.LessonPlan]\n" o)]
                    [*narrative* (display "[.narrative]\n" o)]
                    )

              (expand-directives i o)

              ;(printf "call link-to-lessons-in-pathway?\n")
              (when *narrative*
                ;(printf "yes\n")
                (link-to-lessons-in-pathway o))

              (set! *dictionaries-represented*
                (sort *dictionaries-represented* string-ci<=?))

              (when (or *narrative* *lesson-plan*)
                (create-standards-subfile))

              (when *lesson-plan*
                (create-textbooks-subfile))

              (when *narrative*
                (print-other-resources-intro o)
                (print-link-to-glossary o)
                (print-link-to-standards o)
                (print-link-to-student-workbook o)
                (print-link-to-teacher-resources o)
                (print-link-to-forum o))

              (unless (truthy-getenv "OTHERDIR")
                (fprintf o "\n\n"))

              (unless (or (truthy-getenv "OTHERDIR") (truthy-getenv "NOCOLOPHON"))
                ;(fprintf o "\n\n")
                (fprintf o "[.acknowledgment]\n")
                (fprintf o "--\n")
                (fprintf o (create-acknowledgment))
                (fprintf o "link:https://www.creativecommons.org/licenses/by-nc-nd/4.0/[image:~alib/CCbadge.png[], window=\"_blank\"]\n" *dist-root-dir*)
                (fprintf o (create-copyright *copyright-name*))
                (fprintf o "\n--\n")
                )

              (when *lesson-plan*
                (call-with-output-file (build-path *containing-directory* ".cached" ".index-sidebar.asc")
                  (lambda (o)
                    (print-standards-js o #:sidebar #t)
                    (print-textbooks-js o)
                    (display-comment "%SIDEBARSECTION%" o)
                    (display-prereqs-bar o)
                    (display-standards-bar o)
                    (display-textbooks-bar o)
                    (display-practices-bar o)
                    (display-comment "%ENDSIDEBARSECTION%" o)
                    )
                  #:exists 'replace)

                )

              )

            #:exists 'replace)))
      ;

      (when (or *lesson-plan* *narrative*)
        ;no longer possible to append to pathway's file, as there
        ;is no pathway at this stage
        ;(add-exercises)
        (create-glossary-subfile))

      (when *lesson-plan*
        (accumulate-glossary-and-standards))

      ;(printf "pathwayrootdir = ~a\n" *pathway-root-dir*)
      ;(printf "lesson = ~a\n" *lesson*)
      ;(printf "lessonsubdir = ~a\n" *lesson-subdir*)

      (when (pair? *prereqs-used*)
        (let ([prim-file (if *lesson-plan*
                             (build-path *containing-directory* ".cached" ".index.primtxt")
                             (if (and *workbook-page?* *lesson*)
                                 (make-temporary-file ".pageprim-~a.primtxt" #f
                                                      (format "lessons/~a/.cached"
                                                              *lesson*)
                                                      )
                                 #f))])
          (when prim-file
            (store-functions-used *prereqs-used* prim-file))))

      (set! *prereqs-used* '())

      (when *lesson-plan*
        (let ([prev-prim-file (build-path *containing-directory* ".cached" ".prevlesson.primtxt")])
          (when (file-exists? prev-prim-file)
            (let ([prims (read-data-file prev-prim-file #:mode 'forms)])
              (when (pair? prims)
                (for ([prim prims])
                  (add-prereq prim))))))
        (create-lang-prereq-file *prereqs-used* *proglang* sym-to-adocstr out-file))

      (when *lesson-plan*
        (call-with-output-file (path-replace-extension out-file "-extra-mat.asc")
          (lambda (o)
            (let ([workbook-pages-ls-file
                    (format "lessons/~a/pages/.cached/.workbook-pages-ls.txt.kp"
                            *lesson*
                            )])
              (unless (file-exists? workbook-pages-ls-file)
                (error 'ERROR "File ~a not found" workbook-pages-ls-file))

            (for ([x (reverse *starter-file-links*)])
              (fprintf o "\n* ~a\n\n" x))

            (let* ([workbook-pages (read-data-file workbook-pages-ls-file #:mode 'files)]
                   [xx (sort *printable-exercise-links*
                             (lambda (x y)
                               (let ([x-i (index-of workbook-pages (car x))]
                                     [y-i (index-of workbook-pages (car y))])
                                 (cond [(and x-i y-i) (< x-i y-i)]
                                       [else #f]))))])
                (for ([x xx])
                  (fprintf o "\n* ~a\n\n" (cadr x)))))

            (for ([x (reverse *online-exercise-links*)])
              (fprintf o "\n* ~a\n\n" x))

            ; (printf "outputting opt project links ~s in extra-mat\n" *opt-project-links*)
            (let ([opt-proj-links (reverse *opt-project-links*)])
              (call-with-output-file (path-replace-extension out-file "-opt-proj.rkt.kp")
                (lambda (o)
                  (for ([link-pair opt-proj-links])
                    (write link-pair o)
                    (newline o)))
                #:exists 'replace)

              (for ([x opt-proj-links])
                (fprintf o "\n* [.OptProject]##{startsb}~a{endsb} {startsb}~a{endsb}##\n\n" (car x) (cadr x))))

            (for ([x (reverse *opt-starter-file-links*)])
              (fprintf o "\n* ~a\n\n" x))

            (for ([x (reverse *opt-printable-exercise-links*)])
              (fprintf o "\n* ~a\n\n" x))

            (for ([x (reverse *opt-online-exercise-links*)])
              (fprintf o "\n* ~a\n\n" x))

            )
          #:exists 'replace)

        (call-with-output-file (build-path *containing-directory* ".cached" ".lesson-keywords.txt.kp")
          (lambda (o)
            (let ([first? #t])
            (display "    keywords: [" o)
            (for ([k *lesson-keywords*])
              (cond [first? (set! first? #f)]
                    [else (display ", " o)])
              (write k o))
            (display "]," o) (newline o)))
          #:exists 'replace)
        )

      (when *internal-links-port* (close-output-port *internal-links-port*))
      (when *external-links-port* (close-output-port *external-links-port*))

      )))

(define (asciidoctor asc-file html-file)
  ;(printf "asciidoctor ~a with pathwayrootdir=~a\n" file *pathway-root-dir*)
  (system (format "~a -a pathwayrootdir=~a ~a -o ~a" *asciidoctor*
                  *pathway-root-dir* asc-file html-file))
  (void)
  )

(define (display-exercise-collation o)
  ;(printf "doing display-exercise-collation ~s\n" *pathway-exercises-file*)
  ;(printf "pwrd = ~s\n" *pathway-root-dir*)
  ;(printf "? = ~s\n" (file-exists? *pathway-exercises-file*))
  (let* ([all-lessons (read-data-file *pathway-lesson-order* #:mode 'files)]
         [lessons-with-exx (read-data-file *pathway-lessons-containing-exercises-file* #:mode 'forms)]
         [lessons (sort lessons-with-exx #:key car
                        (lambda (x y)
                          (< (index-of all-lessons x) (index-of all-lessons y))))]
         [exx (read-data-file *pathway-exercises-file* #:mode 'forms)])
    ;(printf "lessons= ~s\n\nexercises= ~s\n" lessons exx)
    (unless (null? exx)
      ;(printf "exercises found in ~s\n" *pathway-exercises-file*)
      (fprintf o "[.exercises_and_solutions,cols=\"1a,2a\"]\n")
      (fprintf o "|===\n")
      (for ([lsn lessons])
        (let* ([lsn-dir (car lsn)]
               [lsn-exx (filter (lambda (x) (string=? (car x) lsn-dir)) exx)])
          (fprintf o "|link:../~a/index.shtml[~a] |\n\n[cols=\"2a,1a\"]\n!===\n" lsn-dir (cadr lsn))
          (for ([ex lsn-exx])
            ;(printf "ex = ~s ~a\n" ex (length ex))
            (let* ([ti (list-ref ex 2)]
                   [exer (list-ref ex 1)]
                   [soln (regexp-replace "/pages/" exer "/solution-pages/")])
              (fprintf o "!~a ![ link:~a[exercise] : link:~a[solution] ]\n" ti exer soln)))
          (fprintf o "!===\n")))
      (fprintf o "|===\n\n"))))

(define (add-exercises)
  ;(printf "doing add-exercises\n")
  (when (and *force* (cons? *exercises-done*))
    ;(printf "doing add-exercises I\n")
    (set! *exercises-done* (reverse *exercises-done*))
    (call-with-output-file *pathway-exercises-file*
      (lambda (o)
        (for ([ex *exercises-done*])
          (fprintf o "~s\n" ex)))
      #:exists 'append)
    (call-with-output-file *pathway-lessons-containing-exercises-file*
      (lambda (o)
        (fprintf o "(\"lessons/~a\" ~s)\n" *lesson-plan* *page-title*))
      #:exists 'append)
    ))

(define (create-glossary-subfile)
  ;(printf "doing create-glossary-and-standards-subfiles ~a ~a ~a\n" *narrative*)
  (print-menubar (build-path *containing-directory* ".cached" ".pathway-glossary-comment.txt"))
  (call-with-output-file (build-path *containing-directory* ".cached" ".pathway-glossary.asc")
    (lambda (op)
      (unless (empty? *glossary-items*)
        (set! *glossary-items*
          (sort *glossary-items* #:key car string-ci<=?))
        (when *narrative*
          (fprintf op "= Glossary\n\n"))
        (when *lesson*
          (fprintf op ".Glossary\n\n"))
        (fprintf op "[.glossary]~%")
        (for ([s *glossary-items*])
          ;(fprintf op "* *~a*: ~a~%" (car s) (cadr s))
          (fprintf op "~a:: ~a~%" (car s) (cadr s)))
        (fprintf op "~%~%")))
    #:exists 'replace)

  (let ([missing-glossary-items-file "pathway-missing-glossary-items.rkt.kp"])
    (when (file-exists? missing-glossary-items-file)
      (delete-file missing-glossary-items-file))

    (unless (null? *missing-glossary-items*)
      (call-with-output-file missing-glossary-items-file
        (lambda (o)
          (display "(" o) (newline o)
          (for-each
            (lambda (g)
              (write g o) (newline o))
            (reverse *missing-glossary-items*))
          (display ")" o) (newline o)
          )
        #:exists 'replace)))

  )

(define (create-standards-section dict dict-standards-met op)
  (fprintf op "\n[.alignedStandards.standards-~a]\n" dict)
  (fprintf op (if *lesson*
                  ".~a Standards\n"
                  "== ~a Standards\n\n")
           (expand-dict-abbrev dict))
  (fprintf op "[.standards-hierarchical-table]~%")
  (for ([s dict-standards-met])
    ;(printf "s= ~s\n" s)
    (let ([sublist-items (unbox (list-ref s 1))]
          [s (list-ref s 2)]
          ;[dict (list-ref s 3)]
          [lessons (unbox (list-ref s 4))])
      (fprintf op "~a:: " (car s))
      (fprintf op "~a\n" (cadr s))
      (unless *lesson*
        (when (> (length lessons) 0)
          (fprintf op "{startsb}See: ~a.{endsb}\n"
                   (string-join
                     (map
                       (lambda (x)
                         (let ([ltitle (list-ref x 0)]
                               [lesson (list-ref x 1)]
                               [pwy (list-ref x 2)])
                           (cond [pwy
                                   (cond [(string=? pwy "algebra-pyret")
                                          (set! ltitle (string-append ltitle "^(Pyret)^"))]
                                         [(string=? pwy "algebra-wescheme")
                                          (set! ltitle (string-append ltitle "^(WeScheme)^"))])
                                   (format " link:courses/pass:[~a]/lessons/pass:[~a]/index.shtml[~a]"
                                           pwy lesson ltitle)]
                                 [else
                                   (format " link:./lessons/pass:[~a]/index.shtml[~a]"
                                           lesson ltitle)])))
                       lessons) ";"))))
      (for ([n sublist-items])
        (fprintf op "** ~a~%" (list-ref s (+ n 1)))
        )))
  (fprintf op "\n\n"))

(define (display-standards-selection o *narrative* *dictionaries-represented*)
  ;(printf "doing display-standards-selection ~a\n" *narrative*)
  (let ([narrative? *narrative*])
    (when narrative? (fprintf o "= Standards\n\n"))
    (when narrative? (print-standards-js o))
    (when narrative? (display (create-begin-tag "div" ".standard-menu-container") o))
    (cond [narrative?
            (display
              (enclose-div ""
                (string-append
                  "\nBootstrap lessons align with several important teaching standards.\n"
                  "Select particular standards from the following menu to see\n"
                  "which lessons meet those standards.\n"))
              o)]
          [else #f ;(display ".Relevant Standards\n" o)
                ])
    (when narrative? (display (create-begin-tag "div" "") o))
    (display (enclose-tag "select" ".standardsAlignmentSelect"
               #:attribs
               ;(format " multiple onchange=\"showStandardsAlignment()\" style=\"height: ~apx\"" 75)
               " onchange=\"showStandardsAlignment()\""
               (string-append
                 (if (null? *dictionaries-represented*) ""
                     (let ([first-dict (car *dictionaries-represented*)])
                       (enclose-tag "option" ""
                         #:attribs (format "selected=\"selected\" value=\"standards-~a\"" first-dict)
                         first-dict)))
                 (string-join
                   (map (lambda (dict)
                          (enclose-tag "option" ""
                            #:attribs (format "value=\"standards-~a\"" dict)
                            dict))
                        (if (null? *dictionaries-represented*) '()
                            (cdr *dictionaries-represented*)))
                   "")))
             o)
    (newline o)
    (when narrative?
      (display (create-end-tag "div") o)
      (display (create-end-tag "div") o))
    ;(display "\n\n" o)
    ))

(define (display-textbooks-selection o *textbooks-represented*)
  (display (enclose-tag "select" ".textbooksAlignmentSelect"
             #:attribs
             ;(format " multiple onchange=\"showTextbooksAlignment()\" style=\"height: ~apx\"" 75)
             " onchange=\"showTextbooksAlignment()\""
             (string-append
               (if (null? *textbooks-represented*) ""
                   (let ([first-textbook (car *textbooks-represented*)])
                     (enclose-tag "option" ""
                       #:attribs (format "selected=\"selected\" value=\"textbook-~a\""
                                         (regexp-replace "\\." first-textbook "_"))
                       first-textbook)))
               (string-join
                 (map (lambda (textbook-label)
                        (enclose-tag "option" ""
                          #:attribs (format "value=\"textbook-~a\""
                                            (regexp-replace* "\\." textbook-label "_"))
                          textbook-label))
                      (if (null? *textbooks-represented*) '()
                          (cdr *textbooks-represented*)))
                 "")))
           o)
  (newline o))

(define (create-textbooks-subfile)
  (let ([subf (build-path *containing-directory* ".cached" ".index-textbooks.asc")])
    (call-with-output-file subf
      (lambda (o)
        (unless (empty? *chapters-used*)
          (for ([textbook-label *textbooks-represented*])
            ;(printf "doing textbook-label= ~s\n" textbook-label)
            (let ([textbook-chapters-used
                    (filter (lambda (s) (string=? (list-ref s 2) textbook-label))
                            *chapters-used*)])
              (unless (empty? textbook-chapters-used)
                (fprintf o "\n[.alignedTextbooks.textbook-~a]\n"
                         (regexp-replace* "\\." textbook-label "_"))
                (fprintf o ".~a\n" textbook-label)
                ;FIXME: class name should be more general, not refer to "standards"
                (fprintf o "[.standards-hierarchical-table]\n")
                (for ([s textbook-chapters-used])
                  (fprintf o "~a:: " (list-ref s 0))
                  (fprintf o "~a\n" (list-ref s 1)))))))
        )
      #:exists 'replace)))

(define (create-standards-file file *narrative* *lesson*)
  ;(printf "create-standards-file ~s ~s ~s \n" file *narrative* *lesson*)
  ;(printf "standards-met= ~s\n\n\n" *standards-met*)
  ;(printf "dictionaries-represented= ~s\n" *dictionaries-represented*)
  (when *narrative*
    (print-menubar (string-append file "-comment.txt")))
  (call-with-output-file (string-append file ".asc")
    (lambda (op)
      (unless (empty? *standards-met*)
        (when *narrative*
          (display-standards-selection op *narrative* *dictionaries-represented*))
        (for ((dict *dictionaries-represented*))
          (let ([dict-standards-met
                  (filter (lambda (s) (string=? (list-ref s 3) dict))
                          *standards-met*)])
            (unless (empty? dict-standards-met) ;it will never be empty!
              (create-standards-section
                dict
                (sort dict-standards-met #:key car string-ci<=?) op))))))
    #:exists 'replace))

(define (create-standards-subfile)
  ;(printf "doing create-standards-subfile\n")
  (create-standards-file
    (format "~a/.cached/.pathway-standards" *containing-directory*)
    *narrative* *lesson*))

(define (accumulate-glossary-and-standards)
  ;(printf "doing accumulate-glossary-and-standards\n")
  (call-with-output-file (build-path *containing-directory* ".cached" ".lesson-glossary.txt")
    (lambda (op)
      (for ([s *glossary-items*])
        (fprintf op "~s~n" (car s))))
    #:exists 'replace)
  (call-with-output-file (build-path *containing-directory* ".cached" ".lesson-standards.txt.kp")
    (lambda (op)
      (call-with-output-file (build-path *containing-directory* ".cached" ".lesson-standards-w-prose.txt.kp")
        (lambda (op2)
          (let ([first? #t])
            (display "    standards: [" op2)
            (for ([s *standards-met*])
              (fprintf op "~s~n" (car s))
              (let ([x (caddr s)])
                (cond [first? (set! first? #f)]
                      [else (display ",\n                " op2)])
                (write (string-append (car x) " : " (cadr x)) op2))
              )
            (display "]" op2) (newline op2)
            ))
        #:exists 'replace))
    #:exists 'replace)
  )

;coe

(define (hspace n)
  (enclose-span ".hspace"
                (string-join (build-list n (lambda (i) "{nbsp}")) "")))

(define (intersperse-spaces args funargs?)
  (define (intersperse-spaces-aux args)
    (if (null? args) args
        (let ([a (car args)] [d (cdr args)])
          (if (null? d) (list a)
              (cons a
                    (cons (hspace 1)
                          (intersperse-spaces-aux d)))))))
  (let ([ans (intersperse-spaces-aux args)])
    (apply string-append
           (if (and funargs? (not (null? args)))
               (cons (hspace 1) ans)
               ans))))

(define (sexp->coe e)
  ;(printf "sexp->coe ~s\n" e)
  (string-append
    ;enclosing following in span .gdrive-only doesn't seem to work
    (sexp->block-table e #:pyret (string=? *proglang* "pyret"))
    ;
    (enclose-span ".begin-ignore-for-gdrive" "")
    (enclose-div ".circleevalsexp"
      (sexp->block e #:pyret (string=? *proglang* "pyret")))
    (enclose-span ".end-ignore-for-gdrive" "")))

(define *hole-symbol* '++_______++)
(define *hole2-symbol* '++____________________++)
(define *hole3-symbol* *hole2-symbol*)

(define *list-of-hole-symbols*
  (list *hole-symbol* *hole2-symbol* *hole3-symbol*))

(define (answer? e)
  (and (list? e) (memq (car e) '(?ANSWER ?ANS))))

(define *common-infix-ops*
 '(+ - * / and or < > = <= >= <> frac
     string=? string<? string<=? string>? string>=? string<>?))

(define *pyret-infix-ops*
  (append *common-infix-ops*))

(define *arith-infix-ops*
  (append *common-infix-ops* '(expt)))

(define (infix-op? e #:pyret [pyret #f])
  (cond ((not (list? e)) (memq e (if pyret *pyret-infix-ops* *arith-infix-ops*)))
        ((memq (car e) '(?ANSWER ?ANS))
         (let ((a (cadr e)))
           (memq a (if pyret *pyret-infix-ops* *arith-infix-ops*))))
        (else #f)))

(define (answer->hole e)
  (let ((n (string-length (format "~a" e))))
    (cond ((< n 3) 'BSLeaveAHoleHere)
          ((< n 10) 'BSLeaveAHoleHere2)
          (else 'BSLeaveAHoleHere3))))

(define (answer-fill-length e)
  (let ([n (string-length (format "~a" e))])
    (cond [(< n 3) ".studentAnswerShort"]
          [(< n 10) ".studentAnswerMedium"]
          [else ".studentAnswerLong"])))

(define answer-block-fill-length answer-fill-length)

(define (infix-sexp->math a e #:wrap [wrap #t] #:encloser [encloser #f]
                          #:parens [parens #f] #:first [first #f])
  ;(printf "doing infix-sexp->math ~s ~s w:~s e:~s p:~s f:~s\n" a e wrap encloser parens first)
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
               [e1 (if (>= n 1) (car e) #f)]
               [rest-e (if (>= n 1) (cdr e) '())]
               [arg1 (and e1
                         (sexp->arith e1 #:pyret #f #:wrap #t
                                      #:encloser a #:parens parens #:first #t #:tex #t))]
               [args (map (lambda (e1) (sexp->arith e1 #:pyret #f #:wrap #t
                                                    #:encloser a #:parens parens #:tex #t)) rest-e)]
               [args (if e1 (cons arg1 args) args)]
               [x (string-join args (format " ~a " am))])
          (let ([ans (if (and wrap (or (not encloser)
                                       parens
                                       (and (eq? encloser '+)
                                            (if first
                                                (not (memq a '(+ - * / frac expt)))
                                                (not (memq a '(* / frac expt)))))
                                       (and (eq? encloser '-)
                                            (if first
                                                (not (memq a '(+ - * / frac expt)))
                                                (not (memq a '(* / frac expt)))))
                                       (and (eq? encloser '*) (not (memq a '(* / frac expt))))))
                         (format "( ~a )" x)
                         x)])
            ;(printf "infix ret'd ~s\n" ans)
            ans)))))

(define (sexp->arith e #:pyret [pyret #f] #:wrap [wrap #f]
                     #:encloser [encloser #f] #:parens [parens #f] #:first [first #f] #:tex [tex #f])
  ;(printf "doing sexp->arith ~s l:~s w:~s e:~s p:~s\n" e pyret wrap encloser parens)
  (cond [(member e '(true false)) (let ([x (format "~a" e)])
                                    (if pyret x (enclose-span ".value.wescheme-boolean" x)))]
        [(number? e) (let ([x (format "~a" e)])
                       (if pyret x (enclose-span ".value.wescheme-number" x)))]
        [(and (symbol? e) pyret
              (memq e '(BSLeaveAHoleHere BSLeaveAHoleHere2 BSLeaveAHoleHere3)))
         (enclose-span ".studentAnswer" (format "~a" e))] ;CHECK
        [(symbol? e) (let ([x (sym-to-adocstr e #:pyret pyret #:tex tex)])
                       (if pyret x (enclose-span ".value.wescheme-symbol" x)))]
        [(string? e) (let ([x (format "~s" e)])
                       (if pyret x (enclose-span ".value.wescheme-string" x)))]
        [(answer? e) (let* ([e (cadr e)]
                            [fill-len (answer-fill-length e)])
                       ;(printf "answer frag found: ~s\n" e)
                       (if *solutions-mode?*
                           (enclose-span (format ".studentAnswerFilled~a" fill-len)
                             (sexp->arith e #:pyret pyret #:wrap wrap #:parens parens))
                           (enclose-span (format ".studentAnswerUnfilled~a" fill-len)
                             "{nbsp}"
                             ;(symbol->string *hole-symbol*)
                             )))]
        [(list? e) (let ([a (car e)])
                     (cond [(and pyret (or (memq a *list-of-hole-symbols*) ;XXX:
                                           (infix-op? a #:pyret #t)
                                           ))
                            (let* ([a (sexp->arith a #:pyret #t)]
                                   [lft (sexp->arith (list-ref e 1) #:pyret #t #:wrap #t
                                                     #:parens parens)]
                                   [rt (sexp->arith (list-ref e 2) #:pyret #t #:wrap #t
                                                    #:parens parens)]
                                   [x (format "~a ~a ~a" lft a rt)])
                              (if (or wrap parens) (format "({zwsp}~a{zwsp})" x) x)) ]
                           [(and (not pyret) (or (memq a *list-of-hole-symbols*) ;XXX:
                                                 (infix-op? a #:pyret #f)
                                                 ))
                            (infix-sexp->math a (cdr e) #:wrap wrap #:encloser encloser
                                              #:parens parens #:first first)]
                           [(and (eq? a 'define) (= (length e) 3) pyret)
                            (let* ([lhs (list-ref e 1)]
                                   [rhs (list-ref e 2)]
                                   [lhs-c (sexp->arith lhs #:pyret #t)]
                                   [rhs-c (sexp->arith rhs #:pyret #t)])
                              (cond [(cons? lhs)
                                     (format "fun ~a: ~a end" lhs-c rhs-c)]
                                    [else
                                      (format "~a = ~a" lhs-c rhs-c)]))]
                           [(and (eq? a 'list) pyret)
                            (let* ([args (cdr e)]
                                   [args-c (map (lambda (x) (sexp->arith x #:pyret #t)) args)])
                              (format "[list: ~a]" (string-join args-c ", ")))]
                           [(and (eq? a 'sqrt) (= (length e) 2) (not pyret))
                            (format "\\sqrt{ ~a }" (sexp->arith (cadr e) #:parens parens))]
                           [(and (eq? a 'sqr) (= (length e) 2) (not pyret))
                            (let* ([x (cadr e)]
                                   [xm (sexp->arith x #:parens parens)])
                              (format
                                (if (list? x)
                                    " { ( ~a ) }^ 2 "
                                    " { ~a }^ 2 ") xm))]
                           [else
                             (format (if pyret "~a{zwsp}({zwsp}~a{zwsp})" "~a(~a)")
                                     (sexp->arith a #:pyret pyret #:parens parens)
                                     (string-join
                                       (map (lambda (e1)
                                              (sexp->arith e1 #:pyret pyret #:parens parens))
                                            (cdr e))
                                       ", "))]
                           ))]
        [else (error 'ERROR "sexp->arith: unknown s-exp ~s" e)]))

(define (add-prereq sym)
  ;(printf "doing add-prereq ~s\n" sym)
  (when (and (or *lesson-plan* *workbook-page?*) (symbol? sym))
    ;use conditional here if you want to exclude some symbols
    (unless (member sym *prereqs-used*)
      (set! *prereqs-used* (cons sym *prereqs-used*)))))

(define holes-to-underscores
  (let* ([hole *hole-symbol*]
         [hole2 *hole2-symbol*]
         [hole3 hole2])
    (lambda (e #:wescheme [wescheme #f])
      ;(printf "doing holes-to-underscores ~s\n" e)
      (cond [(or (null? e) (number? e) (string? e)) e]
            [(eq? e 'BSLeaveAHoleHere) hole] ;XXX: used anymore?
            [(eq? e 'BSLeaveAHoleHere2) hole2]
            [(eq? e 'BSLeaveAHoleHere3) hole3]
            [(and (eq? e 'frac) wescheme)
             (add-prereq '/)
             '/]
            [(pair? e) (cons (holes-to-underscores (car e) #:wescheme wescheme)
                             (holes-to-underscores (cdr e) #:wescheme wescheme))]
            [else
              (add-prereq e)
              e]))))

(define (sexp->wescheme e)
  ; (printf "doing sexp->wescheme ~s\n" e)
  (let ([h (holes-to-underscores e #:wescheme #t)])
    ;(printf "h2u retn'd ~s\n" h)
    (enclose-textarea-2 ".racket" (sexp->block h #:wescheme #t))))

(define (sexp->pyret e #:parens [parens #f])
  ; (printf "\ndoing sexp->pyret ~s\n" e)
  (let ([h (holes-to-underscores e)])
    ;(printf "h2u retn'd ~s\n" h)
    (enclose-textarea-2 ".pyret" (sexp->arith h #:pyret #t #:parens parens))))

(define (sexp->math e #:parens [parens #f])
  ;(printf "doing sexp->math ~s p:~s\n" e parens)
  (enclose-math (sexp->arith e #:parens parens #:tex #t)))

(define (sexp->code e #:parens [parens #f])
  (if (string=? *proglang* "pyret")
      (sexp->pyret e #:parens parens)
      (sexp->wescheme e)))

(define (sym-to-adocstr e #:pyret [pyret #f] #:tex [tex #f])
  ;(printf "sym-to-adocstr ~s p:~a t:~a\n" e pyret tex)
  (cond [pyret (cond [(eq? e '+) "{plus}"]
                     [(eq? e '=) "=="]
                     [(eq? e 'expt) "num-expt"]
                     [(eq? e 'frac) "/"]
                     [(eq? e 'pi) "num-pi"]
                     [(eq? e 'sqr) "num-sqr"]
                     [(eq? e 'sqrt) "num-sqrt"]
                     [(eq? e 'random) "num-random"]
                     [(eq? e 'string-contains?) "string-contains"]
                     [(eq? e 'string=?) "=="]
                     [(eq? e 'string<?) "<"]
                     [(eq? e 'string<=?) "\\<="]
                     [(eq? e 'string>?) ">"]
                     [(eq? e 'string>=?) ">="]
                     [(eq? e 'string<>?) "<>"]
                     [(memq e '(* -)) (format "{empty}~a" e)]
                     [else (let ([es (format "~a" e)])
                               (cond [(regexp-match #rx"\\?$" es)
                                      (regexp-replace #rx"(.*)\\?$" es "is-\\1")]
                                     [(regexp-match #rx"([a-z])/([a-z])" es)
                                      (regexp-replace #rx"([a-z])/([a-z])" es "\\1-\\2")]
                                     [else es]))])]
        [(not tex) (cond [(eq? e '<=) "\\<="]
                         [(eq? e '+) "{plus}"]
                         [(eq? e 'frac) "/"]
                         [(memq e '(* -)) (format "{empty}~a" e)]
                         [else (format "~a" e)])]
        [else (cond [(eq? e '<=) " \\le "]
                    [(eq? e 'pi) " \\pi "]
                    [else
                      (format "~a" e)])]))

(define (sexp->block-table e #:pyret [pyret #f])
  ;(printf "doing sexp->block-table ~s ~a\n" e pyret)
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
        [(answer? e) (let* ([e (cadr e)]
                            [fill-len (answer-block-fill-length e)])
                       (if *solutions-mode?*
                           (enclose-span (format ".studentBlockAnswerFilled~a" fill-len)
                           (sexp->block-table e #:pyret pyret))
                           (enclose-span (format ".value~a.studentBlockAnswerUnfilled~a"
                                                 (if pyret "" ".wescheme-symbol")
                                                 fill-len)
                             "{nbsp}{nbsp}{nbsp}")))]
        [(list? e) (let ([a (car e)])
                     (enclose-tag "table" ".gdrive-only.expression"
                       (if (or (symbol? a) (infix-op? a))
                           (let ([args (map (lambda (e1)
                                                (sexp->block-table e1 #:pyret pyret))
                                              (cdr e))])
                             (string-append
                               (enclose-tag "tr" ""
                                 (enclose-tag "td" ".operator"
                                   (enclose-span ".operator" (sexp->block-table a #:pyret pyret))))
                                 (enclose-tag "tr" ""
                                   (enclose-tag "td" ""
                                     (enclose-tag "table" ".args"
                                       (enclose-tag "tr" ""
                                         (apply string-append
                                                (map (lambda (arg)
                                                       (enclose-tag "td" ".arg" arg))
                                                     args))))))))
                           ;is this else ever used in our docs? (Not really args)
                           (let ([args (map (lambda (e1)
                                                 (sexp->block-table e1 #:pyret pyret))
                                               e)])
                             (enclose-tag "tr" ""
                               (enclose-tag "td" ""
                                 (enclose-tag "table" ".args"
                                   (enclose-tag "tr" ""
                                     (apply string-append
                                            (map (lambda (arg)
                                                   (enclose-tag "td" "" arg))
                                                 args)))))))
                             )))]
        [else (error 'ERROR "sexp->block-table: unknown s-exp")]))

(define (sexp->block e #:pyret [pyret #f] #:wescheme [wescheme #f])
  ;(printf "doing sexp->block ~s ~a\n" e pyret)
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
        [(answer? e) (let* ([e (cadr e)]
                            [fill-len (answer-block-fill-length e)])
                       (if *solutions-mode?*
                           (enclose-span
                             (if wescheme
                                 (format ".studentAnswerFilled~a" fill-len)
                                 (format ".studentBlockAnswerFilled~a" fill-len))
                             (sexp->block e #:pyret pyret #:wescheme wescheme))
                           (enclose-span
                             (if wescheme
                                 (format ".value.wescheme-symbol.studentAnswerUnfilled~a" fill-len)
                                 (format ".value.studentBlockAnswerUnfilled~a" fill-len))
                             "{nbsp}{nbsp}{nbsp}")))]
        [(list? e) (let ([a (car e)])
                     (enclose-span ".expression"
                       (if (or (symbol? a) (answer? a))
                           (let ([args (intersperse-spaces
                                         (map (lambda (e1)
                                                (sexp->block e1 #:pyret pyret #:wescheme wescheme))
                                              (cdr e)) 'args)])
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
                               (enclose-span ".rParen" ")"))))))]
        [else (error 'ERROR "sexp->block: unknown s-exp")]))

(define (sexp exp #:form [form "circofeval"])
  (when (string? exp)
    (set! exp (with-input-from-string exp read)))
  (cond [(string=? form "circofeval")
         (sexp->coe exp)]
        [(member form (list "code" "text"))
                 (sexp->block exp #:pyret (string=? *proglang* "pyret"))]
        [else (sexp->block exp #:pyret (string=? *proglang* "pyret"))]))

(define (code x #:multi-line [multi-line #t]) ;TODO or #f?
  ;(printf "doing code ~s\n" x)
  (let ([pyret? (string=? *proglang* "pyret")])
    (unless (string? x)
      (set! x ((if pyret? wescheme->pyret wescheme->wescheme) x #:indent 0)))
    (enclose-textarea #:multi-line multi-line
      (if pyret? ".pyret" ".racket")
      (if pyret? (regexp-replace* " :: " x " :{empty}: ")
          x))))

(define (contract funname domain-list range [purpose #f] #:single? [single? #t])
  ;(printf "doing contract ~s ~s ~s ~s ~s\n" funname domain-list range purpose single?)
  (let ([funname-sym (if (symbol? funname) funname (string->symbol funname))])
    (add-prereq funname-sym)
    (let ([s (string-append
              ;(if single? "```\n" "")
              (if *pyret?* "# " "; ")
              (if *pyret?* (wescheme->pyret funname-sym) funname)
              " "
              ; used to be single colon for WeScheme
              "{two-colons}"
              " "
              ; used to not have commas in WeScheme
              (vars-to-commaed-string domain-list)
              " -> "
              range
              (if purpose
                  (string-append "\n"
                    (if *pyret?* "# " "; ")
                    purpose)
                  "")
              ;(if single? "\n```\n" "")
              )])
      (if single?
          (enclose-textarea (if *pyret?* ".pyret" ".racket") s #:multi-line #t)
          s))))

(define (contracts . args)
  (let ([res ""])
    (let loop ([args args])
      (unless (null? args)
        (set! res (string-append res "\n"
                    (keyword-apply contract '(#:single?) '(#f)
                                   (car args))))
        (loop (cdr args))))
    (enclose-textarea (if *pyret?* ".pyret" ".racket") res #:multi-line #t)))
