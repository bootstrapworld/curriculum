#lang racket

(provide
  read-word
  *make-read-group
  )

(define (read-word i)
  (let loop ([r '()])
    (let ([c (peek-char i)])
      (if (or (char-alphabetic? c) (char=? c #\-))
          (loop (cons (read-char i) r))
          (if (null? r) ""
              (list->string (reverse r)))))))

(define (quote-rev-string s)
  (let ([n (string-length s)])
    (let loop ([i 0] [r (list #\")])
      (if (>= i n) (cons #\" r)
          (let ([c (string-ref s i)])
            (cond [(char=? c #\") (loop (+ i 1) (cons c (cons #\\ r)))]
                  [else (loop (+ i 1) (cons c r))]))))))

(define (*make-read-group code errmessage-file-context)
  (letrec ([read-group
             (lambda (i directive #:scheme? [scheme? #f])
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
                                           (string-trim (list->string (reverse r))))
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
                                   (if scheme?
                                       (loop (cons c r) #f nesting #f #f)
                                       (loop (if in-space? r (cons #\space r)) #t nesting #f #f))]
                                  [(char=? c #\{)
                                   (loop (cons c r) #f (+ nesting 1) #f #f)]
                                  [(char=? c #\})
                                   (if (= nesting 0)
                                       (string-trim (list->string (reverse r)))
                                       (loop (cons c r) #f (- nesting 1) #f #f))]
                                  [else (loop (cons c r) #f nesting #f #f)])))]
                       [else
                         (printf "WARNING: Ill-formed metadata directive in ~a: @~a\n\n"
                                 (errmessage-file-context) directive)
                         ""])))])
    read-group))
