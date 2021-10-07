#lang racket

(provide *im-textbook-list*)

(define *im-textbook-list*
'(
  ; Modeled after https://github.com/bootstrapworld/curriculum/blob/
  ; ada269498c15600c27452688218e202f333d5ae0/shared/langs/en-us/textbook-cmp-
  ; dictionary.rkt

  ; We are borrowing the infrastructure used for standards alignment,
  ; but in this case we're really talking about *chapters*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Illustrative Mathematics Grade 6 Unit 1: Area and Surface Area
  ; https://curriculum.illustrativemathematics.org/MS/teachers/1/1/index.html
  ("IM.6.1.3"
    "Reasoning to Find Area")

  ("IM.6.1.12"
    "What is Surface Area?")

  ("IM.6.1.13"
    "Polyhedra")

  ("IM.6.1.14"
    "Nets and Surface Area")    

  ("IM.6.1.15"
    "More Nets, More Surface Area")

  ; Illustrative Mathematics Grade 6 Unit 2: Introducing Ratios
  ; https://curriculum.illustrativemathematics.org/MS/teachers/1/2/index.html
  ("IM.6.2.14"
    "Solving Equivalent Ratio Problems")

  ; Illustrative Mathematics Grade 6 Unit 3: More about Constant Speed 
  ; https://curriculum.illustrativemathematics.org/MS/teachers/1/3/index.html
  ("IM.6.3.8"
    "More about Constant Speed")

  ; Illustrative Mathematics Grade 6 Unit 5: Expressions and Equations 
  ; https://curriculum.illustrativemathematics.org/MS/teachers/1/5/index.html
  ("IM.6.5.5"
    "Decimal Points in Products")

  ; Illustrative Mathematics Grade 6 Unit 6: Expressions and Equations 
  ; https://curriculum.illustrativemathematics.org/MS/teachers/1/6/index.html
  ("IM.6.6.2"
    "Truth and Equations")

  ("IM.6.6.6"
    "Write Expressions Where Letters Stand for Numbers")

  ("IM.6.6.8"
    "Equal and Equivalent")

  ("IM.6.6.13"
    "Expressions with Exponents")

  ("IM.6.6.14"
    "Evaluating Expressions with Exponents")

  ("IM.6.6.15"
    "Equivalent Exponential Expressions"

  ("IM.6.6.16"
    "Two Related Quantities, Part 1")

  ("IM.6.6.17"
    "Two Related Quantities, Part 2")

  ("IM.6.6.18"
    "More Relationships")

  ; Illustrative Mathematics Grade 6 Unit 7: Rational Numbers
  ; https://curriculum.illustrativemathematics.org/MS/teachers/1/7/index.html
  ("IM 6.7.8"
    "Writing and Graphing Inequalities")

  ("IM.6.7.9"
    "Solutions of Inequalities")

  ("IM.6.7.10"
    "Interpreting Inequalities")

  ("IM.6.7.11"
    "Points on the Coordinate Plane")

  ("IM.6.7.12"
    "Constructing the Coordinate Plane")

  ("IM.6.7.13"
    "Interpreting Points on a Coordinate Plane")

  ("IM.6.7.14"
    "Distances on the Coordinate Plane")

  ("IM.6.7.15"
    "Shapes on the Coordinate Plane")

  ; Illustrative Mathematics Grade 6 Unit 8: Data Sets and Distributions
  ; https://curriculum.illustrativemathematics.org/MS/teachers/1/8/index.html
  ("IM.6.8.1"
    "Got Data?")

  ("IM.6.8.2"
    "Statistical Questions")

  ("IM.6.8.6"
    "Histograms")
 
  ("IM.6.8.7"
    "Using Histograms to Answer Statistical Questions")

  ("IM.6.8.8"
    "Describing Distributions on Histograms")

  ("IM.6.8.9"
    "Interpreting the Mean as Fair Share")

  ("IM.6.8.10"
    "Interpreting the Mean as the Balance Point")

  ("IM.6.8.13"
    "The Median of a Data Set")

  ("IM.6.8.14"
    "Comparing Mean and Median")

  ("IM.6.8.15"
    "Quartiles and Interquartile Range")

  ("IM.6.8.16"
    "Box Plots")

  ("IM.6.8.17"
    "Using Box Plots")

  ; End of chapter/section list
 )))
