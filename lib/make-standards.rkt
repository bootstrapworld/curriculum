#!/usr/bin/env racket

#lang racket

(require "defines.rkt")
(require "html-tag-gen.rkt")
(require "the-standards-dictionaries.rkt")
(require "utils.rkt")
(require "preproc.rkt")

(define *standards-met* '())

(define *dictionaries-represented* '())

;(print-menubar "standards")

(define *lesson* #f)

(define (add-standard x lesson-title lesson pwy o)
  ;(printf "doing add-standard ~a ~a ~a ~a\n" x lesson-title lesson pwy)
  (let-values ([(sublist-item c dict) (assoc-standards x *standards-list*)])
    (cond [c (let ([std (list-ref c 0)])
               (when (and o *lesson*)
                 (fprintf o "**~a**: ~a~n~n"
                          std (list-ref c 1)))
               (cond [(assoc std *standards-met*) =>
                                                (lambda (c0)
                                                  (when sublist-item
                                                    (let ([sublist-items (list-ref c0 1)])
                                                      (box-add-new! sublist-item sublist-items)))
                                                  (unless *lesson*
                                                    (box-add-new! (list lesson-title lesson pwy)
                                                                  (list-ref c0 4)))
                                                  )]
                     [else
                       (let ([sublist-items
                               (box (if sublist-item
                                        (list sublist-item)
                                        '()))])
                         (unless (member dict *dictionaries-represented*)
                           (set! *dictionaries-represented* (cons dict *dictionaries-represented*)))
                         (set! *standards-met*
                           (cons (list std sublist-items c dict
                                       (box (list (list lesson-title lesson pwy))))
                                 *standards-met*)))]))]
          [else (printf "Standard ~a not found~%" x)]
          )))

(define *all-standards* (read-data-file "all-standards.txt" #:mode 'forms))

(let ([ss *all-standards*])
  (for ([s ss])
    (let ([std (list-ref s 0)]
          [ltitle (list-ref s 1)]
          [lesson (list-ref s 2)]
          [pwy (list-ref s 3)])
      (add-standard std ltitle lesson pwy #f))))

;(printf "standards-met= ~s\n\n\n" *standards-met*)

;(printf "dictionaries-represented= ~s\n" *dictionaries-represented*)

(create-standards-file "Standards" #t #f *standards-met* *dictionaries-represented*)

(void)
