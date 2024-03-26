#lang racket

(require json)

(provide
  check-in-langtable?
  store-functions-used
  )

(define lang-table-file "lib/langtable.js")

(define *language-table*
  (cond [(not (file-exists? lang-table-file)) '()]
        [else
          (call-with-input-file lang-table-file
            (lambda (i)
              (read i) (read i) (read i)
              (string->jsexpr
              (port->string i))))]))

(define (get-primitive-name p)
  (string->symbol (hash-ref p 'name)))

(define *number-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'Number) 'primitives)))
(define *string-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'String) 'primitives)))
(define *boolean-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'Boolean) 'primitives)))
(define *image-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'Image) 'primitives)))
(define *table-list* (map get-primitive-name (hash-ref (hash-ref *language-table* 'Table) 'primitives)))

(define *allowed-prims* (list *number-list* *string-list* *boolean-list* *image-list* *table-list*))

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
