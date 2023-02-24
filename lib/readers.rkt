#lang racket

(provide
  read-word
  string-to-form
  *make-read-group
  read-commaed-group
  )

(define (read-word i)
  (let loop ([r '()])
    (let ([c (peek-char i)])
      (if (or (char-alphabetic? c) (char=? c #\-))
          (loop (cons (read-char i) r))
          (cond [(null? r)
                 (if (char=? c #\@)
                     (begin (read-char i) "@")
                     "")]
                [else
                  (list->string (reverse r))])))))

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

(define (*make-read-group code errmessage-file-context)
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
                                             (if multiline? s (string-trim s))))
                                   (error 'ERROR "read-group: Runaway directive ~a" directive)]
                                  [in-escape? (loop (cons c r) #f nesting in-string? #f)]
                                  [(char=? c #\\)
                                   (loop (cons c r) #f nesting in-string? #t)]
                                  [in-string?
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
                         (printf "WARNING: Ill-formed metadata directive in ~a: @~a\n\n"
                                 (errmessage-file-context) directive)
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
    (printf "read-c-group in ~s~%" r)
    (set! r
      (map (lambda (x)
             (set! x (string-trim x))
             (let ([last-i (- (string-length x) 1)])
               (when (and (>= last-i 1) (char=? (string-ref x 0) #\")
                          (char=? (string-ref x last-i) #\"))
                 (set! x (substring x 1 last-i))))
             x) 
           r))
    (printf "read-c-group out ~s~%" r)
    r
    ))
