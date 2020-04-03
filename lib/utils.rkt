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

(define (read-data-file f #:lists [lists #f])
  (call-with-input-file f
    (lambda (i)
      (let loop ([lines '()])
        (let ([x (read-line i)])
          (if (eof-object? x) (reverse lines)
              (loop (if (regexp-match #rx"^ *;" x)
                        lines
                        (if lists
                            (let ([xx (map unquote-string (string-split x))])
                              (if (null? xx) lines
                                  (cons xx lines)))
                            (let ([x (unquote-string (string-trim x))])
                              (if (string=? x "") lines
                                  (cons x lines))))))))))))
