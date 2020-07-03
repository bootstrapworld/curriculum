#!/usr/bin/env racket

#lang racket

(define *missing-glossary-items*
  (let ([missing-glossary-items-file "pathway-missing-glossary-items.rkt.kp"])
    (if (file-exists? missing-glossary-items-file)
        (call-with-input-file missing-glossary-items-file read)
        '())))

(for-each (lambda (gi)
            (printf "WARNING: Item ~s not found in glossary\n\n"
                    gi))
          *missing-glossary-items*)

(void)
