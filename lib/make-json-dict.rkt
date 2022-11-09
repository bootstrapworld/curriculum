#!/usr/bin/env racket

#lang racket

(require "../shared/langs/en-us/standards/the-standards-dictionaries.rkt")
(require "../shared/langs/en-us/textbooks/the-textbook-dictionaries.rkt")
(require "../shared/langs/en-us/practices/the-practices-dictionaries.rkt")

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
              (let ([entry (list-ref lyst j)])
                (fprintf o "      ~s: {\n" (first entry))
                (fprintf o "        \"description\": ~s,\n" (second entry))
                (fprintf o "        \"lessons\": [")
                (let ([lessons (rest (rest entry))])
                  (unless (null? lessons)
                    (fprintf o "~s" (string-join lessons ","))))
                (fprintf o "]\n")
                (fprintf o "      }~a\n"
                         (if (= j last-j) "" ",")))
              (loopj (+ j 1))))
          (fprintf o "    }~a\n"
                   (if (= i last-i) "" ","))
          (loop (+ i 1)))))))

(call-with-output-file "dictionaries.js"
  (lambda (o)
    (fprintf o "let dictionaries = {\n")
    (fprintf o "  \"standards\": {\n")
    (display-sublist *standards-list* o)
    (fprintf o "  },\n")
    (fprintf o "  \"textbooks\": {\n")
    (display-sublist *textbooks-list* o)
    (fprintf o "  },\n")
    (fprintf o "  \"practices\": {\n")
    (display-sublist *practices-list* o)
    (fprintf o "  }\n")
    (fprintf o "};\n")
    )
  #:exists 'replace)
