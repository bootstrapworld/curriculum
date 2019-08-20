#lang racket
#|
|#

(provide *function-list*)

(define *solutions-mode?* (getenv "SOLUTIONS"))

(define *proglang* (getenv "PROGLANG"))

(unless (member *proglang* '("pyret" "wescheme"))
  (error 'function-directives.rkt "Unknown proglang ~a" *proglang*))

(define *show-funname-contract?* #f)
(define *show-domains?* #f)
(define *show-range?* #f)
(define *show-purpose?* #f)
(define *show-examples* #f)
(define *show-funname-defn?* #f)
(define *show-params?* #f)
(define *show-body?* #f)

(define *div-nesting* 0)

(define (ft-list-ref s i)
  (let ([n (length s)])
    (and (< i n) (list-ref s i))))

(define (encoded-ans style s show?)
  ;(printf "\ndoing encoded-ans ~s ~s ~s\n" style s show?)
  (format "[.studentAnswer~a.~a~a]##~a##"
          (if (string=? style ".recipe_purpose")
              "" ".studentAnswerCode")
          (if show? "solution" "blank")
          style
          (if show? s
              (let ([n (string-length (if (string? s) s (format "~a" s)))])
                (make-string n #\M)))))

(define (write-directions page-header funname directions)
  (format "\n
[.designRecipeLayout]
== [.dr-title]##~a: ~a##\n
[.recipe_word_problem]
**Directions**: ~a\n\n"
          page-header
          funname
          directions))

(define (write-purpose funname domain-list range purpose)
  (string-append
    (format "\n
[.recipe_title]
Contract and Purpose Statement\n
[.recipe_instructions]
Every contract has three parts...\n\n")
    (write-wrapper ".recipe_graf"
      (lambda ()
        (string-append
          (encoded-ans ".recipe_name" funname *show-funname-defn?*)
          ":"
          (encoded-ans ".recipe_domain" (vars-to-string domain-list) *show-domains?*)
          "→"
          (encoded-ans ".recipe_range" range *show-range?*))))
    ;(write-clear)
    (write-wrapper-scan ".recipe_graf"
      (lambda ()
        (encoded-ans ".recipe_purpose" purpose *show-purpose?*)))))

(define (write-examples funname num-examples example-list buggy-example-list)
  ;(printf "doing write-examples num-examples=~a example-list=~a buggy-example-list=~a " num-examples example-list buggy-example-list)
  (string-append
    (format "\n
[.recipe_title]
Examples\n
[.recipe_instructions]
Write some examples, then circle and label what changes...\n\n")
    ;examples

    (apply string-append
           (cond [(and #t (cons? buggy-example-list))
                  ;(printf "doing buggy-example-list ~s\n" buggy-example-list)
                  (map (lambda (e)
                         (write-each-example (caar e) (cdar e) (cadr e) #t))
                       buggy-example-list) ]
                 [else
                   (let* ([example-list-len (length example-list)]
                          [num-blank-examples (max 0 (- num-examples example-list-len))])
                     (append
                       (map (lambda (e s)
                              (let* ([n (- (length e) 1)]
                                     [body (list-ref e n)]
                                     [parms (take e n)])
                                (write-each-example funname parms body s)))
                            example-list
                            (cond [(eq? *show-examples* #t)
                                   (build-list example-list-len (lambda (i) #t))]
                                  [(eq? *show-examples* #f)
                                   (build-list example-list-len (lambda (i) #f))]
                                  [else
                                    (let* ([num-examples-after-shown-ones
                                             (max 0 (- example-list-len
                                                       (length *show-examples*)))]
                                           [mod-show-examples
                                             (append *show-examples* (build-list
                                                                       num-examples-after-shown-ones
                                                                       (lambda (i) #f)))]
                                           [mod-show-examples
                                             (take mod-show-examples example-list-len)])
                                      mod-show-examples)]))
                       (build-list num-blank-examples
                                   (lambda (i)
                                     (write-each-example funname '() '() #f)))))]
                 ))
    ))

(define (write-each-example/wescheme funname show-funname? args show-args? body show-body?)
  ;(printf "write-each-example/scheme ~s ~s ~s\n" funname args body)
  (string-append
    (write-wrapper ".recipe_graf"
      (lambda ()
        (string-append
          ;(write-clear)
          (write-large "(")
          (write-spaced "EXAMPLE ")
          (write-large "(")
          (encoded-ans ".recipe_name" funname show-funname?)
          " "
          (encoded-ans ".recipe_example_inputs" (list-to-string args) show-args?)
          (write-large ")")
          (write-clear) ;EXAMPLE body on its own line!
          (encoded-ans "" "MM" #f)
          (encoded-ans ".recipe_example_body" (expr-to-string body) show-body?)
          (write-large ")")
          )))))

(define (write-each-example/pyret funname show-funname? args show-args? body show-body?)
  (write-wrapper ".recipe_graf"
    (lambda ()
      (string-append
        ;(write-clear)
        (write-spaced "examples:")
        (write-clear)
        (encoded-ans "" "MM" #f)
        (encoded-ans ".recipe_name" funname show-funname?)
        " "
        (write-large "(")
        (encoded-ans ".recipe_example_inputs" (list-to-commaed-string args) show-args?)
        (write-large ")")
        (write-clear)
        (encoded-ans "" "MM" #f)
        (write-spaced "is")
        (encoded-ans "" "MM" #f)
        (encoded-ans ".recipe_example_body" body show-body?)
        (write-clear)
        (write-spaced "end")
        ))))

(define (write-each-example funname args body show)
  (let ([show-funname? #f]
        [show-args? #f]
        [show-body? #f])
    (cond [(not show) #f]
          [(not *solutions-mode?*) #f]
          [(eqv? show #t)
           (set! show-funname? #t)
           (set! show-args? #t)
           (set! show-body? #t)]
          [(list? show)
           (set! show-funname? (list-ref show 0))
           (set! show-args? (list-ref show 1))
           (set! show-body? (list-ref show 2))])
    ((case *proglang*
       [("pyret") write-each-example/pyret]
       [("wescheme") write-each-example/wescheme])
     funname show-funname? args show-args? body show-body?)))

(define (expr-to-string x)
  (format "~s" x))

(define (list-to-string xx)
  ;(printf "list-to-string ~s\n" xx)
  (let ([ans (apply string-append
                    (reverse
                      (let loop ([xx xx] [r '()])
                        (if (null? xx) r
                            (loop (cdr xx) (cons (format " ~s" (car xx)) r))))))])
    (if (string=? ans "") " " ans)))

(define (list-to-commaed-string xx)
  (cond [(null? xx) ""]
        [(= (length xx) 1) (format "~s" (car xx))]
        [else (let loop ([xx (cdr xx)] [r (format "~s" (car xx))])
                (if (null? xx) r
                    (loop (cdr xx) (string-append r ", " (format "~s" (car xx))))))]))

(define (vars-to-string xx)
  (let ([ans (apply string-append
                    (reverse
                      (let loop ([xx xx] [r '()])
                        (if (null? xx) r
                            (loop (cdr xx) (cons (format " ~a" (car xx)) r))))))])
    (if (string=? ans "") " " ans)))

(define (vars-to-commaed-string xx)
  (cond [(null? xx) ""]
        [(= (length xx) 1) (format "~a" (car xx))]
        [else (let loop ([xx (cdr xx)] [r (format "~a" (car xx))])
                (if (null? xx) r
                    (loop (cdr xx) (string-append r ", " (format "~a" (car xx))))))]))

(define (write-definition/wescheme funname param-list body)
  (let ([cond? (and (pair? body) (eqv? (car body) 'cond))])
    (string-append
      (format "\n
[.recipe_title]
Definition\n
[.recipe_instructions]
Write the definition, giving variable names to all your input values...\n\n")
      (write-null-wrapper ""
        (lambda ()
          (string-append
            (write-wrapper ".recipe_line"
              (lambda ()
                (string-append
                  (write-large "(")
                  (write-spaced "define")
                  (write-spaced " ")
                  (write-large "(")
                  (encoded-ans ".recipe_name" funname *show-funname-defn?*)
                  " "
                  (encoded-ans ".recipe_variables" (vars-to-string param-list) *show-params?*)
                  (write-large ")"))))

            (cond [cond?
                    (write-wrapper ".recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "MM" #f)
                          (write-large "(")
                          (encoded-ans ".recipe_cond" "cond" *show-body?*))))]
                  [else ""])

            (cond [cond?
                    (apply string-append
                           (map write-cond-clause (cdr body)))]
                  [else
                    (write-wrapper ".recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "MM" #f)
                          (encoded-ans ".recipe_definition_body" (expr-to-string body) *show-body?*)
                          (write-large ")")
                          )))])

            (cond [cond?
                    (write-wrapper ".recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "MM" #f)
                          (write-large "))"))))]
                  [else
                    ""
                    #;(write-wrapper ".recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "MM" #f)
                          (write-large ")"))))
                    ])))))))

(define (write-definition/pyret funname param-list body)
  (if (not (string? body))
      "Don't care"
      (let ([body-lines (map string-trim (regexp-split #rx"\n" body))])
        (string-append
          (format "\n
[.recipe_title]
Definition\n
[.recipe_instructions]
Write the definition, giving variable names to all your input values...\n\n")
          (write-null-wrapper ""
            (lambda ()
              (string-append
                (write-wrapper ".recipe_line"
                  (lambda ()
                    (string-append
                      (write-spaced "fun ")
                      (encoded-ans ".recipe_name" funname *show-funname-defn?*)
                      (write-large "(")
                      (encoded-ans ".recipe_variables" (vars-to-commaed-string param-list) *show-params?*)
                      (write-large ")"))))
                (apply string-append
                       (map
                         (lambda (body-line)
                           (write-wrapper ".recipe_line"
                             (lambda ()
                               (string-append
                                 (encoded-ans "" "MM" #f)
                                 (encoded-ans ".recipe_definition_body" body-line *show-body?*)))))
                         body-lines))
                (write-wrapper ".recipe_line"
                  (lambda ()
                    "end")))))))))

(define (write-definition funname param-list body)
  ((case *proglang*
     [("pyret") write-definition/pyret]
     [("wescheme") write-definition/wescheme])
   funname param-list body))

(define (write-clear)
  "[.clear]## ##")

(define (write-spaced s)
  ;(format "[.spacer]##~a##" s)
  (format "~a" s)
  )

(define (write-large s)
  (format "[.bigparen]##~a##" s))

(define *wrapper-block-level* 0)

(define (write-wrapper-scan classes thunk)
  (let ([res (thunk)])
    (if (or #t (string=? classes "")) res
        (format "[~a]##~a##" classes res))))

(define (write-null-wrapper classes thunk)
  (thunk))

(define (write-wrapper classes thunk)
  (string-append
    (let ([old-*wrapper-block-level* *wrapper-block-level*]
          [res #f])
      (set! *wrapper-block-level* (+ *wrapper-block-level* 2))
      (if (= *wrapper-block-level* 2)
          (set! res (string-append
                      (format "\n\n[.wrapper~a]\n" classes)
                      (make-string *wrapper-block-level* #\-)
                      "\n"
                      (write-clear)
                      (thunk)
                      "\n"
                      (make-string *wrapper-block-level* #\-)
                      "\n"))
          (set! res (write-wrapper-scan classes thunk)))
      (set! *wrapper-block-level* old-*wrapper-block-level*)
      res)))

(define (write-cond-clause clause)
  ;(printf "doing write-cond-clause ~s\n" clause)
  (write-wrapper ".recipe_line.recipe_cond_clause"
    (lambda ()
      (string-append (encoded-ans "" "MMMMM" #f)
                     (write-large "{startsb}")
                     (write-wrapper ".clause"
                       (lambda ()
                         (string-append
                           (encoded-ans ".questions" (expr-to-string (car clause)) *show-body?*)
                           " "
                           (encoded-ans ".answers" (list-to-string (cdr clause)) *show-body?*))))
                     (write-large "{endsb}")))))

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
                                #:assess-design-recipe (assess-design-recipe #f)
                                )

  (set! *show-funname-contract?* show-funname-contract?)
  (set! *show-domains?* show-domains?)
  (set! *show-range?* show-range?)
  (set! *show-purpose?* show-purpose?)
  (set! *show-examples* show-examples)
  (set! *show-funname-defn?* show-funname-defn?)
  (set! *show-params?* show-params?)
  (set! *show-body?* show-body?)

  (unless *solutions-mode?*
    (set! *show-funname-contract?* #f)
    (set! *show-domains?* #f)
    (set! *show-range?* #f)
    (set! *show-purpose?* #f)
    (set! *show-examples* #f)
    (set! *show-funname-defn?* #f)
    (set! *show-params?* #f)
    (set! *show-body?* #f)
    )

  (when (and *solutions-mode?* (not assess-design-recipe))
    (set! *show-funname-contract?* #t)
    (set! *show-domains?* #t)
    (set! *show-range?* #t)
    (set! *show-purpose?* #t)
    (set! *show-examples* #t)
    (set! *show-funname-defn?* #t)
    (set! *show-params?* #t)
    (set! *show-body?* #t)
    )

  ;(printf "d-r-e body= ~s\n" body)
  ;uncomment in orig;
  ;comment, debug
  (when (and (cons? example-list) (cons? buggy-example-list))
    (error 'design-recipe-exercise "At most one of example-list and buggy-example-list should be provided"))

  (when (string=? funname "")
    (set! funname " ")
    (set! page-header "Design Recipe")
    (when (string=? directions "")
      (set! directions (format "{sp} +\n{sp} +\n{sp} +\n")))
    )
  (when (string=? range "") (set! range " "))
  (when (string=? purpose "") (set! purpose " "))
  (unless *show-purpose?* (set! purpose " "))

  (string-append

    (write-directions page-header funname directions)

    (write-purpose funname domain-list range purpose)

    (write-examples funname num-examples example-list buggy-example-list)

    (write-definition funname param-list body)

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
  (let ([use-examples (if (cons? buggy-example-list) buggy-example-list example-list)])
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
                            #:assess-design-recipe #t
                            )))

(define *function-list*
  `(
    ("assess-design-recipe" ,assess-design-recipe)
    ("design-recipe-exercise" ,design-recipe-exercise)
    ))
