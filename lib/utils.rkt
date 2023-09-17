#lang racket

(provide
  truthy-getenv
  ferror
  file-mtime
  system-echo
  unquote-string
  read-data-file
  gen-new-id
  qualify-proglang
  create-zero-file
  anonymize-filename
  math-unicode-if-possible
  )

(require file/sha1)

(define (truthy-getenv ev)
  (let ([x (getenv ev)])
    (if (and x (string=? x "")) #f
        x)))

(define (ferror tag fmt . args)
  (apply error 'ERROR (format "~a: ~a" tag fmt) args))

(define (file-mtime f)
  (if (file-exists? f) (file-or-directory-modify-seconds f) 0))

(define (system-echo cmd . args)
  (let* ([x (apply process* cmd args)]
         [i (first x)]
         [result (format "~a" (read i))])
    (close-input-port i)
    (close-output-port (second x))
    (close-input-port (fourth x))
    (and (not (eof-object? result))
         result)))

(define (unquote-string s)
  (string-trim s "\""))

(define (read-data-file f #:mode [mode 'files])
  ; (printf "doing read-data-file ~s ~s\n" f mode)
  (if (not (file-exists? f)) '()
      (call-with-input-file f
        (lambda (i)
          (case mode
            [(files) (let loop ([xx '()])
                       (let ([x (read-line i)])
                         (if (eof-object? x) (reverse xx)
                             (let ([x (unquote-string (string-trim x))])
                               (set! x (regexp-replace "[ \t]*;.*$" x ""))
                               (loop (if (string=? x "") xx
                                         (cons x xx)))))))]
            [(lines) (let loop ([xx '()])
                       (let ([x (read-line i)])
                         (if (eof-object? x) (reverse xx)
                             (loop
                               (let ([yy (call-with-input-string x
                                           (lambda (i2)
                                             (let loop2 ([yy '()])
                                               (let ([y (read i2)])
                                                 (if (eof-object? y) (reverse yy)
                                                     (loop2 (cons (format "~a" y) yy)))))))])
                                 (if (null? yy) xx (cons yy xx)))))))]
            [(lua-return)
             (read-line i)
             (let loop ([xx '()])
               (let ([c (peek-char i)])
                 (cond [(or (eof-object? c) (char=? c #\})) (reverse xx)]
                       [(or (char=? c #\,) (char-whitespace? c)) (read-char i) (loop xx)]
                       [else (loop (cons (read i) xx))])))]
            [(forms) (let loop ([xx '()])
                       (let ([x (read i)])
                         (if (eof-object? x) (reverse xx)
                             (loop (cons x xx)))))])))))

(define *id-counter* 0)

(define (gen-new-id)
  (set! *id-counter* (+ *id-counter* 1))
  *id-counter*)

(define (qualify-proglang dirname rel-root *proglang*)
  ; (printf "doing qualify-proglang ~s ~s ~s\n\n" dirname rel-root *proglang*)
  (unless (or (string=? *proglang* "pyret")
              (regexp-match (string-append "-" *proglang* "$") dirname))
    (let ([q (string-append dirname "-" *proglang*)])
      (when (directory-exists? (build-path rel-root q))
        (set! dirname q))))
  dirname)

(define (create-zero-file f)
  (unless (file-exists? f)
    (call-with-output-file f
      (lambda (o)
        (display 0 o) (newline o)))))

(define (anonymize-filename img)
  ; (printf "doing anonymize-filename ~s\n" img)
  (let-values ([(dir fname _) (split-path img)])
    (when (eqv? dir 'relative) (set! dir 'same))
    (let ([basename (path->string (path-replace-extension fname ""))]
          [ext (path-get-extension fname)])
      (unless ext (set! ext ""))
      (build-path dir
                  (path-replace-extension
                    (substring
                      (bytes->hex-string (call-with-input-string basename sha1-bytes))
                      0 16)
                    ext)))))

(define (math-id1-or-number text)
  (cond [(math-unicode-if-possible text) => identity]
        [(andmap (lambda (c) (or (char-numeric? c) (char=? c #\.)))
                 (string->list text))
         text]
        [else #f]))

(define (math-frac text)
  (let ([x (regexp-match "^\\\\frac{([^}]*)} *{([^}]*)}" text)])
    (and x
         (let ([numr (math-id1-or-number (second x))]
               [denr (math-id1-or-number (third x))])
           (and numr denr
                (list numr denr))))))

(define (math-unicode-if-possible text)
  (case text
    [("a")   "𝑎"]
    [("b")   "𝑏"]
    [("c")   "𝑐"]
    [("f")   "𝑓"]
    [("g")   "𝑔"]
    [("h")   "ℎ"]
    [("r")   "𝑟"]
    [("x")   "𝑥"]
    [("y")   "𝑦"]
    [("R^2") "𝑅²"]
    [("x_1") "𝑥₁"]
    [("x_2") "𝑥₂"]
    [("y_1") "𝑦₁"]
    [("y_2") "𝑦₂"]
    [("=")   "="]
    [("±")   "±"]
    [else
      (cond [(math-frac text)
             => (lambda (xx)
                  (string-append (first xx) "⁄" (second xx)))]
            [else #f])]))
