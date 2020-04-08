":"; exec racket -f $0 -m -- "$@"

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
(require "lessons-and-standards.rkt")
;(require "draw-dep-diag.rkt")

(define *proglang* (string-downcase (getenv "PROGLANG")))

(define *solutions-mode?* (truthy-getenv "SOLUTION"))

(define *link-lint?* (truthy-getenv "LINT"))

(define *internal-links-port* #f)
(define *external-links-port* #f)

(define *base-namespace* (current-namespace))

(define *pathway-root-dir* (getenv "PATHWAYROOTDIR"))

(define *pathway-exercises-file*
  (string-append *pathway-root-dir* "resources/workbook-exercises.txt"))

(define *workbook-pagenums*
  (if (truthy-getenv "LESSONPLAN")
      (let ([f (string-append *pathway-root-dir* "workbook-pagenum-index.rkt.kp")])
        (if (file-exists? f)
            (call-with-input-file f read)
            '()))
      '()))

;(printf "*workbook-pagenums* = ~s\n" *workbook-pagenums*)

(define *external-url-index*
  (let ([f (string-append *pathway-root-dir* "external-index.rkt")])
    (if (file-exists? f)
        (call-with-input-file f read)
        '())))

;default values
(define *copyright-name* "Bootstrap:Cosmology")
(define *copyright-author* "Jack Kepler, Ike Newton, and Al Einstein")

(define *copyright-info-file* (string-append *pathway-root-dir* "copyright-info.rkt"))

(define *copyright-info*
  (if (file-exists? *copyright-info-file*)
      (call-with-input-file *copyright-info-file* read)
      '()))

(cond ((assoc "name" *copyright-info*) =>
       (lambda (c) (set! *copyright-name* (cadr c)))))

(cond ((assoc "author" *copyright-info*) =>
       (lambda (c) (set! *copyright-author* (cadr c)))))

(define *glossary-items* '())

(define *missing-glossary-items* '())

(define *standards-met* '())

(define *dictionaries-represented* '())

(define *exercises-done* '())

(define (read-word i)
  (let loop ([r '()])
    (let ([c (peek-char i)])
      (if (or (char-alphabetic? c) (char=? c #\-))
          (loop (cons (read-char i) r))
          (if (null? r) ""
              (list->string (reverse r)))))))

(define (quote-rev-string s)
  (let ([n (string-length s)])
    (let loop ([i 0] [r (list #\")])
      (if (>= i n) (cons #\" r)
          (let ([c (string-ref s i)])
            (cond [(char=? c #\") (loop (+ i 1) (cons c (cons #\\ r)))]
                  [else (loop (+ i 1) (cons c r))]))))))

(define (read-group i directive #:scheme? [scheme? #f])
  (let ([c (peek-char i)])
    (cond [(char=? c #\{)
           (read-char i)
           (let loop ([r '()]
                      [in-space? #t]
                      [nesting 0]
                      [in-string? #f]
                      [in-escape? #f])
             (let ([c (read-char i)])
               (cond [(eof-object? c)
                         (error 'ERROR "read-group: Runaway directive ~a" directive)]
                     [in-escape? (loop (cons c r) #f nesting in-string? #f)]
                     [(char=? c #\\)
                      (loop (cons c r) #f nesting in-string? #t)]
                     [in-string?
                       (if (char=? c #\")
                           (loop (cons c r) #f nesting #f #f)
                           (loop (cons c r) #f nesting #t #f))]
                     [(and scheme? (char=? c #\@))
                      (let* ([directive (read-word i)]
                             [gp (read-group i directive #:scheme? #t)])
                        ;(printf "dir=~a gp= ~s\n" directive gp)
                        (when (string=? directive "code")
                          (set! gp (code gp)))
                        ;(printf "dir=~a gp'= ~s\n" directive gp)
                        (loop (append (quote-rev-string gp) r)
                              #f nesting #f #f))]
                     [(char=? c #\")
                      (loop (cons c r) #f nesting #t #f)]
                     [(member c '(#\space #\tab #\newline #\return))
                      (if scheme?
                          (loop (cons c r) #f nesting #f #f)
                          (loop (if in-space? r (cons #\space r)) #t nesting #f #f))]
                     [(char=? c #\{)
                      (loop (cons c r) #f (+ nesting 1) #f #f)]
                     [(char=? c #\})
                      (if (= nesting 0)
                          (string-trim (list->string (reverse r)))
                          (loop (cons c r) #f (- nesting 1) #f #f))]
                     [else (loop (cons c r) #f nesting #f #f)])))]
          [else
            (printf "WARNING: Ill-formed metadata directive @~a\n" directive)
            ""])))

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
                         (error 'ERROR "read-commaed-group: Runaway directive ~a" directive)]
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
  (let* ([std-bits (regexp-split #rx"&" std)] ;XXX This is probly obsolete now
         [std (list-ref std-bits 0)]
         [sublist-item #f]
         [c #f]
         [dict #f])
    (for ([x *standards-list*])
      (unless c
        (let ([stds-list (caddr x)])
          (set! c (assoc std stds-list))
          (when c (set! dict (car x))))))
    (when (>= (length std-bits) 3)
      (set! sublist-item (string->number (list-ref std-bits 2))))
    (values sublist-item c dict)))

(define (add-standard x lesson lesson-title o)
  ;(printf "doing add-standard ~a ~a ~a\n" x lesson lesson-title)
  (let-values ([(sublist-item c dict) (assoc-standards x)])
    (cond [c (let ([std (list-ref c 0)])
               (when (and o (truthy-getenv "LESSON"))
                 (fprintf o "**~a**: ~a~n~n"
                          std (list-ref c 1)))
               (cond [(assoc std *standards-met*) =>
                                                (lambda (c0)
                                                  (when sublist-item
                                                    (let ([sublist-items (list-ref c0 1)])
                                                      (box-add-new! sublist-item sublist-items)))
                                                  (unless (truthy-getenv "LESSON")
                                                    (box-add-new! (list lesson lesson-title)
                                                                  (list-ref c0 4)))
                                                  )]
                     [else
                       (let ([sublist-items
                               (box (if sublist-item
                                        (list sublist-item)
                                        '()))])
                         (unless (member dict *dictionaries-represented*)
                           (set! *dictionaries-represented* (cons dict *dictionaries-represented*)))
                         (set! *standards-met*
                           (cons (list std sublist-items c dict
                                       (box (list (list lesson lesson-title))))
                                 *standards-met*)))]))]
          [else (printf "Standard ~a not found~%" x)]
          )))

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
  (eval arg *base-namespace*))

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

(define (display-prereqs-row other-lessons o)
  ;(printf "doing display-prereqs-row ~a\n" other-lessons)
  (display "\n| Prerequisites | " o)
  (display
    (if (null? other-lessons) "None"
        (string-join
          (map (lambda (lesson)
                 (let ([lesson-title lesson]
                       [lesson-title-file (format "../~a/index-title.txt" lesson)])
                   (cond [(file-exists? lesson-title-file)
                          (set! lesson-title (call-with-input-file lesson-title-file read-line))]
                         [else
                           (printf "WARNING: pathway doesn't specify constituent lessons in correct order\n")])
                   (format "link:{pathwayrootdir}lessons/~a/index.html[~a]" lesson lesson-title)))
               other-lessons)
          ", ")) o)
  (display "\n\n" o))

(define (display-standards-row o)
  ;(printf "doing display-standards-row\n")
  (unless (empty? *standards-met*)
    (display "| " o)
    (display-standards-selection o)
    (display
      (string-append
        "|\n"
        "\n"
        "include::./pathway-standards.asc[]\n") o)))

(define (include-standards o) ;XXX obsolete?
  (display
    (string-append
      "\n\n\n"
      "[.left-header,cols=\"20a,80a\"]\n"
      "|===\n") o)
  (display-standards-row o)
  (display
    "\n|===\n\n" o))

(define (include-glossary o)
  ;(printf "include-glossary\n")
  (fprintf o "\n\ninclude::./pathway-glossary.asc[]\n\n"))

(define (workbook-pagenum lesson snippet)
  ;(printf "workbook-pagenum ~s ~s\n" lesson snippet)
  (let* ([snippet.adoc
           (path->string
             (path-replace-extension snippet ".adoc"))]
         [c (or (assoc (list lesson snippet.adoc) *workbook-pagenums*)
                (assoc (list lesson snippet) *workbook-pagenums*))])
    (if c (cadr c) #f)))

(define (make-workbook-link lesson pages-dir snippet link-text #:exercise? [exercise? #f])
  ;(printf "make-workbook-link ~s ~s ~s ~s\n" lesson pages-dir snippet link-text)
  (let* ([g (string-append lesson "/" pages-dir "/" snippet)]
         [f (string-append *pathway-root-dir* g)]
         [error-cascade? #f])
    ;g = relative pathname of the linked file from pathway-root-dir
    ;f = its fully qualified pathname
    (when (path-has-extension? snippet ".adoc")
      (let ([f.html (path-replace-extension f ".html")]
            [f.pdf (path-replace-extension f ".pdf")])
        (cond [(file-exists? f.html) (set! f f.html)
                                     (set! g (path-replace-extension g ".html"))]
              [(file-exists? f.pdf) (set! f f.pdf)
                                    (set! g (path-replace-extension g ".pdf"))])))
    (unless (file-exists? f)
      (set! error-cascade? #t)
      (check-link f)
      (printf "WARNING: @workbook-link refers to nonexistent file ~a\n" f))
    (when exercise?
      (set! *exercises-done* (cons (list (format "{pathwayrootdir}~a" g) *page-title*) *exercises-done*)))
    (format "link:{pathwayrootdir}~a[~a~a~a]" g
            link-text
            (if (truthy-getenv "LESSONPLAN")
                (let ([pagenum (workbook-pagenum lesson snippet)])
                  (unless pagenum
                    (unless error-cascade?
                      (printf "WARNING: @workbook-link used for non-workbook page ~a\n" f)))
                  (cond [pagenum
                          (let ([x (format "Page ~a" pagenum)])
                            (if (string=? link-text "") x
                                (string-append " (" x ")")))]
                        [else ""]))
                "")
            (if (truthy-getenv "LESSONPLAN") ", window=\"_blank\"" ""))))

(define (display-comment prose o)
  (display "%CURRICULUMCOMMENT%\n" o)
  (display "++++\n" o)
  (display prose o)
  (display "\n++++\n" o)
  (display "%ENDCURRICULUMCOMMENT%" o))

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

(define (make-image img opts #:centered? [centered? #f])
  ;(printf "making image ~s ~s\n" img opts)
  (let* ([lesson (truthy-getenv "LESSONPLAN")]
         [lesson-subdir (truthy-getenv "LESSONSUBDIR")]
         [text (if (pair? opts) (clean-up-image-text (car opts)) "")]
         [rest-opts (if (pair? opts) (cdr opts) '())]
         [commaed-opts (string-join rest-opts ", ")]
         [text-wo-url (clean-up-url-in-image-text text)]
         [adoc-img
           (cond [lesson
                   (format "image:{pathwayrootdir}lessons/~a/~a[~s, ~a]" lesson img
                           text-wo-url commaed-opts)]
                 [lesson-subdir
                   (format "image:{pathwayrootdir}~a/~a/~a[~s, ~a]" (getenv "LESSON") lesson-subdir
                           img text-wo-url commaed-opts)]
                 [else
                   (format "image:~a[~s, ~a]" img text-wo-url commaed-opts)])])
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
            adoc-img)))))

(define (check-link f #:external? [external? #f])
  (when *link-lint?*
    (cond [external? (display f *external-links-port*)
                     (newline *external-links-port*)]
          [(not (file-exists? f))
           (display f *internal-links-port*)
           (newline *internal-links-port*)])))

(define (make-link f link-text #:include? [include? #f])
  (cond [(not include?)

         (cond [(regexp-match #rx"://" f) (check-link f #:external? #t)]
               [else
                 (when (path-has-extension? f ".adoc")
                   (let ([f.html (path-replace-extension f ".html")]
                         [f.pdf (path-replace-extension f ".pdf")])
                     (cond [(file-exists? f.html) (set! f f.html)]
                           [(file-exists? f.pdf) (set! f f.pdf)])))
                 (unless (file-exists? f)
                   (check-link f)
                   (printf "WARNING: @link refers to nonexistent file ~a\n" f))])

         (format "link:~a[~a~a]" f link-text
                 (if (or (truthy-getenv "LESSONPLAN") (truthy-getenv "TEACHER_RESOURCES"))
                     ", window=\"_blank\"" ""))]
        [else
          (let ([f.asc (path-replace-extension f ".asc")])
            ;TODO: probably not needed anymore
            (cond [(file-exists? f.asc) (set! f f.asc)])
            (format "include::~a[]" f))]))

(define *lesson-summary-file* #f)

(define *asciidoctor*
  (format "asciidoctor -a linkcss -a proglang=~a -a pathway=~a -a stylesheet=~alib/curriculum.css"
          *proglang*
          (getenv "SRCPATHWAY")
          *pathway-root-dir*))

(define *standards-dictionaries*
  (map car *standards-list*))

(define *page-title* #f)

(define (display-title i o)
  (let ([title (string-trim (read-line i))])
    (set! *page-title* title)
    (when (truthy-getenv "LESSONPLAN")
      (call-with-output-file "index-title.txt"
        (lambda (o)
          (display title o) (newline o))
        #:exists 'replace))
    #|
    (unless (truthy-getenv "TEACHER_RESOURCES")
      (fprintf o "[.lesson-title]\n"))
    |#
    (let ([header-with-logo? (or (truthy-getenv "LESSONPLAN")
                                 ;(truthy-getenv "NARRATIVE")
                                 ;(truthy-getenv "TEACHER_RESOURCES")
                                 )])
      (display #\= o) (display #\space o)
      (when header-with-logo?
        (display
          (enclose-span ".bootstraplogo"
            "image:{pathwayrootdir}lib/bootstraplogo.png[]")
          o)
        ;(fprintf o "\n\n")
        (display " " o)
        )
      (if header-with-logo?
          (display (enclose-span ".bootstrapheader" title) o)
          (display title o))
      (newline o))))

(define (display-lesson-description desc o)
  (call-with-output-file "index-desc.txt"
    (lambda (o)
      (display desc o) (newline o))
    #:exists 'replace)
  (display desc o)
  (newline o))

(define (display-lesson-dependencies other-lessons o) ;XXX obsolete?
  ;  (call-with-output-file "index-dependencies.txt"
  ;    (lambda (o)
  ;      (fprintf o "(")
  ;      (for ([lesson other-lessons])
  ;        (fprintf o "~s " lesson))
  ;      (fprintf o ")\n"))
  ;    #:exists 'replace)
  (display
    (string-append
      "\n\n\n"
      "[.left-header,cols=\"20a,80a\"]\n"
      "|===") o)
  (display-prereqs-row other-lessons o)
  (display "|===\n\n" o))

(define (link-to-lessons-in-pathway o)
  ;(printf "link-to-lessons-in-pathway~n")
  ;
  (let ([lessons (read-data-file "lesson-order.txt")])
    ;
    ;(fprintf o "~n.Lessons Used in This Pathway\n")
    (print-lessons-intro o)
    ;(draw-dependency-diagram lessons o)
    (fprintf o "[#lesson-list]\n")
    (for ([lesson lessons])
      (let ([lesson-index-file (format "./lessons/~a/index.html" lesson)]
            [lesson-title-file (format "./lessons/~a/index-title.txt" lesson)]
            [lesson-desc-file (format "./lessons/~a/index-desc.txt" lesson)]
            [lesson-title lesson]
            [lesson-description #f])
        (when (file-exists? lesson-title-file)
          (set! lesson-title (call-with-input-file lesson-title-file read-line)))
        (when (file-exists? lesson-desc-file)
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
        (when (file-exists? lesson-index-file)
          (fprintf o "link:~a[~a] ::" lesson-index-file lesson-title)
          (if lesson-description
              (display lesson-description o)
              (display " {nbsp}" o)))
        ;(when lesson-description
        ;(display lesson-description o)
        ;(newline o))
        (newline o)))
    (fprintf o "link:./pathway-lessons.html[All the lessons] :: This is a single page that contains all the lessons listed above.\n")

    (let ([lessons-file "pathway-lessons.asciidoc"]
          [lessons-toc-file "pathway-lessons-toc.asciidoc"])

      (call-with-output-file lessons-file
        (lambda (lo)
          (fprintf lo "= Lessons Used in This Pathway~n~n")
          (fprintf lo "include::~a[]~n~n" lessons-toc-file)
          (call-with-output-file lessons-toc-file
            (lambda (toco)
              (fprintf toco "[verse]~n")
              (for ((lesson lessons))
                (let ([lesson-asc-file
                        (format "./lessons/~a/index.asc" lesson)]
                      [lesson-glossary-file
                        (format "./lessons/~a/lesson-glossary.txt" lesson)]
                      [lesson-standards-file
                        (format "./lessons/~a/lesson-standards.txt" lesson)]
                      [lesson-title-file
                        (format "./lessons/~a/index-title.txt" lesson)]
                      [lesson-title lesson]
                      )

                  (when (file-exists? lesson-title-file)
                    (set! lesson-title (call-with-input-file lesson-title-file read-line)))

                  (when (file-exists? lesson-glossary-file)
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
                    (call-with-input-file lesson-standards-file
                      (lambda (i)
                        (let loop ()
                          (let ([x (read i)])
                            (unless (eof-object? x)
                              (add-standard x lesson lesson-title lo)
                              (loop)))))))

                  ;(printf "took care of pw stds~n")

                  (when (file-exists? lesson-asc-file)
                    (fprintf lo "[[~a]]~n" lesson)
                    (fprintf toco "<<~a>>~n" lesson)
                    (fprintf lo "== ~a\n" lesson-title)
                    (fprintf lo "include::./lessons/~a/index.asc[leveloffset=+1,2..-1]~n~n"
                             lesson))
                  )))
            #:exists 'replace))
        #:exists 'replace)
      ;(asciidoctor lessons-file)
      (newline o))))

(define (preproc-n-asciidoctor in-file)
  ;(printf "doing preproc-n-asciidoctor ~a\n" in-file)
  (let ([out-file (path-replace-extension in-file ".asc")]
        [first-subsection-reached? #f]
        [title-reached? #f]
        )
    ;
    (when *link-lint?*
      (let ([internal-links-file (path-replace-extension in-file ".internal-links.txt.kp")]
            [external-links-file (path-replace-extension in-file ".external-links.txt.kp")])
        (when (file-exists? internal-links-file) (delete-file internal-links-file))
        (when (file-exists? external-links-file) (delete-file external-links-file))
        (set! *internal-links-port* (open-output-file internal-links-file))
        (set! *external-links-port* (open-output-file external-links-file))))
    ;
    (when (truthy-getenv "LESSONPLAN")
      (let* ([lesson0 (getenv "LESSON")]
             [lesson (cadr (regexp-split #rx"/" lesson0))])
        (for ([x *lessons-and-standards*])
          (when (string=? (car x) lesson)
            (for ([s (cdr x)])
              (add-standard s lesson #f #f))))))
    ;
    (when (truthy-getenv "NARRATIVE")
      (print-menubar "index"))
    ;
    (when (truthy-getenv "TEACHER_RESOURCES")
      (print-menubar "index"))
    ;
    (define (expand-directives i o)
      (let ([beginning-of-line? #t])
        (let loop ()
          (let ([c (read-char i)])
            (unless (eof-object? c)
              (cond
                [(char=? c #\@)
                 (set! beginning-of-line? #f)
                 (let ([directive (read-word i)])
                   ;(printf "directive = ~s~%" directive)
                   (cond [(string=? directive "") (display c o)]
                         [(string=? directive "span")
                          (display-begin-span (string-trim (read-group i directive)) o)
                          ]
                         [(string=? directive "comment")
                          (let ([prose (read-group i directive)])
                            (if title-reached?
                                (display-comment prose o)
                                (call-with-output-file "index-comment.txt"
                                  (lambda (o)
                                    (display "<!--" o)
                                    (display prose o)
                                    (display "-->" o)
                                    (newline o)))))]
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
                              (printf "WARNING: Directive @vocab has ill-formed argument~%"))
                            (display (enclose-span ".vocab" arg) o)
                            (cond [s (unless (member s *glossary-items*)
                                       (set! *glossary-items* (cons s *glossary-items*)))]
                                  [else
                                    (unless (member arg *missing-glossary-items*)
                                      (set! *missing-glossary-items* (cons arg *missing-glossary-items*)))
                                    (printf "WARNING: Item ~s not found in glossary~%"
                                                arg)]))]
                         [(string=? directive "std")
                          (let ([args (read-commaed-group i directive)])
                            (printf "WARNING: Directive @std is obsolete\n")
                            )]
                         [(string=? directive "prereqs-stds")
                          (display-prereqs-row (read-commaed-group i directive) o)
                          (display-standards-row o)
                          ]
                         [(string=? directive "image")
                          (let ([args (read-commaed-group i directive)])
                            (display (make-image (car args) (cdr args)) o))]
                         [(string=? directive "centered-image")
                          (let ([args (read-commaed-group i directive)])
                            (display (make-image (car args) (cdr args) #:centered? #t) o))]
                         [(string=? directive "math")
                          (display (enclose-math (read-group i directive)) o)]
                         [(or (string=? directive "workbook-link")
                              (string=? directive "exercise-link"))
                          (let* ([args (read-commaed-group i directive)]
                                 [exercise? (string=? directive "exercise-link")]
                                 [n (length args)]
                                 [page (car args)]
                                 [link-text (if (> n 1) (cadr args) "")]
                                 [page-compts (regexp-split #rx"/" page)]
                                 [first-compt (car page-compts)])
                            ;(when (string=? directive "exercise-link") (printf "calling @exercise-link ~s\n" args))
                            (case (length page-compts)
                              [(1)
                               (display (make-workbook-link (getenv "LESSON")
                                                            "pages"
                                                            first-compt
                                                            link-text
                                                            #:exercise? exercise?) o)]
                              [(2)
                               (let ([second-compt (cadr page-compts)]
                                     [lesson-dir (truthy-getenv "LESSON")])
                                 (cond [(and (or (string=? first-compt "pages")
                                                 (string=? first-compt "solution-pages"))
                                             lesson-dir)
                                        (display (make-workbook-link lesson-dir
                                                                     first-compt
                                                                     (cadr page-compts)
                                                                     link-text
                                                                     #:exercise? exercise?) o)]
                                       [else
                                         ;XXX: should these just be warnings
                                         ;with the @workbook-link converted to plain @link ?
                                         (error 'ERROR
                                                 "adoc-preproc: Incorrect @workbook-link ~a\n" page)]))]
                              [(3)
                               (let ([second-compt (cadr page-compts)]
                                     [third-compt (caddr page-compts)])
                                 (cond [(or (string=? second-compt "pages")
                                            (string=? second-compt "solution-pages"))
                                        (display (make-workbook-link (string-append "lessons/" first-compt)
                                                                     second-compt
                                                                     third-compt link-text
                                                                     #:exercise? exercise?) o)]
                                       [else
                                         (error 'ERROR
                                                 "adoc-preproc: Incorrect² @workbook-link ~a\n" page)]))]
                              [else
                                (error 'ERROR
                                        "adoc-preproc: Incorrect³  @workbook-link ~a\n" page)]))]
                         [(or (string=? directive "worksheet-link")
                              (string=? directive "worksheet-include")
                              (string=? directive "exercise-link"))
                          ;TODO: Remove this after a while
                          (error 'ERROR
                                  "adoc-preproc: Obsolete directive ~a\n" directive)]
                         [(string=? directive "link")
                          (let* ([args (read-commaed-group i directive)]
                                 [adocf (car args)]
                                 [link-text (string-join
                                              (map string-trim (cdr args)) ", ")])
                            (display (make-link adocf link-text) o))]
                         [(string=? directive "include")
                          (let* ([args (read-commaed-group i directive)]
                                 [adocf (car args)] ;only one right? FIXME
                                 )
                            (display (make-link adocf "" #:include? #t) o))]
                         [(string=? directive "lesson-description")
                          (unless (truthy-getenv "LESSONPLAN") ;TODO: or LESSON or both?
                            (error 'ERROR
                                   "adoc-preproc: @lesson-description valid only in lesson plan"))
                          (display-lesson-description (read-group i directive) o)]
                         [(string=? directive "depends-on") ;XXX obsolete
                          (unless (truthy-getenv "LESSONPLAN")
                            (error 'ERROR "adoc-preproc: @depends-on valid only in lesson plan"))
                          (display-lesson-dependencies (read-commaed-group i directive) o)]
                         [(string=? directive "solutions-workbook")
                          ;TODO: don't need this anymore -- link is autogen'd
                          (unless (truthy-getenv "TEACHER_RESOURCES")
                            (error 'ERROR
                                   "adoc-preproc: @solutions-workbook valid only in teacher resources directory~n"))
                          (fprintf o "link:./protected/pd-workbook.pdf[Teacher's PD Workbook]")
                          (newline o)
                          (fprintf o "link:./protected/workbook-sols.pdf[Teacher's Workbook, with Solutions]")
                          ]
                         [(string=? directive "do")
                          (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                            (for-each massage-arg exprs))]
                         [(string=? directive "show")
                          (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                            (for ([s exprs])
                              (display (massage-arg s) o)))]
                         [(string=? directive "clear")
                          (read-group i directive)
                          (newline o)
                          (display (enclose-span ".clear" " ") o)]
                         [(string=? directive "vspace")
                          (let ([height (string-trim (read-group i directive))])
                            (display
                              (string-append
                                (create-begin-tag "span" ".vspace" #:attribs
                                                  (format "style=\"height: ~a\"" height))
                                (create-end-tag "span")) o))]
                         [(string=? directive "quad")
                          (let ([width (string-trim (read-group i directive))])
                            (display
                              (string-append
                                (create-begin-tag "span" ".quad" #:attribs
                                                  (format "style=\"width: ~a\"" width))
                                (create-end-tag "span")) o))]
                         [(string=? directive "fitb")
                          (let* ([width (string-trim (read-group i directive))]
                                 [text (string-trim (read-group i directive))])
                            (display
                              (string-append
                                (create-begin-tag "span" ".fitb" #:attribs
                                                  (format "style=\"width: ~a\"" width))
                                text
                                (create-end-tag "span")) o))]
                         [(string=? directive "fitbruby")
                          (let* ([width (string-trim (read-group i directive))]
                                 [text (string-trim (read-group i directive))]
                                 [ruby (string-trim (read-group i directive))])
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
                         [(assoc directive *macro-list*)
                          => (lambda (s)
                               (display (cadr s) o))]
                         [(assoc directive *function-list*)
                          => (lambda (f)
                               (let ([g (read-group i directive)])
                                 (let ([args (string-to-form g)])
                                   (let-values ([(key-list key-vals args)
                                                 (rearrange-args args)])
                                     (call-with-input-string (keyword-apply (cadr f) key-list key-vals args)
                                       (lambda (i)
                                         (expand-directives i o)
                                         ))))))]
                         [else
                           (printf "WARNING: Unrecognized directive @~a~%" directive)
                           (display c o) (display directive o)
                           #f]))]
                [(and (or (truthy-getenv "LESSON")
                          (truthy-getenv "LESSONPLAN")
                          (truthy-getenv "NARRATIVE")
                          (truthy-getenv "TEACHER_RESOURCES"))
                      beginning-of-line? (char=? c #\=))
                 (set! beginning-of-line? #f)
                 (cond [title-reached?
                         (cond [first-subsection-reached? #f]
                               [(check-first-subsection i o)
                                (set! first-subsection-reached? #t)
                                (when (truthy-getenv "LESSONPLAN")
                                  ;(include-standards o)
                                  (include-glossary o))]
                               [else #f])
                         (cond [(truthy-getenv "LESSON")
                                (display-section-markup i o)]
                               [else (display c o)])]
                       [else
                         (set! title-reached? #t)
                         (cond [(or (truthy-getenv "LESSONPLAN") (truthy-getenv "TEACHER_RESOURCES"))
                                (display-title i o)]
                               [else (display #\= o)])
                         (when (truthy-getenv "TEACHER_RESOURCES")
                           ;(printf "teacher resource autoloading stuff\n")
                           (newline o)
                           (fprintf o (create-workbook-links))
                           (display-exercise-collation o)
                           )])]
                [(char=? c #\newline)
                 (newline o)
                 (set! beginning-of-line? #t)]
                [else
                  (set! beginning-of-line? #f)
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
                               [else (error 'ERROR "preproc-n-asciidoctor: deadc0de")])]
                        [else (display c o)])])
              (loop))))))
    ;
    (call-with-input-file in-file
      (lambda (i)
        (call-with-output-file out-file
          (lambda (o)
            (expand-directives i o)

            (when (truthy-getenv "NARRATIVE")
              (link-to-lessons-in-pathway o))

            (set! *dictionaries-represented*
              (sort *dictionaries-represented* string-ci<=?))

            (when (or (truthy-getenv "NARRATIVE") (truthy-getenv "LESSONPLAN"))
              (create-standards-subfile))

            (when (truthy-getenv "NARRATIVE")
              (print-other-resources-intro o)
              (print-link-to-glossary o)
              (print-link-to-standards o)
              (print-link-to-student-workbook o)
              (print-link-to-teacher-resources o)
              (print-link-to-forum o))

            (unless (truthy-getenv "OTHERDIR")
              (fprintf o "\n\n")
              (fprintf o "[.acknowledgment]\n")
              (fprintf o "--\n")
              (fprintf o (create-acknowledgment))
              (fprintf o "link:https://www.creativecommons.org/licenses/by-nc-nd/4.0/[image:{pathwayrootdir}lib/CCbadge.png[], window=\"_blank\"]\n")
              (fprintf o (create-copyright *copyright-name* *copyright-author*))
              (fprintf o "\n--\n")
              )
            )

          #:exists 'replace)))
  ;

  (when (or (truthy-getenv "NARRATIVE")
            (truthy-getenv "LESSONPLAN"))
    (add-exercises)
    (create-glossary-subfile))

  (when (truthy-getenv "LESSONPLAN")
    (accumulate-glossary-and-standards))

  ;(printf "OTHERDIR = ~a\n"  (truthy-getenv "OTHERDIR"))
  (unless (truthy-getenv "OTHERDIR")
    (asciidoctor out-file)
    (unless (truthy-getenv "DEBUG")
      (delete-file out-file)))

  (when *link-lint?*
    (close-output-port *internal-links-port*)
    (close-output-port *external-links-port*))

    ))

(define (asciidoctor file)
  ;(printf "asciidoctor ~a with pathwayrootdir=~a\n" file *pathway-root-dir*)
  (system (format "~a -a pathwayrootdir=~a ~a" *asciidoctor* *pathway-root-dir* file))
  (void)
  )

(define (display-exercise-collation o)
  ;(printf "doing display-exercise-collation ~s\n" *pathway-exercises-file*)
  ;(printf "pwrd = ~s\n" *pathway-root-dir*)
  ;(printf "? = ~s\n" (file-exists? *pathway-exercises-file*))
  (let ([exx (read-data-file *pathway-exercises-file* #:mode 'forms)])
    (unless (null? exx)
      ;(printf "exercises found in ~s\n" *pathway-exercises-file*)
      (fprintf o "=== Exercises and Solutions\n\n")
      (fprintf o "[.exercises_and_solutions]\n")
      (fprintf o "|===\n")
      (for ([ex exx])
        ;(printf "ex = ~s ~a\n" ex (length ex))
        (let* ([ti (list-ref ex 1)]
               [exer (list-ref ex 0)]
               [soln (regexp-replace "/pages/" exer "/solution-pages/")])
          (fprintf o "~a |[link:~a[exercise] : link:~a[solution]]\n" ti exer soln)))
      (fprintf o "|===\n\n"))))

(define (add-exercises)
  ;(printf "doing add-exercises\n")
  (unless (null? *exercises-done*)
    ;(printf "doing add-exercises I\n")
    (call-with-output-file *pathway-exercises-file*
      (lambda (o)
        (for ([ex *exercises-done*])
          (fprintf o "~s\n" ex)))
      #:exists 'append)))

(define (create-glossary-subfile)
  ;(printf "doing create-glossary-and-standards-subfiles ~a ~a ~a\n" (truthy-getenv "NARRATIVE"))
  (print-menubar "pathway-glossary")
  (call-with-output-file "pathway-glossary.asc"
    (lambda (op)
      (unless (empty? *glossary-items*)
        (set! *glossary-items*
          (sort *glossary-items* #:key car string-ci<=?))
        (when (truthy-getenv "NARRATIVE")
          (fprintf op "= Glossary\n\n"))
        (when (truthy-getenv "LESSON")
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
  (fprintf op (if (truthy-getenv "LESSON")
                  ".~a Statements\n"
                  "== ~a Statements\n\n")
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
      (unless (truthy-getenv "LESSON")
        (when (> (length lessons) 0)
          (fprintf op "{startsb}See: ~a.{endsb}\n"
                   (string-join
                     (map
                       (lambda (x)
                         (format " link:./~a/index.html[~a]" (car x) (cadr x)))
                       lessons) ";"))))
      (for ([n sublist-items])
        (fprintf op "** ~a~%" (list-ref s (+ n 1)))
        ;(fprintf op "** ~a~%" (list-ref s (+ n 1)))
        )))
  (fprintf op "\n\n"))

(define (display-standards-selection o)
  (let ([narrative? (truthy-getenv "NARRATIVE")])
    (when narrative? (fprintf o "= Standards\n\n"))
    (print-standards-js o)
    (when narrative? (display (create-begin-tag "div" ".standard-menu-container") o))
    (cond [narrative?
            (display
              (enclose-div ""
                (string-append
                  "\nThis pathway aligns with several important teaching standards.\n"
                  "Select particular standards from the following menu to see\n"
                  "which items in the standards are met.\n"))
              o)]
          [else (display "Relevant Standards\n" o)])
    (when narrative? (display (create-begin-tag "div" "") o))
    (display (enclose-tag "select" ".standardsAlignmentSelect"
               #:attribs
               (format  " multiple onchange=\"showStandardsAlignment()\" style=\"height: ~apx\"" 75)
               (string-join
                 (map (lambda (dict)
                        (enclose-tag "option" ""
                          #:attribs (format "value=\"standards-~a\"" dict)
                          dict))
                      *dictionaries-represented*)
                 "\n")) o)
    (when narrative?
      (display (create-end-tag "div") o)
      (display (create-end-tag "div") o))
    (display "\n\n" o)))

(define (create-standards-subfile)
  ;(printf "doing create-standards-subfiles ~s\n" *standards-met*)
  (when (truthy-getenv "NARRATIVE")
    (print-menubar "pathway-standards"))
  (call-with-output-file "pathway-standards.asc"
    (lambda (op)
      (unless (empty? *standards-met*)
        (when (truthy-getenv "NARRATIVE")
          (display-standards-selection op))
        (when (truthy-getenv "LESSON")
          (fprintf op (string-append
                        "\n[.alignedStandardsIntro]\n"
                        "_Select one or more standards from the menu on the left (⌘-click\n"
                        "on Mac, Ctrl-click elsewhere)._\n\n")))
        (for ((dict *dictionaries-represented*))
          (let ([dict-standards-met
                  (filter (lambda (s) (string=? (list-ref s 3) dict))
                          *standards-met*)])
            (unless (empty? dict-standards-met) ;it will never be empty!
              (create-standards-section
                dict
                (sort dict-standards-met #:key car string-ci<=?) op))))))
    #:exists 'replace))

(define (accumulate-glossary-and-standards)
  ;(printf "doing accumulate-glossary-and-standards\n")
  (call-with-output-file "lesson-glossary.txt"
    (lambda (op)
      (for ([s *glossary-items*])
        (fprintf op "~s~n" (car s))))
    #:exists 'replace)
  (call-with-output-file "lesson-standards.txt"
    (lambda (op)
      (for ([s *standards-met*])
        (fprintf op "~s~n" (car s))))
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
  (enclose-div ".circleevalsexp"
    (sexp->block e #:pyret (string=? *proglang* "pyret"))))

(define *hole-symbol* '++_______++)
(define *hole2-symbol* '++____________________++)
(define *hole3-symbol* *hole2-symbol*)

(define *list-of-hole-symbols*
  (list *hole-symbol* *hole2-symbol* *hole3-symbol*))

(define (sexp->arith e #:pyret [pyret #f] #:wrap [wrap #f])
  ;(when pyret (printf "doing sexp->arith ~s\n" e))
  (cond [(number? e) (format "~a" e)]
        [(and (symbol? e) pyret
              (memq e '(BSLeaveAHoleHere BSLeaveAHoleHere2 BSLeaveAHoleHere3)))
         (enclose-span ".studentAnswer" (format "~a" e))]
        [(symbol? e) (sym-to-adocstr e #:pyret pyret)]
        [(string? e) (format "~s" e)]
        [(list? e) (let ([a (car e)])
                     (if (or (memq a '(+ - * / and or < > = <= >=))
                             (memq a *list-of-hole-symbols*))
                         (if (and (eq? a '/) (not pyret))
                             (format "{~a \\over ~a}"
                                     (sexp->arith (list-ref e 1))
                                     (sexp->arith (list-ref e 2)))
                             (let* ([a (if pyret (sexp->arith a #:pyret #t)
                                           (cond [(eq? a '*) "\\;\\times\\;"]
                                                 [(eq? a '/) "\\div"]
                                                 [else a]))]
                                    [lft (sexp->arith (list-ref e 1) #:pyret pyret #:wrap #t)]
                                    [rt (sexp->arith (list-ref e 2) #:pyret pyret #:wrap #t)]
                                    [x (format "~a ~a ~a"
                                               lft
                                               a
                                               rt)])
                               (if wrap
                                   (if pyret
                                       (format "({zwsp}~a{zwsp})" x)
                                       (format "(~a)" x))
                                   x)))
                         (format "~a{zwsp}({zwsp}~a{zwsp})"
                                 (sexp->arith a #:pyret pyret)
                                 (string-join
                                   (map (lambda (e1)
                                          (sexp->arith e1 #:pyret pyret)) (cdr e))
                                   ", "))
                         ))]
        [else (error 'ERROR "sexp->arith: unknown s-exp ~s" e)]))

(define holes-to-underscores
  (let* ([hole *hole-symbol*]
         [hole2 (if (string=? *proglang* "pyret")
                    *hole2-symbol*
                    (list hole hole hole))]
         [hole3 hole2])
    (lambda (e)
      (cond [(pair? e) (cons (holes-to-underscores (car e))
                             (holes-to-underscores (cdr e)))]
            [(number? e) e]
            [(string? e) e]
            [(eq? e 'BSLeaveAHoleHere) hole]
            [(eq? e 'BSLeaveAHoleHere2) hole2]
            [(eq? e 'BSLeaveAHoleHere3) hole3]
            [else e]))))

(define (sexp->wescheme e)
  (enclose-textarea ".racket" (format "~s" (holes-to-underscores e)))
  ;(enclose-textarea ".racket" (sexp->block e))
  )

(define (sexp->pyret e)
  (enclose-textarea ".pyret" (sexp->arith (holes-to-underscores e) #:pyret #t)))

(define (sexp->math e)
  (enclose-math (sexp->arith e)))

(define (sexp->code e)
  ((if (string=? *proglang* "pyret")
       sexp->pyret
       sexp->wescheme) e))

(define (sym-to-adocstr e #:pyret [pyret #f])
  ;(printf "sym-to-adocstr ~s ~a\n" e pyret)
  (cond [pyret (cond [(eq? e 'string=?) "string-equal"]
                     [(eq? e 'sqrt) "num-sqrt"]
                     [(eq? e '=) "=="]
                     [else (format "~a" e)])]
        [(eq? e '<=) "\\<="]
        [else (format "~a" e)]))

(define (sexp->block e #:pyret [pyret #f])
  ;(printf "doing sexp->block ~s ~a\n" e pyret)
  (cond [(member e '(true false)) (enclose-span ".value.wescheme-boolean" (format "~a" e))]
        [(eq? e 'else) (enclose-span ".wescheme-keyword" "else")]
        [(number? e) (enclose-span ".value.wescheme-number" (format "~a" e))]
        [(string? e) (enclose-span ".value.wescheme-string" (format "~s" e))]
        [(boolean? e) (enclose-span ".value.wescheme-boolean" (format "~a" e))]
        [(symbol? e)
         (enclose-span ".value.wescheme-symbol"
           (cond [(memq e '(BSLeaveAHoleHere BSLeaveAHoleHere2 BSLeaveAHoleHere3))
                  "{nbsp}{nbsp}{nbsp}"]
                 [else (sym-to-adocstr e #:pyret pyret)]))]
        [(list? e) (let ([a (car e)])
                     (enclose-span ".expression"
                       (if (symbol? a)
                           (let ([args (intersperse-spaces
                                         (map (lambda (e1)
                                                (sexp->block e1 #:pyret pyret))
                                              (cdr e)) 'args)])
                             (string-append
                               (enclose-span ".lParen" "(")
                               (enclose-span ".operator" (sexp->block a #:pyret pyret))
                               args
                               (enclose-span ".rParen" ")")))
                           (let ([parts (intersperse-spaces
                                          (map (lambda (e1)
                                                 (sexp->block e1 #:pyret pyret))
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

(define (code x #:multi-line [multi-line #t])
  (let ([pyret? (string=? *proglang* "pyret")])
    (enclose-textarea
      (if pyret? ".pyret" ".racket")
      (if pyret? (regexp-replace* " :: " x " :{zwsp}: ")
          x))))

(define elem string-append)

(define (permute-list lst)
  (let loop ([sourcelst lst])
    (if (empty? sourcelst) empty
        (let ([choose (list-ref sourcelst (random (length sourcelst)))])
          (cons choose (loop (remove choose sourcelst)))))))

(define (pad-to alst to-len with-elt)
  (let ([n (length alst)])
    (if (>= n to-len) alst
        (let ([extras (build-list (- to-len n) (lambda (i) with-elt))])
          (append alst extras)))))

(define (string-or-los s)
  (if (string? s) s
      (string-join s "\n")))

(define (contract-exercise/internal tag start-str colon-str)
  (string-append start-str
    (enclose-span  ".contract-name.studentAnswer" "")
    colon-str
    (enclose-span  ".contract-domain.studentAnswer" "")
    " -> "
    (enclose-span  ".contract-range.studentAnswer" "")))

(define (contract-exercise tag)
  (contract-exercise/internal tag "; " ": "))

(define (contract-exercise/pyret tag)
  (contract-exercise/internal tag "" " :: "))

(define (create-itemlist #:style [style #f] items)
  ;(printf "doing create-itemlist ~s\n" items)
  (string-append "\n\n"
    (if style (string-append "[.plain.exercises]") "")
    (apply string-append
           (let ([n (length items)])
             (let loop ([i n] [r '()])
               (cond [(< i 1) r]
                     [else (loop (- i 1)
                                 (cons (string-append "\n\n"
                                         (if style (format "~a. " i) "* ")
                                         (string-or-los (list-ref items (- i 1))))
                                       r))]))))
    "\n\n"))

(define (create-exercise-itemlist items #:ordered [ordered #t]
                                  #:itemstyle [itemstyle #f])
  ;(printf "doing create-exercise-itemlist ~s\n" items)
  ;how to use itemstyle?
  (create-itemlist #:style ordered
                   (map (lambda (c)
                          (enclose-div (or itemstyle ".ExerciseListItem")
                                       (string-or-los c)))
                        items)))

(define (create-exercise-itemlist/contract-answers
          contents
          #:pyret [pyret #f] #:ordered [ordered #t])
  ;(printf "doing create-exercise-itemlist/contract-answers ~s\n" contents)
  (set! pyret (string=? *proglang* "pyret"))
  (create-exercise-itemlist
    #:ordered ordered
    (map (lambda (c)
           (list ((if pyret
                      contract-exercise/pyret
                      contract-exercise) "dummyid")
                 c))
         contents)))

(define (two-col-layout #:leftcolextratag [leftcolextratag ""]
                        #:rightcolextratag [rightcolextratag ""]
                        #:layoutstyle [layoutstyle ""]
                        colA colB)
  (let* ([maxcollength (max (length colA) (length colB))]
         [paddedcolA (pad-to colA maxcollength "")]
         [paddedcolB (pad-to colB maxcollength "")]
         [leftcolstyle (string-append ".leftColumn" leftcolextratag)]
         [rightcolstyle (string-append ".rightColumn" rightcolextratag)])
    (string-append
      (format "[.twoColumnLayout~a]\n" layoutstyle)
      (apply string-append
             (map (lambda (lft rt)
                    (string-append
                      "- "
                      (enclose-div leftcolstyle lft)
                      "\n"
                      (enclose-div rightcolstyle rt)
                      "\n"))
                  paddedcolA paddedcolB))
      "\n\n")))

(define questions-and-answers two-col-layout)

(define completion-exercise two-col-layout)

(define (open-response-exercise colA answer-type)
  (unless (member answer-type '("circeval" "code" "math" "text"))
    (error 'ERROR "open-response-exercise: Unexpected answer type ~a\n" answer-type))
  (two-col-layout colA '()
                  #:rightcolextratag (string-append ".studentAnswer" "." answer-type)))

(define (matching-exercise #:permute [permute #f]
                           colA colB)
  (let* ([colB (if permute (permute-list colB) colB)]
         [nA (length colA)]
         [nB (length colB)]
         [paddedcolA (if (> nB nA) (pad-to colA nB "") colA)]
         [paddedcolB (if (> nA nB) (pad-to colB nA "") colB)])
    (two-col-layout #:layoutstyle ".matching"
                    paddedcolA paddedcolB)))

(define (get-index ans presented-order #:compare-with [compare-with eq?])
  (let loop ([i 0] [s presented-order])
    (cond [(null? s) -1]
          [(compare-with (car s) ans) i]
          [else (loop (+ i 1) (cdr s))])))

(define int->alpha
  (let ([a->int (char->integer #\a)])
    (lambda (i)
      (string (integer->char (+ a->int i))))))

(define (matching-exercise-answers #:compare-with [compare-with eq?]
                                   #:content-of-ans [content-of-ans #f]
                                   #:some-no-match? [some-no-match? #f]
                                   ques formatted-ans presented-ans)
  (let ([annotated-ans
          (map (lambda (ansF ansC)
                 (let ([i (get-index ansC presented-ans
                                     #:compare-with compare-with)]
                       [label #f])
                   (when (and (< i 0) (not some-no-match?))
                     (error 'ERROR "matching-exercise-answers: Couldn't find ~a in ~a\n"
                            ansC presented-ans))
                   (enclose-div ".labeledRightColumn"
                     (if (>= i 0)
                         (let ([label (int->alpha i)])
                           (string-append
                             (enclose-span ".rightColumnLabel" label)
                             ansF))
                         (enclose-span ".matchLabelAns"
                           "No matching answer")))))
               formatted-ans (or content-of-ans formatted-ans))])
    (two-col-layout #:layoutstyle ".solutions.matching" ques annotated-ans)))

(define (exercise-evid-tags . x) #f)

(define (exercise-handout #:title [title #f] #:instr [instr #f] #:forevidence [forevidence #f]
                          . body)
  (string-append
    (format "\n\n== Exercise~a\n\n"
            (if title (format ": ~a" title) "")
            )
    (if instr
        (format "*Directions*: ~a\n\n" instr)
        "")
    (apply string-append
           (filter (lambda (x) (not (void? x))) body))))

(define (main . cl-args)
  (unless (= (length cl-args) 1)
    (error 'ERROR "adoc-preproc: Exactly one arg accepted"))
  (preproc-n-asciidoctor (car cl-args)))

;(void)
