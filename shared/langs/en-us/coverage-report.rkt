#!/usr/bin/env racket

#lang racket


(require "standards-cc-ela-dictionary.rkt")
(require "standards-cc-math-dictionary.rkt")
(require "standards-csta-dictionary.rkt")
(require "standards-k12cs-dictionary.rkt")
(require "standards-ngss-dictionary.rkt")
(require "standards-ok-dictionary.rkt")
(require "textbook-cmp-dictionary.rkt")


(require "lessons-and-standards.rkt")

(define *all-the-standards* '())


(for ([std-list (list *cc-ela-standards-list*
                      *cc-math-standards-list*
                      *csta-standards-list*
                      *k12cs-standards-list*
                      *ngss-standards-list*
                      *ok-standards-list*
                      *cmp-standards-list*)])
  (for ([std-desc std-list])
    (let ([std (car std-desc)])
      (set! *all-the-standards*
        (cons std *all-the-standards*)))))


(define *unused-standards* *all-the-standards*)

(for ([lesson-line *lessons-and-standards*])
  (let ([lesson-stds (cdr lesson-line)])
    (for ([std lesson-stds])
      (when (member std *unused-standards*)
        (set! *unused-standards*
          (remove std *unused-standards*))))))


(printf "Unused standards:\n\n")


(let loop ([unused-standards *unused-standards*] [i 0])
  (unless (null? unused-standards)
    (printf "~s" (car unused-standards))
    (cond [(= i 0) (newline) (set! i -1)]
          [else (printf " ")])
    (loop (cdr unused-standards) (+ i 1))))

(newline)
