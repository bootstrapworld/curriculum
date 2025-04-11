#lang racket

(require "html-tag-gen.rkt")

(provide
  read-word
  read-backticked-text
  string-to-form
  *make-read-group
  read-commaed-group
  ignorespaces
  spaces-till-newline-inclusive
  ignorespaces-peek-char
  process-as-many-pluses-as-possible
  process-passthrough-lines
  math-unicode-if-possible
  )

(define (read-word i)
  (let loop ([r '()])
    (let ([c (peek-char i)])
      (cond [(eof-object? c) (list->string (reverse r))]
            [(or (char-alphabetic? c) (char=? c #\-))
             (loop (cons (read-char i) r))]
            [(null? r)
             (cond [(char=? c #\@) (read-char i) "@"]
                   [else ""])]
            [else (list->string (reverse r))]))))

(define (read-backticked-text i)
  (let loop ([r '(#\`)])
    (let ([c (read-char i)])
      (cond [(eof-object? c) (list->string (reverse r))]
            [(char=? c #\`) (list->string (reverse (cons #\` r)))]
            [else (loop (cons c r))]))))

(define (read-mathjax-word i)
  (let ([c (read-char i)])
    (cond [(eof-object? c) ""]
          [(char-alphabetic? c)
           (let loop ([r (list c)])
             (let ([c (peek-char i)])
               (cond [(or (eof-object? c) (not (char-alphabetic? c)))
                      (list->string (reverse r))]
                     [else (loop (cons (read-char i) r))])))]
          [else (string c)])))

(define (slim-runaway-text s [max-length 120])
  (let ([n (string-length s)])
    (cond [(<= n max-length) s]
          [else (let ([m (quotient (- max-length 5) 2)])
                  (format "~a ··· ~a" (substring s 0 m) (substring s (- n m))))])))

(define (quote-rev-string s)
  (let ([n (string-length s)])
    (let loop ([i 0] [r (list #\")])
      (if (>= i n) (cons #\" r)
          (let ([c (string-ref s i)])
            (cond [(char=? c #\") (loop (+ i 1) (cons c (cons #\\ r)))]
                  [else (loop (+ i 1) (cons c r))]))))))

(define (string-to-form s)
  (call-with-input-string s
    (lambda (i)
      (let loop ([r '()])
        (let ([x (read i)])
          (if (eof-object? x) (reverse r)
              (loop (cons x r))))))))

(define (*make-read-group #:code [code identity] #:errmessage-file-context [errmessage-file-context (lambda () "_")])
  (letrec ([read-group
             (lambda (i directive #:scheme? [scheme? #f] #:multiline? [multiline? #f])
               (let ([c (peek-char i)])
                 (cond [(char=? c #\{)
                        (read-char i)
                        (let loop ([r '()]
                                   [in-space? #t]
                                   [nesting 0]
                                   [in-string? #f]
                                   [in-escape? #f])
                          (let ([c (read-char i)])
                            (cond [(eof-object? c)
                                   (printf "Read so far: ~s\n"
                                           (let ([s (list->string (reverse r))])
                                             (unless multiline?
                                               (set! s (string-trim s)))
                                             (slim-runaway-text s)))
                                   (error 'ERROR "read-group: Runaway directive ~a" directive)]
                                  [in-escape? (loop (cons c r) #f nesting in-string? #f)]
                                  [(char=? c #\\)
                                   (loop (cons c r) #f nesting in-string? #t)]
                                  [(and scheme? in-string?)
                                    (if (char=? c #\")
                                        (loop (cons c r) #f nesting #f #f)
                                        (loop (cons c r) #f nesting #t #f))]
                                  [(and scheme? (char=? c #\@))
                                   (let* ([directive (read-word i)]
                                          [gp (read-group i directive #:scheme? #t)])
                                     ;(printf "dir=~a gp= ~s\n" directive gp)
                                     (when (string=? directive "code")
                                       (set! gp (code gp)))
                                     ;(printf "dir=~a gp'= ~s\n" directive gp)
                                     (loop (append (quote-rev-string gp) r)
                                           #f nesting #f #f))]
                                  [(char=? c #\")
                                   (loop (cons c r) #f nesting #t #f)]
                                  [(member c '(#\space #\tab #\newline #\return))
                                   (if (or scheme? multiline?)
                                       (loop (cons c r) #f nesting #f #f)
                                       (loop (if in-space? r (cons #\space r)) #t nesting #f #f))]
                                  [(char=? c #\{)
                                   (loop (cons c r) #f (+ nesting 1) #f #f)]
                                  [(char=? c #\})
                                   (if (= nesting 0)
                                       (let ([s (list->string (reverse r))])
                                         (if multiline? s (string-trim s)))
                                       (loop (cons c r) #f (- nesting 1) #f #f))]
                                  [else (loop (cons c r) #f nesting #f #f)])))]
                       [else
                         (printf "WARNING: Ill-formed metadata directive in ~a: ~a, ~s\n\n"
                                 (errmessage-file-context) directive c)
                         ""])))])
    read-group))

(define (read-commaed-group i directive read-group)
  (let* ([g (read-group i directive)]
         [n (string-length g)]
         [r (let loop ([i 0] [r '()])
              (if (>= i n)
                  (reverse r)
                  (let loop2 ([j i] [in-string? #f] [in-escape? #f])
                    (if (>= j n) (loop j (cons (substring g i j) r))
                        (let ([c (string-ref g j)])
                          (cond [(eof-object? c)
                                 ; (error 'ERROR "read-commaed-group: Runaway directive ~a in (~a,~a)"
                                 ;        directive *lesson-subdir* *in-file*)
                                 (error 'ERROR "read-commaed-group: Runaway directive ~a" directive)
                                 ]
                                [in-escape?
                                  (loop2 (+ j 1) in-string? #f)]
                                [(char=? c #\\)
                                 (loop2 (+ j 1) in-string? #t)]
                                [in-string?
                                  (if (char=? c #\")
                                      (loop2 (+ j 1) #f #f)
                                      (loop2 (+ j 1) #t #f))]
                                [(char=? c #\")
                                 (loop2 (+ j 1) #t #f)]
                                [(char=? c #\,)
                                 (loop (+ j 1) (cons (substring g i j) r))]
                                [else (loop2 (+ j 1) #f #f)]))))))])
    (map (lambda (x)
           (set! x (string-trim x))
           (let ([last-i (- (string-length x) 1)])
             (when (and (>= last-i 1) (char=? (string-ref x 0) #\")
                        (char=? (string-ref x last-i) #\"))
               (set! x (substring x 1 last-i))))
           x)
         r)))

(define local-read-group
  (let ([read-group (*make-read-group)])
    (lambda (i directive)
      (read-group i directive))))

(define (ignorespaces i)
  (let loop ()
    (let ([c (peek-char i)])
      (when (char-whitespace? c)
        (read-char i)
        (loop)))))

(define (spaces-till-newline-inclusive i)
  (list->string
    (reverse
      (let loop ([r '()])
        (let ([c (peek-char i)])
          (cond [(eof-object? c) r]
                [(char=? c #\newline) (read-char i) r]
                [(char-whitespace? c)
                 (read-char i) (loop (cons c r))]
                [else r]))))))

(define (ignorespaces-peek-char i)
  (let loop ()
    (let ([c (peek-char i)])
      (cond [(eof-object? c) #\space]
            [(char-whitespace? c) (read-char i) (loop)]
            [else c]))))

(define (process-as-many-pluses-as-possible i o)
  (display #\+ o)
  (let loop ([n 1])
    (let ([c (peek-char i)])
      (cond [(eof-object? c) n]
            [(char=? c #\+) (display (read-char i) o) (loop (+ n 1))]
            [else n]))))

(define (process-passthrough-lines i o)
  (let loop ()
    (let ([L (read-line i)])
      (unless (eof-object? L)
        (display L o) (newline o)
        (unless (regexp-match #rx"^\\+\\+\\+\\+" L)
          (loop))))))

(define (read-mathjax-token i)
  (ignorespaces i)
  (let ([c (peek-char i)])
    (cond [(eof-object? c) ""]
          [(char=? c #\{) (local-read-group i "math braced token")]
          [else (string (read-char i))])))

(define *superscriptables*
  '(
    (#\0 "⁰")
    (#\1 "¹")
    (#\2 "²")
    (#\3 "³")
    (#\4 "⁴")
    (#\5 "⁵")
    (#\6 "⁶")
    (#\7 "⁷")
    (#\8 "⁸")
    (#\9 "⁹")
    (#\+ "⁺")
    (#\- "⁻")
    (#\= "⁼")
    (#\( "⁽")
    (#\) "⁾")
    (#\a "ᵃ")
    (#\b "ᵇ")
    (#\c "ᶜ")
    (#\d "ᵈ")
    (#\e "ᵉ")
    (#\f "ᶠ")
    (#\g "ᵍ")
    (#\h "ʰ")
    (#\i "ⁱ")
    (#\j "ʲ")
    (#\k "ᵏ")
    (#\l "ˡ")
    (#\m "ᵐ")
    (#\n "ⁿ")
    (#\o "ᵒ")
    (#\p "ᵖ")
    (#\r "ʳ")
    (#\s "ˢ")
    (#\t "ᵗ")
    (#\u "ᵘ")
    (#\v "ᵛ")
    (#\w "ʷ")
    (#\x "ˣ")
    (#\y "ʸ")
    (#\z "ᶻ")
    ))

(define *subscriptables*
  '(
    (#\0 "₀")
    (#\1 "₁")
    (#\2 "₂")
    (#\3 "₃")
    (#\4 "₄")
    (#\5 "₅")
    (#\6 "₆")
    (#\7 "₇")
    (#\8 "₈")
    (#\9 "₉")
    (#\+ "₊")
    (#\- "₋")
    (#\= "₌")
    (#\( "₍")
    (#\) "₎")
    (#\a "ₐ")
    (#\e "ₑ")
    (#\h "ₕ")
    (#\i "ᵢ")
    (#\j "ⱼ")
    (#\k "ₖ")
    (#\l "ₗ")
    (#\m "ₘ")
    (#\n "ₙ")
    (#\o "ₒ")
    (#\p "ₚ")
    (#\r "ᵣ")
    (#\s "ₛ")
    (#\t "ₜ")
    (#\u "ᵤ")
    (#\v "ᵥ")
    (#\x "ₓ")
    ))

(define *mathjax-special-chars*
  '(
    (#\A "𝐴")
    (#\B "𝐵")
    (#\C "𝐶")
    (#\R "𝑅")
    (#\S "𝑆")
    (#\a "𝑎")
    (#\b "𝑏")
    (#\c "𝑐")
    (#\d "𝑑")
    (#\e "𝑒")
    (#\f "𝑓")
    (#\g "𝑔")
    (#\h "𝒽")
    (#\i "𝑖")
    (#\j "𝑗")
    (#\k "𝑘")
    (#\l "𝑙")
    (#\m "𝑚")
    (#\n "𝑛")
    (#\o "𝑜")
    (#\p "𝑝")
    (#\q "𝑞")
    (#\r "𝑟")
    (#\s "𝑠")
    (#\t "𝑡")
    (#\u "𝑢")
    (#\v "𝑣")
    (#\w "𝑤")
    (#\x "𝑥")
    (#\y "𝑦")
    (#\z "𝑧")
    (#\- "−")
    (#\± "±")
    ))

(define *mathjax-chars-that-need-flanking-space*
  '(
    #\+
    #\-
    #\=
    ))

(define *standard-mathjax-ctl-seqs*
  '(
    ("Delta" "Δ")
    ("Sigma" "Σ")
    ("div" "÷")
    ("ge" "≥")
    ("gt" ">")
    ("infty" "∞")
    ("le" "≤")
    ("lt" "<")
    ("mul" "×")
    ("times" "×")
    ))

(define (math-superscript ss #:use-unicode? [use-unicode? #f] #:asciidoc? [asciidoc? #t])
  (let* ([ss (math-unicode-if-possible ss #:asciidoc? asciidoc?)]
         [ss-list (string->list ss)])
    (cond [(and use-unicode? (andmap (lambda (c) (assoc c *superscriptables*)) ss-list))
           (apply string-append
             (map (lambda (c) (second (assoc c *superscriptables*))) ss-list))]
          [asciidoc?
            (string-append
              (enclose-tag "sup" "" ss) "&#x2009;")]
          [else
            (string-append "<sup>" ss "</sup>")])))

(define (math-subscript ss #:use-unicode? [use-unicode? #f] #:asciidoc? [asciidoc? #t])
  (let* ([ss (math-unicode-if-possible ss #:asciidoc? asciidoc?)]
         [ss-list (string->list ss)])
    (cond [(and use-unicode? (andmap (lambda (c) (assoc c *subscriptables*)) ss-list))
           (apply string-append
             (map (lambda (c) (second (assoc c *subscriptables*))) ss-list))]
          [asciidoc?
            (enclose-tag "sub" "" ss)]
          [else (string-append "<sub>" ss "</sub>")])))

#| ; currently unused - all sqrts are handled by MathJax as of 4/11/25
(define (math-sqrt x)
  ; (printf "math-sqrt of ~s\n" x)
  (let ([n (string-length x)])
    (string-append "√"
      (if (<= n 1) x
          (enclose-span ".overbar" x)))))
|#
(define (math-italic s #:asciidoc? [asciidoc? #t])
  (if asciidoc?
      (enclose-tag "i" "" s)
      (string-append "<i>" s "</i>")))

(define (math-unicode-if-possible text #:asciidoc? [asciidoc? #t])
  ; (printf "doing math-unicode-if-possible ~s ~s\n" text asciidoc?)
  (cond [(or (regexp-match "\\\\over[^l]" text)
             (regexp-match "\\\\require" text)
             (regexp-match "\\\\textit" text)
             (regexp-match "\\\\textbf" text)
             (regexp-match "\\\\qquad" text)
             (regexp-match "\\\\sqrt" text)
             ;(and (regexp-match "\\\\sqrt" text) (not asciidoc?))
             ; (regexp-match "\\\\sqrt" text)
             ; (regexp-match "\\\\sqrt{[^}]+[-+]" text)
             (and (regexp-match "\\\\sqrt{.[^}]" text) asciidoc?)
             (and (regexp-match "\\\\frac{" text) (regexp-match "=" text))
             (regexp-match "\\\\frac{[^ }]+ [^}]+}" text)
             (and (not asciidoc?) (regexp-match "\\\\overline" text))
             ; (and (regexp-match "\\\\div" text) (regexp-match "=" text))
             )
         ; (printf "WARNING: @math{~a} needs MathJax\n\n" text)
         #f]
        [else
          (set! text (regexp-replace* "\\( +" text "("))
          (set! text (regexp-replace* " +\\)" text ")"))
          (set! text (regexp-replace* "\\\\pi" text "π"))
          (call-with-output-string
            (lambda (o)
              (call-with-input-string text
                (lambda (i)
                  (let loop ()
                    (let ([c (peek-char i)])
                      (unless (eof-object? c)
                        (display
                          (cond [(char=? c #\\)
                                 (read-char i)
                                 (let ([ctl-seq (read-mathjax-word i)])
                                   (case ctl-seq
                                     [("mbox" "text") (let ([x (local-read-group i "math mbox")])
                                                 x)]
                                     #| ; all sqrts are forced to mathjax as of 4/11/25
                                     [("sqrt") (let ([x (local-read-group i "math sqrt")])
                                                 ; (printf "sqrt of x = ~s\n" x)
                                                 (math-sqrt (math-unicode-if-possible
                                                              x #:asciidoc? asciidoc?)))]
                                    |#
                                     [("frac") (let* ([nu (read-mathjax-token i)]
                                                      [de (read-mathjax-token i)])
                                                 (display (math-superscript nu #:asciidoc? asciidoc?) o)
                                                 (display "/" o)
                                                 (math-subscript de #:asciidoc? asciidoc?))]
                                     [("overline") (let ([dec (read-mathjax-token i)])
                                                     (enclose-span ".overbar"
                                                       (math-unicode-if-possible
                                                         dec #:asciidoc? asciidoc?)))]
                                     [("|" "lvert" "rvert") "&#x7c;"]
                                     [(";") " "]
                                     [else
                                       (cond [(assoc ctl-seq *standard-mathjax-ctl-seqs*) => second]
                                             [else ctl-seq])]))]
                                [(char=? c #\{) (math-unicode-if-possible
                                                  (local-read-group i "math brace")
                                                  #:asciidoc? asciidoc?)]
                                [(char=? c #\^)
                                 (read-char i)
                                 (math-superscript (read-mathjax-token i)
                                                   #:use-unicode? #f
                                                   #:asciidoc? asciidoc?)]
                                [(char=? c #\_)
                                 (read-char i)
                                 (math-subscript (read-mathjax-token i)
                                                 #:use-unicode? #f
                                                 #:asciidoc? asciidoc?)]
                                [(member c *mathjax-chars-that-need-flanking-space*)
                                 (read-char i)
                                 (string #\space c #\space)]
                                [(char-alphabetic? c)
                                 (read-char i)
                                 (math-italic (string c) #:asciidoc? asciidoc?)]
                                [(assoc c *mathjax-special-chars*)
                                 => (lambda (x)
                                      (read-char i)
                                      (second x))]
                                [else (read-char i) (string c)])
                          o)
                        (loop))))))))]))
