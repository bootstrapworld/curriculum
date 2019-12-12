#lang racket

(provide 
  mstring
  ferror
  file-mtime
  )

(define (mstring . strs)
  (string-join strs "\n"))

(define (ferror tag fmt . args)
  (apply error 'ERROR (format "~a: ~a" tag fmt) args))

(define (file-mtime f)
  (if (file-exists? f) (file-or-directory-modify-seconds f) 0))
