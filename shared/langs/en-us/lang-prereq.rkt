#lang racket

(provide *language-table*)

(define *language-table*
  '(

    (Number
      (
       + - * /
       expt
       pi
       sqr sqrt
       )
      ())

    (String
      (
       string-length
       )
      ())

    (Image
      (
       circle ellipse image-url overlay
       put-image  rectangle rotate  scale square  star
       text triangle
       )
      ())

    ))
