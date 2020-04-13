#lang racket

(provide
  truthy-getenv
  ferror
  file-mtime
  read-data-file
  )

(define (truthy-getenv ev)
  (let ([x (getenv ev)])
    (if (and x (string=? x "")) #f
        x)))

(define (ferror tag fmt . args)
  (apply error 'ERROR (format "~a: ~a" tag fmt) args))

(define (file-mtime f)
  (if (file-exists? f) (file-or-directory-modify-seconds f) 0))

(define (unquote-string s)
  (string-trim s "\""))

(define (read-data-file f #:mode [mode 'files])
  ;(printf "doing read-data-file ~s ~s\n" f mode)
  (if (not (file-exists? f)) '()
      (call-with-input-file f
        (lambda (i)
          (case mode
            [(files) (let loop ([xx '()])
                       (let ([x (read-line i)])
                         (if (eof-object? x) (reverse xx)
                             (let ([x (unquote-string (string-trim x))])
                               (loop (if (or (regexp-match #rx";" x) (string=? x "")) xx
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
            [(forms) (let loop ([xx '()])
                       (let ([x (read i)])
                         (if (eof-object? x) (reverse xx)
                             (loop (cons x xx)))))])))))

