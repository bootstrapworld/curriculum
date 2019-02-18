#! /bin/sh
#|
exec racket -t $0 -m -- "$@"
|#

#lang racket

(provide main)

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
  (let* ((std-bits (regexp-split #rx"&" std))
         (std (list-ref std-bits 0))
         (sublist-item #f))
    (let ((c (assoc std L)))
      (when (>= (length std-bits) 3)
        (set! sublist-item (string->number (list-ref std-bits 2))))
      (list c sublist-item))))

(define (box-add-new! v bx)
  (let ((vv (unbox bx)))
    (unless (member v vv)
      (set-box! bx (sort (cons v vv) <)))))

(define (check-first-subsection i o)
  (let ((c (peek-char i)))
    (if (char=? c #\=)
        (begin (read-char i)
               (set! c (peek-char i))
               (if (char=? c #\=)
                   #t
                   (begin (display #\= o)
                          #f)))
        #f)))

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

(define (add-include-directive o in-file)
  (fprintf o "include::~a[]~%~%" (path-replace-extension in-file "-glossary.adoc3"))
  (fprintf o "include::~a[]~%~%" (path-replace-extension in-file "-standards.adoc3"))
  (display #\= o))

(define *summary-file* #f)

(define *all-glossary-items* '())

(define *asciidoctor* "asciidoctor -a linkcss -a stylesheet=curriculum.css")

(define (preprocess in-file)
  (let ((out-file (path-replace-extension in-file ".adoc2"))
        (glossary-out-file (path-replace-extension in-file "-glossary.adoc3"))
        (glossary-items '())
        (standards-met '())
        (standards-out-file (path-replace-extension in-file "-standards.adoc3"))
        ;(standards-file "standards.rkt")
        ;(materials '())
        ;(preparation-items '())
        (first-subsection-crossed? #f)
        )
    (call-with-input-file in-file
      (lambda (i)
        (call-with-output-file out-file
          (lambda (o)
            (let loop ()
              (let ((c (read-char i)))
                (unless (eof-object? c)
                  (case c
                    ((#\@)
                     (let ((directive (read-word i)))
                       ;(printf "directive= ~s~%" directive)
                       (cond ((string=? directive "") (display c o))
                             ((string=? directive "vocab")
                              (let* ((arg (read-group i))
                                     (s (assoc-glossary arg *glossary-list*)))
                                (when (string=? arg "")
                                  (printf "Directive @vocab has ill-formed argument~%"))
                                (display arg o)
                                (cond (s (unless (member s glossary-items)
                                          (set! glossary-items (cons s glossary-items)))
                                        (unless (member s *all-glossary-items*)
                                          (set! *all-glossary-items*
                                            (cons s *all-glossary-items*))))
                                      (else (printf "Item ~a not found in glossary~%"
                                                    arg)))))
                             ((string=? directive "std")
                              (let ((args (read-commaed-group i)))
                                (when (empty? args)
                                  (printf "Directive @std has ill-formed argument~%"))
                                (for-each
                                  (lambda (arg)
                                    (let* ((s (assoc-standards arg *standards-list*))
                                           (c (list-ref s 0))
                                           (sublist-item (list-ref s 1)))
                                      (cond (c (let ((std (list-ref c 0)))
                                                 (cond ((assoc std standards-met) =>
                                                        (lambda (c0)
                                                          (let ((sublist-items (list-ref c0 2)))
                                                            (box-add-new! sublist-item sublist-items))))
                                                       (else
                                                         (let ((sublist-items
                                                                 (box (if sublist-item
                                                                          (list sublist-item)
                                                                          '()))))
                                                           (set! standards-met
                                                             (cons (list std c sublist-items)
                                                                   standards-met)))))))
                                            (else (printf "Standard ~a not found~%" arg)))))
                                  args)))
                             ((string=? directive "link")
                              (let* ((args (read-commaed-group i))
                                     (arg1 (car args)))
                                (fprintf o
                                         "link:~a[~a]"
                                         (string-replace arg1 #rx"\\.adoc$" ".html")
                                         (if (= (length args) 1) "" (cadr args)))))
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
                    ((#\newline)
                     (newline o)
                     (cond (first-subsection-crossed? #f)
                           ((check-first-subsection i o)
                            (set! first-subsection-crossed? #t)
                            (add-include-directive o in-file))
                           (else #f)))
                    (else (display c o)))
                  (loop)))))
          #:exists 'replace)))
    (call-with-output-file glossary-out-file
      (lambda (op)
        (unless (empty? glossary-items)
          (set! glossary-items
            (sort glossary-items #:key car string-ci<=?))
          (fprintf op ".Glossary~%")
          (for-each
            (lambda (s)
              (fprintf op "* *~a*: ~a~%" (car s) (cadr s)))
            glossary-items)
          (fprintf op "~%~%")))
      #:exists 'replace)
    (call-with-output-file standards-out-file
      (lambda (op)
        (unless (empty? standards-met)
          (set! standards-met
            (sort standards-met #:key car string-ci<=?))
          (fprintf op ".Standards Statements~%")
          (fprintf op "[.standards-hierarchical-table]~%")
          (for-each
            (lambda (s)
              (let ((s (cadr s))
                    (sublist-items (unbox (caddr s))))
                (fprintf op "* *~a*: ~a~%" (car s) (cadr s))
                (for-each (lambda (n)
                            (fprintf op "** ~a~%" (list-ref s (+ n 1))))
                          sublist-items)))
            standards-met)
          (fprintf op "~%~%")))
      #:exists 'replace)
    (system (format "~a ~a" *asciidoctor* out-file))))

#|
(require (path->string (build-path 'up "shared" "langs" "en-us" "glossary-terms.rkt")))
(require (path->string (build-path 'up "shared" "langs" "en-us" "standards-dictionary.rkt")))
(require (path->string (build-path 'up "shared" "langs" "en-us" "form-elements.rkt")))
(require (path->string (build-path 'up "shared" "langs" "en-us" "function-directives.rkt")))
|#

(require "glossary-terms.rkt")
(require "standards-dictionary.rkt")
(require "form-elements.rkt")
(require "function-directives.rkt")

(define (main . args)
  (set! *all-glossary-items* '())
  (set! *summary-file* "summary.adoc2")
  (for-each preprocess args)
  (unless (empty? *all-glossary-items*)
    (set! *all-glossary-items*
      (sort *all-glossary-items* #:key car string-ci<=?))
    (call-with-output-file *summary-file*
      (lambda (op)
        (for-each
          (lambda (s)
            (fprintf op "* *~a*: ~a~%" (car s) (cadr s)))
          *all-glossary-items*))
      #:exists 'replace)
    (system (format "~a ~a" *asciidoctor* *summary-file*)))
  (void))
