#lang racket

(provide create-workbook-links)

(define (create-workbook-links)
  (string-append
    "La mayoria de los ejercicios son parte del **link:../workbook/workbook.pdf[Student Workbook]**,\n"
    "y también proporcionamos **link:./protected/workbook-sols.pdf[Workbook Solutions]** protegido con contraseña.\n\n"
    "También puede encontrar las versiones de 'ejercicio' y 'solución' de todos los materiales complementarios, en las listas a continuación."))
