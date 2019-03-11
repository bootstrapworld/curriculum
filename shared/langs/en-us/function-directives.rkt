#lang racket
#|
|#

(provide *function-list*)

(define (ft-list-ref s i)
  (let ((n (length s)))
    (and (< i n) (list-ref s i))))

(define lparen #\()
(define rparen #\))

(define (design-recipe-exercise funname directions
                                #:page-header (page-header "Word Problem")
                                #:show-funname-contract? (show-funname-contract? #f)
                                #:domain-list (domain-list '()) ; list of string
                                #:show-domains? (show-domains? #f)
                                #:range (range #f)
                                #:show-range? (show-range? #f)
                                #:purpose (purpose #f)
                                #:show-purpose? (show-purpose? #f)
                                #:num-examples (num-examples 0) ; number of total example spaces to generate
                                #:example-list (example-list '()) ;concrete examples -- see doc above func for details
                                #:buggy-example-list (buggy-example-list '()) ; full concrete examples with error
                                #:show-examples (show-examples '()) ; see doc above func for details
                                #:buggy-funname-defn (buggy-funname-defn #f)
                                #:show-funname-defn? (show-funname-defn? #f)
                                #:param-list (param-list '()) ; list of string
                                #:show-params? (show-params? #f)
                                #:body (body #f) ; a string
                                #:show-body? (show-body? #f)
                                #:grid-lines? (grid-lines? #f)
                                #:lang (lang 'racket)
                                )

  #; (when (and (cons? example-list) (cons? buggy-example-list))
    (error 'design-recipe-exercise "At most one of example-list and buggy-example-list should be provided"))

  (define (write-example funname ex show)
    (let ((show-funname? #f)
          (show-args? #f)
          (show-body? #f))
      (cond ((not show) #f)
            ((eqv? show #t)
             (set! show-funname? #t)
             (set! show-args? #t)
             (set! show-body? #t))
            ((list? show)
             (set! show-funname? (list-ref show 0))
             (set! show-args? (list-ref show 1))
             (set! show-body? (list-ref show 2))))
      (format "

(EXAMPLE (~a ~a) ~a)

"
              (if show-funname? funname "")
              (if show-args?
                  (apply string-append
                         (let loop ((args (cdr (reverse (cdr ex)))) (r '()))
                           (if (null? args) r
                               (loop (cdr args) (cons (format " ~a" (car args)) r)))))
                  "")
              (if show-body?
                  (format "~a" (car (reverse (cdr ex))))
                  ""))))

  (string-append
    (format "
== ~a: ~a

_**Directions**: ~a_
" page-header
            funname
            directions)

    (format "

=== Contract and Purpose Statement

_Every contract has three parts..._

")
    (format "

=== Examples

_Write some examples, then circle and label what changes..._

")
    ;examples

    (apply string-append
           (reverse
             (let loop ((i 0) (r '()))
               (if (>= i num-examples) r
                   (loop (+ i 1) (cons
                                   (write-example funname
                                                  (list-ref example-list i)
                                                  (ft-list-ref show-examples i))
                                   r))))))

    (format "

=== Definition

_Write the definition, given variable names to all your input values..._

~cdefine (~a ~a)

" lparen funname
            (apply string-append
                   (let loop ((params (reverse param-list)) (r '()))
                     (if (null? params) r
                         (loop (cdr params) (cons (format " ~a" (car params)) r)))))
                   )

  (apply string-append
         (if (eqv? (car body) 'cond)
             (let loop ((clauses (cdr body))
                        (r (list (format "~c~a~%~%" lparen
                                         (if show-body? "cond" "")))))
               (if (null? clauses) (reverse r)
                   (loop (cdr clauses)
                         (cons
                           (format "~a~%~%"
                                   (if show-body? (car clauses) "[]"))
                           r))))
             (list (if show-body?
                       (format "~a~%~%" body)
                       ""))))

    (format "~c~%~%" rparen)

          )

  )

(define (assess-design-recipe
          funname directions
          #:domain-list (domain-list '()) ; list of string
          #:range (range #f)
          #:purpose (purpose #f)
          #:example-list (example-list '()) ;concrete examples -- see doc above func for details
          #:buggy-example-list (buggy-example-list '()) ; full concrete examples with error
          #:buggy-funname-defn (buggy-funname-defn #f)
          #:param-list (param-list '()) ; list of string
          #:body (body #f) ; a string
          #:grid-lines? (grid-lines? #f)
          )
  (unless range (error 'assess-design-recipe "range required"))
  (unless purpose (error 'assess-design-recipe "purpose required"))
  (unless body (error 'assess-design-recipe "body required"))
  (let ((use-examples (if (cons? buggy-example-list) buggy-example-list example-list)))
    (design-recipe-exercise funname directions
                            #:page-header "Check for Mistakes in this Word Problem"
                            #:show-funname-contract? #t
                            #:domain-list domain-list
                            #:show-domains? #t
                            #:range range
                            #:show-range? #t
                            #:purpose purpose
                            #:show-purpose? #t
                            #:num-examples (length use-examples)
                            #:example-list use-examples
                            #:buggy-example-list use-examples
                            #:show-examples (build-list (length use-examples) (lambda (i) #t))
                            #:buggy-funname-defn buggy-funname-defn
                            #:show-funname-defn? #t
                            #:param-list param-list
                            #:show-params? #t
                            #:body body
                            #:show-body? #t
                            #:grid-lines? grid-lines?
                            )))

(define *function-list*
  `(
    ("assess-design-recipe" ,assess-design-recipe)
    ("design-recipe-exercise" ,design-recipe-exercise)
    ))
