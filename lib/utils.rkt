#lang racket

(provide
  truthy-getenv
  unquote-string
  read-data-file
  gen-new-id
  qualify-proglang
  create-zero-file
  anonymize-filename
  nicer-case
  extract-domain-name
  )

(require file/sha1)

(define (truthy-getenv ev)
  (let ([x (getenv ev)])
    (if (and x (string=? x "")) #f
        x)))

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
            [(form) (read i)]
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

(define (nicer-case x)
  (cond [(string=? x "codap") "CODAP"]
        [(string=? x "wescheme") "WeScheme"]
        [else (string-titlecase x)]))

(define (extract-domain-name f)
  (let ([x (regexp-match "[a-zA-Z][^.:/]*[.](com|org)" f)])
    (and x
         (let ([y (first x)])
           (and (not (string-ci=? y "google"))
                (string-titlecase (substring y 0 (- (string-length y) 4))))))))
