#lang racket

(provide *language-table*)

(define *language-table*
  '(

    (Number
      (
       + - * /
       expt
       mean median modes
       sqr sqrt
       )
      (
       4
       -1.2
       2/3
       pi
       ))

    (String
      (
       string-length
       string-repeat string-contains
       )
      (
       "hello"
       "91"))

    (Boolean
      (
       == < <= >= string-equal
       )
      (
       true false
       ))

    (Image
      (
       triangle circle star rectangle ellipse square text overlay
       bar-chart pie-chart bar-chart-summarized pie-chart-summarized
       histogram
       )
      ())

    (Table
      (count .row-n .order-by .filter .build-column
             )
      ())

    ))
