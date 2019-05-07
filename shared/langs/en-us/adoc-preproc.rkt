#!/usr/bin/env racket

#lang racket

(define (read-word i)
  (let loop ((r '()))
    (let ((c (peek-char i)))
      (if (or (char-alphabetic? c) (char=? c #\-))
          (loop (cons (read-char i) r))
          (if (null? r) ""
              (list->string (reverse r)))))))

(define (read-group i)
  (let ((c (peek-char i)))
    (cond ((char=? c #\{)
           (read-char i)
           (let loop ((r '())
                      (in-space? #t)
                      (nesting 0)
                      (in-string? #f)
                      (in-escape? #f))
             (let ((c (read-char i)))
               (cond (in-escape? (loop (cons c r) #f nesting in-string? #f))
                     ((char=? c #\\)
                      (loop (cons c r) #f nesting in-string? #t))
                     (in-string?
                       (if (char=? c #\")
                           (loop (cons c r) #f nesting #f #f)
                           (loop (cons c r) #f nesting #t #f)))
                     ((char=? c #\")
                      (loop (cons c r) #f nesting #t #f))
                     ((member c '(#\space #\tab #\newline #\return))
                      (loop (if in-space? r (cons #\space r)) #t nesting #f #f))
                     ((char=? c #\{)
                      (loop (cons c r) #f (+ nesting 1) #f #f))
                     ((char=? c #\})
                      (if (= nesting 0)
                          (string-trim (list->string (reverse r)))
                          (loop (cons c r) #f (- nesting 1) #f #f)))
                     (else (loop (cons c r) #f nesting #f #f))))))
          (else
            (printf "Ill-formed metadata directive~%")
            ""))))

(define (read-commaed-group i)
  (let* ((g (read-group i))
         (n (string-length g)))
    (let loop ((i 0) (r '()))
      (if (>= i n)
          (map string-trim (reverse r))
          (let loop2 ((j i) (in-string? #f) (in-escape? #f))
            (if (>= j n) (loop j (cons (substring g i j) r))
                (let ((c (string-ref g j)))
                  (cond (in-escape?
                          (loop2 (+ j 1) in-string? #f))
                        ((char=? c #\\)
                         (loop2 (+ j 1) in-string? #t))
                        (in-string?
                          (if (char=? c #\")
                              (loop2 (+ j 1) #f #f)
                              (loop2 (+ j 1) #t #f)))
                        ((char=? c #\")
                         (loop2 (+ j 1) #t #f))
                        ((char=? c #\,)
                         (loop (+ j 1) (cons (substring g i j) r)))
                        (else (loop2 (+ j 1) #f #f))))))))))

(define (string-trim-dq s)
  (let ((n (string-length s)))
    (if (char=? (string-ref s 0) (string-ref s (- n 1)) #\")
        (substring s 1 (- n 1))
        s)))

(define (read-commaed-group-obs i)
  (map string-trim
       (regexp-split #rx"," (read-group i))))

(define (assoc-glossary term L)
  ;(printf "doing assoc-glossary ~s ~n" term)
  (let ((naive-singular (if (char-ci=? (string-ref term (- (string-length term) 1)) #\s)
                             (substring term 0 (- (string-length term) 1))
                             "")))
    ;(printf "naive sing = ~s~n" naive-singular)
    (let loop ((L L))
      (if (null? L) #f
          (let* ((c (car L))
                 (lhs (car c)))
            ;(printf "lhs = ~s~n" lhs)
            (or (cond ((string? lhs)
                       (and (or (string-ci=? lhs term)
                                (string-ci=? lhs naive-singular))
                            c))
                      ((list? lhs)
                       (and (memf (lambda (x) (string-ci=? x term)) lhs)
                            (list (car lhs) (cadr c))))
                      (else #f))
                (loop (cdr L))))))))

(define (assoc-standards std L)
  ;(printf "doing assoc-standards ~s\n" std)
  (let* ((std-bits (regexp-split #rx"&" std))
         (std (list-ref std-bits 0))
         (sublist-item #f))
    (let ((c (assoc std L)))
      (when (>= (length std-bits) 3)
        (set! sublist-item (string->number (list-ref std-bits 2))))
      ;(printf "returning (~s ~s)\n" c sublist-item)
      (list sublist-item c))))

(define (box-add-new! v bx)
  ;(printf "doing box-add-new! ~s ~s\n" v bx)
  (let ((vv (unbox bx)))
    (unless (member v vv)
      (set-box! bx (sort (cons v vv) <)))))

(define (check-first-subsection i o)
  (let ((c (peek-char i)))
    (if (eof-object? c) #f
        (char=? c #\=))))

(define (display-title i o)
  (let ((title (string-trim (read-line i))))
    (call-with-output-file "index-title.txt"
      (lambda (o)
        (display title o) (newline o))
      #:exists 'replace)
    (display #\= o) (display #\space o) (display title o) (newline o)))

(define (display-lesson-description desc o)
  (call-with-output-file "index-desc.txt"
    (lambda (o)
      (display desc o) (newline o))
    #:exists 'replace)
  (display desc o) (newline o))

(define (string->form s)
  (call-with-input-string s
    (lambda (i)
      (let loop ((r '()))
        (let ((x (read i)))
          (if (eof-object? x) (reverse r)
              (loop (cons x r))))))))

(define (rearrange-args args)
  (define (remove-quote arg)
    (if (and (list? arg)
             (= (length arg) 2)
             (eq? (car arg) 'quote))
        (cadr arg)
        arg))

  (define (sort-keyword-args args)
    (let ((args-paired (let loop ((args args) (r '()))
                         (if (null? args) r
                               (loop (cddr args)
                                     (cons (list (car args) (remove-quote (cadr args)))
                                         r))))))
      (sort args-paired keyword<? #:key car)))

  (let loop ((args args) (r '()))
    (if (null? args)
        (values '() '() (reverse r))
        (let ((arg (car args)))
          (cond ((keyword? arg)
                 (let ((kvkv (sort-keyword-args args)))
                   (values (map car kvkv) (map cadr kvkv) (reverse r))))
                (else
                  (loop (cdr args) (cons arg r))))))))

(define (include-glossary-and-standards-files o pathway?)
  ;(printf "include-glossary-and-standards-files~n")
  (newline o)
  (newline o)
  (cond (pathway?
          (fprintf o "link:./index-glossary.html[Glossary]~%~%")
          (fprintf o "link:./index-standards.html[Standards]~%~%"))
        (else
          (fprintf o "include::./~a[]~%~%" "index-glossary.asc")
          ;(fprintf o "include::./~a[]~%~%" "index-standards.asc")
          )))

(define *pathway-root-dir* (getenv "PATHWAYROOTDIR"))

(define *index-file* (string-append *pathway-root-dir* "workbook-page-index.rkt"))

(define *index-list* (call-with-input-file *index-file* read))

(define *index-length* (length *index-list*))

(define *external-url-index-file* (string-append *pathway-root-dir* "external-index.rkt"))

(define *external-url-index*
  (if (file-exists? *external-url-index-file*)
      (call-with-input-file *external-url-index-file* read)
      '()))

(define (make-worksheet-link lesson snippet link-text)
  ;(printf "make-worksheet-link ~a ~a ~a\n" lesson snippet link-text)
  (let (
        (snippet.adoc (path->string (path-replace-extension snippet ".adoc")))
        (snippet.html (path->string (path-replace-extension snippet ".html")))
        (snippet.pdf (path->string (path-replace-extension snippet ".pdf")))
        (link-text (if (string=? link-text "") link-text (string-append link-text ", ")))
        (pno "?")
        )
    (let loop ((i 0))
      (if (>= i *index-length*)
          (printf "Missing worksheet link ~a~n" snippet)
          (let* ((entry (list-ref *index-list* i))
                 (lesson2 (car entry)) (snippet2 (cadr entry)))
            (cond ((and (string=? lesson lesson2)
                        (or (string=? snippet.adoc snippet2)
                            (string=? snippet.html snippet2)
                            (string=? snippet.pdf snippet2)))
                   (set! pno (+ i 1)))
                  (else (loop (+ i 1)))))))
    (let* ((g (string-append "lessons/" lesson "/workbook-pages/" snippet))
           (f (string-append *pathway-root-dir* g)))
      (set! snippet.html (path-replace-extension f ".html"))
      (set! snippet.pdf (path-replace-extension f ".pdf"))
      (cond ((file-exists? snippet.html) (set! g (path-replace-extension g ".html")))
            ((file-exists? snippet.pdf) (set! g (path-replace-extension g ".pdf"))))
      (format "link:{pathwayrootdir}~a[~aPage ~a]" g link-text pno))))

(define (make-exercise-link lesson exer link-text include?)
  ;(printf "make-exercise-link ~a ~a ~a\n" lesson exer link-text)
  (let* ((g (string-append "lessons/" lesson "/exercises/" exer))
         (f (string-append *pathway-root-dir* g))
         (exer.asc (path-replace-extension f ".asc"))
         (exer.html (path-replace-extension f ".html"))
         (exer.pdf (path-replace-extension f ".pdf")))
    (cond ((file-exists? exer.html) (set! g (path-replace-extension g ".html")))
          ((file-exists? exer.pdf) (set! g (path-replace-extension g ".pdf"))))
    (cond (include?
            (format "include::~a[]" exer.asc))
          (else
            (format "link:{pathwayrootdir}~a[~a]" g link-text)))))

(define (make-image lesson img opts)
  (format "image::{pathwayrootdir}lessons/~a/~a[~a]" lesson img
          (string-join opts ", ")))

(define (make-lesson-link lesson file link-text)
  (let ((pno "?")
        (link-text (if (string=? link-text "") link-text (string-append link-text ", "))))
   (let loop ((i 0))
      (if (>= i *index-length*)
          (printf "Missing lesson in worksheet~a~n" lesson)
          (let* ((entry (list-ref *index-list* i))
                 (lesson2 (car entry)) )
            (cond ((string=? lesson lesson2)
                   (set! pno (+ i 1)))
                  (else (loop (+ i 1)))))))
    (format "link:{pathwayrootdir}lessons/~a/~a[~aPage ~a]" lesson file link-text pno)))

(define *lesson-summary-file* #f)

(define *all-glossary-items* '())

(define *asciidoctor* "asciidoctor -a linkcss -a stylesheet=curriculum.css")

(define (preproc-n-asciidoctor in-file)
  (let ((out-file (path-replace-extension in-file ".asc"))
        (glossary-items '())
        (standards-met '())
        (lesson-glossary-accumulator "lesson-glossary.txt")
        (lesson-standards-accumulator "lesson-standards.txt")
        ;(materials '())
        ;(preparation-items '())
        (first-subsection-reached? #f)
        (title-reached? #f)
        )
    (define (link-to-lessons-in-pathway o)
      ;(printf "link-to-lessons-in-pathway~n")
      (include-glossary-and-standards-files o #t)

      (fprintf o "~n.Workbooks~n[verse]~n")
      (fprintf o "link:./workbook/workbook.pdf[Student Workbook]~n")
      (fprintf o "link:./resources/protected/workbook-sols.pdf[Teacher Workbook]~n")

      (let ((lessons (call-with-input-file "workbook-index.rkt" read)))

        (fprintf o "~n.Lessons used in this pathway~n")
        (fprintf o "[#lesson-list]~%")
        (for ((lesson lessons))
          (let ((lesson-title-file (format "./lessons/~a/index-title.txt" lesson))
                (lesson-desc-file (format "./lessons/~a/index-desc.txt" lesson))
                (lesson-title lesson)
                (lesson-description #f))
            (when (file-exists? lesson-title-file)
                (set! lesson-title (call-with-input-file lesson-title-file read-line)))
            (when (file-exists? lesson-desc-file)
              (set! lesson-description
                (call-with-input-file lesson-desc-file
                  (lambda (i)
                    (let ((r ""))
                      (let loop ()
                        (let ((x (read-line i)))
                          (unless (eof-object? x)
                            (set! r (string-append r "\n" x))
                            (loop))))
                      r)))))
            (fprintf o "link:./lessons/~a/index.html[~a] ::" lesson lesson-title)
            (when lesson-description
              (display lesson-description o)
              ;(newline o)
              )
            (newline o)))

        (let ((lessons-file "pathway-lessons.asc")
            (lessons-toc-file "pathway-lessons-toc.asc"))
          (fprintf o "link:./pathway-lessons.html[Lessons Used in This Pathway (Single Page)]~n~n")
          (fprintf o "link:./resources/index.html[Teacher Resources]~n~n")

        (call-with-output-file lessons-file
          (lambda (lo)
            (fprintf lo "= Lessons Used in This Pathway~n~n")
            (fprintf lo "include::~a[]~n~n" lessons-toc-file)
            (call-with-output-file lessons-toc-file
              (lambda (toco)
                (fprintf toco "[verse]~n")
                (for ((lesson lessons))
                  (let ((lesson-glossary-file
                          (format "./lessons/~a/~a" lesson lesson-glossary-accumulator))
                        (lesson-standards-file
                          (format "./lessons/~a/~a" lesson lesson-standards-accumulator)))

                    (when (file-exists? lesson-glossary-file)
                      (call-with-input-file lesson-glossary-file
                        (lambda (i)
                          (let loop ()
                            (let ((x (read i)))
                              (unless (eof-object? x)
                                (let ((s (assoc-glossary x *glossary-list*)))
                                  (cond (s (unless (member s glossary-items)
                                             (set! glossary-items
                                               (cons s glossary-items))))))
                                (loop)))))))
                    ;(printf "took care of pw glossary~n")

                    (when (file-exists? lesson-standards-file)
                      (call-with-input-file lesson-standards-file
                        (lambda (i)
                          (let loop ()
                            (let ((x (read i)))
                              (unless (eof-object? x)
                                (let* ((s (assoc-standards x *standards-list*))
                                       (sublist-item (list-ref s 0))
                                       (c (list-ref s 1)))
                                  (cond (c (let ((std (list-ref c 0)))
                                             (cond ((assoc std standards-met) =>
                                                    (lambda (c0)
                                                      (when sublist-item
                                                        (let ((sublist-items (list-ref c0 1)))
                                                          (box-add-new! sublist-item sublist-items)))))
                                                   (else
                                                     (let ((sublist-items
                                                             (box (if sublist-item
                                                                      (list sublist-item)
                                                                      '()))))
                                                       (set! standards-met
                                                         (cons (list std sublist-items c)
                                                               standards-met)))))))))
                                (loop)))))))

                    ;(printf "took care of pw stds~n")

                    (fprintf lo "[[~a]]~n" lesson)
                    (fprintf toco "<<~a>>~n" lesson)
                    (fprintf lo "include::./lessons/~a/index.asc[leveloffset=+1]~n~n"
                             lesson)))) #:exists 'replace))
          #:exists 'replace)
        ;(printf "calling preproc-n-asciidoctor on grouped lessons~n")
        ;(preproc-n-asciidoctor lessons-file #:auxfile #t)
        (asciidoctor lessons-file)
        ;(printf "link-to-lessons-in-pathway done~n")
        (newline o))))
    (call-with-input-file in-file
      (lambda (i)
        (call-with-output-file out-file
          (lambda (o)
            (let ((beginning-of-line? #t))
            (let loop ()
              (let ((c (read-char i)))
                (unless (eof-object? c)
                  (cond
                      ((char=? c #\@)
                       (set! beginning-of-line? #f)
                       (let ((directive (read-word i)))
                         ;(printf "directive = ~s~%" directive)
                         (cond ((string=? directive "") (display c o))
                               ((string=? directive "vocab")
                                (let* ((arg (read-group i))
                                       (s (assoc-glossary arg *glossary-list*)))
                                  (when (string=? arg "")
                                    (printf "Directive @vocab has ill-formed argument~%"))
                                  (display arg o)
                                  (cond (s (unless (member s glossary-items)
                                             (set! glossary-items (cons s glossary-items))))
                                        (else (printf "Item ~a not found in glossary~%"
                                                      arg)))))
                               ((string=? directive "std")
                                ;(printf "doing @std\n")
                                (let ((args (read-commaed-group i)))
                                  (when (empty? args)
                                    (printf "Directive @std has ill-formed argument~%"))
                                  (for-each
                                    (lambda (arg)
                                      (let* ((s (assoc-standards arg *standards-list*))
                                             (sublist-item (list-ref s 0))
                                             (c (list-ref s 1)))
                                        (cond (c (let ((std (list-ref c 0)))
                                                   (fprintf o "~a: ~a~n~n"
                                                            std (list-ref c 1))
                                                   (cond ((assoc std standards-met) =>
                                                          (lambda (c0)
                                                            (when sublist-item
                                                              (let ((sublist-items (list-ref c0 1)))
                                                                (box-add-new! sublist-item
                                                                              sublist-items)))))
                                                         (else
                                                           (let ((sublist-items
                                                                   (box (if sublist-item
                                                                            (list sublist-item)
                                                                            '()))))
                                                             (set! standards-met
                                                               (cons (list std sublist-items c)
                                                                     standards-met)))))))
                                              (else (printf "Standard ~a not found~%" arg)))))
                                    args)))
                               ((string=? directive "image")
                                (let ((args (read-commaed-group i)))
                                  (display (make-image (getenv "LESSON") (car args) (cdr args)) o)))
                               ((or (string=? directive "worksheet-link")
                                    (string=? directive "worksheet-include"))
                                (let* ((include? (string=? directive "worksheet-include"))
                                       (args (read-commaed-group i))
                                       (n (length args))
                                       (page (car args))
                                       (link-text (if (> n 1) (cadr args) ""))
                                       (page-compts (regexp-split #rx"/"  page))
                                       (first-compt (car page-compts)))
                                  (case (length page-compts)
                                    ((1)
                                     (let* ((pointer (car page-compts))
                                            (actual-url (assoc pointer *external-url-index*)))
                                       (if actual-url
                                           (fprintf o "link:~a[~a]" (cadr actual-url)
                                                    (if (string=? link-text "")
                                                        pointer link-text))
                                           (printf "Unresolved external link ~a~n" pointer))))
                                    ((2)
                                     (let ((second-compt (cadr page-compts))
                                           (lesson-dir (getenv "LESSON")))
                                       (cond ((string=? first-compt "exercises")
                                              (cond (lesson-dir
                                                      (display (make-exercise-link lesson-dir
                                                                                   (cadr page-compts)
                                                                                   link-text
                                                                                   include?) o))
                                                    (else
                                                      (printf "Incomplete exercise link ~a~n" page))))
                                             ((string=? first-compt "workbook-pages")
                                              (cond (lesson-dir
                                                      (display (make-worksheet-link lesson-dir
                                                                                    (cadr page-compts)
                                                                                    link-text) o))
                                                    (else
                                                      (printf "Incomplete worksheet link ~a~n" page))))
                                             (else
                                               (display (make-lesson-link
                                                          first-compt
                                                          (cadr page-compts)
                                                          link-text) o)))))
                                    ((3)
                                     (let ((second-compt (cadr page-compts))
                                           (third-compt (caddr page-compts)))
                                       (cond ((string=? second-compt "exercises")
                                              (display (make-exercise-link first-compt
                                                                           third-compt
                                                                           link-text
                                                                           include?) o))
                                             ((string=? second-compt "workbook-pages")
                                              (display (make-worksheet-link first-compt
                                                                            third-compt link-text) o))
                                             (else (printf "Bad worksheet link ~a~n" page))))))))
                               ((string=? directive "link")
                                (let* ((args (read-commaed-group i))
                                       (adocf (car args))
                                       (htmlf (path-replace-extension adocf ".html"))
                                       (pdff (path-replace-extension adocf ".pdf"))
                                       (f adocf)
                                       )
                                  (cond ((file-exists? htmlf) (set! f htmlf))
                                        ((file-exists? pdff) (set! f pdff)))

                                  (fprintf o "link:~a[~a]" f
                                           (if (= (length args) 1) ""
                                               (string-trim-dq (cadr args))))))
                               ((string=? directive "lesson-description")
                                (unless (getenv "LESSON")
                                  (error 'adoc-preproc.rkt "@lesson-description valid only in lesson plan"))
                                (display-lesson-description (read-group i) o))
                               ((string=? directive "lessons-in-pathway-obsolete")
                                (unless (getenv "NARRATIVE")
                                  (error 'adoc-preproc.rkt "@lessons-in-pathway valid only in pathway narrative"))
                                (link-to-lessons-in-pathway o))
                               ((assoc directive *macro-list*) =>
                                (lambda (s)
                                  (display (cadr s) o)))
                               ((assoc directive *function-list*) =>
                                (lambda (f)
                                  (let ((args (string->form (read-group i))))
                                    (let-values (((key-list key-vals args)
                                                  (rearrange-args args)))
                                      (display (keyword-apply (cadr f) key-list key-vals args) o)))))
                               (else
                                 (printf "Unrecognized directive @~a~%" directive)
                                 #f))))
                      ((and (getenv "LESSON") beginning-of-line? (char=? c #\=))
                       (set! beginning-of-line? #f)
                       (cond (title-reached?
                               (cond (first-subsection-reached? #f)
                                     ((check-first-subsection i o)
                                      (set! first-subsection-reached? #t)
                                      (include-glossary-and-standards-files o #f))
                                     (else #f))
                               (display c o))
                             (else
                               (set! title-reached? #t)
                               (display-title i o))))
                    ((char=? c #\newline)
                     (newline o)
                       (set! beginning-of-line? #t)
                     )
                    (else
                        (set! beginning-of-line? #f)
                        (display c o)))
                  (loop)))))
            (when (getenv "NARRATIVE")
              (link-to-lessons-in-pathway o))
            )
          #:exists 'replace)))

    (create-glossary-and-standards-subfiles glossary-items standards-met)

    (cond ((getenv "LESSON")
           (accumulate-glossary-and-standards glossary-items standards-met))
          (else
            (asciidoctor "-a title=Glossary index-glossary.asc")
            (asciidoctor "-a title=Standards index-standards.asc")))

    (asciidoctor out-file)))

(define (asciidoctor file)
  (system (format "~a -a pathwayrootdir=~a ~a" *asciidoctor* *pathway-root-dir* file)))

(define (create-glossary-and-standards-subfiles glossary-items standards-met)
  ;(printf "doing create-glossary-and-standards-subfiles ~a ~a ~a\n" (getenv "NARRATIVE") glossary-items standards-met)
  (let ((glossary-out-file "index-glossary.asc")
        (standards-out-file "index-standards.asc"))
    (call-with-output-file glossary-out-file
      (lambda (op)
        (unless (empty? glossary-items)
          (set! glossary-items
            (sort glossary-items #:key car string-ci<=?))
          (fprintf op ".Glossary~%")
          (fprintf op "[#glossary]~%")
          (for-each
            (lambda (s)
              ;(fprintf op "* *~a*: ~a~%" (car s) (cadr s))
              (fprintf op "~a:: ~a~%" (car s) (cadr s))
              )
            glossary-items)
          (fprintf op "~%~%")))
      #:exists 'replace)
    (call-with-output-file standards-out-file
      (lambda (op)
        (unless (empty? standards-met)
          (set! standards-met
            (sort standards-met #:key car string-ci<=?))
          (fprintf op ".Standards Statements~%")
          (fprintf op "[#standards]~%")
          (fprintf op "[.standards-hierarchical-table]~%")
          (for-each
            (lambda (s)
              (let ((sublist-items (unbox (cadr s)))
                    (s (caddr s)))
                ;(fprintf op "* *~a*: ~a~%" (car s) (cadr s))
                (fprintf op "~a:: ~a~%" (car s) (cadr s))
                (for-each (lambda (n)
                            (fprintf op "** ~a~%" (list-ref s (+ n 1)))
                            (fprintf op "** ~a~%" (list-ref s (+ n 1)))
                            )
                          sublist-items)))
            standards-met)
          (fprintf op "~%~%")))
      #:exists 'replace)
    )
  ;(printf "create-glossary-and-standards-subfiles done\n")
  )

(define (accumulate-glossary-and-standards glossary-items standards-met)
  ;(printf "doing accumulate-glossary-and-standards\n")
  (let ((lesson-glossary-accumulator "lesson-glossary.txt")
        (lesson-standards-accumulator "lesson-standards.txt"))
    (call-with-output-file lesson-glossary-accumulator
      (lambda (op)
        (for-each (lambda (s)
                    (fprintf op "~s~n" (car s)))
                  glossary-items))
      #:exists 'replace)
    (call-with-output-file lesson-standards-accumulator
      (lambda (op)
        (for-each (lambda (s)
                    (fprintf op "~s~n" (car s)))
                  standards-met))
      #:exists 'replace)
    )
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
