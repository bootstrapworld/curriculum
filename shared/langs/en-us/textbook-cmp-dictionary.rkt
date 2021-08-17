#lang racket

(provide *cmp-textbook-list*)

(define *cmp-textbook-list*
'(

  ; We are borrowing the infrastructure used for standards alignment,
  ; but in this case we're really talking about *chapters*

  ("CMP.6.1" 
    "Prime Time: Factors & Multiples")

  ("CMP.6.2" 
    "Comparing Bits and Pieces: Ratios, Rational Numbers and Equivalence")

  ("CMP.6.3" 
    "Let’s be Rational: Understanding Fraction Operations ")

  ("CMP.6.4" 
    ; The DR recipes we made for OK in restating the problem could connect nicely here, but it feels like a bit of a stretch to suggest that they would just pop into DR here.
    "Covering and Surrounding: Two Dimensional Measurement ")

  ("CMP.6.5" 
    "Decimal Ops: Computing with Decimals and Percents ")

  ("CMP.6.6" 
    ; coordinates lesson could be an extension for this lesson if we figured out how to communicate that to teachers
    "Variables and Patterns: Focus on Algebra") 

  ("CMP.6.7" 
    "Data About Us: Statistics and Data Analysis ")

  ("CMP.7.1"
    ; image functions from the contracts lesson could be a really nice extension activity for this unit. 
    "Shapes and Designs: Two Dimensional Geometry ")

  ("CMP.7.2" "Accentuate the Negative: Integers and Rational Numbers")

  ("CMP.7.3" 
    ; Flags lesson could be a really nice extension activity for this unit.
    "Stretching and Shrinking: Understanding Similarity")

  ("CMP.7.4" 
    ; we've been talking about writing a propotions lesson - keep this unit's goals in mind.
    "Comparing and Scaling: Ratios, Rates, Percent, Proportions")

  ("CMP.7.5" 
    ;There are also some DR problems connected to this unit.
    "Moving Straight Ahead: Linear Relationships ")

  ("CMP.7.6" 
    ; This feels like a gap in our materials that we might fill soon?
    "What Do You Expect: Probability and Expected Values")

  ("CMP.7.7" 
    ;There are some DR problems related to this unit.
    ;We could expand our SA of rect prism unit to work for other prisms or to include scaling.
    "Filling and Wrapping: Three Dimensional Measurement")

  ("CMP.7.8" 
    "Samples and Populations: Making Comparisons and Predictions")
  
  ("CMP.8.1" 
    "Thinking with Mathematical Models: Linear and Inverse Variations ")

  ("CMP.8.2" 
    "Looking for Pythagoras: The Pythagorean Theorem")

  ("CMP.8.3" 
    "Growing, Growing, Growing: Exponential Functions")

  ("CMP.8.4" 
    "Say it with Symbols: Making Sense of Symbols")

  ("CMP.8.5" 
    ; This is another lesson to look at if we write a lesson on proportionality
    "Butterflies, Pinwheels and Wallpaper: Symmetry and Transformations")
  
  ("CMP.8.6" 
    "It’s in the System: Systems of Linear Equations and Inequalities")

  ("CMP.Alg-Ext.1" 
    "Frogs and Fleas and Painted Cubes: Quadratic Functions")

  ("CMP.Alg-Ext.2" 
    ; Part of this unit is focused on function of notation, which perhaps could be connected to the defining functions 
    ; If we build something for inverse functions it should get linked to this
    "Function Junction: Families of Functions")
 ))

