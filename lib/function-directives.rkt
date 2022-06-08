#lang racket

(require "utils.rkt")
(require "html-tag-gen.rkt")

(provide assess-design-recipe
         design-recipe-exercise
         get-function-name
         wescheme-symbol->pyret
         wescheme->pyret
         wescheme->wescheme
         vars-to-commaed-string vars-to-string
         design-codap-recipe
         data-cycle
         )

(define *solutions-mode?* #f)

(define *proglang* "pyret")

(define *pyret?* #t)

(define (set-proglang! proglang)
  (set! *proglang* proglang)
  (set! *pyret?* (string=? *proglang* "pyret"))
  (unless (member *proglang* '("pyret" "wescheme" "codap"))
    (error 'ERROR "function-directives.rkt: Unknown proglang ~a"
           *proglang*)))

(define *show-funname-contract?* #f)
(define *show-domains?* #f)
(define *show-range?* #f)
(define *show-purpose?* #f)
(define *show-examples* #f)
(define *show-funname-defn?* #f)
(define *show-params?* #f)
(define *show-body?* #f)

(define *table-marker* "|")

(define *div-nesting* 0)

(define *max-wescheme-cond-side-length* 32)
(define *max-line-length* 50)
;; NOTE(Emmanuel) - these lines have been subsumed by *max-line-length*
;(define *max-wescheme-example-side-length* 30)
;(define *max-pyret-example-side-length* 30)

(define *max-pyret-example-clause-length* 60)

(define *funname* #f)

(define (get-function-name) *funname*)

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
        [(list e) (let ([a (first e)])
                    (cond [(and (eq? a 'cond) (> (length e) 1))
                           (let ([cond-clauses (rest e)])
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
                                   (rest cond-clauses))
                                 "\n")))]
                          [(and (eq? a 'define) (= (length e) 3))
                           (let* ([lhs (second e)] [rhs (third e)]
                                                 [lhs-s (wescheme->wescheme lhs)]
                                                 [rhs-s (wescheme->wescheme rhs #:indent
                                                                            (and indent (+ indent 2)))]
                                                 [rhs-s-nl? (regexp-match "\n" rhs-s)])
                             (string-append "(define " lhs-s
                               (if rhs-s-nl? "\n" " ")
                               (if (and rhs-s-nl? indent) (make-string (+ indent 2) #\space) "")
                               rhs-s ")"))]
                          [(eq? a 'EXAMPLE)
                           (let ([num-examples (/ (length (rest e)) 2)])
                             (let loop ([n num-examples] [e (rest e)] [r ""])
                               (if (= n 0) r
                                   (let* ([lhs (first e)] [rhs (second e)]
                                                        [lhs-s (wescheme->wescheme lhs)]
                                                        [rhs-s (wescheme->wescheme rhs)]
                                                        [tot-len (+ (string-length lhs-s)
                                                                    (string-length rhs-s))])
                                     (loop (- n 1) (rest (rest e))
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

(define (wescheme-symbol->pyret e)
  (cond [(eq? e '<=) "\\<="]
        [(eq? e '=) "=="]
        [(eq? e 'abs) "num-abs"]
        [(eq? e 'expt) "num-expt"]
        [(eq? e 'frac) "/"]
        [(eq? e 'image=?) "images-equal"]
        [(eq? e 'make-posn) "posn"]
        [(eq? e 'pi) "num-pi"]
        [(eq? e 'random) "num-random"]
        [(eq? e 'sqr) "num-sqr"]
        [(eq? e 'sqrt) "num-sqrt"]
        [(eq? e 'string-contains?) "string-contains"]
        [(eq? e 'string<=?) "\\<="]
        [(eq? e 'string<>?) "<>"]
        [(eq? e 'string<?) "<"]
        [(eq? e 'string=?) "=="]
        [(eq? e 'string>=?) ">="]
        [(eq? e 'string>?) ">"]
        [else
          (let ([es (format "~a" e)])
            (cond [(regexp-match #rx"\\?$" es)
                   (regexp-replace #rx"(.*)\\?$" es "is-\\1")]
                  [(regexp-match #rx"([a-z])/([a-z])" es)
                   (regexp-replace #rx"([a-z])/([a-z])" es "\\1-\\2")]
                  [else es]))]))

(define (wescheme->pyret e #:wrap [wrap #f] #:indent [indent #f])
  ;(printf "doing wescheme->pyret ~s ~s\n" e wrap)
  (cond [(number? e) (format "~a" e)]
        [(symbol? e) (wescheme-symbol->pyret e)]
        [(string? e) (format "~s" e)]
        [(list? e) (let ([a (first e)])
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
                            (let* ([clauses (rest e)]
                                   [n (- (length clauses) 1)])
                              (let loop ([i n] [r '("end")])
                                (if (< i 0) (string-join
                                              (map (lambda (c)
                                                     (string-append
                                                       (if indent  (make-string indent #\space) "")
                                                       c)
                                                     ) r)
                                              "\n")
                                    (let ([clause (list-ref clauses i)])
                                      (loop (- i 1) (cons
                                                      (string-append
                                                        (cond [(and (= i n) (eq? (first clause) 'else))
                                                               (string-append "else: "  (wescheme->pyret (second clause)))]
                                                              [(= i 0)
                                                               (string-append "if " (wescheme->pyret (first clause)) ": " (wescheme->pyret (second clause)))]
                                                              [else
                                                                (string-append "else if " (wescheme->pyret (first clause)) ": " (wescheme->pyret (second clause)))]))
                                                      r))))))]
                           [(eq? a 'define)
                            (let* ([lhs (second e)] [rhs (third e)]
                                                  [lhs-s (wescheme->pyret lhs)]
                                                  [rhs-s (wescheme->pyret rhs #:indent
                                                                          (and indent (+ indent 2)))]
                                                  [rhs-s-nl? (regexp-match "\n" rhs-s)]
                                                  [rhs-s-if? (regexp-match "^ *if " rhs-s)]
                                                  )
                              (if (pair? lhs)
                                  (string-append "fun " lhs-s ":"
                                    (if rhs-s-nl? "\n" " ")
                                    (if (and rhs-s-nl? indent) (make-string (if rhs-s-if? indent (+ indent 2)) #\space) "")
                                    rhs-s
                                    (if rhs-s-nl? "\n" " ")
                                    "end")
                                  (string-append lhs-s " = " rhs-s)))]
                           [(eq? a 'EXAMPLE)
                            (let ([num-examples (/ (length (rest e)) 2)])
                              (let loop ([n num-examples] [e (rest e)] [r "examples:"])
                                (if (= n 0)
                                    (string-append r "\nend")
                                    (let* ([lhs (first e)] [rhs (second e)]
                                                         [lhs-s (wescheme->pyret lhs)]
                                                         [rhs-s (wescheme->pyret rhs)]
                                                         [tot-len (+ (string-length (format "~s" lhs))
                                                                     (string-length (format "~s" rhs)))])
                                      ; (printf "*** lhs-s = ~s; rhs-s = ~s\n" lhs-s rhs-s)
                                      ; (printf "*** tot-len = ~s\n" tot-len)
                                      (loop (- n 1) (rest (rest e))
                                            (string-append r "\n"
                                              (if indent (make-string (+ indent 2) #\space) "")
                                              lhs-s " is "
                                              (if (< tot-len *max-pyret-example-clause-length*) ""
                                                  (string-append
                                                    "\n"
                                                    (if indent (make-string (+ indent 4) #\space) "")))
                                              rhs-s))))))]
                           [else (format "~a{empty}({empty}~a{empty})"
                                         (wescheme->pyret a)
                                         (string-join
                                           (map (lambda (e1)
                                                  (wescheme->pyret e1)) (rest e))
                                           ", "))]))]
        [else
          (error ' ERROR "wescheme->pyret: unknown s-exp ~s" e)]))

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

(define (write-proglang)
  (enclose-span (format ".headless-design-recipe.FOR~a" *proglang*) ""))

(define (write-section-header page-header funname)
  (format (string-append
            "\n\n[.designRecipeLayout]\n"
            "= [.dr-title]##~a~a##\n")
          page-header
          (if funname (format ": ~a" funname) "")))

(define (write-directions directions)
  (format (string-append
            "\n[.recipe_word_problem]\n"
            "**Directions**: ~a\n\n")
          directions))

(define (write-title title-text)
  (string-append
    "\n\n[.recipe_title, cols=\"100a,1a\"]\n"
    *table-marker* "===\n"
    *table-marker* " " title-text *table-marker* "\n"
    *table-marker* "===\n\n"))

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
                                    [("wescheme") (first e)]
                                    [("pyret" "codap") (take e n)])])
                           (write-each-example (first fun-call) (rest fun-call) body #t)))
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
    (set! args (rest funname))
    (set! funname (first funname)))
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
                            (loop (rest xx) (cons (format " ~s" (first xx)) r))))))])
    (if (string=? ans "") " " ans)))

(define (list-to-commaed-string xx)
  ;(printf "doing list-to-commaed-string ~s\n" xx)
  (string-join (map wescheme->pyret xx) ", "))

(define (vars-to-string xx)
  (let ([ans (apply string-append
                    (reverse
                      (let loop ([xx xx] [r '()])
                        (if (null? xx) r
                            (loop (rest xx) (cons (format " ~a" (first xx)) r))))))])
    (if (string=? ans "") " " ans)))

(define (vars-to-commaed-string xx)
  (cond [(null? xx) " "]
        [(= (length xx) 1) (format "~a" (first xx))]
        [else (let loop ([xx (rest xx)] [r (format "~a" (first xx))])
                (if (null? xx) r
                    (loop (rest xx) (string-append r ", " (format "~a" (first xx))))))]))

(define (write-definition/wescheme funname param-list body)
  (let ([cond? (and (pair? body) (eqv? (first body) 'cond))])
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
                          (encoded-ans ".recipe_cond" "cond" #t)
                          (encoded-ans "" "__" #f))))]
                  [else ""])

            (cond [cond?
                    (write-wrapper ".cond_clauses"
                      (lambda ()
                        (apply string-append
                          (map write-cond-clause (rest body)))))]
                  [else
                    (write-wrapper ".recipe.recipe_line"
                      (lambda ()
                        (string-append
                          (encoded-ans "" "__" #f)
                          (encoded-ans ".recipe_definition_body" (expr-to-string body) *show-body?*)
                          (write-large ")")
                          )))])

            ))))))

(define (write-body-line/pyret body-line)
  ; (printf "write-body-line-p ~s\n" body-line)
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
                            (encoded-ans ".answers" (highlight-keywords (first otherwise-branch))
                                         *show-body?*)))]
                       [(string-contains? body-line "then:")
                        (let* ([test-action (string-split body-line " then: ")]
                               [test (first test-action)]
                               [action (second test-action)]
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
              [(or (string-prefix? body-line "if ")
                   (string-prefix? body-line "else if ")
                   (string-prefix? body-line "else: "))
               (let* ([n (cond [(string-prefix? body-line "if ") 3]
                               [(string-prefix? body-line "else if ") 8]
                               [(string-prefix? body-line "else: ") 6])]
                      [leadup (substring body-line 0 n)]
                      [kode (substring body-line n)])
                 (string-append
                   (highlight-keywords leadup)
                   (encoded-ans ".answers" (highlight-keywords kode) *show-body?*)))]
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
             [last-body-line (first (drop body-lines n))])
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
                         (let* ([test (expr-to-string (first clause))]
                                [action (list-to-string (rest clause))]
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
                                #:proglang [proglang "pyret"]
                                #:dist-root-dir [dist-root-dir ""]
                                #:solutions-mode? [solutions-mode? #f]
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
                                #:nested-in-table? [nested-in-table? #f]
                                )

  ;TODO: check what the mandatory defaults should be in non-solutions mode, and what
  ;should be overridden in solutions mode

  (set-proglang! proglang)

  (set! *solutions-mode?* solutions-mode?)

  (set! *show-funname-contract?* show-funname-contract?)
  (set! *show-domains?* show-domains?)
  (set! *show-range?* show-range?)
  (set! *show-purpose?* show-purpose?)
  (set! *show-examples* show-examples)
  (set! *show-funname-defn?* show-funname-defn?)
  (set! *show-params?* show-params?)
  (set! *show-body?* show-body?)

  (set! *table-marker* (if nested-in-table? "!" "|"))

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

    (if headless?
        (write-proglang)
        (write-section-header page-header funname))

    (write-directions directions)

    (write-purpose funname domain-list range purpose)

    (write-examples funname num-examples example-list buggy-example-list)

    (write-definition (or buggy-funname-defn funname) param-list body)

    )

  )

(define (assess-design-recipe
          funname directions
          #:proglang [proglang "pyret"]
          #:dist-root-dir [dist-root-dir ""]
          #:solutions-mode? [solutions-mode? #f]
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
          #:nested-in-table? [nested-in-table? #f]
          )
  (set-proglang! proglang)
  (set! *solutions-mode?* solutions-mode?)
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
                            #:nested-in-table? nested-in-table?
                            )))

;;;; CODAP design recipe

(define *show-transformer-name?* #f)
(define *show-transformer-contract?* #f)
(define *show-transformer-type?* #f)
(define *show-example-headers?* #f)
(define *show-input-examples* #f)
(define *show-output-examples* #f)
(define *show-formula-expression?* #f)

(define (write-transformer transformer-name transformer-type)
  (when transformer-type
    (set! transformer-type (string-downcase transformer-type)))
  (let ([style-transformer-type
          (lambda (type)
            (if (and *show-transformer-type?* transformer-type
                     (string=? transformer-type type))
                ".codap_transformer_type_checked"
                ".codap_transformer_type"))])

  (string-append
    "\n\n[.recipe_title.transformer_type, cols=\"100a,1a\"]\n"
    "|===\n"
    "| Transformer (check one) "
    (format
      (string-append
        "\n[~a]\nFilter"
        "\n[~a]\nTransform"
        "\n[~a]\nBuild")
      (style-transformer-type "filter")
      (style-transformer-type "transform")
      (style-transformer-type "build"))
    "|\n"
    "|===\n\n"
    "[.recipe]\n"
    "++++\n<p class=\"recipe\"><span class=\"studentAnswer recipe_name\">"
    (if *show-transformer-name?* transformer-name "")
    "</span></p>\n++++")))

(define (write-example-tables input-rows output-rows stipulated-num-input-rows stipulated-num-output-rows)
  ; (printf "doing write-example-tables ~s ~s ~s ~s\n" input-rows output-rows stipulated-num-input-rows stipulated-num-output-rows)
  (string-append
    (write-title "Example Tables")
    "[.recipe.recipe_instructions.codap_example_tables]\n"
    "What gets filtered/transformed/built? In the sample tables below, add the relevant columns.\n\n"

    (let* ([input-header (if (null? input-rows) #f (first input-rows))]
           [output-header (if (null? output-rows) #f (first output-rows))]
           [num-input-cols (if input-header (length input-header) 2)]
           [num-output-cols (if output-header (length output-header) 2)]
           [input-rows (if input-header (rest input-rows) input-rows)]
           [output-rows (if output-header (rest output-rows) output-rows)]
           )
      (string-append
        "[cols=\"1a,1a\"]\n"
        "|===\n"
        "|\n\n"
        (format "[.cols=~a, options=header]\n" num-input-cols)
        (write-each-example-table #t input-header input-rows  *show-input-examples* stipulated-num-input-rows num-input-cols)
        "|\n\n"
        (format "[.cols=~a, options=header]\n" num-output-cols)
        (write-each-example-table #f output-header output-rows  *show-output-examples* stipulated-num-output-rows num-output-cols)
        "\n\n"
        "|===\n\n"))))

(define (write-each-example-table is-input header rows show-rows stipulated-num-rows num-cols)
  ; (printf "doing write-each-example-table ~s ~s ~s ~s ~s\n" header rows show-rows stipulated-num-rows num-cols)
  (let* ([num-given-rows (length rows)]
         [num-blank-rows (max 0 (- stipulated-num-rows num-given-rows))])
    (string-append
      "[.ExampleTableTitle]\n"
      (if is-input "Original Table" "Transformed Table")
      "\n!===\n\n"
      (apply string-append
        (map (lambda (x) (string-append "! " (if *show-example-headers?* x ""))) header))
      "\n"
      (apply string-append
        (append
          (map (lambda (ro s)
                 (cond [s (string-append (apply string-append (map (lambda (x) (string-append "! " x)) ro)) "\n")]
                       [else (string-append (apply string-append (map (lambda (x) "! ") (build-list num-cols (lambda (x) 'ignore)))) "\n")]))
               rows
               (cond [(eq? show-rows #t) (build-list num-given-rows (lambda (i) #t))]
                     [(eq? show-rows #f) (build-list num-given-rows (lambda (i) #f))]
                     [else (let* ([num-rows-after-shown-ones (max 0 (- num-given-rows (length show-rows)))]
                                  [modified-show-examples (append show-rows (build-list num-rows-after-shown-ones (lambda (i) #f)))]
                                  [modified-show-examples (take modified-show-examples num-given-rows)])
                             modified-show-examples)]))
          (map (lambda (x) "! ") (build-list (* num-blank-rows num-cols) (lambda (i) 'ignore)))))
      "\n"
      "!===\n\n"
      )))

(define (design-codap-recipe transformer-name directions
                             #:proglang [proglang "codap"]
                             #:dist-root-dir [dist-root-dir ""]
                             #:solutions-mode? [solutions-mode? #f]
                             #:page-header [page-header "Design Recipe"]
                             #:show-transformer-name? [show-transformer-name? #f]
                             #:show-transformer-contract? [show-transformer-contract? #f]
                             #:show-transformer-type? [show-transformer-type? #f]
                             #:transformer-type [transformer-type #f]
                             #:domain-list [domain-list '()]
                             #:show-domains? [show-domains? #f]
                             #:range [range ""]
                             #:show-range? [show-range? #f]
                             #:purpose [purpose ""]
                             #:show-purpose? [show-purpose? #f]
                             #:num-input-examples [num-input-examples 1]
                             #:num-output-examples [num-output-examples 1]
                             #:input-examples [input-examples '()]
                             #:output-examples [output-examples '()]
                             #:show-example-headers? [show-example-headers? #t]
                             #:show-input-examples [show-input-examples '()]
                             #:show-output-examples [show-output-examples '()]
                             #:show-formula-expression? [show-formula-expression? #f]
                             #:formula-expression [formula-expression ""]
                             #:headless? [headless? #f]
                             )

  (set! *solutions-mode?* solutions-mode?)

  (set! *show-transformer-name?* show-transformer-name?)
  (set! *show-transformer-contract?* show-transformer-contract?)
  (set! *show-transformer-type?* show-transformer-type?)
  (set! *show-domains?* show-domains?)
  (set! *show-range?* show-range?)
  (set! *show-purpose?* show-purpose?)
  (set! *show-example-headers?* show-example-headers?)
  (set! *show-input-examples* show-input-examples)
  (set! *show-output-examples* show-output-examples)
  (set! *show-formula-expression?* show-formula-expression?)

  (when *solutions-mode?*
    (set! *show-transformer-name?* #t)
    (set! *show-transformer-contract?* #t)
    (set! *show-transformer-type?* #t)
    (set! *show-domains?* #t)
    (set! *show-range?* #t)
    (set! *show-purpose?* #t)
    (set! *show-example-headers?* #t)
    (set! *show-input-examples* #t)
    (set! *show-output-examples* #t)
    (set! *show-formula-expression?* #t))

  ;any error check here?

  (string-append

    (if headless?
        (write-proglang)
        (write-section-header page-header #f))

    (write-directions directions)

    (write-transformer transformer-name transformer-type)

    (write-example-tables input-examples output-examples num-input-examples num-output-examples)

    (write-formula-expression transformer-name domain-list range purpose formula-expression)

    )

  )

(define (write-formula-expression transformer-name domain-list range purpose body)
  (string-append
    (write-title "Contents (Contract, Purpose Statement, and Expression)")
    "[.recipe.recipe_contract]\n"
    (encoded-ans ".recipe_domain" (vars-to-commaed-string domain-list) *show-domains?*)
    "->"
    (encoded-ans ".recipe_range" range *show-range?*)
    "\n\n"
    "[.recipe.recipe_purpose_statement]\n"
    (write-purpose-prose purpose)
    "\n\n"
    "[.recipe]\n"
    "++++\n<p class=\"recipe\"><span class=\"studentAnswer recipe_formula\">"
    (if *show-formula-expression?* body "")
    "</span></p>\n++++"
    "\n\n"))

;;;; Data cycle

(define *show-question?* #f)
(define *show-rows?* #f)
(define *show-cols?* #f)
(define *show-filter?* #f)
(define *show-build?* #f)
(define *show-expression?* #f)
(define *show-finding?* #f)
(define *show-new-question?* #f)

(define (data-cycle instructions
                    #:proglang [proglang #f]
                    #:dist-root-dir [dist-root-dir ""]
                    #:solutions-mode? [solutions-mode? #f]
                    #:question [question ""]
                    #:show-question? [show-question? #f]
                    #:rows [rows ""]
                    #:show-rows? [show-rows? #f]
                    #:cols [cols ""]
                    #:show-cols? [show-cols? #f]
                    #:filter-fn [filter-fn ""]
                    #:show-filter? [show-filter? #f]
                    #:build-fn [build-fn ""]
                    #:show-build? [show-build? #f]
                    #:expression [expression ""]
                    #:show-expression? [show-expression? #f]
                    #:finding [finding ""]
                    #:show-finding? [show-finding? #f]
                    #:new-question [new-question ""]
                    #:show-new-question? [show-new-question? #f]
                    )

  (set! *solutions-mode?* solutions-mode?)

  (set! *show-question?* show-question?)
  (set! *show-rows?* show-rows?)
  (set! *show-cols?* show-cols?)
  (set! *show-filter?* show-filter?)
  (set! *show-build?* show-build?)
  (set! *show-expression?* show-expression?)
  (set! *show-finding?* show-finding?)
  (set! *show-new-question?* show-new-question?)

  (when *solutions-mode?*
    (set! *show-question?* #t)
    (set! *show-rows?* #t)
    (set! *show-cols?* #t)
    (set! *show-filter?* #t)
    (set! *show-build?* #t)
    (set! *show-expression?* #t)
    (set! *show-finding?* #t)
    (set! *show-new-question?* #t))

  (string-append
    "[.data-cycle, cols=\"^.^3, .^20\", stripes=\"none\"]\n"
    "|===\n"
    "| "
    "image:" dist-root-dir "lib/images/AskQuestions.png[Ask Questions icon]"
    "\n"
    "|\n"
    (fitbruby "" question ".data-cycle-question" *show-question?*)
    "\n\n"
    (fitb "100%" "")
    "\n\n"
    (enclose-span ".data-cycle-type-of-question" "")
    (hspace "1.5em")
    (enclose-span ".data-cycle-lookup" "")
    (hspace "1.5em")
    (enclose-span ".data-cycle-arithmetic" "")
    (hspace "1.5em")
    (enclose-span ".data-cycle-statistical" "")
    "\n\n"
    "| "
    "image:" dist-root-dir "lib/images/ConsiderData.png[Consider Data icon]"
    "\n"
    "|\n"
    (fitbruby "" rows ".data-cycle-rows" *show-rows?*)
    "\n\n"
    (fitbruby "" cols ".data-cycle-cols" *show-cols?*)
    "\n\n"
    "| "
    "image:" dist-root-dir "lib/images/AnalyzeData.png[Analyze icon]"
    "\n"
    "|\n"
    (fitbruby "" filter-fn ".data-cycle-filter" *show-filter?*)
    "\n\n"
    (fitbruby "" build-fn ".data-cycle-build" *show-build?*)
    "\n\n"
    (fitbruby "" expression ".data-cycle-expression" *show-expression?*)
    "\n\n"
    "| "
    "image:" dist-root-dir "lib/images/InterpretData.png[Interpret icon]"
    "\n"
    "|\n"
    (fitbruby "" finding ".data-cycle-finding" *show-finding?*)
    "\n\n"
    (fitb "100%" "")
    "\n\n"
    (fitbruby "" new-question ".data-cycle-new-question" *show-new-question?*)
    "\n\n"
    (fitb "100%" "")
    "\n\n"
    (fitb "100%" "")
    "\n"
    "|==="
    "\n\n")
  )
