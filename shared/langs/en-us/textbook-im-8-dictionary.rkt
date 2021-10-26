#lang racket

(provide *im-8-textbook-list*)

(define *im-8-textbook-list*
'(
  ; Modeled after https://github.com/bootstrapworld/curriculum/blob/
  ; ada269498c15600c27452688218e202f333d5ae0/shared/langs/en-us/textbook-cmp-
  ; dictionary.rkt

  ; We are borrowing the infrastructure used for standards alignment,
  ; but in this case we're really talking about *chapters*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Illustrative Mathematics Grade 8 Unit 1: Rigid Transformations and Congruence
  ; https://curriculum.illustrativemathematics.org/MS/teachers/3/1/index.html
  ("IM.8.1.1"
    "Moving in the Plane")

  ("IM.8.1.2"
    "Naming the moves")

  ("IM.8.1.3"
    "Grid Moves")

  ; Illustrative Mathematics Grade 8 Unit 2: Dilations, Similarity, and Introducing Slope

  ("IM.8.2.1" 
   "https://curriculum.illustrativemathematics.org/MS/teachers/3/2/index.html"
   "Projecting and Scaling")

  ; Illustrative Mathematics Grade 8 Unit 3: Linear Relationships
  ; https://curriculum.illustrativemathematics.org/MS/teachers/3/3/index.html
  ("IM.8.3.11"
    "Equations of All Kinds of Lines")

  ; Illustrative Mathematics Grade 8 Unit 5: Functions and Volume
  ; https://curriculum.illustrativemathematics.org/MS/teachers/3/5/index.html
  ("IM.8.5.1"
    "Inputs and Outputs")

  ("IM.8.5.2"
    "Introduction to Functions")

  ("IM.8.5.3"
    "Equations for Functions")

  ("IM.8.5.10"
    "Piecewise Linear Functions")

  ; Illustrative Mathematics Grade 8 Unit 6: Associations in Data
  ; https://curriculum.illustrativemathematics.org/MS/teachers/3/6/index.html
  ("IM.8.6.1"
    "Organizing Data")

  ("IM.8.6.2"
    "Plotting Data")

  ("IM.8.6.3"
    "What a Point in a Scatter Plots Means")

  ("IM.8.6.4"
    "Fitting a Lin to Data")

  ("IM.8.6.5"
    "Describing Trends in Scatter Plots")

  ("IM.8.6.6"
    "The Slope of a Fitted Line")

  ("IM.8.6.7"
    "Observing More Patterns in Scatter Plots")

  ("IM.8.6.8"
    "Analyzing Bivariate Data")

  ; Illustrative Mathematics Grade 8 Unit 7: Exponents and Scientific Notation
  ; https://curriculum.illustrativemathematics.org/MS/teachers/3/7/index.html
  ("IM.8.7.7"
    "Practice with Rational Bases")

  ; Illustrative Mathematics Grade 8 Unit 8: Pythagorean Theorem and Irrational Numbers
  ; https://curriculum.illustrativemathematics.org/MS/teachers/3/8/index.html
  ("IM.8.8.6"
    "Finding Side Lengths of Triangles")

  ("IM.8.8.7"
    "A Proof of the Pythagorean Theorem")

  ("IM.8.8.8"
    "Finding Unknown Side Lengths")

  ("IM.8.8.10"
    "Applications of the Pythagorean Theorem")

  ("IM.8.8.11"
    "Finding Distances in the Coordinate Plane")

  ; End of chapter/section list
 ))
