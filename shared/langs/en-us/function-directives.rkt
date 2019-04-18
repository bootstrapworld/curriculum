#lang racket
#|
|#

(provide *function-list*)

(define *solutions-mode?* (getenv "SOLUTIONS"))

(define (ft-list-ref s i)
  (let ((n (length s)))
    (and (< i n) (list-ref s i))))

(define (design-recipe-exercise funname directions
                                #:page-header (page-header "Word Problem")
                                #:show-funname-contract? (show-funname-contract? #f)
                                #:domain-list (domain-list '()) ; list of string
                                #:show-domains? (show-domains? #f)
                                #:range (range #f)
                                #:show-range? (show-range? #f)
                                #:purpose (purpose #f)
                                #:show-purpose? (show-purpose? #f)
                                ; num-examples = 1, in orig
                                ; = 0, debug
                                #:num-examples (num-examples 1) ; number of total example spaces to generate
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

  (when *solutions-mode?*
    (set! show-funname-contract? #f)
    (set! show-domains? #f)
    (set! show-range? #f)
    (set! show-purpose? #f)
    (set! show-examples #f)
    (set! show-funname-defn? #f)
    (set! show-params? #f)
    (set! show-body? #f)
    )

  ;(printf "d-r-e body= ~s\n" body)
  ;uncomment in orig;
  ;comment, debug
  (when (and (cons? example-list) (cons? buggy-example-list))
    (error 'design-recipe-exercise "At most one of example-list and buggy-example-list should be provided"))

  ;maybe this can be hoisted out?
  (define (write-example funname parms body show)
    ;(printf "write-example ~s ~s ~s ~s\n" funname parms body show)
    (let ((show-funname? #f)
          (show-args? #f)
          (show-body? #f))
      (cond ((not show) #f)
            ((not *solutions-mode?*) #f)
            ((eqv? show #t)
             (set! show-funname? #t)
             (set! show-args? #t)
             (set! show-body? #t))
            ((list? show)
             (set! show-funname? (list-ref show 0))
             (set! show-args? (list-ref show 1))
             (set! show-body? (list-ref show 2))))
      (format "~n
 (EXAMPLE (~a ~a) ~a)~n
~n"
              (if show-funname? funname "")
              (if show-args?
                  (apply string-append
                         (let loop ((args parms) (r '()))
                           (if (null? args) r
                               (loop (cdr args) (cons (format " ~a" (car args)) r)))))
                  "")
              (if show-body?
                  (format " ~a" body)
                  "")))) ;end write-example

  (string-append

    (format "\n
== ~a: ~a\n
_**Directions**: ~a_
" page-header
            funname
            directions)

    (format "\n
=== Contract and Purpose Statement\n
_Every contract has three parts..._\n
")

    (format "\n
=== Examples\n
_Write some examples, then circle and label what changes..._\n
")
    ;examples

    (apply string-append
           (cond [(and #t (cons? buggy-example-list))
                  ;(printf "doing buggy-example-list ~s\n" buggy-example-list)
                  (map (lambda (e)
                         (write-example (caar e) (cdar e) (cadr e) #t))
                       buggy-example-list) ]
                 [else
                   (let* ((example-list-len (length example-list))
                          (num-blank-examples (- num-examples example-list-len)))
                     (append
                       (map (lambda (e s)
                              (let* ((n (- (length e) 1))
                                     (body (list-ref e n))
                                     (parms (take e n)))
                                (write-example funname parms body s)))
                            example-list
                            (append show-examples
                                    (build-list (- example-list-len (length show-examples))
                                                (lambda (i) #f))))
                       (build-list num-blank-examples
                                   (lambda (i)
                                     (write-example funname '() '() #f)))))]
                 ))

    (format "\n
=== Definition\n
_Write the definition, given variable names to all your input values..._\n
 (define (~a ~a)
" funname
            (apply string-append
                   (let loop ((params (reverse param-list)) (r '()))
                     (if (null? params) r
                         (loop (cdr params) (cons (format " ~a" (car params)) r)))))
            )


    (if (eqv? (car body) 'cond)
        (apply string-append
               (let loop ((clauses (cdr body))
                          (r (list (format "   (~a~%"
                                           (if show-body? "cond" "")))))
                 (if (null? clauses) (reverse (cons (format "   )~%") r))
                     (begin
                       (loop (cdr clauses)
                             (cons
                               (format "     ~a~%"
                                       (if show-body? (car clauses) "[]"))
                               r))))))
        (if show-body?
            (format "   ~a~%" body)
            ""))

    (format " )~%~%")

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
                            ;orig example-list, debug = use-examples
                            ;#:example-list use-examples
                            #:example-list example-list
                            ;orig buggy-example-list, debug = use-examples
                            ;#:buggy-example-list use-examples
                            #:buggy-example-list buggy-example-list
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
