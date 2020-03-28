#lang racket

(provide 
  truthy-getenv
  ferror
  file-mtime
  )

(define (truthy-getenv ev)
  (let ([x (getenv ev)])
    (if (and x (string=? x "")) #f
        x)))

(define (ferror tag fmt . args)
  (apply error 'ERROR (format "~a: ~a" tag fmt) args))

(define (file-mtime f)
  (if (file-exists? f) (file-or-directory-modify-seconds f) 0))
