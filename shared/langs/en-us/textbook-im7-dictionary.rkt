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

  ; Illustrative Mathematics Grade 7 Unit 1: Scale Drawings
  ; https://curriculum.illustrativemathematics.org/MS/teachers/2/1/index.html
  ("IM.7.1.1"
    "What are Scaled Copies?")

  ("IM.7.1.5"
    "The Size of the Scale Factor")

  ; Illustrative Mathematics Grade 7 Unit 2: Introducing Proportional Relationships
  ; https://curriculum.illustrativemathematics.org/MS/teachers/2/2/index.html
  ("IM.7.2.3"
    "More about Constant of Proportionality")

  ("IM.7.2.4"
    "Proportional Relationships and Equations")

  ("IM.7.2.5"
    "Two Equations for Each Relationship")

  ("IM.7.2.6"
    "Using Equations to Solve Problems")

  ; Illustrative Mathematics Grade 7 Unit 4: Proportional Relationships and Percentages
  ; https://curriculum.illustrativemathematics.org/MS/teachers/2/4/index.html
  ("IM.7.4.1"
    "Lots of Flags")

  ; Illustrative Mathematics Grade 7 Unit 5: Ratioanl Number Arithmetic
  ; https://curriculum.illustrativemathematics.org/MS/teachers/2/5/index.html
  ("IM.7.5.13"
    "Expressions with Rational Numbers")

  ("IM.7.5.14"
    "Solving Problems with Rational Numbers")

  ; Illustrative Mathematics Grade 7 Unit 6: Expressions, Equations, and Inequalities
  ; https://curriculum.illustrativemathematics.org/MS/teachers/2/6/index.html
  ("IM.7.6.11"
    "Using Equations to Solve Problems")

  ("IM.7.6.13"
    "Reintroducing Inequalities")

  ("IM.7.6.14"
    "Finding Solutions to Inequalities in Context")

  ("IM.7.6.15"
    "Efficiently Solving Inequalities")

  ("IM.7.6.16"
    "Interpreting Inequalities")

  ("IM.7.6.17"
    "Modeling with Inequalities")

  ; Illustrative Mathematics Grade 7 Unit 7: Angles, Triangles, and Prisms
  ; https://curriculum.illustrativemathematics.org/MS/teachers/2/7/index.html
  ("IM.7.7.14"
    "Surface Area of Right Prisms")

  ; Illustrative Mathematics Grade 7 Unit 8: Probability and Sampling
  ; https://curriculum.illustrativemathematics.org/MS/teachers/2/8/index.html
  ("IM.7.8.11"
    "Comparing Groups")

  ("IM.7.8.12"
    "Larger Populations")

  ("IM.7.8.13"
    "What Makes a Good Sample?")

  ("IM.7.8.14"
    "Sampling in a Fair Way")

  ("IM.7.8.15"
    "Estimating Populations Measures of Center")

  ("IM.7.8.17"
    "More about Sampling Variability")

  ("IM.7.8.18"
    "Comparing Populations Using Samples")

  ("IM.7.8.19"
    "Comparing Populations with Friends")

  ; End of chapter/section list
 )))
