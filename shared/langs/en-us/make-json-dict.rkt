#!/usr/bin/env racket

#lang racket

(require "standards/the-standards-dictionaries.rkt")
(require "textbooks/the-textbook-dictionaries.rkt")
(require "practices/the-practices-dictionaries.rkt")

(define (display-sublist dictionaries o)
  (let ([last-i (- (length dictionaries) 1)])
    (let loop ([i 0])
      (unless (> i last-i)
        (let* ([dictionary (list-ref dictionaries i)]
               [nickname (first dictionary)]
               [lyst (third dictionary)]
               [last-j (- (length lyst) 1)])
          (fprintf o "    ~s: {\n" nickname)
          (let loopj ([j 0])
            (unless (> j last-j)
              (let ([desc (list-ref lyst j)])
                (fprintf o "      ~s: ~s~a\n"
                         (first desc) (second desc)
                         (if (= j last-j) "" ",")))
              (loopj (+ j 1))))
          (fprintf o "    }~a\n"
                   (if (= i last-i) "" ","))
          (loop (+ i 1)))))))

(define (display-sublist-obs dictionaries o)
  ; (printf "doing display-sublist ~s\n" dictionaries)
  (let ([first? #t])
    (for ([dictionary dictionaries])
      (let ([nickname (first dictionary)]
            ; [full-name (second dictionary)]
            [lyst (third dictionary)]
            ; [url (fourth dictionary)] 
            )
        ; (printf "doing ~s ~s\n" nickname lyst)
        (fprintf o "    ~a~s: {\n" (if first? " " ",") nickname)
        (set! first? #f)
        (let ([i-first? #t])
          (for ([desc lyst])
            (fprintf o "      ~a~s: ~s\n" (if i-first? " " ",") (first desc) (second desc))
            (set! i-first? #f)
            )
          )
        (fprintf o "    }\n")
        ))))



(call-with-output-file "dictionaries.json"
  (lambda (o)
    (fprintf o "{\n")
    (fprintf o "  \"standards\": {\n")
    (display-sublist *standards-list* o)
    (fprintf o "  },\n")
    (fprintf o "  \"textbooks\": {\n")
    (display-sublist *textbooks-list* o)
    (fprintf o "  },\n")
    (fprintf o "  \"practices\": {\n")
    (display-sublist *practices-list* o)
    (fprintf o "  }\n")
    (fprintf o "}\n")
    )
  #:exists 'replace)
