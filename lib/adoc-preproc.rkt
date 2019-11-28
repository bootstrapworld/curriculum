":"; exec racket -f $0 -m -- "$@"

(require "html-tag-gen.rkt")
(require "defines.rkt")
(require "create-copyright.rkt")
(require "create-acknowledgment.rkt")
(require "create-workbook-links.rkt")
(require "form-elements.rkt")
(require "function-directives.rkt")
(require "glossary-terms.rkt")
(require "all-standards-dictionary.rkt")
(require "lessons-and-standards.rkt")

(define *proglang* (string-downcase (getenv "PROGLANG")))

(define *solutions-mode?* (getenv "SOLUTION"))

(define *base-namespace* (current-namespace))

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
               (cond [in-escape? (loop (cons c r) #f nesting in-string? #f)]
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
                  (cond [in-escape?
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

(define *span-stack* '())

(define (span-stack-present?)
  (pair? *span-stack*))

(define (top-span-stack)
  (car *span-stack*))

(define (grow-span-stack)
  (set! *span-stack* (cons 0 *span-stack*)))

(define (pop-span-stack)
  (set! *span-stack* (cdr *span-stack*)))

(define (increment-top-span-stack)
  (let ([n (car *span-stack*)])
    (set! *span-stack* (cons (+ n 1) (cdr *span-stack*)))))

(define (decrement-top-span-stack)
  (let ([n (car *span-stack*)])
    (when (<= n 0)
      (error 'span "Bad @span: Check missing braces"))
    (set! *span-stack* (cons (- n 1) (cdr *span-stack*)))))

(define (display-begin-span span-args o)
  (grow-span-stack)
  (display (create-begin-tag "span" span-args) o))

(define (display-end-span o)
  (pop-span-stack)
  (display (create-end-tag "span") o))

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
  (let* ([std-bits (regexp-split #rx"&" std)]
         [std (list-ref std-bits 0)]
         [sublist-item #f]
         [c #f]
         [dict #f])
    (for-each
      (lambda (x)
        (unless c
          (let ([stds-list (cdr x)])
            (set! c (assoc std stds-list))
            (when c (set! dict (car x))))))
      *standards-alist*)
    (when (>= (length std-bits) 3)
      (set! sublist-item (string->number (list-ref std-bits 2))))
    (values sublist-item c dict)))

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
          (let loop ((section-level 1))
            (let ((c (peek-char i)))
              (cond [(eof-object? c) section-level]
                    [(char=? c #\=) (read-char i) (loop (+ section-level 1))]
                    [else section-level])))])
    (fprintf o "[.lesson-section-~a]~n" (- section-level 1))
    (let loop ([section-level section-level])
      (unless (<= section-level 0)
        (display #\= o) (loop (- section-level 1))))))

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
    (let ([args-paired (let loop ((args args) (r '()))
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

(define (include-standards dictionaries-represented o)
  (unless (getenv "LESSONPLAN") (error ' include-standards "deadc0de"))
  (display
    (mstring
      "\n\n"
      "[.left-header,cols=\"20a,80a\"]"
      "|==="
      "|") o)
  (display-standards-selection dictionaries-represented o)
  (display
    (mstring
      "|"
      ""
      "include::./index-standards.asc[]"
      ""
      "|===\n\n") o))

(define (include-glossary o)
  ;(printf "include-glossary\n")
  (when (getenv "NARRATIVE") (error ' include-glossary "deadc0de"))
  (fprintf o "\n\ninclude::./index-glossary.asc[]\n\n"))

(define *pathway-root-dir* (getenv "PATHWAYROOTDIR"))

(define *pathway-exercises-file* (string-append *pathway-root-dir* "workbook-exercises.txt"))

(define *index-file* (string-append *pathway-root-dir* "workbook-page-index.rkt"))

(define *index-list* (call-with-input-file *index-file* read))

(define *index-length* (length *index-list*))

(define *external-url-index-file* (string-append *pathway-root-dir* "external-index.rkt"))

(define *external-url-index*
  (if (file-exists? *external-url-index-file*)
      (call-with-input-file *external-url-index-file* read)
      '()))

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

(define (prefix-pathway-root-dir f)
  (if (string=? *pathway-root-dir* "") f
      (build-path *pathway-root-dir* f)))

(define (make-worksheet-link lesson workbook-dir snippet link-text)
  ;(printf "make-worksheet-link ~a ~a ~a ~a\n" lesson workbook-dir snippet link-text)
  (let ([g (string-append "lessons/" lesson "/" workbook-dir "/" snippet)])
    (when (path-has-extension? snippet ".adoc")
      (let* ([f (string-append *pathway-root-dir* g)]
             [snippet.html (path-replace-extension f ".html")]
             [snippet.pdf (path-replace-extension f ".pdf")])
        (cond [(file-exists? snippet.html) (set! g (path-replace-extension g ".html"))]
              [(file-exists? snippet.pdf) (set! g (path-replace-extension g ".pdf"))])))
    (format "link:{pathwayrootdir}~a[~a~a]" g link-text
            (if (getenv "LESSONPLAN") ", window=\"_blank\"" ""))
    ))

(define (make-exercise-link lesson exerdir exer link-text
                            #:include? [include? #f] #:as-is? [as-is? #f])
  ;(printf "make-exercise-link ~a ~a ~a ~a ~a\n" lesson exerdir exer link-text as-is?)
  (let* ([g (string-append "lessons/" lesson "/"
                           (if as-is? exerdir
                               (if *solutions-mode?* "exercises-sols"
                                   "exercises")) "/" exer)]
         [f (string-append *pathway-root-dir* g)]
         [exer.html (path-replace-extension f ".html")]
         [exer.pdf (path-replace-extension f ".pdf")])
    (cond [(file-exists? exer.html) (set! g (path-replace-extension g ".html"))]
          [(file-exists? exer.pdf) (set! g (path-replace-extension g ".pdf"))]
          [(path-has-extension? g ".adoc") (set! g (path-replace-extension g ".html"))])
    (cond [include?
            (let ([exer.asc (path-replace-extension f ".asc")] [n -1])
              (when (file-exists? exer.asc)
                ;(printf "exercising ~a\n" exer.asc)
                (system (format "grep -n '^\\[\\.acknowledgment\\]' ~a|sed -e 's/^\\([^:]*\\):.*/\\1/' > temp2.txt" exer.asc))
                (set! n (- (call-with-input-file "temp2.txt" read) 1)))
              (format "include::~a[lines=1..~a]" exer.asc n)
              ;(format "include::~a[]" exer.asc)
              )]
          [else
            (format "link:{pathwayrootdir}~a[~a]" g link-text)])))

(define (display-comment prose o)
  (display "@CURRICULUMCOMMENT\n" o)
  (display "++++\n" o)
  (display prose o)
  (display "\n++++\n" o)
  (display "@ENDCURRICULUMCOMMENT" o))

(define (clean-up-image-text text)
  (when (char=? (string-ref text 0) #\")
    (set! text (substring text 1)))
  (let ([n (string-length text)])
    (when (char=? (string-ref text (- n 1)) #\")
      (set! text (substring text 0 (- n 1)))))
  (set! text (regexp-replace* #rx"," text "@CURRICULUMCOMMA"))
  (set! text (string-append " " text " ")) ;FIXME needed?
  text)

(define (clean-up-url-in-image-text text)
  (regexp-replace* #rx"https://" text ""))

(define (make-image img opts)
  ;(printf "making image ~s ~s\n" img opts)
  (let ([lesson (getenv "LESSON")]
        [text (clean-up-image-text (car opts))]
        [rest-opts (cdr opts)])
    (set! opts (string-join rest-opts ", "))
    (string-append
      (format "[.tooltip.centered-image]\n")
      (enclose-span ".tooltiptext" text) "\n"
      (let ([text (clean-up-url-in-image-text text)])
        (if lesson
            (format "image:{pathwayrootdir}lessons/~a/~a[~s, ~a]" lesson img
                    text opts)
            (format "image:~a[~s, ~a]" img text opts)))
      )))

(define (make-lesson-link lesson file-seq link-text)
  ;(printf "make-lesson-link ~a ~a ~a~n" lesson file-seq link-text)
  (when (string=? lesson ".") (set! lesson (getenv "LESSON")))
  (let* ([g (format "lessons/~a/~a" lesson
                    (string-join file-seq "/"))]
         [f (string-append *pathway-root-dir* g)]
         [f.html (path-replace-extension f ".html")]
         [f.pdf (path-replace-extension f ".pdf")])
    ;(printf "g=~a~n f=~a~n f.html=~a~n f.pdf=~a~n" g f f.html f.pdf)
    (cond [(file-exists? f.html) (set! g (path-replace-extension g ".html"))]
          [(file-exists? f.pdf) (set! g (path-replace-extension g ".pdf"))])
    (format "link:{pathwayrootdir}~a[~a]" g link-text)))

(define *lesson-summary-file* #f)

(define *asciidoctor*
  (format "asciidoctor -a linkcss -a proglang=~a -a pathway=~a -a stylesheet=~acurriculum.css"
          *proglang*
          (getenv "SRCPATHWAY")
          *pathway-root-dir*))

(define *standards-dictionaries*
  (map car *standards-alist*))

(define (preproc-n-asciidoctor in-file)
  (let ([out-file (path-replace-extension in-file ".asc")]
        [exercises-done '()]
        [glossary-items '()]
        [standards-met '()]
        [dictionaries-represented '()]
        [lesson-glossary-accumulator "lesson-glossary.txt"]
        [lesson-standards-accumulator "lesson-standards.txt"]
        ;[materials '()]
        ;[preparation-items '()]
        [first-subsection-reached? #f]
        [title-reached? #f]
        [page-title #f]
        [comment-before-title #f]
        )
    ;
    (define (display-title i o)
      (let ([title (string-trim (read-line i))])
        (set! page-title title)
        (when (getenv "LESSONPLAN")
          (call-with-output-file "index-title.txt"
            (lambda (o)
              (display title o) (newline o))
            #:exists 'replace))
        #|
        (unless (getenv "TEACHER_RESOURCES")
          (fprintf o "[.lesson-title]\n"))
        |#
        (let ([header-with-logo? (or (getenv "LESSONPLAN")
                                     ;(getenv "NARRATIVE")
                                     (getenv "TEACHER_RESOURCES"))])
          (display #\= o) (display #\space o)
          (when header-with-logo?
            ;TODO repl w enclose-span
            (display-begin-span ".bootstraplogo" o)
            (fprintf o "image:{pathwayrootdir}bootstraplogo.png[]")
            (display-end-span o)
            ;(fprintf o "\n\n")
            (display " " o)
            )
          (when header-with-logo? (display-begin-span ".bootstrapheader" o))
          (display title o)
          (when header-with-logo? (display-end-span o))
          (newline o))))
    ;
    (define (display-lesson-description desc o)
      (call-with-output-file "index-desc.txt"
        (lambda (o)
          (display desc o) (newline o))
        #:exists 'replace)
      (display desc o)
      (newline o))
    ;
    (define (add-exercise exercise)
      ;(printf "doing add-exercise ~s (i= ~a, w= ~a, l= ~a)\n" exercise in-file (getenv "WORKBOOK") (getenv "LESSON"))
      (let ([exer.html (path-replace-extension exercise ".html")])
        (when (getenv "WORKBOOK")
          ;(printf "adding exercise ~a ~a\n" exer.html page-title)
          (set! exercises-done (cons (list exer.html page-title) exercises-done)))))
    ;
    (define (add-exercise-title name)
      (when (getenv "EXERCISE")
        (let ([ex-ti-file (path-replace-extension in-file ".title")])
          (call-with-output-file ex-ti-file
            (lambda (o)
              (display name o)
              (newline o))
            #:exists 'replace))))
    ;
    (define (add-standard x lesson lesson-title o)
      ;(printf "doing add-standard ~a ~a ~a\n" x lesson lesson-title)
      (let-values ([(sublist-item c dict) (assoc-standards x)])
        (cond [c (let ([std (list-ref c 0)])
                   (when (and o (getenv "LESSON"))
                     (fprintf o "**~a**: ~a~n~n"
                              std (list-ref c 1)))
                   (cond [(assoc std standards-met) =>
                          (lambda (c0)
                            (when sublist-item
                              (let ([sublist-items (list-ref c0 1)])
                                (box-add-new! sublist-item sublist-items)))
                            (unless (getenv "LESSON")
                              (box-add-new! (list lesson lesson-title)
                                            (list-ref c0 4)))
                            )]
                         [else
                           (let ([sublist-items
                                   (box (if sublist-item
                                            (list sublist-item)
                                            '()))])
                             (unless (member dict dictionaries-represented)
                               (set! dictionaries-represented (cons dict dictionaries-represented)))
                             (set! standards-met
                               (cons (list std sublist-items c dict
                                           (box (list (list lesson lesson-title))))
                                     standards-met)))]))]
              [else (printf "Standard ~a not found~%" x)]
              )))
    ;
    (define (link-to-lessons-in-pathway o)
      ;(printf "link-to-lessons-in-pathway~n")
      ;(include-glossary o) ;not needed
    ;
      (let ([lessons (call-with-input-file "workbook-index.rkt" read)])
      ;
        ;(fprintf o "~n.Lessons Used in This Pathway\n")
        (print-lessons-intro o)
        ;(fprintf o "[#lesson-list]~%")
        (for ((lesson lessons))
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

      (let ([lessons-file "pathway-lessons.asc"]
            [lessons-toc-file "pathway-lessons-toc.asc"])

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
                          (format "./lessons/~a/~a" lesson lesson-glossary-accumulator)]
                        [lesson-standards-file
                          (format "./lessons/~a/~a" lesson lesson-standards-accumulator)]
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
                                  (cond [s (unless (member s glossary-items)
                                             (set! glossary-items
                                               (cons s glossary-items)))]))
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
    ;

    (when (getenv "LESSONPLAN")
      (let ((lesson (getenv "LESSON")))
        (for ([x *lessons-and-standards*])
          (when (string=? (car x) lesson)
            (for ([s (cdr x)])
              (add-standard s lesson #f #f))))))
    ;
    (set! dictionaries-represented
      (sort dictionaries-represented string-ci<=?))
    ;
    (when (getenv "NARRATIVE")
      (print-menubar "index"))
    ;
    (call-with-input-file in-file
      (lambda (i)
        (call-with-output-file out-file
          (lambda (o)
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
                               [(string=? directive "vocab")
                                (let* ([arg (read-group i directive)]
                                       [s (assoc-glossary arg *glossary-list*)])
                                  (when (string=? arg "")
                                    (printf "WARNING: Directive @vocab has ill-formed argument~%"))
                                  (display arg o)
                                  (cond [s (unless (member s glossary-items)
                                             (set! glossary-items (cons s glossary-items)))]
                                        [else (printf "Item ~a not found in glossary~%"
                                                      arg)]))]
                               [(string=? directive "std")
                                ;FIXME maybe remove this directive?
                                (let ([args (read-commaed-group i directive)])
                                  (when (empty? args)
                                    (printf "WARNING: Directive @std has ill-formed argument~%"))
                                  (for-each
                                    (lambda (arg)
                                      (add-standard arg #f #f o)
                                      )
                                    args))]
                               [(string=? directive "image")
                                (let ([args (read-commaed-group i directive)])
                                  (display (make-image (car args) (cdr args)) o))]
                               [(or (string=? directive "worksheet-link")
                                    (string=? directive "worksheet-include")
                                    (string=? directive "exercise-link"))
                                (let* ([include? (string=? directive "worksheet-include")]
                                       [exercise-as-is? (string=? directive "exercise-link")]
                                       [args (read-commaed-group i directive)]
                                       [n (length args)]
                                       [page (car args)]
                                       [link-text (if (> n 1) (cadr args) "")]
                                       [page-compts (regexp-split #rx"/" page)]
                                       [first-compt (car page-compts)])
                                  (case (length page-compts)
                                    [(1)
                                     (let* ([pointer (car page-compts)]
                                            [actual-url (assoc pointer *external-url-index*)])
                                       (when (string=? link-text "")
                                         (set! link-text pointer))
                                       (unless actual-url
                                         (printf "WARNING: Unresolved external link ~a~n" pointer))
                                       (fprintf o "link:~a[~a]"
                                                (if actual-url (cadr actual-url) pointer)
                                                (cond ((not actual-url)
                                                       (format "Missing external link for ~a: ~a"
                                                               pointer link-text))
                                                      (else link-text)))
                                       )
                                     ]
                                    [(2)
                                     (let ([second-compt (cadr page-compts)]
                                           [lesson-dir (getenv "LESSON")])
                                       (cond [(or (string=? first-compt "exercises")
                                                  (string=? first-compt "exercises-sols"))
                                              (add-exercise (format "~a/~a" lesson-dir page))
                                              (cond [lesson-dir
                                                      (display (make-exercise-link
                                                                 lesson-dir
                                                                 first-compt
                                                                 second-compt
                                                                 link-text
                                                                 #:include? include?
                                                                 #:as-is? exercise-as-is?) o)]
                                                    [else
                                                      (printf "WARNING: Incomplete exercise link ~a~n"
                                                              page)])]
                                             [(or (string=? first-compt "workbook-pages")
                                                  (string=? first-compt "workbook-sols-pages"))
                                              (cond [lesson-dir
                                                      (display (make-worksheet-link lesson-dir
                                                                                    first-compt
                                                                                    (cadr page-compts)
                                                                                    link-text) o)]
                                                    [else
                                                      (printf "WARNING: Incomplete worksheet link ~a~n"
                                                              page)])]
                                             [else
                                               (display (make-lesson-link
                                                          first-compt
                                                          (cdr page-compts)
                                                          link-text) o)]))]
                                    [(3)
                                     (let ([second-compt (cadr page-compts)]
                                           [third-compt (caddr page-compts)])
                                       (cond [(or (string=? second-compt "exercises")
                                                  (string=? second-compt "exercises-sols"))
                                              (add-exercise page)
                                              (display (make-exercise-link
                                                         first-compt
                                                         second-compt
                                                         third-compt
                                                         link-text
                                                         #:include? include?
                                                         #:as-is? exercise-as-is?) o)]
                                             [(or (string=? second-compt "workbook-pages")
                                                  (string=? second-compt "workbook-sols-pages"))
                                              (display (make-worksheet-link first-compt
                                                                            second-compt
                                                                            third-compt link-text) o)]
                                             ;(else (printf "Bad worksheet link ~a~n" page))
                                             [else
                                               (display (make-lesson-link first-compt
                                                                          (cdr page-compts)
                                                                          link-text) o)

                                               ]
                                             ))]
                                    [else
                                      (display (make-lesson-link first-compt
                                                                 (cdr page-compts)
                                                                 link-text) o)]

                                    ))]
                               [(string=? directive "link")
                                (let* ([args (read-commaed-group i directive)]
                                       [adocf (car args)]
                                       [htmlf (path-replace-extension adocf ".html")]
                                       [pdff (path-replace-extension adocf ".pdf")]
                                       [f adocf]
                                       [link-text (string-join
                                                    (map string-trim (cdr args)) ", ")])
                                  ;(printf "doing @link of ~s~n" args)
                                  (cond [(file-exists? htmlf) (set! f htmlf)]
                                        [(file-exists? pdff) (set! f pdff)])
                                  (fprintf o "link:~a[~a~a]" f link-text
                                           (if (or (getenv "LESSONPLAN")
                                                   (getenv "TEACHER_RESOURCES"))
                                               ", window=\"_blank\"" "")))]
                               [(string=? directive "lesson-description")
                                (unless (getenv "LESSONPLAN") ;TODO or LESSON or both?
                                  (error 'adoc-preproc.rkt "@lesson-description valid only in lesson plan"))
                                (display-lesson-description (read-group i directive) o)]
                               [(string=? directive "solutions-workbook")
                                (unless (getenv "TEACHER_RESOURCES")
                                  (error 'adoc-preproc.rkt "@solutions-workbook valid only in teacher resources directory~n"))
                                (fprintf o "link:./protected/pd-workbook.pdf[Teacher's PD Workbook]")
                                (newline o)
                                (fprintf o "link:./protected/workbook-sols.pdf[Teacher's Workbook, with Solutions]")
                                ]
                               [(string=? directive "do")
                                (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                                  (for-each massage-arg exprs))]
                               [(string=? directive "show")
                                (let ([exprs (string-to-form (read-group i directive #:scheme? #t))])
                                  (for-each
                                    (lambda (s)
                                      (display (massage-arg s) o))
                                    exprs))]
                               [(assoc directive *macro-list*) =>
                                                               (lambda (s)
                                                                 (display (cadr s) o))]
                               [(assoc directive *function-list*) =>
                                                                  (lambda (f)
                                                                    (let ([g (read-group i directive)])
                                                                      (let ([args (string-to-form g)])
                                                                        (let-values ([(key-list key-vals args)
                                                                                      (rearrange-args args)])
                                                                          (add-exercise-title (car args))
                                                                          (display (keyword-apply (cadr f) key-list key-vals args) o)))))]
                               [else
                                 (printf "WARNING: Unrecognized directive @~a~%" directive)
                                 #f]))]
                      [(and (or (getenv "LESSON")
                                (getenv "LESSONPLAN")
                                (getenv "NARRATIVE")
                                (getenv "TEACHER_RESOURCES"))
                            beginning-of-line? (char=? c #\=))
                       (set! beginning-of-line? #f)
                       (cond [title-reached?
                               (cond [first-subsection-reached? #f]
                                     [(check-first-subsection i o)
                                      (set! first-subsection-reached? #t)
                                      (when (getenv "LESSONPLAN")
                                        (include-standards dictionaries-represented o)
                                        (include-glossary o))]
                                     [else #f])
                               (cond [(getenv "LESSON")
                                      (display-section-markup i o)]
                                     [else (display c o)])]
                             [else
                               (set! title-reached? #t)
                               (display-title i o)
                               (when (getenv "TEACHER_RESOURCES")
                                 ;(printf "teacher resource autoloading stuff\n")
                                 (newline o)
                                 (fprintf o (create-workbook-links)))])]
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
                                     [else (error ' preproc-n-asciidoctor "deadc0de")])]
                              [else (display c o)])])
                    (loop)))))

            (when (getenv "NARRATIVE")
              (link-to-lessons-in-pathway o)
              (create-standards-subfile standards-met dictionaries-represented)

              (print-other-resources-intro o)
              (print-link-to-glossary o)
              (print-link-to-standards o)
              (print-link-to-student-workbook o)
              (print-link-to-teacher-resources o)
              (print-link-to-forum o)

              )

            (when (getenv "LESSONPLAN")
              (create-standards-subfile standards-met dictionaries-represented))

            (unless #f ;(getenv "EXERCISE")
              (fprintf o "\n\n")
              (fprintf o "[.acknowledgment]\n")
              (fprintf o "--\n")
              (fprintf o (create-acknowledgment))
              (fprintf o "\n--\n\n")
              (fprintf o "[.copyright]\n")
              (fprintf o "--\n")
              (fprintf o "link:http://creativecommons.org/licenses/by-nc-nd/4.0/[image:{pathwayrootdir}CCbadge.png[], window=\"_blank\"]\n")
              (fprintf o (create-copyright *copyright-name* *copyright-author*))
              (fprintf o "\n--\n")
              )
            )

          #:exists 'replace)))
  ;

  (when (or (getenv "NARRATIVE")
            (getenv "LESSONPLAN"))
    (create-glossary-subfile glossary-items))

  ;(printf "exercises-done = ~s\n" exercises-done)

  (when (getenv "WORKBOOK")
    ;(printf "Adding exercises ~a\n" exercises-done)
    (call-with-output-file *pathway-exercises-file*
      (lambda (o)
        (for-each
          (lambda (f)
            (fprintf o "(\"~a\" ~s)\n" (car f) (cadr f))
            )
          (reverse exercises-done)))
      #:exists 'append))

  (when (getenv "LESSONPLAN")
    (accumulate-glossary-and-standards glossary-items standards-met))

  (asciidoctor out-file)))

(define (asciidoctor file)
  ;(printf "asciidoctor ~a~n" file)
  (system (format "~a -a pathwayrootdir=~a ~a" *asciidoctor* *pathway-root-dir* file))
  (void)
  )

(define (create-glossary-subfile glossary-items)
  ;(printf "doing create-glossary-and-standards-subfiles ~a ~a ~a\n" (getenv "NARRATIVE") glossary-items standards-met)
  (print-menubar "index-glossary")
  (call-with-output-file "index-glossary.asc"
    (lambda (op)
      (unless (empty? glossary-items)
        (set! glossary-items
          (sort glossary-items #:key car string-ci<=?))
        (fprintf op (if (getenv "LESSON")
                        ".Glossary\n"
                        "= Glossary\n\n"))
        (fprintf op "[.glossary]~%")
        (for-each
          (lambda (s)
            ;(fprintf op "* *~a*: ~a~%" (car s) (cadr s))
            (fprintf op "~a:: ~a~%" (car s) (cadr s))
            )
          glossary-items)
        (fprintf op "~%~%")))
    #:exists 'replace))

(define (create-standards-section dict standards-met op)
  (fprintf op "\n[.alignedStandards.standards-~a]\n" dict)
      (fprintf op (if (getenv "LESSON")
                      ".~a Standards Statements\n"
                      "== ~a Standards Statements\n\n") dict)
  (fprintf op "[.standards-hierarchical-table]~%")
  (for-each
    (lambda (s)
      ;(printf "s= ~s\n" s)
      (let ([sublist-items (unbox (list-ref s 1))]
            [s (list-ref s 2)]
            ;[dict (list-ref s 3)]
            [lessons (unbox (list-ref s 4))])
        (fprintf op "~a:: " (car s))
        (fprintf op "~a\n" (cadr s))
        (unless (getenv "LESSON")
          (when (> (length lessons) 0)
            (fprintf op "{startsb}See: ~a.{endsb}\n"
                     (string-join
                       (map
                         (lambda (x)
                           (format " link:./lessons/~a/index.html[~a]" (car x) (cadr x)))
                         lessons) ";"))))
        (for-each (lambda (n)
                    (fprintf op "** ~a~%" (list-ref s (+ n 1)))
                    ;(fprintf op "** ~a~%" (list-ref s (+ n 1)))
                    )
                  sublist-items)))
    standards-met)
  (fprintf op "\n\n"))

(define (display-standards-selection dictionaries-represented o)
  (print-standards-js o)
  (cond [(getenv "NARRATIVE")
         (display
           (mstring
             "\nThis pathway aligns with several important teaching standards."
             "Select particular standards from the following menu to see"
             "which items in the standards are met.\n\n")
           o)]
        [else (display "Relevant Standards\n" o)])
  (display (enclose-tag "select" ".standardsAlignmentSelect"
             #:attribs
             (format  " multiple onchange=\"showStandardsAlignment()\" style=\"height: ~apx\"" 75)
             (string-join
               (map (lambda (dict)
                      (enclose-tag "option" ""
                        #:attribs (format " value=\"standards-~a\"" dict)
                        dict))
                    dictionaries-represented)
               "\n")) o)
  (display "\n\n" o))

(define (create-standards-subfile standards-met dictionaries-represented)
  ;(printf "doing create-standards-subfiles ~s\n" standards-met)
  (when (getenv "NARRATIVE")
    (print-menubar "index-standards"))
  (call-with-output-file "index-standards.asc"
    (lambda (op)
      (unless (empty? standards-met)
        (when (getenv "NARRATIVE")
          (display-standards-selection dictionaries-represented op))
        (when (getenv "LESSON")
          (fprintf op (mstring
                        "\n[.alignedStandardsIntro]"
                        "_Select one or more standards from the menu on the left (⌘-click"
                        "on Mac, Ctrl-click elsewhere)._\n\n")))
        (for ((dict dictionaries-represented))
          (let ((dict-standards-met
                  (filter (lambda (s) (string=? (list-ref s 3) dict))
                          standards-met)))
            (unless (empty? dict-standards-met) ;it will never be empty!
              (create-standards-section
                dict
                (sort dict-standards-met #:key car string-ci<=?) op))))))))

(define (accumulate-glossary-and-standards glossary-items standards-met)
  ;(printf "doing accumulate-glossary-and-standards\n")
  (call-with-output-file "lesson-glossary.txt"
    (lambda (op)
      (for-each (lambda (s)
                  (fprintf op "~s~n" (car s)))
                glossary-items))
    #:exists 'replace)
  (call-with-output-file "lesson-standards.txt"
    (lambda (op)
      (for-each (lambda (s)
                  (fprintf op "~s~n" (car s)))
                standards-met))
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
  (let ((ans (intersperse-spaces-aux args)))
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
        [else (error 'sexp->arith "unknown s-exp ~s" e)]))

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
  (string-append
    (format "@CURRICULUMSCRIPT")
    (format "@BEGINCURRICULUMSCRIPT\\displaystyle ")
    (sexp->arith e)
    (format "@ENDCURRICULUMSCRIPT")))

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
        [else (error 'sexp->block "unknown s-exp")]))

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
    (error 'open-response-exercise "Unexpected answer type ~a\n" answer-type))
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
                     (error 'matching-exercise-answers "Couldn't find ~a in ~a\n"
                            ansC presented-ans))
                   (enclose-div ".labeldRightColumn"
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
    (error 'adoc-preproc.rkt "Exactly one arg accepted"))
  (preproc-n-asciidoctor (car cl-args)))

;(void)
