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
       string-repeat 
       string-contains
       )
      (
       "hello"
       "91"))

    (Boolean
      (
       == < > <> <= >= 
       string-equal
       and or
       )
      (
       true false
       ))

    (Image
      (
       star triangle circle square rectangle rhombus ellipse regular-polygon radial-star polygon-star 
       text 
       image-url
       overlay put-image above beside below rotate scale flip-horizontal flip-vertical
       bar-chart pie-chart box-plot scatter-plot histogram
       bar-chart-summarized pie-chart-summarized modified-box-plot image-scatter-plot
       )
      (
      🔵🔺🔶
      ))

    (Table
      (count .row-n .order-by .filter .build-column
             )
      ())

    ))
