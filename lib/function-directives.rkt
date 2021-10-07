#lang racket

(require "utils.rkt")
(require "html-tag-gen.rkt")

(provide assess-design-recipe
         design-recipe-exercise
         get-function-name
         wescheme->pyret
         wescheme->wescheme
         vars-to-commaed-string vars-to-string
         )

(define *solutions-mode?* (truthy-getenv "SOLUTION"))

(define *proglang* (string-downcase (getenv "PROGLANG")))

(unless (member *proglang* '("pyret" "wescheme" "codap"))
  (error 'ERROR "function-directives.rkt: Unknown proglang ~a" *proglang*))

(define *pyret?* (string=? *proglang* "pyret"))

(define *show-funname-contract?* #f)
(define *show-domains?* #f)
(define *show-range?* #f)
(define *show-purpose?* #f)
(define *show-examples* #f)
(define *show-funname-defn?* #f)
(define *show-params?* #f)
(define *show-body?* #f)

(define *div-nesting* 0)

(define *max-wescheme-cond-side-length* 32)
(define *max-line-length* 50)
;; NOTE(Emmanuel) - these lines have been subsumed by *max-line-length*
;(define *max-wescheme-example-side-length* 30)
;(define *max-pyret-example-side-length* 30)

(define *funname* #f)

(define (get-function-name) *funname*)

(define (string-multiply s n)
  (let loop ([n n] [r ""])
    (if (= n 0) r
        (loop (- n 1) (string-append r s)))))

(define (encoded-ans style s show?)
  (unless (string? s) (set! s (format "~a" s)))
  (let ([s-og (regexp-replace* #rx"{empty}" s "")])
    ;(printf "encoded-ans ~s\n ~s\n ~s ~s\n" show? s s-og (string-length s-og))
    (enclose-span
      (string-append
        (if (string=? style "") "" ".studentAnswer")
        (if (string=? style ".recipe_purpose") "" ".studentAnswerCode")
        (if show? ".solution" ".blank")
        style)
      (if show? s
          (string-multiply "&#x5f;" (string-length s-og))))))

(define (wescheme->wescheme e #:indent [indent #f])
  ;(printf "doing wescheme->wescheme ~s\n" e)
  (cond [(string? e) (format "~s" e)]
        [(not (pair? e)) (format "~a" e)]
        [(list e) (let ([a (car e)])
                    (cond [(and (eq? a 'cond) (> (length e) 1))
                           (let ([cond-clauses (cdr e)])
                             (string-append
                               "(cond\n"
                               (string-join
                                 (map
                                   (lambda (cl)
                                     (string-append
                                       (if indent (make-string (+ indent 2) #\space) "")
                                       "["
                                       ;REVISIT should propagate indent to within cond-clauses?
                                       (string-join (map wescheme->wescheme cl) " ")
                                       "]"))
                                   (cdr cond-clauses))
                                 "\n")))]
                          [(and (eq? a 'define) (= (length e) 3))
                           (let* ([lhs (cadr e)] [rhs (caddr e)]
                                                 [lhs-s (wescheme->wescheme lhs)]
                                                 [rhs-s (wescheme->wescheme rhs #:indent
                                                                            (and indent (+ indent 2)))]
                                                 [rhs-s-nl? (regexp-match "\n" rhs-s)])
                             (string-append "(define " lhs-s
                               (if rhs-s-nl? "\n" " ")
                               (if (and rhs-s-nl? indent) (make-string (+ indent 2) #\space) "")
                               rhs-s ")"))]
                          [(eq? a 'EXAMPLE)
                           (let ([num-examples (/ (length (cdr e)) 2)])
                             (let loop ([n num-examples] [e (cdr e)] [r ""])
                               (if (= n 0) r
                                   (let* ([lhs (car e)] [rhs (cadr e)]
                                                        [lhs-s (wescheme->wescheme lhs)]
                                                        [rhs-s (wescheme->wescheme rhs)]
                                                        [tot-len (+ (string-length lhs-s)
                                                                    (string-length rhs-s))])
                                     (loop (- n 1) (cddr e)
                                           (string-append r
                                             (if (= n num-examples) "" "\n")
                                             "(EXAMPLE "
                                             lhs-s
                                             (if (< tot-len 35)
                                                 " "
                                                 (string-append "\n"
                                                   (if indent (make-string (+ indent 2) #\space) "")))
                                             rhs-s ")"))))))]
                          [else (string-append "("
                                  (string-join (map wescheme->wescheme e) " ")
                                  ")")]))]
        [else (error ' wescheme->wescheme "")]))

(define (wescheme->pyret e #:wrap [wrap #f] #:indent [indent #f])
  ;(printf "doing wescheme->pyret ~s ~s\n" e wrap)
  (cond [(number? e) (format "~a" e)]
        [(symbol? e) (cond [(eq? e 'sqrt) "num-sqrt"]
                           [(eq? e 'sqr) "num-sqr"]
                           [(eq? e 'random) "num-random"]
                           [(eq? e '=) "=="]
                           [(eq? e '<=) "\\<="]
                           [(eq? e 'string=?) "=="]
                           [(eq? e 'string<?) "<"]
                           [(eq? e 'string<=?) "\\<="]
                           [(eq? e 'string>?) ">"]
                           [(eq? e 'string>=?) ">="]
                           [(eq? e 'string<>?) "<>"]
                           [else
                             (let ([es (format "~a" e)])
                               (cond [(regexp-match #rx"\\?$" es)
                                      (regexp-replace #rx"(.*)\\?$" es "is-\\1")]
                                     [(regexp-match #rx"([a-z])/([a-z])" es)
                                      (regexp-replace #rx"([a-z])/([a-z])" es "\\1-\\2")]
                                     [else es]))])]
        [(string? e) (format "~s" e)]
        [(list? e) (let ([a (car e)])
                     (cond [(memq a '(+ - * / and or < > = <= >= <>
                                        string=? string<? string<=? string>? string>=? string<>?
                                        ))
                            (let* ([a (wescheme->pyret a)]
                                   [lft (wescheme->pyret (list-ref e 1) #:wrap #t)]
                                   [rt (wescheme->pyret (list-ref e 2) #:wrap #t)]
                                   [x (format "~a ~a ~a" lft a rt)])
                              (if wrap
                                  (format "({empty}~a{empty})" x)
                                  x))]
                           [(eq? a 'cond)
                            (string-append "ask:\n"
                              (string-join
                                (map (lambda (e)
                                       (wescheme-cond-clause->pyret
                                         e #:indent indent))
                                     (cdr e)) "\n")
                              "\n"
                              (if indent (make-string indent #\space) "")
                              "end")]
                           [(eq? a 'define)
                            (let* ([lhs (cadr e)] [rhs (caddr e)]
                                                  [lhs-s (wescheme->pyret lhs)]
                                                  [rhs-s (wescheme->pyret rhs #:indent
                                                                          (and indent (+ indent 2)))]
                                                  [rhs-s-nl? (regexp-match "\n" rhs-s)])
                              (if (pair? lhs)
                                  (string-append "fun " lhs-s ":"
                                    (if rhs-s-nl? "\n" " ")
                                    (if indent (make-string (+ indent 2) #\space) "")
                                    rhs-s
                                    (if rhs-s-nl? "\n" " ")
                                    "end")
                                  (string-append lhs-s " = " rhs-s)))]
                           [(eq? a 'EXAMPLE)
                            (let ([num-examples (/ (length (cdr e)) 2)])
                              (let loop ([n num-examples] [e (cdr e)] [r "examples:"])
                                (if (= n 0)
                                    (string-append r "\nend")
                                    (let* ([lhs (car e)] [rhs (cadr e)]
                                                         [lhs-s (wescheme->pyret lhs)]
                                                         [rhs-s (wescheme->pyret rhs)]
                                                         [tot-len (+ (string-length (format "~s" lhs))
                                                                     (string-length (format "~s" rhs)))])
                                      ;(printf "*** lhs-s = ~s; rhs-s = ~s\n" lhs-s rhs-s)
                                      ;(printf "*** tot-len = ~s\n" tot-len)
                                      (loop (- n 1) (cddr e)
                                            (string-append r "\n"
                                              (if indent (make-string (+ indent 2) #\space) "")
                                              lhs-s " is "
                                              (if (< tot-len 35) ""
                                                  (string-append
                                                    "\n"
                                                    (if indent (make-string (+ indent 4) #\space) "")))
                                              rhs-s))))))]
                           [else (format "~a{empty}({empty}~a{empty})"
                                         (wescheme->pyret a)
                                         (string-join
                                           (map (lambda (e1)
                                                  (wescheme->pyret e1)) (cdr e))
                                           ", "))]))]
        [else
          (error ' ERROR "wescheme->pyret: unknown s-exp ~s" e)]))

(define (wescheme-cond-clause->pyret e #:indent [indent #f])
  ;(printf "doing wescheme-cond-clause->pyret ~s\n" e)
  (let ([a (car e)])
    (string-append
      (if indent (make-string (+ indent 2) #\space) "")
      "| "
      (if (eq? a 'else) "otherwise"
          (string-append (wescheme->pyret a)
            " then"))
      ": "
      (wescheme->pyret (cadr e)))))

(define (wescheme->pyret-s s)
  (wescheme->pyret (string->symbol s)))

(define (pyret-keyword? w)
  ;(printf "doing pyret-keyword? ~s\n" w)
  (ormap
    (lambda (kw) (string=? w kw))
    '(
      "|"
      "ask:"
      "else"
      "else:"
      "end"
      "examples:"
      "fun"
      "if"
      "is"
      "otherwise:"
      "then:"
      )))

(define (highlight-keywords s)
  ;(printf "doing (~a) highlight-keywords ~s\n" *proglang* s)
  (if (not (string? s))
      "Don't care"
      (let ([res (let ([lines (regexp-split #rx"\n" s)])
                   (string-join
                     (map (lambda (ln)
                            (let ([words (regexp-split #rx" " ln)])
                              (string-join
                                (map (lambda (w)
                                       (if (pyret-keyword? w)
                                           (begin
                                             ;(printf "found keyword ~a\n" w)
                                             (format "%PYRETKEYWORD%~a%END%" w))
                                           w))
                                     words) " ")))
                          lines) "\n"))])
        (if (string=? res "") " " res))))

(define (write-section-header page-header funname)
  (format (string-append
            "\n\n[.designRecipeLayout]\n"
            "= [.dr-title]##~a: ~a##\n")
          page-header funname))

(define (write-directions directions)
  (format (string-append
            "\n[.recipe_word_problem]\n"
            "**Directions**: ~a\n\n")
          directions))

(define (write-title title-text)
  (string-append
    "\n\n[.recipe_title, cols=\"100a,1a\"]\n"
    "|===\n"
    "| " title-text "|\n"
    "|===\n\n"))

(define (write-purpose funname domain-list range purpose)
  (string-append
    (write-title "Contract and Purpose Statement")
    "[.recipe.recipe_instructions]\n"
    "Every contract has three parts...\n\n"
    "[.recipe.recipe_contract]\n"
    (encoded-ans ".recipe_name" funname *show-funname-contract?*)
    (if *pyret?* "::" ":")
    (encoded-ans ".recipe_domain"
                 ((if *pyret?*
                      vars-to-commaed-string
                      vars-to-string) domain-list) *show-domains?*)
    "->"
    (encoded-ans ".recipe_range" range *show-range?*)
    "\n\n"
    "[.recipe.recipe_purpose_statement]\n"
    (write-purpose-prose purpose)))

(define (write-purpose-prose purpose)
  (cond [*show-purpose?*
          (encoded-ans ".recipe_purpose" purpose *show-purpose?*)]
        [else
          (string-append
            (enclose-span ".begin-ignore-for-gdrive" "")
            (encoded-ans ".recipe_purpose" " " *show-purpose?*)
            (enclose-span ".end-ignore-for-gdrive" "")
            (enclose-span ".gdrive-only"
              (encoded-ans ".recipe_purpose" purpose *show-purpose?*)))]))

(define (write-examples funname num-examples example-list buggy-example-list)
  ;(printf "doing write-examples num-examples=~a example-list=~a buggy-example-list=~a\n" num-examples example-list buggy-example-list)
  (string-append
    (write-title "Examples")
    "[.recipe.recipe_instructions]\n"
    "Write some examples, then circle and label what changes...\n\n"
    ;examples

    (if *pyret?*
        (write-wrapper ".recipe.recipe_example_line.keyword_only"
          (lambda ()
            (write-spaced (highlight-keywords "examples:"))))
        "")

    (apply string-append
           (cond [(cons? buggy-example-list)
                  ;(printf "doing buggy-example-list ~s\n" buggy-example-list)
                  (map (lambda (e)
                         (let* ([n (- (length e) 1)]
                                [body (list-ref e n)]
                                [fun-call
                                  (case *proglang*
                                    [("wescheme") (car e)]
                                    [("pyret" "codap") (take e n)])])
                           (write-each-example (car fun-call) (cdr fun-call) body #t)))
                       buggy-example-list)]
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

    (if *pyret?*
        (write-wrapper ".recipe.recipe_example_line.keyword_only"
          (lambda ()
            (write-spaced (highlight-keywords "end"))))
        "")
    ))

(define (longer-than? len . exprs)
  (let ([exprs-len (foldl + 0
                     (map (lambda (e)
                            (let ([e (regexp-replace* #rx"{empty}" e "")])
                              (string-length e)))
                          exprs))])
    ;(printf "elen = ~s; len = ~s\n" exprs-len len)
    (> exprs-len len)))

(define (write-each-example/wescheme funname show-funname? args show-args? body show-body?)
  ;(printf "write-each-example/scheme ~s ~s ~s\n" funname args body)
  (string-append
    (write-wrapper ".recipe.recipe_example_line"
      (lambda ()
        (string-append
          (encoded-ans "" "(EXAMPLE (" #t)
          (encoded-ans ".recipe_name" funname show-funname?)
          " "
          (encoded-ans ".recipe_example_inputs" (list-to-string args) show-args?)
          (encoded-ans "" ")" #t)
          (let ([body-s (expr-to-string body)])
            (string-append
              (encoded-ans ".recipe_example_body" body-s show-body?)
              (write-large ")")
                  ))
            )))))

(define (write-each-example/pyret funname show-funname? args show-args? body show-body?)
  ;(printf "write-each-example/pyret ~s ~s ~s ~s ~s ~s\n" funname show-funname? args show-args? body show-body?)
  (unless (string? body)
    (set! body (if (null? body) ""
                   (wescheme->pyret body))))
  (when (pair? funname)
    (set! args (cdr funname))
    (set! funname (car funname)))
  (unless (string? funname) (set! funname (format "~a" funname)))
  (set! args (list-to-commaed-string args))
  ;(printf "list-to-commaed-string returned ~s\n" args)
  (cond [(null? body) (set! body "")]
        [(pair? body) (set! body (format "~a" body))])
  (set! body (regexp-replace* #rx"\n" body " "))
  (write-wrapper ".recipe.recipe_example_line"
    (lambda ()
      (string-append
        (encoded-ans "" "__" #f)
        (encoded-ans ".recipe_name" funname show-funname?)
        " "
        (write-large "(")
        (encoded-ans ".recipe_example_inputs" args show-args?)
        (write-large ")")
        (encoded-ans "" "__" #f)
        (highlight-keywords " is ")
        (encoded-ans ".recipe_example_body" (highlight-keywords body) show-body?)
        ))))

(define (write-each-example funname args body show)
  ;(printf "write-each-example ~s ~s ~s ~s\n" funname args body show)
  (let ([show-funname? #f]
        [show-args? #f]
        [show-body? #f])
    (cond [(not show) #f]
          [(eqv? show #t)
           (set! show-funname? #t)
           (set! show-args? #t)
           (set! show-body? #t)]
          ;[(not *solutions-mode?*) #f]
          ;FIXME what exactly should we decide here?
          [(list? show)
           (set! show-funname? (list-ref show 0))
           (set! show-args? (list-ref show 1))
           (set! show-body? (list-ref show 2))])
    ((case *proglang*
       [("pyret" "codap") write-each-example/pyret]
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
  ;(printf "doing list-to-commaed-string ~s\n" xx)
  (string-join (map wescheme->pyret xx) ", "))

(define (vars-to-string xx)
  (let ([ans (apply string-append
                    (reverse
                      (let loop ([xx xx] [r '()])
                        (if (null? xx) r
                            (loop (cdr xx) (cons (format " ~a" (car xx)) r))))))])
    (if (string=? ans "") " " ans)))

(define (vars-to-commaed-string xx)
  (cond [(null? xx) " "]
        [(= (length xx) 1) (format "~a" (car xx))]
        [else (let loop ([xx (cdr xx)] [r (format "~a" (car xx))])
                (if (null? xx) r
                    (loop (cdr xx) (string-append r ", " (format "~a" (car xx))))))]))

(define (write-definition/wescheme funname param-list body)
  (let ([cond? (and (pair? body) (eqv? (car body) 'cond))])
    (string-append
      (write-title "Definition")
      "[.recipe.recipe_instructions]\n"
      "Write the definition, giving variable names to all your input values...\n\n"
      (write-null-wrapper ""
        (lambda ()
          (string-append
            (write-wrapper ".recipe.recipe_line"
              (lambda ()
                (string-append
                  (write-large "(")
                  (write-spaced "define (")
                  (encoded-ans ".recipe_name" funname *show-funname-defn?*)
                  " "
                  (encoded-ans ".recipe_variables" (vars-to-string param-list) *show-params?*)
                  (write-large ")"))))

            (cond [cond?
                    (write-wrapper ".recipe.recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "__" #f)
                          (write-large "(")
                          (encoded-ans ".recipe_cond" "cond" *show-body?*)
                          (encoded-ans "" "__" #f))))]
                  [else ""])

            (cond [cond?
                    (apply string-append
                           (map write-cond-clause (cdr body)))]
                  [else
                    (write-wrapper ".recipe.recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "__" #f)
                          (encoded-ans ".recipe_definition_body" (expr-to-string body) *show-body?*)
                          (write-large ")")
                          )))])

            (cond [cond?
                    (write-wrapper ".recipe.recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "__" #f)
                          (write-large "))" #:tag ".studentAnswer"))))]
                  [else
                    ""
                    #|(write-wrapper ".recipe.recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "__" #f)
                          (write-large ")"))))
                    |#
                    ])))))))

(define (write-body-line/pyret body-line)
  ;(printf "write-body-line-p ~s\n" body-line)
  (write-wrapper ".recipe.recipe_line"
    (lambda ()
      (string-append
        (encoded-ans "" "__" #f)
        (cond [(string=? body-line "") ""]
              [(string-prefix? body-line "|")
               (set! body-line (regexp-replace #rx"^\\| *" body-line ""))
               (string-append
                 (highlight-keywords "| ")
                 (cond [(string-prefix? body-line "otherwise:")
                        (let ([otherwise-branch (string-split body-line "otherwise:")])
                          (string-append
                            (highlight-keywords "otherwise: ")
                            (encoded-ans ".answers" (highlight-keywords (car otherwise-branch))
                                         *show-body?*)))]
                       [(string-contains? body-line "then:")
                        (let* ([test-action (string-split body-line " then: ")]
                               [test (car test-action)]
                               [action (cadr test-action)]
                               [test-len (string-length test)]
                               [action-len (string-length action)])
                          ;(printf "test-action = ~s\n" test-action)
                          (string-append
                            (encoded-ans ".questions" test *show-body?*)
                            (cond [(and *show-body?* (> (+ test-len action-len) 50))
                                   (string-append
                                     (write-clear)
                                     (encoded-ans "" "__" #f)
                                     (encoded-ans "" "| " #f)
                                     (highlight-keywords "then: ")
                                     (encoded-ans ".answers" action *show-body?*))]
                                  [else
                                    (string-append
                                      (highlight-keywords " then: ")
                                      (encoded-ans ".answers" action *show-body?*))])))]
                       [else
                         (encoded-ans "" body-line *show-body?*)]))]
              [(regexp-match #rx"^(ask:|end)" body-line)
               (highlight-keywords body-line)]
              [else
                (encoded-ans ".recipe_definition_body"
                             (highlight-keywords body-line) *show-body?*)])))))

(define (write-definition/pyret funname param-list body)
  ;(printf "doing write-definition/pyret ~s ~s ~s\n" funname param-list body)
  (when (or (not body) (null? body)) (set! body ""))
  (unless (string? body) (set! body (wescheme->pyret body)))
      (let* ([body-lines (map string-trim (regexp-split #rx"\n" body))]
             [n (- (length body-lines) 1)]
             [but-last-body-lines (take body-lines n)]
             [last-body-line (car (drop body-lines n))])
        (string-append
          (write-title "Definition")
          "[.recipe.recipe_instructions]\n"
          "Write the definition, giving variable names to all your input values...\n\n"
          (write-null-wrapper ""
            (lambda ()
              (string-append
                (write-wrapper ".recipe.recipe_line"
                  (lambda ()
                    (string-append
                      (write-spaced (highlight-keywords "fun "))
                      (encoded-ans ".recipe_name" funname *show-funname-defn?*)
                      (write-large "(")
                      (encoded-ans ".recipe_variables" (vars-to-commaed-string param-list) *show-params?*)
                      (write-large "):"))))
                (apply string-append
                       (map write-body-line/pyret but-last-body-lines))
                (write-wrapper ".recipe.recipe_line"
                  (lambda ()
                    (string-append
                      (encoded-ans "" "__" #f)
                      (encoded-ans (if (= n 0) ".recipe_definition_body" "")
                                   (highlight-keywords last-body-line)
                                   (if (string-prefix? last-body-line "end") #t
                                       *show-body?*)))))
                (write-wrapper ".recipe.recipe_line.keyword_only"
                  (lambda ()
                    (write-spaced (highlight-keywords "end"))
                    ))))))))

(define (write-definition funname param-list body)
  ((case *proglang*
     [("pyret" "codap") write-definition/pyret]
     [("wescheme") write-definition/wescheme])
   funname param-list body))

(define (write-clear)
  (string-append "\n"
    (enclose-span ".clear" " ")))

(define (write-spaced s)
  ;(format "[.spacer]##~a##" s)
  (format "~a" s)
  )

(define (write-large s #:tag [tag ""])
  (enclose-span (string-append ".studentAnswerCode" tag) s))

(define *wrapper-block-level* 0)

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
          (set! res (thunk)))
      (set! *wrapper-block-level* old-*wrapper-block-level*)
      res)))

(define (write-cond-clause clause)
  ;(printf "doing write-cond-clause ~s\n" clause)
  (write-wrapper ".recipe.recipe_line.recipe_cond_clause"
    (lambda ()
      (string-append (encoded-ans "" "_____" #f)
                     (write-large "{startsb}")
                     (write-wrapper ".clause"
                       (lambda ()
                         (let* ([test (expr-to-string (car clause))]
                                [action (list-to-string (cdr clause))]
                                [test-len (string-length test)]
                                [action-len (string-length action)])
                           (string-append
                             (encoded-ans ".questions" test *show-body?*)
                             (cond [;(and *show-body?* (> (+ test-len action-len) 57))
                                    (or (> test-len *max-wescheme-cond-side-length*)
                                        (> action-len *max-wescheme-cond-side-length*))
                                    (string-append (write-clear)
                                      (encoded-ans "" "_______" #f)
                                      (encoded-ans ".answers" action *show-body?*))]
                                   [else (string-append " "
                                           (encoded-ans ".answers" action *show-body?*))])))))
                     (write-large "{endsb}")))))

(define (design-recipe-exercise funname directions
                                #:page-header (page-header "Word Problem")
                                #:show-funname-contract? (show-funname-contract? #f)
                                #:domain-list (domain-list '()) ; list of string
                                #:show-domains? (show-domains? #f)
                                #:range (range "")
                                #:show-range? (show-range? #f)
                                #:purpose (purpose "")
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
                                #:grid-lines? (grid-lines? #f) ;TODO: what is grid-lines? for
                                #:lang (lang 'racket)
                                #:assess-design-recipe (assess-design-recipe #f)
                                #:headless? (headless? #f)
                                )

  ;TODO: check what the mandatory defaults should be in non-solutions mode, and what
  ;should be overridden in solutions mode

  (set! *show-funname-contract?* show-funname-contract?)
  (set! *show-domains?* show-domains?)
  (set! *show-range?* show-range?)
  (set! *show-purpose?* show-purpose?)
  (set! *show-examples* show-examples)
  (set! *show-funname-defn?* show-funname-defn?)
  (set! *show-params?* show-params?)
  (set! *show-body?* show-body?)

  #|
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
  |#

  ;FIXME: set show's whenever assess-design-recipe OR solutions-mode?

  (unless assess-design-recipe
  (when  *solutions-mode?*
    (set! *show-funname-contract?* #t)
    (set! *show-domains?* #t)
    (set! *show-range?* #t)
    (set! *show-purpose?* #t)
    (set! *show-examples* #t)
    (set! *show-funname-defn?* #t)
    (set! *show-params?* #t)
    (set! *show-body?* #t)
    ))

  ;(printf "d-r-e body= ~s\n" body)
  ;uncomment in orig;
  ;comment, debug
  (when (and (cons? example-list) (cons? buggy-example-list))
    (error 'ERROR "design-recipe-exercise: At most one of example-list and buggy-example-list should be provided"))

  (when (string=? funname "")
    (set! funname " ")
    (set! page-header "Design Recipe")
    (when (string=? directions "")
      (set! directions (format "{sp} +\n{sp} +\n{sp}\n")))
    )
  (when *pyret?*
    (set! funname (wescheme->pyret-s funname)))
  (set! *funname* funname)
  (when (string=? range "") (set! range " "))
  (when (string=? purpose "") (set! purpose "{nbsp}"))
  ;(unless *show-purpose?* (set! purpose " "))

  (string-append

    (if headless? ""
        (write-section-header page-header funname))

    (write-directions directions)

    (write-purpose funname domain-list range purpose)

    (write-examples funname num-examples example-list buggy-example-list)

    (write-definition (or buggy-funname-defn funname) param-list body)

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
          #:headless? (headless? #f)
          )
  (unless range (error 'ERROR "assess-design-recipe: range required"))
  (unless purpose (error 'ERROR "assess-design-recipe: purpose required"))
  (unless body (error 'ERROR "assess-design-recipe: body required"))
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
                            #:headless? headless?
                            )))

