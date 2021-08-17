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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
  ; https://curriculum.illustrativemathematics.org/MS/teachers/3/2/index.html
  ("IM.8.2.1"
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Illustrative Mathematics Algebra 1 Unit 1: One-variable Statistics
  ; https://curriculum.illustrativemathematics.org/HS/teachers/1/1/index.html
  ("IM.Alg1.1.1" 
    "Getting to Know You")

  ("IM.Alg1.1.2" 
    "Data Representations")

  ("IM.Alg1.1.3" 
    "A Gallery of Data")

  ("IM.Alg1.1.4" 
    "The Shape of Distributions")

  ("IM.Alg1.1.5" 
    "Calculating Measures of Center and Variability")

  ("IM.Alg1.1.6" 
    "Mystery Computations")

  ("IM.Alg1.1.7" 
    "Spreadsheet Computations")

  ("IM.Alg1.1.8" 
    "Spreadsheet Shortcuts")

  ("IM.Alg1.1.9" 
    "Technological Graphing")

  ("IM.Alg1.1.10" 
    "The Effect of Extremes")

  ("IM.Alg1.1.11" 
    "Comparing and Contrasting Data Distributions")

  ("IM.Alg1.1.12" 
    "Standard Deviation")

  ("IM.Alg1.1.13" 
    "More Standard Deviation")

  ("IM.Alg1.1.14" 
    "Outliers")

  ("IM.Alg1.1.15" 
    "Comparing Data Sets")

  ("IM.Alg1.1.16" 
    "Analyzing Data")

  ; Illustrative Mathematics Algebra 1 Unit 2: Linear Equations, Inequalities, and Systems
  ; https://curriculum.illustrativemathematics.org/HS/teachers/1/2/index.html
  ("IM.Alg1.2.1" 
    "Planning a Pizza Party")

  ("IM.Alg1.2.2" 
    "Writing Equations to Model Relationships (Part 1)")

  ("IM.Alg1.2.3" 
    "Writing Equations to Model Relationships (Part 2)")

  ("IM.Alg1.2.4" 
    "Equations and Their Solutions")

  ("IM.Alg1.2.5" 
    "Equations and Their Graphs")

  ("IM.Alg1.2.6" 
    "Equivalent Equations")

  ("IM.Alg1.2.7" 
    "Explaining Steps for Rewriting Equations")

  ("IM.Alg1.2.8" 
    "Which Variable to Solve for? (Part 1)")

  ("IM.Alg1.2.9" 
    "Which Variable to Solve for? (Part 2)")

  ("IM.Alg1.2.10" 
    "Connecting Equations to Graphs (Part 1)")

  ("IM.Alg1.2.11" 
    "Connecting Equations to Graphs (Part 2)")

  ("IM.Alg1.2.12" 
    "Writing and Graphing Systems of Linear Equations")

  ("IM.Alg1.2.13" 
    "Solving Systems by Substitution")

  ("IM.Alg1.2.14" 
    "Solving Systems by Elimination (Part 1)")

  ("IM.Alg1.2.15" 
    "Solving Systems by Elimination (Part 2)")

  ("IM.Alg1.2.16" 
    "Solving Systems by Elimination (Part 3)")

  ("IM.Alg1.2.17" 
    "Systems of Linear Equations and Their Solutions")

  ("IM.Alg1.2.18" 
    "Representing Situations with Inequalities")

  ("IM.Alg1.2.19" 
    "Solutions to Inequalities in One Variable")

  ("IM.Alg1.2.20" 
    "Writing and Solving Inequalities in One Variable")

  ("IM.Alg1.2.21" 
    "Graphing Linear Inequalities in Two Variables (Part 1)")

  ("IM.Alg1.2.22" 
    "Graphing Linear Inequalities in Two Variables (Part 2)")

  ("IM.Alg1.2.23" 
    "Solving Problems with Inequalities in Two Variables")

  ("IM.Alg1.2.24" 
    "Solutions to Systems of Linear Inequalities in Two Variables")

  ("IM.Alg1.2.25" 
    "Solving Problems with Systems of Linear Inequalities in Two Variables")

  ("IM.Alg1.2.26" 
    "Modeling with Systems of Inequalities in Two Variables")

  ; Illustrative Mathematics Algebra 1 Unit 3: Two-variable Statistics
  ; https://curriculum.illustrativemathematics.org/HS/teachers/1/3/index.html
  ("IM.Alg1.3.1" 
    "Two-way Tables")

  ("IM.Alg1.3.2" 
    "Relative Frequency Tables")

  ("IM.Alg1.3.3" 
    "Associations in Categorical Data")

  ("IM.Alg1.3.4" 
    "Linear Models")

  ("IM.Alg1.3.5" 
    "Fitting Lines")

  ("IM.Alg1.3.6" 
    "Residuals")

  ("IM.Alg1.3.7" 
    "The Correlation Coefficient")

  ("IM.Alg1.3.8" 
    "Using the Correlation Coefficient")

  ("IM.Alg1.3.9" 
    "Causal Relationships")

  ("IM.Alg1.3.10" 
    "Fossils and Flags")

  ; Illustrative Mathematics Algebra 1 Unit 4: Functions
  ; https://curriculum.illustrativemathematics.org/HS/teachers/1/4/index.html
  ("IM.Alg1.4.1" 
    "Describing and Graphing Situations")

  ("IM.Alg1.4.2" 
    "Function Notation")

  ("IM.Alg1.4.3" 
    "Interpreting & Using Function Notation")

  ("IM.Alg1.4.4" 
    "Using Function Notation to Describe Rules (Part 1)")

  ("IM.Alg1.4.5" 
    "Using Function Notation to Describe Rules (Part 2)")

  ("IM.Alg1.4.6" 
    "Features of Graphs")

  ("IM.Alg1.4.7" 
    "Using Graphs to Find Average Rate of Change")

  ("IM.Alg1.4.8" 
    "Interpreting and Creating Graphs")

  ("IM.Alg1.4.9" 
    "Comparing Graphs")

  ("IM.Alg1.4.10" 
    "Domain and Range (Part 1)")

  ("IM.Alg1.4.11" 
    "Domain and Range (Part 2)")

  ("IM.Alg1.4.12" 
    "Piecewise Functions")

  ("IM.Alg1.4.13" 
    "Absolute Value Functions (Part 1)")

  ("IM.Alg1.4.14" 
    "Absolute Value Functions (Part 2)")

  ("IM.Alg1.4.15" 
    "Inverse Functions")

  ("IM.Alg1.4.16" 
    "Finding and Interpreting Inverse Functions")

  ("IM.Alg1.4.17" 
    "Writing Inverse Functions to Solve Problems")

  ("IM.Alg1.4.18" 
    "Using Functions to Model Battery Power")

  ; Illustrative Mathematics Algebra 1 Unit 5: Introduction to Exponential Functions
  ; https://curriculum.illustrativemathematics.org/HS/teachers/1/5/index.html
  ("IM.Alg1.5.1" 
    "Growing and Growing")

  ("IM.Alg1.5.2" 
    "Patterns of Growth")

  ("IM.Alg1.5.3" 
    "Representing Exponential Growth")

  ("IM.Alg1.5.4" 
    "Understanding Decay")

  ("IM.Alg1.5.5" 
    "Representing Exponential Decay")

  ("IM.Alg1.5.6" 
    "Analyzing Graphs")

  ("IM.Alg1.5.7" 
    "Using Negative Exponents")

  ("IM.Alg1.5.8" 
    "Exponential Situations as Functions")

  ("IM.Alg1.5.9" 
    "Interpreting Exponential Functions")

  ("IM.Alg1.5.10" 
    "Looking at Rates of Change")

  ("IM.Alg1.5.11" 
    "Modeling Exponential Behavior")

  ("IM.Alg1.5.12" 
    "Reasoning about Exponential Graphs (Part 1)")

  ("IM.Alg1.5.13" 
    "Reasoning about Exponential Graphs (Part 2)")

  ("IM.Alg1.5.14" 
    "Recalling Percent Change")

  ("IM.Alg1.5.15" 
    "Functions Involving Percent Change")

  ("IM.Alg1.5.16" 
    "Compound Interest")

  ("IM.Alg1.5.17" 
    "Different Compounding Intervals")

  ("IM.Alg1.5.18" 
    "Expressed in Different Ways")

  ("IM.Alg1.5.19" 
    "Which One Changes Faster?")

  ("IM.Alg1.5.20" 
    "Changes over Equal Intervals")

  ("IM.Alg1.5.21" 
    "Predicting Populations")

  ; Illustrative Mathematics Algebra 1 Unit 6: Introduction to Quadratic Functions
  ; https://curriculum.illustrativemathematics.org/HS/teachers/1/6/index.html
  ("IM.Alg1.6.1" 
    "A Different Kind of Change")

  ("IM.Alg1.6.2" 
    "How Does it Change?")

  ("IM.Alg1.6.3" 
    "Building Quadratic Functions from Geometric Patterns")

  ("IM.Alg1.6.4" 
    "Comparing Quadratic and Exponential Functions")

  ("IM.Alg1.6.5" 
    "Building Quadratic Functions to Describe Situations (Part 1)")

  ("IM.Alg1.6.6" 
    "Building Quadratic Functions to Describe Situations (Part 2)")

  ("IM.Alg1.6.7" 
    "Building Quadratic Functions to Describe Situations (Part 3)")

  ("IM.Alg1.6.8" 
    "Equivalent Quadratic Expressions")

  ("IM.Alg1.6.9" 
    "Standard Form and Factored Form")

  ("IM.Alg1.6.10" 
    "Graphs of Functions in Standard and Factored Forms")

  ("IM.Alg1.6.11" 
    "Graphing from the Factored Form")

  ("IM.Alg1.6.12" 
    "Graphing the Standard Form (Part 1)")

  ("IM.Alg1.6.13" 
    "Graphing the Standard Form (Part 2)")

  ("IM.Alg1.6.14" 
    "Graphs That Represent Situations")

  ("IM.Alg1.6.15" 
    "Vertex Form")

  ("IM.Alg1.6.16" 
    "Graphing from the Vertex Form")

  ("IM.Alg1.6.17" 
    "Changing the Vertex")

  ; Illustrative Mathematics Algebra 1 Unit 7: Quadratic Equations
  ; https://curriculum.illustrativemathematics.org/HS/teachers/1/7/index.html
  ("IM.Alg1.7.1" 
    "Finding Unknown Inputs")

  ("IM.Alg1.7.2" 
    "When and Why do We Write Quadratic Equations?")

  ("IM.Alg1.7.3" 
    "Solving Quadratic Equations by Reasoning")

  ("IM.Alg1.7.4" 
    "Solving Quadratic Equations with the Zero Product Property")

  ("IM.Alg1.7.5" 
    "How Many Solutions?")

  ("IM.Alg1.7.6" 
    "Rewriting Quadratic Expressions in Factored Form (Part 1)")

  ("IM.Alg1.7.7" 
    "Rewriting Quadratic Expressions in Factored Form (Part 2)")

  ("IM.Alg1.7.8" 
    "Rewriting Quadratic Expressions in Factored Form (Part 3)")

  ("IM.Alg1.7.9" 
    "Solving Quadratic Equations by Using Factored Form")

  ("IM.Alg1.7.10" 
    "Rewriting Quadratic Expressions in Factored Form (Part 4)")

  ("IM.Alg1.7.11" 
    "What are Perfect Squares?")

  ("IM.Alg1.7.12" 
    "Completing the Square (Part 1)")

  ("IM.Alg1.7.13" 
    "Completing the Square (Part 2)")

  ("IM.Alg1.7.14" 
    "Completing the Square (Part 3)")

  ("IM.Alg1.7.15" 
    "Quadratic Equations with Irrational Solutions")

  ("IM.Alg1.7.16" 
    "The Quadratic Formula")

  ("IM.Alg1.7.17" 
    "Applying the Quadratic Formula (Part 1)")

  ("IM.Alg1.7.18" 
    "Applying the Quadratic Formula (Part 2)")

  ("IM.Alg1.7.19" 
    "Deriving the Quadratic Formula")

  ("IM.Alg1.7.20" 
    "Rational and Irrational Solutions")

  ("IM.Alg1.7.21" 
    "Sums and Products of Rational and Irrational Numbers")

  ("IM.Alg1.7.22" 
    "Rewriting Quadratic Expressions in Vertex Form")

  ("IM.Alg1.7.23" 
    "Using Quadratic Expressions in Vertex Form to Solve Problems")

  ("IM.Alg1.7.24" 
    "Using Quadratic Equations to Model Situations and Solve Problems")

  ; End of chapter/section list
 )))
