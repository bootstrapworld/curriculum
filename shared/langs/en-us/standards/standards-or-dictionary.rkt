#lang racket

(provide *or-standards-list*)
    ;;;;;;;;;;;;;;;;;;;  Oregon Math Standards ;;;;;;;;;;;;;;;;;;

(define *or-standards-list*
  '(
    ; Oregon State Standards for Mathematics 5-12

    ; Grade 5
    ("5.OA.A"
     "Write and interpret numerical expressions."
     "order-of-operations"
     )
    ("5.OA.A.1"
     "Write and evaluate numerical expressions that include parentheses."
     "order-of-operations"
     )
    ("5.OA.A.2"
     "Write expressions that record calculations with numbers, and interpret numerical expressions without evaluating them."
     )
    ("5.OA.B"
     "Analyze patterns and relationships."
     )
    ("5.OA.B.3"
     "Generate two numerical patterns using two given rules. Identify and analyze relationships between corresponding terms. Form ordered pairs consisting of corresponding terms from the two patterns, and graph the ordered pairs on a coordinate plane."
    "transform-compose-images" 
    )
    ("5.NBT.A"
     "Understand the place value system."
     )
    ("5.NBT.A.1"
     "Recognize that in a multi-digit number, a digit in one place represents 10 times as much as it represents in the place to its right and 1/10 of what it represents in the place to its left."
     )
    ("5.NBT.A.2"
     "Use whole number exponents to denote powers of 10 and explain the patterns in placement of digits that occur when multiplying and/or dividing whole numbers and decimals by powers of 10."
     )
    ("5.NBT.A.3"
     "Read, write, and compare decimals to thousandths."
     )
    ("5.NBT.A.4"
     "Use place value understanding to round decimals to any place."
     )
    ("5.NBT.B"
     "Perform operations with multi-digit whole numbers and with decimals to hundredths."
     )
    ("5.NBT.B.5"
     "Fluently multiply multi-digit whole numbers using accurate, efficient, and flexible strategies and algorithms based on place value and properties of operations."
     )
    ("5.NBT.B.6"
     "Use a variety of representations and strategies to find whole-number quotients of whole numbers with up to four-digit dividends and two-digit divisors."
     )
    ("5.NBT.B.7"
     "Use a variety of representations and strategies to add, subtract, multiply, and divide decimals to hundredths.  Relate the strategy to a written method and explain the reasoning used."
     )
    ("5.NF.A"
     "Use equivalent fractions as a strategy to add and subtract fractions."
     )
    ("5.NF.A.1"
     "Add and subtract fractions with unlike denominators, including common fractions larger than one and mixed numbers."
     )
    ("5.NF.A.2"
     "Solve problems in authentic contexts involving addition and subtraction of fractions with unlike denominators, including common fractions larger than one and mixed numbers."
     )
    ("5.NF.B"
     "Apply and extend previous understandings of multiplication and division."
     )
    ("5.NF.B.3"
     "Interpret a fraction as division of the numerator by the denominator (a/b = a ÷ b). Solve problems in authentic contexts involving division of whole numbers that result in answers that are common fractions or mixed numbers."
     )
    ("5.NF.B.4"
    "Apply and extend previous understanding and strategies of multiplication to multiply a fraction or whole number by a fraction. Multiply fractional side lengths to find areas of rectangles, and represent fractional products as rectangular areas."
     )
    ("5.NF.B.5"	
    "Apply and extend previous understandings of multiplication and division to represent and calculate multiplication and division of fractions. Interpret multiplication as scaling (resizing) by comparing the size of products of two factors."
     )
    ("5.NF.B.6"
    "Solve problems in authentic contexts involving multiplication of common fractions and mixed numbers."
     )
    ("5.NF.B.7"	
    "Apply and extend previous understandings of division to divide unit fractions by whole numbers and whole numbers by unit fractions, including solving problems in authentic contexts."
     )
    ("5.GM.A"
    "Graph points on the coordinate plane to solve real-world and mathematical problems."
     "transform-compose-images"
     )
    ("5.GM.A.1"
    "Graph and name coordinate points in the first quadrant using the standard (x, y) notation. Understand the coordinate points values represent the distance traveled along the horizontal x-axis and vertical y-axis."
     "transform-compose-images"
     )
    ("5.GM.A.2"	
     "Represent authentic contexts and mathematical problems by graphing points in the first quadrant of the coordinate plane. Interpret the meaning of the coordinate values based on the context of a given situation."
     )
    ("5.GM.B"	
     "Classify two-dimensional figures into categories based on their properties."
     )
    ("5.GM.B.3"
     "Classify two-dimensional figures within a hierarchy based on their geometrical properties, and explain the relationship across and within different categories of these figures."
     )
    ("5.GM.C"	
     "Convert like measurement units within a given measurement system."
     )
    ("5.GM.C.4"	
     "Convert between different-sized standard measurement units within a given measurement system.  Use these conversions in solving multi-step problems in authentic contexts."
     )
    ("5.GM.D"	
     "Geometric measurement: understand concepts of volume."
     )
    ("5.GM.D.5"	
     "Recognize that volume is a measurable attribute of solid figures."
     )
    ("5.GM.D.6"	
     "Measure the volume of a rectangular prism by counting unit cubes using standard and nonstandard units."
     )
    ("5.GM.D.7"	
     "Relate volume of rectangular prisms to the operations of multiplication and addition.  Solve problems in authentic contexts involving volume using a variety of strategies."
     )
    ("5.DR.A"
     "Pose investigative questions and collect/consider data."
     "data-cycle"
     )
    ("5.DR.A.1"
     "Generate questions to investigate situations within the classroom, school or community.  Determine strategies for collecting or considering data involving operations with fractions for this grade that can naturally answer questions by using information presented in line plots."
     "data-cycle"
     )
    ("5.DR.B"	
     "Analyze, represent, and interpret data."
     )
    ("5.DR.B.2"	
     "Analyze graphical representations and describe the distribution of the numerical data through line plots or categorical data through bar graphs. Interpret information presented to answer investigative questions."
     "bar-and-pie-charts"
     "scatter-plots"
     )
    ; Grade 6
    ("6.RP.A"
     "Understand ratio concepts and use ratio reasoning to solve problems."
     "bar-and-pie-charts"
     "transform-compose-images"
     )
    ("6.RP.A.1"
     "Understand the concept of a ratio and use ratio language to describe a ratio relationship between two quantities."
     "transform-compose-images"
     )
    ("6.RP.A.2"
     "Understand the concept of a unit rate in authentic contexts and use rate language in the context of a ratio relationship."
     )
    ("6.RP.A.3"
     "Use ratio and rate reasoning to solve real-world and mathematical problems, e.g., by reasoning about tables of equivalent ratios, tape diagrams, double number line diagrams, or equations."
     "hoc-data"
     )
    ("6.NS.A"
     "Apply and extend previous understandings of multiplication and division to divide fractions by fractions."
     )
    ("6.NS.A.1"
     "Represent, interpret, and compute quotients of fractions to solve problems in authentic contexts involving division of fractions by fractions."
     )
    ("6.NS.B"
     "Compute fluently with multi-digit numbers and find common factors and multiples."
     )
    ("6.NS.B.2"
     "Fluently divide multi-digit numbers using accurate, efficient, and flexible strategies and algorithms based on place value and properties of operations."
     )
    ("6.NS.B.3"
     "Fluently add, subtract, multiply, and divide positive rational numbers using accurate, efficient, and flexible strategies and algorithms."
     )
    ("6.NS.B.4"
     "Determine greatest common factors and least common multiples using a variety of strategies. Apply the distributive property to express a sum of two whole numbers 1–100 with a common factor as a multiple of a sum of two whole numbers with no common factor."
     )
    ("6.NS.C"
     "Apply and extend previous understandings of numbers to the system of rational numbers."
     )
    ("6.NS.C.5"
     "Understand that positive and negative numbers are used together to describe quantities having opposite directions or values. Use positive and negative numbers to represent quantities in authentic contexts, explaining the meaning of zero in each situation."
     )
    ("6.NS.C.6"
     "Represent a rational number as a point on the number line. Extend number line diagrams and coordinate axes to represent points on the line and in the coordinate plane with negative number coordinates."
     )
    ("6.NS.C.7"
     "Interpret statements of inequality as statements about the relative position of two numbers on a number line diagram. Write, interpret, and explain statements of order for rational numbers and absolute value in authentic applications."
     )
    ("6.NS.C.8"
     "Graph points in all four quadrants of the coordinate plane to solve problems in authentic contexts. Include use of coordinates and absolute value to find distances between points with the same first coordinate or the same second coordinate."
     )
    ("6.AEE.A"
     "Apply and extend previous understandings of arithmetic to algebraic expressions."
     )
    ("6.AEE.A.1"
     "Write and evaluate numerical expressions involving whole-number bases and exponents."
     ;Rachel?
     )
    ("6.AEE.A.2"
     "Write, read, and evaluate expressions in which letters stand for numbers."
     ;Rachel?
     )
    ("6.AEE.A.3"
     "Apply the properties of operations to generate equivalent expressions and to determine when two expressions are equivalent."
     ;Rachel?
     )
    ("6.AEE.B"
     "Reason about and solve one-variable equations and inequalities."
     "inequalities1-simple"
     "inequalities2-compound"
     )
    ("6.AEE.B.4"
     "Understand solving an equation or inequality as a process of answering a questionwhich values from a specified set, if any, make the equation or inequality true. Use substitution to determine which number(s) in a given set make an equation or inequality true."
     ;Flannery?
     )
    ; Grade 6
    ("6.AEE.B.5"
     "Use variables to represent numbers and write expressions when solving problems in authentic contexts."
     "linear-regression"
     "grouped-samples"
     "defining-table-functions"
     "surface-area-rect-prism"
     "problem-decomposition"
     "player-animation"
     "inequalities3-sam"
     "inequalities-collision"
     "functions-for-character-animation"
     "function-definition-linear"
     "function-composition"
     "distance"
     "piecewise-functions-conditionals"
     "defining-values"
     "functions-dr"
     "functions-examples-definitions"
     "functions-make-life-easier"
     )
    ("6.AEE.B.6"
     "Write and solve equations of the form x + p = q and px = q in problems that arise from authentic contexts for cases in which p, q and x are all nonnegative rational numbers."
     )
    ("6.AEE.B.7"
     "Write inequalities of the form x > c and x < c to represent constraints or conditions to solve problems in authentic contexts.  Describe and graph on a number line solutions of inequalities of the form x > c and x < c."
     "inequalities3-sam"
     "inequalities1-simple"
     )
    ("6.AEE.C"
     "Represent and analyze quantitative relationships between dependent and independent variables."
     )
    ("6.AEE.C.8"
     "Use variables to represent and analyze two quantities to solve problems in authentic contexts.  Including those that change in relationship to one another; write an equation to express one quantity in terms of the other quantity."
     )
    ("6.G.A"
     "Solve real-world and mathematical problems involving area, surface area, and volume."
     "surface-area-rect-prism"
     )
    ("6.GM.A.1"
     "Find the area of right triangles, other triangles, special quadrilaterals, and polygons by composing into rectangles or decomposing into triangles and other shapes; apply these techniques to solve problems in authentic contexts."
     )
    ("6.GM.A.2"
     "Find the volume of a right rectangular prism with fractional edge lengths by filling it with unit cubes of appropriate unit fraction edge lengths.  Connect and apply to the formulas V = l w h and V = b h to find volumes of right rectangular prisms with fractional edge lengths to solve problems in authentic contexts."
     )
    ("6.GM.A.3"
     "Draw polygons in the four quadrant coordinate plane given coordinates for the vertices and find the length of a side.  Apply these techniques to solve problems in authentic contexts."
     )
    ("6.GM.A.4"
     "Represent three-dimensional figures using nets made up of rectangles and triangles, and use the nets to find the surface area of these figures, including those from authentic contexts."
     "surface-area-rect-prism"
     )
    ("6.DR.A"
     "Formulate Statistical Investigative Questions"
     "data-cycle"
     "measures-of-center"
     "histograms"
     "histograms-interpret"
     "box-plots"
     )
    ("6.DR.A.1"
     "Formulate and recognize statistical investigative questions as those that anticipate changes in descriptive data related to the question and account for it in the answers."
     "ds-intro"
     "choosing-your-dataset"
     "data-cycle"
     )
    ("6.DR.B"
     "Collect and Consider Data"
     "choosing-your-dataset"
     "data-cycle"
     )
    ("6.DR.B.2"
     "Collect and record data with technology to identify and describe the characteristics of numerical data sets using quantitative measures of center and variability."
     "measures-of-center"
     "histograms"
     "histograms-interpret"
     "box-plots"
     "standard-deviation"
     )
    ("6.DR.C"
     "Analyze, summarize, and describe data."
     "standard-deviation"
     "box-plots"
     "measures-of-center"
     "project-data-exploration"
     "project-research-paper"
    )
    ("6.DR.C.3"
     "Analyze data representations and describe measures of center and variability of quantitative data using appropriate displays."
     "measures-of-center"
     "standard-deviation"
     "box-plots"
     )
    ("6.DR.D"
     "Interpret data and answer investigative questions."
     "measures-of-center"
     "histograms-interpret"
     "box-plots"
     "project-data-exploration"
     "project-research-paper"
     )
    ("6.DR.D.4"
     "Interpret quantitative measures of center to describe differences between groups from data collected to answer investigative questions."
     "measures-of-center"
     "standard-deviation"
     "project-data-exploration"
     "project-research-paper"
     )
    
    ; Grade 7
    ("7.RP.A"
     "Analyze proportional relationships and use them to solve real-world and mathematical problems."
     "transform-compose-images"
     "making-game-images"
     )
    ("7.RP.A.1"
     "Solve problems in authentic contexts involving unit rates associated with ratios of fractions."
     "transform-compose-images"
     )
    ("7.RP.A.2"
     "Recognize and represent proportional relationships between quantities in tables, graphs, equations, diagrams, and verbal descriptions of proportional relationships. Identify the constant of proportionality (unit rate) within various representations."
     "functions-can-be-linear"
     "function-definition-linear"
     )
    ("7.RP.A.3"
     "Use proportional relationships to solve ratio and percent problems in authentic contexts."
     "hoc-data"
     )
    ("7.RP.B"
     "Investigate chance processes and develop, use, and evaluate probability models."
     )
    ("7.RP.B.4"
     "Understand that the probability of a chance event is a number between 0 and 1 that expresses the likelihood of the event occurring. Represent probabilities as fractions, decimals, and percents."
     )
    ("7.RP.B.5"
     "Use experimental data and theoretical probability to make predictions. Understand the probability predictions may not be exact."
     )
    ("7.RP.B.6"
     "Develop a probability model and use it to find probabilities of events. Compare theoretical and experimental probabilities and explain possible sources of discrepancy if any exists."
     )
    ("7.RP.B.7"
     "Find probabilities of compound events using organized lists, tables, tree diagrams, and simulation."
     )
    ("7.NS.A"
     "Apply and extend previous understandings of operations with fractions."
     )
    ("7.NS.A.1"
     "Apply and extend previous understandings of addition, subtraction and absolute value to add and subtract rational numbers in authentic contexts. Understand subtraction as adding the additive inverse, p – q = p + (–q)."
     )
    ("7.NS.A.2"
     "Apply and extend previous understandings of multiplication and division and of fractions to multiply and divide rational numbers. Interpret operations of rational numbers solving problems in authentic contexts."
     )
    ("7.NS.A.3"
     "Understand that equivalent rational numbers can be written as fractions, decimals and percents."
     )
    ("7.AEE.A"
     "Use properties of operations to generate equivalent expressions."
     ;Rachel?
     )
    ("7.AEE.A.1"
     "Identify and write equivalent expressions with rational numbers by applying associative, commutative, and distributive properties."
     )
    ("7.EE.A.2"
     "Recognize and represent proportional relationships between quantities in tables, graphs, equations, diagrams, and verbal descriptions of proportional relationships. Identify the constant of proportionality (unit rate) within various representations."
     "problem-decomposition"
     )
    ("7.AEE.B"
     "Solve mathematical problems in authentic contexts using numerical and algebraic expressions and equations."
     "problem-decomposition"
     "player-animation"
     "inequalities3-sam"
     "distance"
     "piecewise-functions-conditionals"
     "functions-dr"
     )
    ("7.AEE.B.3"
     "Write and solve problems in authentic contexts using expressions and equations with positive and negative rational numbers in any form.  Contexts can be limited to those that can be solved with one or two-step linear equations."
     )
    ("7.EE.B.4"
     "Use variables to represent quantities and construct one- and two-step linear inequalities with positive rational numbers to solve authentic problems by reasoning about the quantities."
     "inequalities2-compound"
     "inequalities1-simple"
     "defining-values"
     "functions-dr"
     "functions-make-life-easier"
     )

    ("7.GM.A"
     "Draw, construct, and describe geometical figures and describe the relationships between them."
     "hoc-winter-parley"
     )
    ("7.GM.A.1"
     "Solve problems involving scale drawings of geometric figures.  Reproduce a scale drawing at a different scale and compute actual lengths and areas from a scale drawing."
     )
    ("7.GM.A.2"
     "Draw triangles from three measures of angles or sides.  Understand the possible side lengths and angle measures that determine a unique triangle, more than one triangle, or no triangle."
     )
    ("7.GM.B"
     "Solve mathematical problems in authentic contexts involving angle measure, area, surface area, and volume."
     )
    ("7.GM.B.3"
     "Understand the relationship between area and circumference of circles.  Choose and use the appropriate formula to solve problems with radius, diameter, circumference and area of circles."
     "functions-dr"
     )
    ("7.G.B.4"
     "Apply facts about supplementary, complementary, vertical, and adjacent angles in a multi-step problem to determine an unknown angle in a figure."
     )
    ("7.G.B.5"
     "Solve problems in authentic contexts involving two- and three-dimensional figures.  Given formulas, calculate area, volume and surface area."
     "surface-area-rect-prism"
     "functions-dr"
     )
    ("7.DR.A"
     "Formulate Statistical Investigative Questions."
     "data-cycle"
     )
    ("7.DR.A.1"
     "Formulate summary, comparative investigative questions to gain information about a population and that a sample is valid only if the sample is representative of that population."
     "random-samples"
     "hoc-data"
     )
    ("7.DR.B"
     "Collect and Consider Data"
     "random-samples"
     "project-data-exploration"
     "project-research-paper"
     "hoc-data"
     )
    ("7.DR.B.2"
     "Collect or consider data from a random sample to compare and draw inferences about a population with an unknown characteristic of interest."
     "project-data-exploration"
     "project-research-paper"
     )
    ("7.DR.C"
     "Analyze, summarize and describe data"
     "project-data-exploration"
     "project-research-paper"
     )
    ("7.DR.C.3"
     "Analyze two data distributions visually to compare multiple measures of center and variability."
     "project-data-exploration"
     "project-research-paper"
     )
    ("7.DR.D"
     "Interpret data and answer investigative questions."
     "project-data-exploration"
     "project-research-paper"
     )
    ("7.DR.D.4"
     "Interpret measures of center and measures of variability for numerical data from random samples to compare between two populations, and to answer investigative questions."
     "project-data-exploration"
     "project-research-paper"
     )    
    ; Grade 8
    ("8.NS.A"
     "Know that there are numbers that are not rational, and approximate them by rational numbers."
     )
    ("8.NS.A.1"
     "Know that numbers that are not rational are called irrational."
     )
    ("8.NS.A.2"
     "Use rational approximations of irrational numbers to compare size and locate on a number line."
     )
    ("8.AEE.A"
     "Expressions and equations work with radicals and integer exponents."
     )
    ("8.AEE.A.1"
     "Apply the properties of integer exponents using powers of 10 to generate equivalent numerical expressions."
     )
    ("8.AEE.A.2"
     "Represent solutions to equations using square root and cube root symbols."
     )
    ("8.AEE.A.3"
     "Estimate very large or very small quantities using scientific notation with a single digit times an integer power of ten."
     )
    ("8.AEE.A.4"
     "Perform operations with numbers expressed in scientific notation."
     )

    ; Grade 8
    ("8.AEE.B"
     "Understand the connections between proportional relationships, lines, and linear equations."
     "function-definition-linear"
     "functions-can-be-linear"
     )
    ("8.AEE.B.5"
     "Graph proportional relationships in authentic contexts. Interpret the unit rate as the slope of the graph, and compare two different proportional relationships represented in different ways."
     "function-definition-linear"
     "functions-can-be-linear"
     )
    ("8.AEE.B.6"
     "Write the equation for a line in slope intercept form y = mx + b, where m and b are rational numbers, and explain in context why the slope m is the same between any two distinct points."
     )
    ("8.AEE.C"
     "Analyze and solve linear equations and pairs of simultaneous linear equations."
     )
    ("8.AEE.C.7"
     "Solve linear equations with one variable including equations with rational number coefficients, with the variable on both sides, or whose solutions require using the distributive property and/or combining like terms."
     )
    ("8.AEE.C.8"
     "Find, analyze, and interpret solutions to pairs of simultaneous linear equations using graphs or tables."
     )
    ("8.AFN.A"
     "Define, evaluate, and compare functions."
     )
    ("8.AFN.A.1"
     "Understand in authentic contexts, that the graph of a function is the set of ordered pairs consisting of an input and a corresponding output."
     "contracts"
     "functions-vertical-line-test"
     )
    ("8.AFN.A.2"
     "Compare the properties of two functions represented algebraically, graphically, numerically in tables, or verbally by description."
     "functions-can-be-linear"
     "function-definition-linear"
     )
    ("8.AFN.A.3"
     "Understand and identify linear functions, whose graph is a straight line, and identify examples of functions that are not linear."
     "functions-can-be-linear"
     "function-definition-linear"
     )
    ("8.AFN.B"
     "Use functions to model relationships between quantities."
     "functions-for-character-animation"
     "functions-dr"
     "functions-make-life-easier"
     "function-definition-linear"
     "problem-decomposition"
     )
    ("8.AFN.B.4"
     "Construct a function to model a linear relationship in authentic contexts between two quantities."
     "functions-can-be-linear"
     "function-definition-linear"
     )
    ("8.AFN.B.5"
     "Describe qualitatively the functional relationship between two quantities in authentic contexts by analyzing a graph."
     "functions-can-be-linear"
     "function-definition-linear"
     )
    ("8.GM.A"
     "Understand congruence and similarity using physical models, transparencies, or geometry software."
     )
    ("8.GM.A.1"
     "Verify experimentally the properties of rotations, reflections, and translations."
     "making-game-images"
     )
    ("8.GM.A.2"
     "Understand that a two-dimensional figure is congruent to another if the second can be obtained from the first by a sequence of rotations, reflections, and translations."
     )
    ("8.GM.A.3"
     "Describe the effect of dilations, translations, rotations, and reflections on two-dimensional figures using coordinates."
     )
    ("8.GM.A.4"
     "Understand that a two-dimensional figure is similar to another if the second can be obtained from the first by a sequence of rotations, reflections, translations, and dilations."
     )
    ("8.GM.A.5"
     "Use informal arguments to establish facts about interior and exterior angles of triangles and angles formed by parallel lines cut with a transversal."
     )
    ("8.GM.B"
     "Understand and apply the Pythagorean Theorem."
     "distance"
     )
    ("8.GM.B.6"
     "Distinguish between applications of the Pythagorean Theorem and its Converse in authentic contexts."
     )
    ("8.GM.B.7"
     "Apply the Pythagorean Theorem in authentic contexts to determine unknown side lengths in right triangles."
     "distance"
     )
    ("8.GM.B.8"
     "Apply the Pythagorean Theorem to find the distance between two points in a coordinate system."
     "distance"
     )
    ("8.GM.C"
     "Solve real-world and mathematical problems involving volume of cylinders, cones, and spheres."
     )
    ("8.GM.C.9"
     "Choose and use the appropriate formula for the volume of cones, cylinders, and spheres to solve problems in authentic contexts."
     )
    ("8.DR.A"
     "Formulate Statistical Ivenstigative Questions."
     "data-cycle"
     )
    ("8.DR.A.1"
     "Formulate statistical investigative questions to articulate research topics and uncover patterns of association seen in bivariate categorical data."
     )
    ("8.DR.B"
     "Collect and Consider Data"
     )
    ("8.DR.B.2"
     "Collect or consider data using surveys and measurements to capture patterns of association, and critically analyze data collection methods."
     "scatter-plots"
     "linear-regression"
     "correlations"
     "data-collection"
     )
    ("8.DR.C"
     "Analyze, summarize, and describe data"
     )
    ("8.DR.C.3"
     "Analyze patterns of association between two quantitative or categorical variables and reason about distributions to compare groups."
     "scatter-plots"
     "linear-regression"
     "grouped-samples"
     "correlations"
     )
    ("8.DR.D"
     "Interpret data and answer investigative questions"
     )
    ("8.DR.A.4"
     "Interpret scatter plots for bivariate quantitative data to investigate patterns of association between two quantities to answer investigative questions."
     "linear-regression"
     "scatter-plots"
     "project-research-paper"
     "project-data-exploration"
     )

    ;High School Algebraic Reasoning: Expressions and Equations Standards

    ("HS.AEE.A"
     "Use algebraic reasoning to rewrite expressions in equivalent forms."
     )
    ("HS.AEE.A.1"
     "Interpret an expression which models a quantity by viewing one or more of its parts as a single entity. Reason about how changes in parts of the expression impact the whole, and vice versa."
     "defining-values"
     "functions-make-life-easier"
     "functions-dr"
     "player-animation"
     "piecewise-functions-conditionals"
     )
    ("HS.AEE.A.2"
     "Create and recognize an equivalent form of an expression to understand the quantity represented in an authentic context."
     )
    ("HS.AEE.A.3"
     "Rearrange formulas and equations to highlight a specific quantity."
     )
    ("HS.AEE.B"
     "Use algebraic reasoning to find solutions to an equation, inequality, and systems of equations or inequalities."
     )
    ("HS.AEE.B.4"
     "Define variables and create equations with two or more variables to represent relationships between quantities in order to solve problems in authentic contexts."
     "inequalities3-sam"
     )
    ("HS.AEE.B.5"
     "Define variables and create inequalities with one or more variables and use them to solve problems in authentic contexts."
     "inequalities3-sam"
     )
    ("HS.AEE.B.6"
     "Solve systems of linear equations and systems of linear inequalities in authentic contexts through reasoning,algebraic means, or strategically using technology."
     )
    ("HS.AEE.C"
     "Analyze the structure of an equation or inequality to determine an efficient strategy to find and justify a solution."
     )
    ("HS.AEE.C.7"
     "Represent constraints by equations or inequalities, and by systems of equations and/or inequalities; interpret solutions as viable or nonviable options in authentic contexts."
     "inequalities3-sam"
     )
    ("HS.AEE.C.8"
     "Construct a viable argument to justify a method for solving equations or inequalities."
     )
    ("HS.AEE.D"
     "Make predictions in different applications using expressions, equations, and inequalities to analyze authentic contexts."
     )
    ("HS.AEE.D.9"
     "Understand that the solution to an equation in two variables is a set of points in the coordinate plane that form a curve, which could be a line."
     )
    ("HS.AEE.D.10"
     "Recognize and explain why the point(s) of intersection of the graphs of f(x) and g(x) are solutions to the equation f(x)=g(x).  Interpret the meaning of the coordinates of these points in authentic contexts."
     )
    ("HS.AEE.D.11"
     "Graph and explain why the points in a half plane are solutions to a linear inequality and the solutions to a system of inequalities are the points in the intersection of corresponding half planes. Interpret the meaning of the coordinates of these points in authentic contexts."
     )
; High School Standards Algebraic Reasoning: Functions
    ("HS.AFN.A"
     "Describe functions by using both symbolic and graphical representations."
     "functions-make-life-easier"
     "function-notation"
     )
    ("HS.AFN.A.1"
     "Understand a function as a rule that assigns a unique output for every input and that functions model situations where one quantity determines another."
     "functions-vertical-line-test"
     "contracts"
     )
    ("HS.AFN.A.2"
     "Use function notation and interpret statements that use function notation in terms of the context and the relationship it describes."
     "inequalities2-compound"
     "inequalities1-simple"
     "function-definition-linear"
     "functions-dr"
     "problem-decomposition"
     "function-notation"
     "functions-for-character-animation"
     "defining-table-functions"
     "transform-compose-images"
     "contracts"
     )
    ("HS.AFN.A.3"
     "Calculate and interpret the average rate of change of a function over a specified interval." 
     )
    ("HS.AFN.B"
     "Compare and relate functions using common attributes."
     "inequalities2-compound"
     "inequalities1-simple"
     "function-definition-linear"
     "functions-dr"
     "problem-decomposition"
     "function-notation"
     "functions-for-character-animation"
     "defining-table-functions"
     )
    ("HS.AFN.B.4"
     "Compare properties of two functions using multiple representations. Distinguish functions as members of the same family using common attributes."
     "function-definition-linear"
     "functions-can-be-linear"
     "problem-decomposition"
     )
    ("HS.AFN.B.5"
     "Relate the domain of a function to its graph and to its context."
     "functions-can-be-linear"
     "function-definition-linear"
     )
    ("HS.AFN.C"
     "Represent functions graphically and interpret key features in terms of the equivalent symbolic representation."
     )
    ("HS.AFN.C.6"
     "Interpret key features of functions, from multiple representations, and conversely predict features of functions from knowledge of context."
     )
    ("HS.AFN.C.7"	
     "Graph functions using technology to show key features."
     )
    ("HS.AFN.D"	
     "Model a wide variety of authentic situations using functions through the process of making and changing assumptions, assigning variables, and finding solutions to contextual problems."
     )
    ("HS.AFN.D.8"
     "Model situations involving arithmetic patterns. Use a variety of representations such as pictures, graphs, or an explicit formula to describe the pattern."
     )
    ("HS.AFN.D.9"
     "Identify and interpret the effect on the graph of a function when the equation has been transformed."
     )
    ("HS.AFN.D.10"
     "Explain why a situation can be modeled with a linear function, an exponential function, or neither. In a given model, explain the meaning of coefficients and features of functions used, such as slope for a linear model."
     )
;High School Standards Numeric Reasoning: Number and Quantity
    ("HS.NQ.A"
     "Understand and apply the real number system."
     )
    ("HS.NQ.A.1"
     "Use reasoning to establish properties of positive integer exponents. Extend the definition of exponentiation to include negative and rational exponents so as to be consistent with these properties. Utilize exponentiation to model authentic contexts."
     )
    ("HS.NQ.A.2"
     "Compare real numbers presented through different representations, including both rational and irrational numbers.  Apply comparisons in authentic contexts."
     )
    ("HS.NQ.B"
     "Attend to units of measurement needed to solve problems through quantitative reasoning and mathematical modeling."
     "transform-compose-images"
     )
    ("HS.NQ.B.3"	
     "Use reasoning to choose and interpret measurement units consistently in formulas, graphs, and data displays, as a way to understand problems and to guide the solution of multi-step problems."
     )
    ("HS.NQ.B.4"
     "Define, manipulate, and interpret appropriate quantities using rational and irrational numbers to authentically model situations and use reasoning to justify these choices."
     )
    ("HS.NQ.B.5"
     "Use reasoning to choose a level of accuracy appropriate to limitations on measurement when reporting quantities in modeling situations."
     )
; High School Standards Geometric Reasoning and Measurement

    ("HS.GM.A"	
     "Apply geometric transformations to figures through analysis of graphs and understanding of functions."
     )
    ("HS.GM.A.1"	
     "Apply definitions of rotations, reflections, and translations to transform a figure and map between two congruent figures in authentic contexts."
     )
    ("HS.GM.A.2"	
     "Verify experimentally the properties of a dilation given a center and a scale factor.  Solve problems in authentic contexts involving similar triangles or dilations."
     )
    ("HS.GM.A.3"	
     "Use the slopes of segments and the coordinates of the vertices of triangles, parallelograms, and trapezoids to solve problems in authentic contexts."
     )
    ("HS.GM.A.4"	
     "Use definitions of transformations and symmetry relationships to justify the solutions of problems in authentic contexts."
     )
    ("HS.GM.B"
     "Construct and communicate geometric arguments through use of proofs, logical reasoning, and geometric technology."
     )
    ("HS.GM.B.5"	
     "Apply and justify triangle congruence and similarity theorems in authentic contexts."
     )
    ("HS.GM.B.6"	
     "Justify theorems of line relationships, angles, triangles, and parallelograms; and use them to solve problems in authentic contexts."
     )
    ("HS.GM.B.7"	
     "Perform geometric constructions with a variety of tools and methods."
     )
    ("HS.GM.C"	
     "Solve problems and interpret solutions of area and volume of shapes by applying concepts of congruence, similarity, symmetry in authentic contexts."
     )
    ("HS.GM.C.8"	
     "Solve authentic modeling problems using area formulas for triangles, parallelograms, trapezoids, regular polygons, and circles."
     )
    ("HS.GM.C.9"	
     "Use volume and surface area formulas for prisms, cylinders, pyramids, cones, and spheres to solve problems and apply to authentic contexts."
     )
    ("HS.GM.C.10"
     "Use geometric shapes, their measures, and their properties to describe real world objects, and solve related authentic modeling and design problems."
     )
    ("HS.GM.C.11"
     "Apply concepts of density based on area and volume in authentic modeling situations."
     )
    ("HS.GM.D"	
     "Apply concepts of right triangle trigonometry in authentic contexts to solve problems and interpret solutions."
     )
    ("HS.GM.D.12"	
     "Apply sine, cosine, and tangent ratios, and the Pythagorean Theorem, to solve problems in authentic contexts."
     )
    ("HS.GM.D.13"	
     "Apply the Pythagorean Theorem in authentic contexts, and develop the standard form for the equation of a circle."
     )
    ("HS.GM.D.14"
     "Use the coordinate plane to determine parallel and perpendicular relationships, and the distance between points."
     "distance"
     )
    ; High School Standards Data Reasoning
    ("HS.DR.A"	
     "Formulate Statistical Investigative Questions."
     "data-cycle"
     )
    ("HS.DR.A.1"	
     "Formulate multivariable statistical investigative questions and determine how data from samples can be collected and analyzed to provide an answer."
     "intro-ds"
     "random-samples"
     "choosing-your-dataset"
     )
    ("HS.DR.A.2"	
     "Formulate summative, comparative, and associative statistical investigative questions for surveys, observational studies, and experiments using primary or secondary data."
     "random-samples"
     "data-collection"
     )
    ("HS.DR.A.3"	
     "Formulate inferential statistical investigative questions regarding causality and prediction from correlation."
     "linear-regression"
     "correlations"
     )
    ("HS.DR.A.4"	
     "Use mathematical and statistical reasoning to formulate questions about data to evaluate conclusions and assess risks."
     "threats-to-validity"
     )
    ("HS.DR.B"	
     "Collect and Consider Data."
     )
    ("HS.DR.B.5"	
     "Articulate what constitutes good practice in designing a sample survey, an experiment, and an observational study. Understand issues of bias and confounding variables in a study and their implications for interpretation."
     "data-collection"
     )
    ("HS.DR.B.6"	
     "Distinguish and choose between surveys, observational studies, and experiments to design an appropriate data collection that answers an investigative question of interest."
     "data-collection"
     )
    ("HS.DR.B.7"	
     "Apply an appropriate data collection plan when collecting primary data or selecting secondary data for the statistical investigative question of interest."
     "data-collection"
     )
    ("HS.DR.C"	
     "Analyze, summarize, and describe data."
     )
    ("HS.DR.C.8"	
     "Identify appropriate ways to summarize and then represent the distribution of univariate and bivariate data multiple ways with graphs and/or tables. Use technology to present data that supports interpretation of tabular and graphical representations."
     "standard-deviation"
     "box-plots"
     "histograms-interpret"
     "histograms"
     )
    ("HS.DR.C.9"	
     "Use statistics appropriate to the shape of the data distribution to compare the center and spread of two or more different data sets."
     "standard-deviation"
     "box-plots"
     "measures-of-center"
     "histograms"
     )
    ("HS.DR.C.10"	
     "Use data to compare two groups, describe sample variability, and decide if differences between parameters are significant based on the statistics."
     "standard-deviation"
     "box-plots"
     "measures-of-center"
     "histograms-interpret"
     "histograms"
     )
    ("HS.DR.D"	
     "Interpret data and answer investigative questions."
     )
    ("HS.DR.D.11"	
     "Use statistical evidence from analyses to answer statistical investigative questions, and communicate the findings in a variety of formats (verbal, written, visual) to support informed data-based decisions."
     "project-research-paper"
     "project-data-exploration"
     )
    ("HS.DR.D.12"	
     "Articulate what it means for an outcome or an estimate of a population characteristic to be plausible or not plausible compared to chance variation."
     "scatter-plots"
     "linear-regression"
     "correlations"
     )
    ("HS.DR.D.13"	
     "Use multivariate thinking to articulate how variables impact one another, and measure the strength of association using correlation coefficients for regression curves."
     "linear-regression"
     "correlations"
     )
    ("HS.DR.E"	
     "Understand independence and conditional probability and use them to interpret data."
     )
    ("HS.DR.E.14"	
     "Describe the possible outcomes for a situation as subsets of a sample space."
     "inequalities2-compound"
     )
    ("HS.DR.E.15"	
     "Recognize and explain the concepts of conditional probability and independence in everyday language and everyday situations."
     )

    ))

