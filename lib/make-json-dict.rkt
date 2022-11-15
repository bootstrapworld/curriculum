#!/usr/bin/env racket

#lang racket

(require "../shared/langs/en-us/standards/the-standards-dictionaries.rkt")
(require "../shared/langs/en-us/textbooks/the-textbook-dictionaries.rkt")
(require "../shared/langs/en-us/practices/the-practices-dictionaries.rkt")

(define (display-sublist dictionaries o)

  (for ([dictionary dictionaries])
    (fprintf o "    ~s: {\n" (first dictionary))

    (for ([entry (third dictionary)])
      (fprintf o "      ~s: {\n" (first entry))
      (fprintf o "        \"description\": ~s,\n" (second entry))
      (fprintf o "        \"lessons\": [")
      (let ([lessons (rest (rest entry))])
        (for ([lesson lessons])
          (fprintf o "~s, " lesson)))
      (fprintf o "]\n")
      (fprintf o "      },\n"))

    (fprintf o "    },\n")))

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
