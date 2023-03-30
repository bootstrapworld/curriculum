#lang racket

(provide create-workbook-links)

(define (create-workbook-links)
  (string-append
    "Most exercises are part of the **link:../workbook/workbook.pdf[Student Workbook]**,\n"
    "and we provide password-protected **link:./protected/workbook-sols.pdf[Workbook Solutions]** as well.\n\n"
    "You can find the 'exercise' and 'solution' versions of all supplemental materials as well, in the lists below."))
