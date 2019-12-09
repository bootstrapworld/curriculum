#lang racket

(provide 
  mstring
  ferror
  )

(define (mstring . strs)
  (string-join strs "\n"))

(define (ferror tag fmt . args)
  (apply error 'ERROR (format "~a: ~a" tag fmt) args))

