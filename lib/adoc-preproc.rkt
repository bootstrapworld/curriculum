#!/usr/bin/env racket

#lang racket

(require "defines.rkt")
(require "create-copyright.rkt")

(define *base-namespace* (make-base-namespace))

(define (read-word i)
  (let loop ([r '()])
    (let ([c (peek-char i)])
      (if (or (char-alphabetic? c) (char=? c #\-))
          (loop (cons (read-char i) r))
          (if (null? r) ""
              (list->string (reverse r)))))))

(define (read-group i directive)
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
                     [(char=? c #\")
                      (loop (cons c r) #f nesting #t #f)]
                     [(member c '(#\space #\tab #\newline #\return))
                      (loop (if in-space? r (cons #\space r)) #t nesting #f #f)]
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

(define (display-begin-span span-args o)
  (set! span-args (map string-trim span-args))
  (let ([classes (map (lambda (s) (substring s 1))
                      (filter (lambda (s) (char=? (string-ref s 0) #\.)) span-args))]
        [ids (map (lambda (s) (substring s 1))
                  (filter (lambda (s) (char=? (string-ref s 0) #\#)) span-args))])
    (when (> (length ids) 1)
      (error 'span "Too many ids"))
    (display "@CURRICULUMSPAN" o)
    (when (pair? classes)
      (display "class=\"" o)
      (display (string-join classes " ") o)
      (display "\" " o))
    (when (pair? ids)
      (display "id=\"" o)
      (display (car ids) o)
      (display "\"" o))
    (display "@BEGINCURRICULUMSPAN" o)))

(define (display-end-span o)
  (display "@ENDCURRICULUMSPAN" o))

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

(define (assoc-standards std L)
  ;(printf "doing assoc-standards ~s\n" std)
  (let* ([std-bits (regexp-split #rx"&" std)]
         [std (list-ref std-bits 0)]
         [sublist-item #f])
    (let ([c (assoc std L)])
      (when (>= (length std-bits) 3)
        (set! sublist-item (string->number (list-ref std-bits 2))))
      ;(printf "returning (~s ~s)\n" c sublist-item)
      (list sublist-item c))))

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

(define (display-lesson-description desc o)
  (call-with-output-file "index-desc.txt"
    (lambda (o)
      (display desc o) (newline o))
    #:exists 'replace)
  (display desc o) (newline o))

(define (string->form s)
  (call-with-input-string s
    (lambda (i)
      (let loop ([r '()])
        (let ([x (read i)])
          (if (eof-object? x) (reverse r)
              (loop (cons x r))))))))

(define (rearrange-args args)
  ;(printf "doing rearrange-args ~s\n" args)

  (define (massage-arg arg)
    (eval arg *base-namespace*))

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

(define (include-glossary o)
  ;(printf "include-glossary\n")
  (newline o)
  (newline o)
  (when (getenv "NARRATIVE") (error ' include-glossary "deadc0de"))
  (fprintf o "include::./~a[]~%~%" "index-glossary.asc")
  ;(fprintf o "include::./~a[]~%~%" "index-standards.asc")
  )

(define (include-workbook-and-solutions-files o)
  (fprintf o "\n== Workbooks\n\n")
  (fprintf o "link:./protected/workbook-sols.pdf[Teacher Workbook]\n\n")
  (fprintf o "link:./protected/pd-workbook.pdf[PD Workbook]\n\n")
  #;(let ([exercises
          (call-with-input-file *pathway-exercises-file*
            (lambda (i)
              (let loop ([r '()])
                (let ([x (read i)])
                  (if (eof-object? x) (reverse r)
                      (loop (cons x r)))))))])
    ;(printf "exercises= ~s\n" exercises)
    (fprintf o "[.exercises_and_solutions]\n")
    (fprintf o "== Exercises and Solutions\n\n")
    (fprintf o "|===\n")
    (for-each
      (lambda (ex-ti)
        (let* ([ex (car ex-ti)] [ti (cadr ex-ti)]
               [ex-sol (regexp-replace #rx"/exercises/" ex "/exercises-sols/")])
          (unless ti
            (let ([ex-ti (path-replace-extension
                           (string-append *pathway-root-dir* "lessons/" ex) ".title")])
              (when (file-exists? ex-ti)
                (set! ti (call-with-input-file ex-ti read)))))
          (unless ti (set! ti ""))
          (fprintf o "|~a |[link:../lessons/~a[original] : link:../lessons/~a[answers]]\n"
                   ti ex ex-sol)
          ))
      exercises)
    (fprintf o "|===\n\n")))

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

(define (make-worksheet-link lesson workbook-dir snippet link-text)
  ;(printf "make-worksheet-link ~a ~a ~a ~a\n" lesson workbook-dir snippet link-text)
  (let (
        [snippet.adoc (path->string (path-replace-extension snippet ".adoc"))]
        [snippet.html (path->string (path-replace-extension snippet ".html"))]
        [snippet.pdf (path->string (path-replace-extension snippet ".pdf"))]
        [link-text (if (string=? link-text "") link-text (string-append link-text ", "))]
        [pno #f]
        )
    (let loop ([i 0])
      (if (>= i *index-length*)
          (printf "WARNING: Missing worksheet link ~a~n" snippet)
          (let* ([entry (list-ref *index-list* i)]
                 [lesson2 (car entry)] [snippet2 (cadr entry)])
            (cond [(and (string=? lesson lesson2)
                        (or (string=? snippet.adoc snippet2)
                            (string=? snippet.html snippet2)
                            (string=? snippet.pdf snippet2)))
                   (set! pno (+ i 1))]
                  [else (loop (+ i 1))]))))
    (unless pno
      (set! pno "?")
      (printf "WARNING: Worksheet link ~a ~a ~a ~a with no page number~n"
              lesson workbook-dir snippet link-text))
    (let* ([g (string-append "lessons/" lesson "/" workbook-dir "/" snippet)]
           [f (string-append *pathway-root-dir* g)])
      (set! snippet.html (path-replace-extension f ".html"))
      (set! snippet.pdf (path-replace-extension f ".pdf"))
      (cond [(file-exists? snippet.html) (set! g (path-replace-extension g ".html"))]
            [(file-exists? snippet.pdf) (set! g (path-replace-extension g ".pdf"))])
      (format "link:{pathwayrootdir}~a[~aPage ~a~a]" g link-text pno
              (if (getenv "LESSONPLAN") ", window=\"_blank\"" ""))
      ;(format "link:{pathwayrootdir}~a[~a]" g link-text)
      )))

(define (make-exercise-link lesson exer link-text include?)
  ;(printf "make-exercise-link ~a ~a ~a\n" lesson exer link-text)
  (let* ([solutions-mode? (getenv "SOLUTIONS")]
         [g (string-append "lessons/" lesson
                           (if solutions-mode? "/exercises-sols/" "/exercises/") exer)]
         [f (string-append *pathway-root-dir* g)]
         [exer.asc (path-replace-extension f ".asc")]
         [exer.html (path-replace-extension f ".html")]
         [exer.pdf (path-replace-extension f ".pdf")])
    (cond [(file-exists? exer.html) (set! g (path-replace-extension g ".html"))]
          [(file-exists? exer.pdf) (set! g (path-replace-extension g ".pdf"))])
    (cond [include?
            (format "include::~a[]" exer.asc)]
          [else
            (format "link:{pathwayrootdir}~a[~a]" g link-text)])))

(define (display-comment prose o)
  (display "@CURRICULUMCOMMENT\n" o)
  (display "++++\n" o)
  (display prose o)
  (display "\n++++\n" o)
  (display "@ENDCURRICULUMCOMMENT" o))


(define (make-image img opts)
  (let ([lesson (getenv "LESSON")]
        [opts (string-join opts ", ")])
    (if lesson
        (format "image::{pathwayrootdir}lessons/~a/~a[~a]" lesson img
                opts)
        (format "image::~a[~a]" img opts))))

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

;(define *all-glossary-items* '())

(define *asciidoctor*
  (format "asciidoctor -a linkcss -a proglang=~a -a stylesheet=curriculum.css" (getenv "PROGLANG")))

(define (preproc-n-asciidoctor in-file)
  (let ([out-file (path-replace-extension in-file ".asc")]
        [exercises-done '()]
        [glossary-items '()]
        [standards-met '()]
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
        (display #\= o) (display #\space o) (display title o) (newline o)))
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
      (let* ([s (assoc-standards x *standards-list*)]
             [sublist-item (list-ref s 0)]
             [c (list-ref s 1)])
        (cond [c (let ([std (list-ref c 0)])
                   (when (getenv "LESSON")
                     (fprintf o "**~a**: ~a~n~n"
                              std (list-ref c 1)))
                   (cond [(assoc std standards-met) =>
                          (lambda (c0)
                            (when sublist-item
                              (let ([sublist-items (list-ref c0 1)])
                                (box-add-new! sublist-item sublist-items)))
                            (unless (getenv "LESSON")
                              (box-add-new! (list lesson lesson-title)
                                            (list-ref c0 3)))
                            )]
                         [else
                           (let ([sublist-items
                                   (box (if sublist-item
                                            (list sublist-item)
                                            '()))])
                             (set! standards-met
                               (cons (list std sublist-items c
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
            #;(when lesson-description
            (display lesson-description o)
            ;(newline o)
            )
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
                      (fprintf lo "include::./lessons/~a/index.asc[leveloffset=+1]~n~n"
                               lesson))
                    )))
              #:exists 'replace))
          #:exists 'replace)
        (asciidoctor lessons-file)
        (newline o))))
  ;
  (define span-stack '())
  (define (top-span-stack)
    (car span-stack))
  (define (grow-span-stack)
    (set! span-stack (cons 0 span-stack)))
  (define (pop-span-stack)
    (set! span-stack (cdr span-stack)))
  (define (increment-top-span-stack)
    (let ([n (car span-stack)])
      (set! span-stack (cons (+ n 1) (cdr span-stack)))))
  (define (decrement-top-span-stack)
    (let ([n (car span-stack)])
      (when (<= n 0)
        (error 'span "Bad @span: Check missing braces"))
      (set! span-stack (cons (- n 1) (cdr span-stack)))))
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
                              (display-begin-span (read-commaed-group i directive) o)
                              (grow-span-stack)]
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
                              ;(printf "doing @std\n")
                              (let ([args (read-commaed-group i directive)])
                                (when (empty? args)
                                  (printf "WARNING: Directive @std has ill-formed argument~%"))
                                (for-each
                                  (lambda (arg)
                                    (add-standard arg #f #f o))
                                  args))]
                             [(string=? directive "image")
                              (let ([args (read-commaed-group i directive)])
                                (display (make-image (car args) (cdr args)) o))]
                             [(or (string=? directive "worksheet-link")
                                  (string=? directive "worksheet-include"))
                              (let* ([include? (string=? directive "worksheet-include")]
                                     [args (read-commaed-group i directive)]
                                     [n (length args)]
                                     [page (car args)]
                                     [link-text (if (> n 1) (cadr args) "")]
                                     [page-compts (regexp-split #rx"/"  page)]
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
                                     (cond ((string=? first-compt "exercises")
                                            (add-exercise (format "~a/~a" lesson-dir page))
                                            (cond (lesson-dir
                                                    (display (make-exercise-link lesson-dir
                                                                                 second-compt
                                                                                 link-text
                                                                                 include?) o))
                                                  (else
                                                    (printf "WARNING: Incomplete exercise link ~a~n" page))))
                                           ((or (string=? first-compt "workbook-pages")
                                                (string=? first-compt "workbook-sols-pages"))
                                            (cond (lesson-dir
                                                    (display (make-worksheet-link lesson-dir
                                                                                  first-compt
                                                                                  (cadr page-compts)
                                                                                  link-text) o))
                                                  (else
                                                    (printf "WARNING: Incomplete worksheet link ~a~n" page))))
                                           (else
                                             (display (make-lesson-link
                                                        first-compt
                                                        (cdr page-compts)
                                                        link-text) o))))]
                                  [(3)
                                   (let ([second-compt (cadr page-compts)]
                                         [third-compt (caddr page-compts)])
                                     (cond ((string=? second-compt "exercises")
                                            (add-exercise page)
                                            (display (make-exercise-link first-compt
                                                                         third-compt
                                                                         link-text
                                                                         include?) o))
                                           ((or (string=? second-compt "workbook-pages")
                                                (string=? second-compt "workbook-sols-pages"))
                                            (display (make-worksheet-link first-compt
                                                                          second-compt
                                                                          third-compt link-text) o))
                                           ;(else (printf "Bad worksheet link ~a~n" page))
                                           (else
                                             (display (make-lesson-link first-compt
                                                                        (cdr page-compts)
                                                                        link-text) o)

                                             )
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
                                     [f adocf])
                                ;(printf "doing @link of ~s~n" args)
                                (cond [(file-exists? htmlf) (set! f htmlf)]
                                      [(file-exists? pdff) (set! f pdff)])

                                (fprintf o "link:~a[~a~a]" f
                                         (string-join
                                           (map string-trim (cdr args)) ", ")
                                         (if (getenv "LESSONPLAN") ", window=\"_blank\"" "")))]
                             [(string=? directive "lesson-description")
                              (unless (getenv "LESSON")
                                (error 'adoc-preproc.rkt "@lesson-description valid only in lesson plan"))
                              (display-lesson-description (read-group i directive) o)]
                             [(string=? directive "solutions-workbook")
                              (unless (getenv "TEACHER_RESOURCES")
                                (error 'adoc-preproc.rkt "@solutions-workbook valid only in teacher resources directory~n"))
                              (fprintf o "link:./protected/pd-workbook.pdf[Teacher's PD Workbook]")
                              (newline o)
                              (fprintf o "link:./protected/workbook-sols.pdf[Teacher's Workbook, with Solutions]")
                              ]
                             [(assoc directive *macro-list*) =>
                              (lambda (s)
                                (display (cadr s) o))]
                             [(assoc directive *function-list*) =>
                              (lambda (f)
                                (let ([args (string->form (read-group i directive))])
                                  (let-values ([(key-list key-vals args)
                                                (rearrange-args args)])
                                    (add-exercise-title (car args))
                                    (display (keyword-apply (cadr f) key-list key-vals args) o))))]
                             [else
                               (printf "WARNING: Unrecognized directive @~a~%" directive)
                               #f]))]
                    [(and (or (getenv "LESSON")
                              (getenv "LESSONPLAN")
                              (getenv "TEACHER_RESOURCES"))
                          beginning-of-line? (char=? c #\=))
                     (set! beginning-of-line? #f)
                     (cond [title-reached?
                             (cond [first-subsection-reached? #f]
                                   [(check-first-subsection i o)
                                    (set! first-subsection-reached? #t)
                                    (when (getenv "LESSONPLAN")
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
                               (include-workbook-and-solutions-files o))])]
                    [(char=? c #\newline)
                     (newline o)
                     (set! beginning-of-line? #t)]
                    [else
                      (set! beginning-of-line? #f)
                      (cond [(and (pair? span-stack) (or (char=? c #\{) (char=? c #\})))
                             (cond [(char=? c #\{)
                                    (unless (= (top-span-stack) 0)
                                      (display c o))
                                    (increment-top-span-stack)]
                                   [(char=? c #\})
                                    (decrement-top-span-stack)
                                    (cond [(= (top-span-stack) 0)
                                           (pop-span-stack)
                                           (display-end-span o)]
                                          [else (display c o)])]
                                   [else (error ' preproc-n-asciidoctor "deadc0de")])]
                            [else (display c o)])])
                  (loop)))))

          (when (getenv "NARRATIVE")
            (link-to-lessons-in-pathway o)

            (print-other-resources-intro o)
            (print-link-to-glossary o)
            (print-link-to-standards o)
            (print-link-to-student-workbook o)
            (print-link-to-teacher-resources o)
            (print-link-to-forum o)

            )

          (when (or (getenv "NARRATIVE") (getenv "LESSONPLAN"))
            (fprintf o (create-copyright *copyright-name* *copyright-author*)))
          )

        #:exists 'replace)))
  ;

  (when (or (getenv "NARRATIVE")
            (getenv "LESSONPLAN"))
    (create-glossary-and-standards-subfiles glossary-items standards-met))

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

  (cond [(getenv "LESSONPLAN")
         (accumulate-glossary-and-standards glossary-items standards-met)]
        [(getenv "NARRATIVE")
         (asciidoctor "-a title=Glossary index-glossary.asc")
         (asciidoctor "-a title=Standards index-standards.asc")])

  (asciidoctor out-file)))

(define (asciidoctor file)
  ;(printf "asciidoctor ~a~n" file)
  (system (format "~a -a pathwayrootdir=~a ~a" *asciidoctor* *pathway-root-dir* file)))

(define (create-glossary-and-standards-subfiles glossary-items standards-met)
  ;(printf "doing create-glossary-and-standards-subfiles ~a ~a ~a\n" (getenv "NARRATIVE") glossary-items standards-met)
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
    #:exists 'replace)
  (call-with-output-file "index-standards.asc"
    (lambda (op)
      (unless (empty? standards-met)
        (set! standards-met
          (sort standards-met #:key car string-ci<=?))
        (fprintf op (if (getenv "LESSON")
                        ".Standards Statements\n"
                        "= Standards Statements\n\n"))
        ;(fprintf op "[#standards]~%")
        (fprintf op "[.standards-hierarchical-table]~%")
        (for-each
          (lambda (s)
            ;(printf "s= ~s\n" s)
            (let ([sublist-items (unbox (list-ref s 1))]
                  [lessons (unbox (list-ref s 3))]
                  [s (list-ref s 2)])
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
                          (fprintf op "** ~a~%" (list-ref s (+ n 1)))
                          )
                        sublist-items)))
          standards-met)
        (fprintf op "~%~%")))
    #:exists 'replace)
  ;(printf "create-glossary-and-standards-subfiles done\n")
  )

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
  ;(printf "done accumulate-glossary-and-standards\n")
  )

(require "glossary-terms.rkt")
(require "standards-dictionary.rkt")
(require "form-elements.rkt")
(require "function-directives.rkt")

(define (main cl-args)

  (for ((arg cl-args))
    ;only one though
    (preproc-n-asciidoctor arg))

  )

(main (current-command-line-arguments))

(void)
