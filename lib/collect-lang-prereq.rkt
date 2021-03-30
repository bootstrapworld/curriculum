#lang racket

(require "lang-prereq.rkt")

(provide create-lang-prereq-file)

(define *prereqs-used* #f)
(define *proglang* #f)
(define sym-to-adocstr #f)

(define *number-list* (cadr (assoc 'Number *language-table*)))
(define *string-list* (cadr (assoc 'String *language-table*)))
(define *boolean-list* (cadr (assoc 'Boolean *language-table*)))
(define *image-list* (cadr (assoc 'Image *language-table*)))
(define *table-list* (cadr (assoc 'Table *language-table*)))

(define (display-prereq-row name o)
  ;(printf "doing display-prereq-row ~s\n" name)
  ;(printf "language-table = ~s\n" *language-table*)
  (let* ([name-s (cond [(eq? name 'Number) "Number"]
                       [(eq? name 'String) "String"]
                       [(eq? name 'Boolean) "Boolean"]
                       [(eq? name 'Image) "Image"]
                       [(eq? name 'Table) "Table"]
                       )]
         [name-data (assoc name *language-table*)]
         [name-fns (cadr name-data)]
         [name-vals (caddr name-data)]
         [fns (filter (lambda (x) (member x *prereqs-used*))
                      name-fns)]
         [n (length fns)])
    (display "!" o)
    (display name-s o)
    (newline o)
    ;
    (display "!" o)
    (let loop ([i 0])
      (unless (= i n)
        (fprintf o "`~a`" (sym-to-adocstr (list-ref fns i) #:pyret (string=? *proglang* "pyret")))
        (unless (= i (- n 1))
          (fprintf o ", "))
        (loop (+ i 1))))
    (display "\n" o)
    ;
    (display "!" o)
    ;(printf "name-vals = ~s\n" name-vals)
    (set! n (length name-vals))
    (let loop ([i 0])
      (unless (= i n)
        (fprintf o "`~s`" (list-ref name-vals i))
        (unless (= i (- n 1))
          (fprintf o ", "))
        (loop (+ i 1))))
    (display "\n\n" o)
    ))

(define (create-lang-prereq-file prereqs-used proglang sym-to-adocstr-fn in-file)

  ;(printf "doing create-lang-prereq-file ~s ~s ~s ~s\n" prereqs-used proglang sym-to-adocstr-fn in-file)

  (when prereqs-used

    (set! *prereqs-used* prereqs-used)
    (set! *proglang* proglang)
    (set! sym-to-adocstr sym-to-adocstr-fn)

    (let ([number-functions-used? (ormap (lambda (x) (member x *number-list*)) *prereqs-used*)]
          [string-functions-used? (ormap (lambda (x) (member x *string-list*)) *prereqs-used*)]
          [boolean-functions-used? (ormap (lambda (x) (member x *boolean-list*)) *prereqs-used*)]
          [image-functions-used? (ormap (lambda (x) (member x *image-list*)) *prereqs-used*)]
          [table-functions-used? (ormap (lambda (x) (member x *table-list*)) *prereqs-used*)]
          )

      (call-with-output-file "index.primtxt"
        (lambda (o)
          (for ([prim *prereqs-used*])
            (write prim o) (newline o)))
        #:exists 'replace)

      (call-with-output-file (path-replace-extension in-file "-lang-prereq.asc")
        (lambda (o)
          (when (or number-functions-used?
                    string-functions-used?
                    boolean-functions-used?
                    image-functions-used?)
            (display "|Language Table\n" o)
            (display "|\n" o)
            (display "[.lang-features-table,cols=\"1a,4a,1a\"]\n" o)
            (display "!===\n\n" o)
            (display "!Types !Functions !Values\n\n" o)
            (when number-functions-used? (display-prereq-row 'Number o))
            (when string-functions-used? (display-prereq-row 'String o))
            (when boolean-functions-used? (display-prereq-row 'Boolean o))
            (when image-functions-used? (display-prereq-row 'Image o))
            (when table-functions-used? (display-prereq-row 'Table o))
            (display "!===\n\n" o)))

        #:exists 'replace))
    ))

