#lang racket

(require json)

(provide
  check-in-langtable?
  store-functions-used
  create-lang-prereq-file)

(define lang-table-file "lib/langtable.js")

(define *language-table*
  (cond [(not (file-exists? lang-table-file)) '()]
        [else
          (call-with-input-file lang-table-file
            (lambda (i)
              (read i) (read i) (read i)
              (string->jsexpr
              (port->string i))))]))

(define *prereqs-used* #f)
(define *proglang* #f)
(define sym-to-adocstr #f)

(define (get-primitive-name p)
  (string->symbol (hash-ref p 'name)))

(define *number-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'Number) 'primitives)))
(define *string-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'String) 'primitives)))
(define *boolean-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'Boolean) 'primitives)))
(define *image-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'Image) 'primitives)))
(define *table-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'Table) 'primitives)))

(define *allowed-prims* (list *number-list* *string-list* *boolean-list* *image-list* *table-list*))

(define (display-prereq-row name o)
  ;(printf "doing display-prereq-row ~s\n" name)
  ;(printf "language-table = ~s\n" *language-table*)
  (let* ([name-s (cond [(eq? name 'Number) "Number"]
                       [(eq? name 'String) "String"]
                       [(eq? name 'Boolean) "Boolean"]
                       [(eq? name 'Image) "Image"]
                       [(eq? name 'Table) "Table"]
                       )]
         [name-data (hash-ref *language-table* name)]
         [name-fns (map get-primitive-name (hash-ref name-data 'primitives))]
         [name-vals (hash-ref name-data 'values)]
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

(define (check-in-langtable? prim)
  (ormap (lambda (s) (member prim s)) *allowed-prims*))

(define (store-functions-used prereqs-used prim-file)
  ;(printf "doing store-functions-used ~s ~s\n" prereqs-used prim-file)

  (call-with-output-file prim-file
    (lambda (o)
      (for ([prim prereqs-used])
        (when (ormap (lambda (s) (member prim s))
                     *allowed-prims*)
          (write prim o) (newline o))))
    #:exists 'replace))

(define (create-lang-prereq-file prereqs-used proglang sym-to-adocstr-fn in-file)
  ;(printf "doing create-lang-prereq-file ~s ~s ~s ~s\n" prereqs-used proglang sym-to-adocstr-fn in-file)

  (set! *prereqs-used* prereqs-used)
  (set! *proglang* proglang)
  (set! sym-to-adocstr sym-to-adocstr-fn)

    (let ([number-functions-used? (ormap (lambda (x) (member x *number-list*)) *prereqs-used*)]
          [string-functions-used? (ormap (lambda (x) (member x *string-list*)) *prereqs-used*)]
          [boolean-functions-used? (ormap (lambda (x) (member x *boolean-list*)) *prereqs-used*)]
          [image-functions-used? (ormap (lambda (x) (member x *image-list*)) *prereqs-used*)]
          [table-functions-used? (ormap (lambda (x) (member x *table-list*)) *prereqs-used*)]
          )
      ;TODO make file only when needed?
      ;(printf "outputting to ~s\n" (path-replace-extension in-file "-lang-prereq.asc"))
      (call-with-output-file (path-replace-extension in-file "-lang-prereq.asc")
        (lambda (o)
          (when (or number-functions-used?
                    string-functions-used?
                    boolean-functions-used?
                    image-functions-used?
                    table-functions-used?)
            (display "|Language Table\n" o)
            (display "|\n" o)
            (display "[.lang-features-table,cols=\"1a,4a,2a\"]\n" o)
            (display "!===\n\n" o)
            (display "!Types !Functions !Values\n\n" o)
            (when number-functions-used? (display-prereq-row 'Number o))
            (when string-functions-used? (display-prereq-row 'String o))
            (when boolean-functions-used? (display-prereq-row 'Boolean o))
            (when image-functions-used? (display-prereq-row 'Image o))
            (when table-functions-used? (display-prereq-row 'Table o))
            (display "!===\n\n" o)))

        #:exists 'replace))
    )

