#lang racket

(provide *ccss-standards-list*)

(define *ccss-standards-list*
'(
; Common Core Standards for Mathematical Practice
 
 ("MP.1"
  "Make sense of problems and persevere in solving them"
  )
 ("MP.2"
  "Reason abstractly and quantitatively"
  )
 ("MP.3"
  "Construct viable arguments and critique the reasoning of others"
  )
 ("MP.4"
  "Model with mathematics"
  )
 ("MP.5"
  "Use appropriate tools strategically"
  )
 ("MP.6"
  "Attend to precision"
  )
 ("MP.7"
  "Look for and make use of structure"
  )
 ("MP.8"
  "Look for and express regularity in repeated reasoning"
 )

; Common Core State Standards for Mathematics 5-12

 ("5.OA.A"
  "Write and interpret numerical expressions."
 )
 ("5.OA.A.1"
  "Use parentheses, brackets, or braces in numerical expressions, and evaluate expressions with these symbols."
 )
 ("5.OA.A.2"
  "Write simple expressions that record calculations with numbers, and interpret numerical expressions without evaluating them."
 )
 ("5.OA.B"
  "Analyze patterns and relationships."
 )
 ("5.OA.B.3"
  "Generate two numerical patterns using two given rules. Identify apparent relationships between corresponding terms. Form ordered pairs consisting of corresponding terms from the two patterns, and graph the ordered pairs on a coordinate plane."
 )
 ("5.NBT.A"
  "Understand the place value system."
 )
 ("5.NBT.A.1"
  "Recognize that in a multi-digit number, a digit in one place represents 10 times as much as it represents in the place to its right and 1/10 of what it represents in the place to its left."
 )
 ("5.NBT.A.2"
  "Explain patterns in the number of zeros of the product when multiplying a number by powers of 10, and explain patterns in the placement of the decimal point when a decimal is multiplied or divided by a power of 10. Use whole-number exponents to denote powers of 10."
 )
 ("5.NBT.A.3"
  "Read, write, and compare decimals to thousandths."
 )
 ("5.NBT.A.3.A"
  "Read and write decimals to thousandths using base-ten numerals, number names, and expanded form."
 )
 ("5.NBT.A.3.B"
  "Compare two decimals to thousandths based on meanings of the digits in each place, using >, =, and < symbols to record the results of comparisons."
 )
 ("5.NBT.A.4"
  "Use place value understanding to round decimals to any place."
 )
 ("5.MD.A"
  "Convert like measurements units within a given measurement system."
 )
 ("5.MD.A.1"
  "Convert among different-sized standard measurement units within a given measurement system (e.g., convert 5 cm to 0.05 m), and use these conversions in solving multi-step, real world problems."
 )
 ("5.MD.B"
  "Represent and interpret data."
 )
 ("5.MD.C"
  "Geometric measurement: understand concepts of volume."
 )
 ("5.MD.C.3"
  "Recognize volume as an attribute of solid figures and understand concepts of volume measurement."
 )
 ("5.MD.C.3.A"
  "A cube with side length 1 unit, called a "unit cube," is said to have "one cubic unit" of volume, and can be used to measure volume."
 )
 ("5.MD.C.3.B"
  "A solid figure which can be packed without gaps or overlaps using n unit cubes is said to have a volume of n cubic units."
 )
 ("5.MD.C.4"
  "Measure volumes by counting unit cubes, using cubic cm, cubic in, cubic ft, and improvised units."
 )
 ("5.MD.C.5"
  "Relate volume to the operations of multiplication and addition and solve real world and mathematical problems involving volume."
 )
 ("5.MD.C.5.A"
  "Find the volume of a right rectangular prism with whole-number side lengths by packing it with unit cubes, and show that the volume is the same as would be found by multiplying the edge lengths, equivalently by multiplying the height by the area of the base. Represent threefold whole-number products as volumes, e.g., to represent the associative property of multiplication."
 )
 ("5.MD.C.5.B"
  "Apply the formulas V = l × w × h and V = b × h for rectangular prisms to find volumes of right rectangular prisms with whole-number edge lengths in the context of solving real world and mathematical problems."
 )
 ("5.MD.C.5.C"
  "Recognize volume as additive. Find volumes of solid figures composed of two non-overlapping right rectangular prisms by adding the volumes of the non-overlapping parts, applying this technique to solve real world problems."
 )
 ("5.G.A"
  "Graph points on the coordinate plane to solve real-world and mathematical problems."
 )
 ("5.G.A.1"
  "Use a pair of perpendicular number lines, called axes, to define a coordinate system, with the intersection of the lines (the origin) arranged to coincide with the 0 on each line and a given point in the plane located by using an ordered pair of numbers, called its coordinates. Understand that the first number indicates how far to travel from the origin in the direction of one axis, and the second number indicates how far to travel in the direction of the second axis, with the convention that the names of the two axes and the coordinates correspond (e.g., x-axis and x-coordinate, y-axis and y-coordinate)."
 )
 ("5.G.A.2"
  "Represent real world and mathematical problems by graphing points in the first quadrant of the coordinate plane, and interpret coordinate values of points in the context of the situation."
 )
 ("5.G.B"
  "Classify two-dimensional figures into categories based on their properties."
 )
 ("5.G.B.3"
  "Understand that attributes belonging to a category of two-dimensional figures also belong to all subcategories of that category."
 )
 ("5.G.B.4"
  "Classify two-dimensional figures in a hierarchy based on properties."
 )
 ("6.RP.A"
  "Understand ratio concepts and use ratio reasoning to solve problems."
 )
 ("6.RP.A.1"
  "Understand the concept of a ratio and use ratio language to describe a ratio relationship between two quantities."
 )
 ("6.RP.A.2"
  "Understand the concept of a unit rate a/b associated with a ratio a:b with b ≠ 0, and use rate language in the context of a ratio relationship."
 )
 ("6.RP.A.3"
  "Use ratio and rate reasoning to solve real-world and mathematical problems, e.g., by reasoning about tables of equivalent ratios, tape diagrams, double number line diagrams, or equations."
 )
 ("6.RP.A.3.A"
  "Make tables of equivalent ratios relating quantities with whole-number measurements, find missing values in the tables, and plot the pairs of values on the coordinate plane. Use tables to compare ratios."
 )
 ("6.RP.A.3.B"
  "Solve unit rate problems including those involving unit pricing and constant speed."
 )
 ("6.RP.A.3.C"
  "Find a percent of a quantity as a rate per 100; solve problems involving finding the whole, given a part and the percent."
 )
 ("6.RP.A.3.D"
  "Use ratio reasoning to convert measurement units; manipulate and transform units appropriately when multiplying or dividing quantities."
 )
 ("6.NS.A"
  "Apply and extend previous understandings of multiplication and division to divide fractions by fractions."
 )
 ("6.NS.A.1"
  "Interpret and compute quotients of fractions, and solve word problems involving division of fractions by fractions, e.g., by using visual fraction models and equations to represent the problem."
 )
 ("6.NS.B"
  "Compute fluently with multi-digit numbers and find common factors and multiples."
 )
 ("6.NS.B.2"
  "Fluently divide multi-digit numbers using the standard algorithm."
 )
 ("6.NS.B.3"
  "Fluently add, subtract, multiply, and divide multi-digit decimals using the standard algorithm for each operation."
 )
 ("6.NS.B.4"
  "Find the greatest common factor of two whole numbers less than or equal to 100 and the least common multiple of two whole numbers less than or equal to 12. Use the distributive property to express a sum of two whole numbers 1-100 with a common factor as a multiple of a sum of two whole numbers with no common factor."
 )
 ("6.NS.C"
  "Apply and extend previous understandings of numbers to the system of rational numbers."
 )
 ("6.NS.C.5"
  "Understand that positive and negative numbers are used together to describe quantities having opposite directions or values (e.g., temperature above/below zero, elevation above/below sea level, credits/debits, positive/negative electric charge); use positive and negative numbers to represent quantities in real-world contexts, explaining the meaning of 0 in each situation."
 )
 ("6.NS.C.6"
  "Understand a rational number as a point on the number line. Extend number line diagrams and coordinate axes familiar from previous grades to represent points on the line and in the plane with negative number coordinates."
 )
 ("6.NS.C.6.A"
  "Recognize opposite signs of numbers as indicating locations on opposite sides of 0 on the number line; recognize that the opposite of the opposite of a number is the number itself, e.g., -(-3) = 3, and that 0 is its own opposite."
 )
 ("6.NS.C.6.B"
  "Understand signs of numbers in ordered pairs as indicating locations in quadrants of the coordinate plane; recognize that when two ordered pairs differ only by signs, the locations of the points are related by reflections across one or both axes."
 )
 ("6.NS.C.6.C"
  "Find and position integers and other rational numbers on a horizontal or vertical number line diagram; find and position pairs of integers and other rational numbers on a coordinate plane."
 )
 ("6.NS.C.7"
  "Understand ordering and absolute value of rational numbers."
 )
 ("6.NS.C.7.A"
  "Interpret statements of inequality as statements about the relative position of two numbers on a number line diagram."
 )
 ("6.NS.C.7.B"
  "Write, interpret, and explain statements of order for rational numbers in real-world contexts."
 )
 ("6.NS.C.7.C"
  "Understand the absolute value of a rational number as its distance from 0 on the number line; interpret absolute value as magnitude for a positive or negative quantity in a real-world situation."
 )
 ("6.NS.C.7.D"
  "Distinguish comparisons of absolute value from statements about order."
 )
 ("6.NS.C.8"
  "Solve real-world and mathematical problems by graphing points in all four quadrants of the coordinate plane. Include use of coordinates and absolute value to find distances between points with the same first coordinate or the same second coordinate."
 )
 ("6.EE.A"
  "Apply and extend previous understandings of arithmetic to algebraic expressions."
 )
 ("6.EE.A.1"
  "Write and evaluate numerical expressions involving whole-number exponents."
 )
 ("6.EE.A.2"
  "Write, read, and evaluate expressions in which letters stand for numbers."
 )
 ("6.EE.A.2.A"
  "Write expressions that record operations with numbers and with letters standing for numbers."
 )
 ("6.EE.A.2.B"
  "Identify parts of an expression using mathematical terms (sum, term, product, factor, quotient, coefficient); view one or more parts of an expression as a single entity."
 )
 ("6.EE.A.2.C"
  "Evaluate expressions at specific values of their variables. Include expressions that arise from formulas used in real-world problems. Perform arithmetic operations, including those involving whole-number exponents, in the conventional order when there are no parentheses to specify a particular order (Order of Operations)."
 )
 ("6.EE.A.3"
  "Apply the properties of operations to generate equivalent expressions."
 )
 ("6.EE.A.4"
  "Identify when two expressions are equivalent (i.e., when the two expressions name the same number regardless of which value is substituted into them)."
 )
 ("6.EE.B"
  "Reason about and solve one-variable equations and inequalities."
 )
 ("6.EE.B.5"
  "Understand solving an equation or inequality as a process of answering a question: which values from a specified set, if any, make the equation or inequality true? Use substitution to determine whether a given number in a specified set makes an equation or inequality true."
 )
 ("6.EE.B.6"
  "Use variables to represent numbers and write expressions when solving a real-world or mathematical problem; understand that a variable can represent an unknown number, or, depending on the purpose at hand, any number in a specified set."
 )
 ("6.EE.B.7"
  "Solve real-world and mathematical problems by writing and solving equations of the form x + p = q and px = q for cases in which p, q and x are all nonnegative rational numbers."
 )
 ("6.EE.B.8"
  "Write an inequality of the form x > c or x < c to represent a constraint or condition in a real-world or mathematical problem. Recognize that inequalities of the form x > c or x < c have infinitely many solutions; represent solutions of such inequalities on number line diagrams."
 )
 ("6.EE.C"
  "Represent and analyze quantitative relationships between dependent and independent variables."
 )
 ("6.EE.C.9"
  "Use variables to represent two quantities in a real-world problem that change in relationship to one another; write an equation to express one quantity, thought of as the dependent variable, in terms of the other quantity, thought of as the independent variable. Analyze the relationship between the dependent and independent variables using graphs and tables, and relate these to the equation."
 )
 ("6.G.A"
  "Solve real-world and mathematical problems involving area, surface area, and volume."
 )
 ("6.G.A.1"
  "Find the area of right triangles, other triangles, special quadrilaterals, and polygons by composing into rectangles or decomposing into triangles and other shapes; apply these techniques in the context of solving real-world and mathematical problems."
 )
 ("6.G.A.2"
  "Find the volume of a right rectangular prism with fractional edge lengths by packing it with unit cubes of the appropriate unit fraction edge lengths, and show that the volume is the same as would be found by multiplying the edge lengths of the prism. Apply the formulas V = l w h and V = b h to find volumes of right rectangular prisms with fractional edge lengths in the context of solving real-world and mathematical problems."
 )
 ("6.G.A.3"
  "Draw polygons in the coordinate plane given coordinates for the vertices; use coordinates to find the length of a side joining points with the same first coordinate or the same second coordinate. Apply these techniques in the context of solving real-world and mathematical problems."
 )
 ("6.G.A.4"
  "Represent three-dimensional figures using nets made up of rectangles and triangles, and use the nets to find the surface area of these figures. Apply these techniques in the context of solving real-world and mathematical problems."
 )
 ("6.SP.A"
  "Develop understanding of statistical variability."
 )
 ("6.SP.A.1"
  "Recognize a statistical question as one that anticipates variability in the data related to the question and accounts for it in the answers."
 )
 ("6.SP.A.2"
  "Understand that a set of data collected to answer a statistical question has a distribution which can be described by its center, spread, and overall shape."
 )
 ("6.SP.A.3"
  "Recognize that a measure of center for a numerical data set summarizes all of its values with a single number, while a measure of variation describes how its values vary with a single number."
 )
 ("6.SP.B"
  "Summarize and describe distributions."
 )
 ("6.SP.B.4"
  "Display numerical data in plots on a number line, including dot plots, histograms, and box plots."
 )
 ("6.SP.B.5"
  "Summarize numerical data sets in relation to their context."
 )
 ("6.SP.B.5.A"
  "Summarize numerical data sets in relation to their context by reporting the number of observations."
 )
 ("6.SP.B.5.B"
  "Summarize numerical data sets in relation to their context by describing the nature of the attribute under investigation, including how it was measured and its units of measurement."
 )
 ("6.SP.B.5.C"
  "Summarize numerical data sets in relation to their context by giving quantitative measures of center (median and/or mean) and variability (interquartile range and/or mean absolute deviation), as well as describing any overall pattern and any striking deviations from the overall pattern with reference to the context in which the data were gathered."
 )
 ("6.SP.B.5.D"
  "Summarize numerical data sets in relation to their context by relating the choice of measures of center and variability to the shape of the data distribution and the context in which the data were gathered."
 )
 ("7.RP.A"
  "Analyze proportional relationships and use them to solve real-world and mathematical problems."
 )
 ("7.RP.A.1"
  "Compute unit rates associated with ratios of fractions, including ratios of lengths, areas and other quantities measured in like or different units."
 )
 ("7.RP.A.2"
  "Recognize and represent proportional relationships between quantities."
 )
 ("7.RP.A.2.A"
  "Decide whether two quantities are in a proportional relationship, e.g., by testing for equivalent ratios in a table or graphing on a coordinate plane and observing whether the graph is a straight line through the origin."
 )
 ("7.RP.A.2.B"
  "Identify the constant of proportionality (unit rate) in tables, graphs, equations, diagrams, and verbal descriptions of proportional relationships."
 )
 ("7.RP.A.2.C"
  "Represent proportional relationships by equations."
 )
 ("7.RP.A.2.D"
  "Explain what a point (x, y) on the graph of a proportional relationship means in terms of the situation, with special attention to the points (0, 0) and (1, r) where r is the unit rate."
 )
 ("7.RP.A.3"
  "Use proportional relationships to solve multistep ratio and percent problems."
 )
 ("7.NS.A"
  "Apply and extend previous understandings of operations with fractions."
 )
 ("7.NS.A.1"
  "Apply and extend previous understandings of addition and subtraction to add and subtract rational numbers; represent addition and subtraction on a horizontal or vertical number line diagram."
 )
 ("7.NS.A.1.A"
  "Describe situations in which opposite quantities combine to make 0."
 )
 ("7.NS.A.1.B"
  "Understand p + q as the number located a distance |q| from p, in the positive or negative direction depending on whether q is positive or negative. Show that a number and its opposite have a sum of 0 (are additive inverses). Interpret sums of rational numbers by describing real-world contexts."
 )
 ("7.NS.A.1.C"
  "Understand subtraction of rational numbers as adding the additive inverse, p - q = p + (-q). Show that the distance between two rational numbers on the number line is the absolute value of their difference, and apply this principle in real-world contexts."
 )
 ("7.NS.A.1.D"
  "Apply properties of operations as strategies to add and subtract rational numbers."
 )
 ("7.NS.A.2"
  "Apply and extend previous understandings of multiplication and division and of fractions to multiply and divide rational numbers."
 )
 ("7.NS.A.2.A"
  "Understand that multiplication is extended from fractions to rational numbers by requiring that operations continue to satisfy the properties of operations, particularly the distributive property, leading to products such as (-1)(-1) = 1 and the rules for multiplying signed numbers. Interpret products of rational numbers by describing real-world contexts."
 )
 ("7.NS.A.2.B"
  "Understand that integers can be divided, provided that the divisor is not zero, and every quotient of integers (with non-zero divisor) is a rational number. If p and q are integers, then -(p/q) = (-p)/q = p/(-q). Interpret quotients of rational numbers by describing real-world contexts."
 )
 ("7.NS.A.2.C"
  "Apply properties of operations as strategies to multiply and divide rational numbers."
 )
 ("7.NS.A.2.D"
  "Convert a rational number to a decimal using long division; know that the decimal form of a rational number terminates in 0s or eventually repeats."
 )
 ("7.NS.A.3"
  "Solve real-world and mathematical problems involving the four operations with rational numbers."
 )
 ("7.EE.A"
  "Use properties of operations to generate equivalent expressions."
 )
 ("7.EE.A.1"
  "Apply properties of operations as strategies to add, subtract, factor, and expand linear expressions with rational coefficients."
 )
 ("7.EE.A.2"
  "Understand that rewriting an expression in different forms in a problem context can shed light on the problem and how the quantities in it are related."
 )
 ("7.EE.B"
  "Solve real-life and mathematical problems using numerical and algebraic expressions and equations."
 )
 ("7.EE.B.3"
  "Solve multi-step real-life and mathematical problems posed with positive and negative rational numbers in any form (whole numbers, fractions, and decimals), using tools strategically. Apply properties of operations to calculate with numbers in any form; convert between forms as appropriate; and assess the reasonableness of answers using mental computation and estimation strategies."
 )
 ("7.EE.B.4"
  "Use variables to represent quantities in a real-world or mathematical problem, and construct simple equations and inequalities to solve problems by reasoning about the quantities."
 )
 ("7.EE.B.4.A"
  "Solve word problems leading to equations of the form px + q = r and p(x + q) = r, where p, q, and r are specific rational numbers. Solve equations of these forms fluently. Compare an algebraic solution to an arithmetic solution, identifying the sequence of the operations used in each approach."
 )
 ("7.EE.B.4.B"
  "Solve word problems leading to inequalities of the form px + q > r or px + q < r, where p, q, and r are specific rational numbers. Graph the solution set of the inequality and interpret it in the context of the problem."
 )
 ("7.G.A"
  "Draw, construct, and describe geometical figures and describe the relationships between them."
 )
 ("7.G.A.1"
  "Solve problems involving scale drawings of geometric figures, including computing actual lengths and areas from a scale drawing and reproducing a scale drawing at a different scale."
 )
 ("7.G.A.2"
  "Draw (freehand, with ruler and protractor, and with technology) geometric shapes with given conditions. Focus on constructing triangles from three measures of angles or sides, noticing when the conditions determine a unique triangle, more than one triangle, or no triangle."
 )
 ("7.G.A.3"
  "Describe the two-dimensional figures that result from slicing three-dimensional figures, as in plane sections of right rectangular prisms and right rectangular pyramids."
 )
 ("7.G.B"
  "Solve real-life and mathematical problems involving angle measure, area, surface area, and volume."
 )
 ("7.G.B.4"
  "Know the formulas for the area and circumference of a circle and use them to solve problems; give an informal derivation of the relationship between the circumference and area of a circle."
 )
 ("7.G.B.5"
  "Use facts about supplementary, complementary, vertical, and adjacent angles in a multi-step problem to write and solve simple equations for an unknown angle in a figure."
 )
 ("7.G.B.6"
  "Solve real-world and mathematical problems involving area, volume and surface area of two- and three-dimensional objects composed of triangles, quadrilaterals, polygons, cubes, and right prisms."
 )
 ("7.SP.A"
  "Use random sampling to draw inferences about a population."
 )
 ("7.SP.A.1"
  "Understand that statistics can be used to gain information about a population by examining a sample of the population; generalizations about a population from a sample are valid only if the sample is representative of that population. Understand that random sampling tends to produce representative samples and support valid inferences."
 )
 ("7.SP.A.2"
  "Use data from a random sample to draw inferences about a population with an unknown characteristic of interest. Generate multiple samples (or simulated samples) of the same size to gauge the variation in estimates or predictions."
 )
 ("7.SP.B"
  "Draw informal comparative inferences about two populations."
 )
 ("7.SP.B.3"
  "Informally assess the degree of visual overlap of two numerical data distributions with similar variabilities, measuring the difference between the centers by expressing it as a multiple of a measure of variability."
 )
 ("7.SP.B.4"
  "Use measures of center and measures of variability for numerical data from random samples to draw informal comparative inferences about two populations."
 )
 ("7.SP.C"
  "Investigate chance processes and develop, use, and evaluate probability models."
 )
 ("7.SP.C.5"
  "Understand that the probability of a chance event is a number between 0 and 1 that expresses the likelihood of the event occurring. Larger numbers indicate greater likelihood. A probability near 0 indicates an unlikely event, a probability around 1/2 indicates an event that is neither unlikely nor likely, and a probability near 1 indicates a likely event."
 )
 ("7.SP.C.6"
  "Approximate the probability of a chance event by collecting data on the chance process that produces it and observing its long-run relative frequency, and predict the approximate relative frequency given the probability."
 )
 ("7.SP.C.7"
  "Develop a probability model and use it to find probabilities of events. Compare probabilities from a model to observed frequencies; if the agreement is not good, explain possible sources of the discrepancy."
 )
 ("7.SP.C.7.A"
  "Develop a uniform probability model by assigning equal probability to all outcomes, and use the model to determine probabilities of events."
 )
 ("7.SP.C.7.B"
  "Develop a probability model (which may not be uniform) by observing frequencies in data generated from a chance process."
 )
 ("7.SP.C.8"
  "Find probabilities of compound events using organized lists, tables, tree diagrams, and simulation."
 )
 ("7.SP.C.8.A"
  "Understand that, just as with simple events, the probability of a compound event is the fraction of outcomes in the sample space for which the compound event occurs."
 )
 ("7.SP.C.8.B"
  "Represent sample spaces for compound events using methods such as organized lists, tables and tree diagrams. For an event described in everyday language (e.g., "rolling double sixes"), identify the outcomes in the sample space which compose the event."
 )
 ("7.SP.C.8.C"
  "Design and use a simulation to generate frequencies for compound events."
 )
 ("8.NS.A"
  "Know that there are numbers that are not rational, and approximate them by rational numbers."
 )
 ("8.NS.A.1"
  "Know that numbers that are not rational are called irrational. Understand informally that every number has a decimal expansion; for rational numbers show that the decimal expansion repeats eventually, and convert a decimal expansion which repeats eventually into a rational number."
 )
 ("8.NS.A.2"
  "Use rational approximations of irrational numbers to compare the size of irrational numbers, locate them approximately on a number line diagram, and estimate the value of expressions (e.g., π²)."
 )
 ("8.EE.A"
  "Expressions and equations work with radicals and integer exponents."
 )
 ("8.EE.A.1"
  "Know and apply the properties of integer exponents to generate equivalent numerical expressions."
 )
 ("8.EE.A.2"
  "Use square root and cube root symbols to represent solutions to equations of the form x2 = p and x3 = p, where p is a positive rational number. Evaluate square roots of small perfect squares and cube roots of small perfect cubes. Know that √2 is irrational."
 )
 ("8.EE.A.3"
  "Use numbers expressed in the form of a single digit times an integer power of 10 to estimate very large or very small quantities, and to express how many times as much one is than the other."
 )
 ("8.EE.A.4"
  "Perform operations with numbers expressed in scientific notation, including problems where both decimal and scientific notation are used. Use scientific notation and choose units of appropriate size for measurements of very large or very small quantities. Interpret scientific notation that has been generated by technology."
 )
 ("8.EE.B"
  "Understand the connections between proportional relationships, lines, and linear equations."
 )
 ("8.EE.B.5"
  "Graph proportional relationships, interpreting the unit rate as the slope of the graph. Compare two different proportional relationships represented in different ways."
 )
 ("8.EE.B.6"
  "Use similar triangles to explain why the slope m is the same between any two distinct points on a non-vertical line in the coordinate plane; derive the equation y = mx for a line through the origin and the equation y = mx + b for a line intercepting the vertical axis at b."
 )
 ("8.EE.C"
  "Analyze and solve linear equations and pairs of simultaneous linear equations."
 )
 ("8.EE.C.7"
  "Solve linear equations in one variable."
 )
 ("8.EE.C.7.A"
  "Give examples of linear equations in one variable with one solution, infinitely many solutions, or no solutions. Show which of these possibilities is the case by successively transforming the given equation into simpler forms, until an equivalent equation of the form x = a, a = a, or a = b results (where a and b are different numbers)."
 )
 ("8.EE.C.7.B"
  "Solve linear equations with rational number coefficients, including equations whose solutions require expanding expressions using the distributive property and collecting like terms."
 )
 ("8.EE.C.8"
  "Analyze and solve pairs of simultaneous linear equations."
 )
 ("8.EE.C.8.A"
  "Understand that solutions to a system of two linear equations in two variables correspond to points of intersection of their graphs, because points of intersection satisfy both equations simultaneously."
 )
 ("8.EE.C.8.B"
  "Solve systems of two linear equations in two variables algebraically, and estimate solutions by graphing the equations. Solve simple cases by inspection."
 )
 ("8.EE.C.8.C"
  "Solve real-world and mathematical problems leading to two linear equations in two variables."
 )
 ("8.F.A.1"
  "Understand that a function is a rule that assigns to each input exactly one output. The graph of a function is the set of ordered pairs consisting of an input and the corresponding output."
 )
 ("8.F.A.2"
  "Compare properties of two functions each represented in a different way (algebraically, graphically, numerically in tables, or by verbal descriptions)."
 )
 ("8.F.A.3"
  "Interpret the equation y = mx + b as defining a linear function, whose graph is a straight line; give examples of functions that are not linear. "
 )
 ("8.F.B"
  "Use functions to model relationships between quantities."
 )
 ("8.F.B.4"
  "Construct a function to model a linear relationship between two quantities. Determine the rate of change  and initial value of the function from a description of a relationship or from two (x, y) values, including reading these from a table or from a graph. Interpret the rate of change and initial value of a linear function in terms of the situation it models, and in terms of its graph or a table of values."
 )
 ("8.F.B.5"
  "Describe qualitatively the functional relationship between two quantities by analyzing a graph (e.g., where the function is increasing or decreasing, linear or nonlinear). Sketch a graph that exhibits the qualitative features of a function that has been described verbally."
 )
 ("8.G.A"
  "Understand congruence and similarity using physical models, transparencies, or geometry software."
 )
 ("8.G.A.1"
  "Verify experimentally the properties of rotations, reflections, and translations."
 )
 ("8.G.A.1.A"
  "Lines are taken to lines, and line segments to line segments of the same length."
 )
 ("8.G.A.1.B"
  "Angles are taken to angles of the same measure."
 )
 ("8.G.A.1.C"
  "Parallel lines are taken to parallel lines."
 )
 ("8.G.A.2"
  "Understand that a two-dimensional figure is congruent to another if the second can be obtained from the first by a sequence of rotations, reflections, and translations; given two congruent figures, describe a sequence that exhibits the congruence between them."
 )
 ("8.G.A.3"
  "Describe the effect of dilations, translations, rotations, and reflections on two-dimensional figures using coordinates."
 )
 ("8.G.A.4"
  "Understand that a two-dimensional figure is similar to another if the second can be obtained from the first by a sequence of rotations, reflections, translations, and dilations; given two similar two-dimensional figures, describe a sequence that exhibits the similarity between them."
 )
 ("8.G.A.5"
  "Use informal arguments to establish facts about the angle sum and exterior angle of triangles, about the angles created when parallel lines are cut by a transversal, and the angle-angle criterion for similarity of triangles. "
 )
 ("8.G.B"
  "Understand and apply the Pythagorean Theorem."
 )
 ("8.G.B.6"
  "Explain a proof of the Pythagorean Theorem and its converse."
 )
 ("8.G.B.7"
  "Apply the Pythagorean Theorem to determine unknown side lengths in right triangles in real-world and mathematical problems in two and three dimensions."
 )
 ("8.G.B.8"
  "Apply the Pythagorean Theorem to find the distance between two points in a coordinate system."
 )
 ("8.G.C"
  "Solve real-world and mathematical problems involving volume of cylinders, cones, and spheres."
 )
 ("8.G.C.9"
  "Know the formulas for the volumes of cones, cylinders, and spheres and use them to solve real-world and mathematical problems."
 )
 ("8.SP.A.1"
  "Construct and interpret scatter plots for bivariate measurement data to investigate patterns of association between two quantities. Describe patterns such as clustering, outliers, positive or negative association, linear association, and nonlinear association."
 )
 ("8.SP.A.2"
  "Know that straight lines are widely used to model relationships between two quantitative variables. For scatter plots that suggest a linear association, informally fit a straight line, and informally assess the model fit by judging the closeness of the data points to the line."
 )
 ("8.SP.A.3"
  "Use the equation of a linear model to solve problems in the context of bivariate measurement data, interpreting the slope and intercept. "
 )
 ("8.SP.A.4"
  "Understand that patterns of association can also be seen in bivariate categorical data by displaying frequencies and relative frequencies in a two-way table. Construct and interpret a two-way table summarizing data on two categorical variables collected from the same subjects. Use relative frequencies calculated for rows or columns to describe possible association between the two variables. "
 )
 ("HSN.NS.A"
  "Extend the properties of exponents to rational exponents."
 )
 ("HSN.NS.A.1"
  "Explain how the definition of the meaning of rational exponents follows from extending the properties of integer exponents to those values, allowing for a notation for radicals in terms of rational exponents."
 )
 ("HSN.NS.A.2"
  "Rewrite expressions involving radicals and rational exponents using the properties of exponents."
 )
 ("HSN.NS.B"
  "Use properties of rational and irrational numbers."
 )
 ("HSN.NS.B.3"
  "Explain why the sum or product of two rational numbers is rational; that the sum of a rational number and an irrational number is irrational; and that the product of a nonzero rational number and an irrational number is irrational."
 )
 ("HSN.Q.A"
  "Reason quantitatively and use units to solve problems."
 )
 ("HSN.Q.A.1"
  "Use units as a way to understand problems and to guide the solution of multi-step problems; choose and interpret units consistently in formulas; choose and interpret the scale and the origin in graphs and data displays."
 )
 ("HSN.Q.A.2"
  "Define appropriate quantities for the purpose of descriptive modeling."
 )
 ("HSN.Q.A.3"
  "Choose a level of accuracy appropriate to limitations on measurement when reporting quantities."
 )
 ("HSN.CN.A"
  "Perform arithmetic operations with complex numbers."
 )
 ("HSN.CN.A.1"
  "Know there is a complex number i such that i2 = -1, and every complex number has the form a + bi with a and b real."
 )
 ("HSN.CN.A.2"
  "Use the relation i2 = -1 and the commutative, associative, and distributive properties to add, subtract, and multiply complex numbers."
 )
 ("HSN.CN.A.3"
  "Find the conjugate of a complex number; use conjugates to find moduli and quotients of complex numbers."
 )
 ("HSN.CN.B"
  "Represent complex numbers and their operations on the complex plane."
 )
 ("HSN.CN.B.4"
  "Represent complex numbers on the complex plane in rectangular and polar form (including real and imaginary numbers), and explain why the rectangular and polar forms of a given complex number represent the same number."
 )
 ("HSN.CN.B.5"
  "Represent addition, subtraction, multiplication, and conjugation of complex numbers geometrically on the complex plane; use properties of this representation for computation."
 )
 ("HSN.CN.B.6"
  "Calculate the distance between numbers in the complex plane as the modulus of the difference, and the midpoint of a segment as the average of the numbers at its endpoints."
 )
 ("HSN.CN.C"
  "Use complex numbers in polynomial identities and equations."
 )
 ("HSN.CN.C.7"
  "Solve quadratic equations with real coefficients that have complex solutions."
 )
 ("HSN.CN.C.8"
  "Extend polynomial identities to the complex numbers."
 )
 ("HSN.CN.C.9"
  "Know the Fundamental Theorem of Algebra; show that it is true for quadratic polynomials."
 )
 ("HSN.VM.A"
  "Represent and model with vector quantities."
 )
 ("HSN.VM.A.1"
  "Recognize vector quantities as having both magnitude and direction. Represent vector quantities by directed line segments, and use appropriate symbols for vectors and their magnitudes (e.g., v, |v|, ||v||, v)."
 )
 ("HSN.VM.A.2"
  "Find the components of a vector by subtracting the coordinates of an initial point from the coordinates of a terminal point."
 )
 ("HSN.VM.A.3"
  "Solve problems involving velocity and other quantities that can be represented by vectors."
 )
 ("HSN.VM.B"
  "Perform operations on vectors."
 )
 ("HSN.VM.B.4"
  "Add and subtract vectors."
 )
 ("HSN.VM.B.4.A"
  "Add vectors end-to-end, component-wise, and by the parallelogram rule. Understand that the magnitude of a sum of two vectors is typically not the sum of the magnitudes."
 )
 ("HSN.VM.B.4.B"
  "Given two vectors in magnitude and direction form, determine the magnitude and direction of their sum."
 )
 ("HSN.VM.B.4.C"
  "Understand vector subtraction v - w as v + (-w), where -w is the additive inverse of w, with the same magnitude as w and pointing in the opposite direction. Represent vector subtraction graphically by connecting the tips in the appropriate order, and perform vector subtraction component-wise."
 )
 ("HSN.VM.B.5"
  "Multiply a vector by a scalar."
 )
 ("HSN.VM.B.5.A"
  "Represent scalar multiplication graphically by scaling vectors and possibly reversing their direction; perform scalar multiplication component-wise, e.g., as c(vx, vy) = (cvx, cvy)."
 )
 ("HSN.VM.B.5.B"
  "Compute the magnitude of a scalar multiple cv using ||cv|| = |c|v. Compute the direction of cv knowing that when |c|v ≠ 0, the direction of cv is either along v (for c > 0) or against v (for c < 0)."
 )
 ("HSN.VM.C"
  "Perform operations on matrices and use matrices in applications."
 )
 ("HSN.VM.C.6."
  "Use matrices to represent and manipulate data, e.g., to represent payoffs or incidence relationships in a network."
 )
 ("HSN.VM.C.7"
  "Multiply matrices by scalars to produce new matrices, e.g., as when all of the payoffs in a game are doubled."
 )
 ("HSN.VM.C.8"
  "Add, subtract, and multiply matrices of appropriate dimensions."
 )
 ("HSN.VM.C.9"
  "Understand that, unlike multiplication of numbers, matrix multiplication for square matrices is not a commutative operation, but still satisfies the associative and distributive properties."
 )
 ("HSN.VM.C.10"
  "Understand that the zero and identity matrices play a role in matrix addition and multiplication similar to the role of 0 and 1 in the real numbers. The determinant of a square matrix is nonzero if and only if the matrix has a multiplicative inverse."
 )
 ("HSN.VM.C.11"
  "Multiply a vector (regarded as a matrix with one column) by a matrix of suitable dimensions to produce another vector. Work with matrices as transformations of vectors."
 )
 ("HSN.VM.C.12"
  "Work with 2 × 2 matrices as a transformations of the plane, and interpret the absolute value of the determinant in terms of area."
 )
 ("HSA.SSE.A.1"
  "Interpret expressions that represent a quantity in terms of its context."
 )
 ("HSA.SSE.A.1.A"
  "Interpret parts of an expression, such as terms, factors, and coefficients."
 )
 ("HSA.SSE.A.1.B"
  "Interpret complicated expressions by viewing one or more of their parts as a single entity."
 )
 ("HSA.SSE.A.2"
  "Use the structure of an expression to identify ways to rewrite it."
 )
 ("HSA.SSE.B"
  "Write expressions in equivalent forms to solve problems."
 )
 ("HSA.SSE.B.3"
  "Choose and produce an equivalent form of an expression to reveal and explain properties of the quantity represented by the expression."
 )
 ("HSA.SSE.B.3.A"
  "Factor a quadratic expression to reveal the zeros of the function it defines."
 )
 ("HSA.SSE.B.3.B"
  "Complete the square in a quadratic expression to reveal the maximum or minimum value of the function it defines."
 )
 ("HSA.SSE.B.3.C"
  "Use the properties of exponents to transform expressions for exponential functions."
 )
 ("HSA.SSE.B.4"
  "Derive the formula for the sum of a finite geometric series (when the common ratio is not 1), and use the formula to solve problems."
 )
 ("HSA.APR.A"
  "Perform arithmetic operations on polynomials."
 )
 ("HSA.APR.A.1"
  "Understand that polynomials form a system analogous to the integers, namely, they are closed under the operations of addition, subtraction, and multiplication; add, subtract, and multiply polynomials."
 )
 ("HSA.APR.B"
  "Understand the relationship between zeros and factors of polynomials."
 )
 ("HSA.APR.B.2"
  "Know and apply the Remainder Theorem: For a polynomial p(x) and a number a, the remainder on division by x - a is p(a), so p(a) = 0 if and only if (x - a) is a factor of p(x)."
 )
 ("HSA.APR.B.3"
  "Identify zeros of polynomials when suitable factorizations are available, and use the zeros to construct a rough graph of the function defined by the polynomial."
 )
 ("HSA.APR.C"
  "Use polynomial identities to solve problems."
 )
 ("HSA.APR.C.4"
  "Prove polynomial identities and use them to describe numerical relationships."
 )
 ("HSA.APR.C.5"
  "Know and apply the Binomial Theorem for the expansion of (x + y)n in powers of x and y for a positive integer n, where x and y are any numbers, with coefficients determined for example by Pascal's Triangle."
 )
 ("HSA.APR.D"
  "Rewrite rational expressions."
 )
 ("HSA.APR.D.6"
  "Rewrite simple rational expressions in different forms; write a(x)/b(x) in the form q(x) + r(x)/b(x), where a(x), b(x), q(x), and r(x) are polynomials with the degree of r(x) less than the degree of b(x), using inspection, long division, or, for the more complicated examples, a computer algebra system."
 )
 ("HSA.APR.D.7"
  "Understand that rational expressions form a system analogous to the rational numbers, closed under addition, subtraction, multiplication, and division by a nonzero rational expression; add, subtract, multiply, and divide rational expressions."
 )
 ("HSA.CED.A"
  "Create equations that describe numbers or relationships."
 )
 ("HSA.CED.A.1"
  "Create equations and inequalities in one variable and use them to solve problems."
 )
 ("HSA.CED.A.2"
  "Create equations in two or more variables to represent relationships between quantities; graph equations on coordinate axes with labels and scales."
 )
 ("HSA.CED.A.3"
  "Represent constraints by equations or inequalities, and by systems of equations and/or inequalities, and interpret solutions as viable or nonviable options in a modeling context."
 )
 ("HSA.CED.A.4"
  "Rearrange formulas to highlight a quantity of interest, using the same reasoning as in solving equations."
 )
 ("HSA.REI.A"
  "Understand solving equations as a proces of reasoning and explain the reasoning."
 )
 ("HSA.REI.A.1"
  "Explain each step in solving a simple equation as following from the equality of numbers asserted at the previous step, starting from the assumption that the original equation has a solution. Construct a viable argument to justify a solution method."
 )
 ("HSA.REI.A.2"
  "Solve simple rational and radical equations in one variable, and give examples showing how extraneous solutions may arise."
 )
 ("HSA.REI.B"
  "Solve equations and inequalities in one variable."
 )
 ("HSA.REI.B.3"
  "Solve linear equations and inequalities in one variable, including equations with coefficients represented by letters."
 )
 ("HSA.REI.B.4"
  "Solve quadratic equations in one variable."
 )
 ("HSA.REI.B.4.A"
  "Use the method of completing the square to transform any quadratic equation in x into an equation of the form (x - p)2 = q that has the same solutions. Derive the quadratic formula from this form."
 )
 ("HSA.REI.B.4.B"
  "Solve quadratic equations by inspection (e.g., for x2 = 49), taking square roots, completing the square, the quadratic formula and factoring, as appropriate to the initial form of the equation. Recognize when the quadratic formula gives complex solutions and write them as a ± bi for real numbers a and b."
 )
 ("HSA.REI.C"
  "Solve systems of equations."
 )
 ("HSA.REI.C.5"
  "Prove that, given a system of two equations in two variables, replacing one equation by the sum of that equation and a multiple of the other produces a system with the same solutions."
 )
 ("HSA.REI.C.6"
  "Solve systems of linear equations exactly and approximately (e.g., with graphs), focusing on pairs of linear equations in two variables."
 )
 ("HSA.REI.C.7"
  "Solve a simple system consisting of a linear equation and a quadratic equation in two variables algebraically and graphically. For example, find the points of intersection between the line y = -3x and the circle x2 + y2 = 3."
 )
 ("HSA.REI.C.8"
  "Represent a system of linear equations as a single matrix equation in a vector variable."
 )
 ("HSA.REI.C.9"
  "Find the inverse of a matrix if it exists and use it to solve systems of linear equations (using technology for matrices of dimension 3 × 3 or greater)."
 )
 ("HSA.REI.D"
  "Represent and solve equations and inequalities graphically."
 )
 ("HSA.REI.D.10"
  "Understand that the graph of an equation in two variables is the set of all its solutions plotted in the coordinate plane, often forming a curve (which could be a line)."
 )
 ("HSA.REI.D.11"
  "Explain why the x-coordinates of the points where the graphs of the equations y = f(x) and y = g(x) intersect are the solutions of the equation f(x) = g(x); find the solutions approximately, e.g., using technology to graph the functions, make tables of values, or find successive approximations. Include cases where f(x) and/or g(x) are linear, polynomial, rational, absolute value, exponential, and logarithmic functions."
 )
 ("HSA.REI.D.12"
  "Graph the solutions to a linear inequality in two variables as a half-plane (excluding the boundary in the case of a strict inequality), and graph the solution set to a system of linear inequalities in two variables as the intersection of the corresponding half-planes."
 )
 ("HSF.IF.A"
  "Understand the concept of a function and use function notation."
 )
 ("HSF.IF.A.1"
  "Understand that a function from one set (called the domain) to another set (called the range) assigns to each element of the domain exactly one element of the range. If f is a function and x is an element of its domain, then f(x) denotes the output of f corresponding to the input x. The graph of f is the graph of the equation y = f(x)."
 )
 ("HSF.IF.A.2"
  "Use function notation, evaluate functions for inputs in their domains, and interpret statements that use function notation in terms of a context."
 )
 ("HSF.IF.A.3"
  "Recognize that sequences are functions, sometimes defined recursively, whose domain is a subset of the integers."
 )
 ("HSF.IF.B"
  "Interpret functions that arise in applications in terms of the context."
 )
 ("HSF.IF.B.4"
  "For a function that models a relationship between two quantities, interpret key features of graphs and tables in terms of the quantities, and sketch graphs showing key features given a verbal description of the relationship."
 )
 ("HSF.IF.B.5"
  "Relate the domain of a function to its graph and, where applicable, to the quantitative relationship it describes."
 )
 ("HSF.IF.B.6"
  "Calculate and interpret the average rate of change of a function (presented symbolically or as a table) over a specified interval. Estimate the rate of change from a graph."
 )
 ("HSF.IF.C"
  "Analyze functions using different representations."
 )
 ("HSF.IF.C.7"
  "Graph functions expressed symbolically and show key features of the graph, by hand in simple cases and using technology for more complicated cases."
 )
 ("HSF.IF.C.7.A"
  "Graph linear and quadratic functions and show intercepts, maxima, and minima."
 )
 ("HSF.IF.C.7.B"
  "Graph square root, cube root, and piecewise-defined functions, including step functions and absolute value functions."
 )
 ("HSF.IF.C.7.C"
  "Graph polynomial functions, identifying zeros when suitable factorizations are available, and showing end behavior."
 )
 ("HSF.IF.C.7.D"
  "Graph rational functions, identifying zeros and asymptotes when suitable factorizations are available, and showing end behavior."
 )
 ("HSF.IF.C.7.E"
  "Graph exponential and logarithmic functions, showing intercepts and end behavior, and trigonometric functions, showing period, midline, and amplitude."
 )
 ("HSF.IF.C.8"
  "Write a function defined by an expression in different but equivalent forms to reveal and explain different properties of the function."
 )
 ("HSF.IF.C.8.A"
  "Use the process of factoring and completing the square in a quadratic function to show zeros, extreme values, and symmetry of the graph, and interpret these in terms of a context."
 )
 ("HSF.IF.C.8.B"
  "Use the properties of exponents to interpret expressions for exponential functions. For example, identify percent rate of change in functions such as y = (1.02)ᵗ, y = (0.97)ᵗ, y = (1.01)12ᵗ, y = (1.2)ᵗ/10, and classify them as representing exponential growth or decay."
 )
 ("HSF.IF.C.9"
  "Compare properties of two functions each represented in a different way (algebraically, graphically, numerically in tables, or by verbal descriptions)."
 )
 ("HSF.BF.A"
  "Build a function that models a relationship between two quantities."
 )
 ("HSF.BF.A.1"
  "Write a function that describes a relationship between two quantities."
 )
 ("HSF.BF.A.1.A"
  "Determine an explicit expression, a recursive process, or steps for calculation from a context."
 )
 ("HSF.BF.A.1.B"
  "Combine standard function types using arithmetic operations."
 )
 ("HSF.BF.A.1.C"
  "Compose functions."
 )
 ("HSF.BF.A.2"
  "Write arithmetic and geometric sequences both recursively and with an explicit formula, use them to model situations, and translate between the two forms."
 )
 ("HSF.BF.B"
  "Build new functions from existing functions."
 )
 ("HSF.BF.B.3"
  "Identify the effect on the graph of replacing f(x) by f(x) + k, k f(x), f(kx), and f(x + k) for specific values of k (both positive and negative); find the value of k given the graphs. Experiment with cases and illustrate an explanation of the effects on the graph using technology. Include recognizing even and odd functions from their graphs and algebraic expressions for them."
 )
 ("HSF.BF.B.4"
  "Find inverse functions."
 )
 ("HSF.BF.B.4.A"
  "Solve an equation of the form f(x) = c for a simple function f that has an inverse and write an expression for the inverse."
 )
 ("HSF.BF.B.4.B"
  "Verify by composition that one function is the inverse of another."
 )
 ("HSF.BF.B.4.C"
  "Read values of an inverse function from a graph or a table, given that the function has an inverse."
 )
 ("HSF.BF.B.4.D"
  "Produce an invertible function from a non-invertible function by restricting the domain."
 )
 ("HSF.BF.B.5"
  "Understand the inverse relationship between exponents and logarithms and use this relationship to solve problems involving logarithms and exponents."
 )
 ("HSF.LE.A"
  "Construct and compare linear, quadratic, and exponential models and solve problems."
 )
 ("HSF.LE.A.1"
  "Distinguish between situations that can be modeled with linear functions and with exponential functions."
 )
 ("HSF.LE.A.1.A"
  "Prove that linear functions grow by equal differences over equal intervals, and that exponential functions grow by equal factors over equal intervals."
 )
 ("HSF.LE.A.1.B"
  "Recognize situations in which one quantity changes at a constant rate per unit interval relative to another."
 )
 ("HSF.LE.A.1.C"
  "Recognize situations in which a quantity grows or decays by a constant percent rate per unit interval relative to another."
 )
 ("HSF.LE.A.2"
  "Construct linear and exponential functions, including arithmetic and geometric sequences, given a graph, a description of a relationship, or two input-output pairs (include reading these from a table)."
 )
 ("HSF.LE.A.3"
  "Observe using graphs and tables that a quantity increasing exponentially eventually exceeds a quantity increasing linearly, quadratically, or (more generally) as a polynomial function."
 )
 ("HSF.LE.A.4"
  "For exponential models, express as a logarithm the solution to abct = d where a, c, and d are numbers and the base b is 2, 10, or e; evaluate the logarithm using technology."
 )
 ("HSF.LE.B"
  "Interpret expressions for functions in terms of the situation they model."
 )
 ("HSF.LE.B.5"
  "Interpret the parameters in a linear or exponential function in terms of a context."
 )
 ("HSF.TF.A"
  "Extend the domain of trigonometric functions using the unit circle."
 )
 ("HSF.TF.A.1"
  "Understand radian measure of an angle as the length of the arc on the unit circle subtended by the angle."
 )
 ("HSF.TF.A.2"
  "Explain how the unit circle in the coordinate plane enables the extension of trigonometric functions to all real numbers, interpreted as radian measures of angles traversed counterclockwise around the unit circle."
 )
 ("HSF.TF.A.3"
  "Use special triangles to determine geometrically the values of sine, cosine, tangent for π/3, π/4 and π/6, and use the unit circle to express the values of sine, cosine, and tangent for x, π + x, and 2π - x in terms of their values for x, where x is any real number."
 )
 ("HSF.TF.A.4"
  "Use the unit circle to explain symmetry (odd and even) and periodicity of trigonometric functions."
 )
 ("HSF.TF.B"
  "Model periodic phenomena with trigonometric functions."
 )
 ("HSF.TF.B.5"
  "Choose trigonometric functions to model periodic phenomena with specified amplitude, frequency, and midline."
 )
 ("HSF.TF.B.6"
  "Understand that restricting a trigonometric function to a domain on which it is always increasing or always decreasing allows its inverse to be constructed."
 )
 ("HSF.TF.B.7"
  "Use inverse functions to solve trigonometric equations that arise in modeling contexts; evaluate the solutions using technology, and interpret them in terms of the context."
 )
 ("HSF.TF.C"
  "Prove and apply trigonometric identities."
 )
 ("HSF.TF.C.8"
  "Prove the Pythagorean identity sin2(θ) + cos2(θ) = 1 and use it to find sin(θ), cos(θ), or tan(θ) given sin(θ), cos(θ), or tan(θ) and the quadrant of the angle."
 )
 ("HSF.TF.C.9"
  "Prove the addition and subtraction formulas for sine, cosine, and tangent and use them to solve problems."
 )
 ("HSG.CO.A"
  "Experiment with transformations in the plane."
 )
 ("HSG.CO.A.1"
  "Know precise definitions of angle, circle, perpendicular line, parallel line, and line segment, based on the undefined notions of point, line, distance along a line, and distance around a circular arc."
 )
 ("HSG.CO.A.2"
  "Represent transformations in the plane using, e.g., transparencies and geometry software; describe transformations as functions that take points in the plane as inputs and give other points as outputs. Compare transformations that preserve distance and angle to those that do not (e.g., translation versus horizontal stretch)."
 )
 ("HSG.CO.A.3"
  "Given a rectangle, parallelogram, trapezoid, or regular polygon, describe the rotations and reflections that carry it onto itself."
 )
 ("HSG.CO.A.4"
  "Develop definitions of rotations, reflections, and translations in terms of angles, circles, perpendicular lines, parallel lines, and line segments."
 )
 ("HSG.CO.A.5"
  "Given a geometric figure and a rotation, reflection, or translation, draw the transformed figure using, e.g., graph paper, tracing paper, or geometry software. Specify a sequence of transformations that will carry a given figure onto another."
 )
 ("HSG.CO.B"
  "Understand congruence in terms of rigid motions"
 )
 ("HSG.CO.B.6"
  "Use geometric descriptions of rigid motions to transform figures and to predict the effect of a given rigid motion on a given figure; given two figures, use the definition of congruence in terms of rigid motions to decide if they are congruent."
 )
 ("HSG.CO.B.7"
  "Use the definition of congruence in terms of rigid motions to show that two triangles are congruent if and only if corresponding pairs of sides and corresponding pairs of angles are congruent."
 )
 ("HSG.CO.B.8"
  "Explain how the criteria for triangle congruence (ASA, SAS, and SSS) follow from the definition of congruence in terms of rigid motions."
 )
 ("HSG.CO.C"
  "Prove geometric theorems."
 )
 ("HSG.CO.C.9"
  "Prove theorems about lines and angles."
 )
 ("HSG.CO.C.10"
  "Prove theorems about triangles."
 )
 ("HSG.CO.C.11"
  "Prove theorems about parallelograms."
 )
 ("HSG.CO.D" 
  "Make geometric constructions."
 )
 ("HSG.CO.D.12"
  "Make formal geometric constructions with a variety of tools and methods."
 )
 ("HSG.CO.D.13"
  "Construct an equilateral triangle, a square, and a regular hexagon inscribed in a circle."
 )
 ("HSG.SRT.A"
  "Understand similarity in terms of similarity transformations."
 )
 ("HSG.SRT.A.1"
  "Verify experimentally the properties of dilations given by a center and a scale factor."
 )
 ("HSG.SRT.A.1.A"
  "A dilation takes a line not passing through the center of the dilation to a parallel line, and leaves a line passing through the center unchanged."
 )
 ("HSG.SRT.A.1.B"
  "The dilation of a line segment is longer or shorter in the ratio given by the scale factor."
 )
 ("HSG.SRT.A.2"
  "Given two figures, use the definition of similarity in terms of similarity transformations to decide if they are similar; explain using similarity transformations the meaning of similarity for triangles as the equality of all corresponding pairs of angles and the proportionality of all corresponding pairs of sides."
 )
 ("HSG.SRT.A.3"
  "Use the properties of similarity transformations to establish the AA criterion for two triangles to be similar."
 )
 ("HSG.SRT.B"
  "Prove theorems involving similarity."
 )
 ("HSG.SRT.B.4"
  "Prove theorems about triangles (similarity)."
 )
 ("HSG.SRT.B.5"
  "Use congruence and similarity criteria for triangles to solve problems and to prove relationships in geometric figures."
 )
 ("HSG.SRT.C"
  "Define trigonometric ratios and solve problems involving right triangles."
 )
 ("HSG.SRT.C.6"
  "Understand that by similarity, side ratios in right triangles are properties of the angles in the triangle, leading to definitions of trigonometric ratios for acute angles."
 )
 ("HSG.SRT.C.7"
  "Explain and use the relationship between the sine and cosine of complementary angles."
 )
 ("HSG.SRT.C.8"
  "Use trigonometric ratios and the Pythagorean Theorem to solve right triangles in applied problems."
 )
 ("HSG.SRT.D"
  "Apply trigonometry to general triangles."
 )
 ("HSG.SRT.D.9"
  "Derive the formula A = 1/2 ab sin(C) for the area of a triangle by drawing an auxiliary line from a vertex perpendicular to the opposite side."
 )
 ("HSG.SRT.D.10"
  "Prove the Laws of Sines and Cosines and use them to solve problems."
 )
 ("HSG.SRT.D.11"
  "Understand and apply the Law of Sines and the Law of Cosines to find unknown measurements in right and non-right triangles."
 )
 ("HSG.C.A"
  "Understand and apply theorems about circles."
 )
 ("HSG.C.A.1"
  "Prove that all circles are similar."
 )
 ("HSG.C.A.2"
  "Identify and describe relationships among inscribed angles, radii, and chords."
 )
 ("HSG.C.A.3"
  "Construct the inscribed and circumscribed circles of a triangle, and prove properties of angles for a quadrilateral inscribed in a circle."
 )
 ("HSG.C.A.4"
  "Construct a tangent line from a point outside a given circle to the circle."
 )
 ("HSG.C.B"
  "Find arc lengths and areas of sectors of circles."
 )
 ("HSG.C.B.5"
  "Derive using similarity the fact that the length of the arc intercepted by an angle is proportional to the radius, and define the radian measure of the angle as the constant of proportionality; derive the formula for the area of a sector."
 )
 ("HSG.GPE.A"
  "Translate between the geometric description and the equation for a conic section."
 )
 ("HSG.GPE.A.1"
  "Derive the equation of a circle of given center and radius using the Pythagorean Theorem; complete the square to find the center and radius of a circle given by an equation."
 )
 ("HSG.GPE.A.2"
  "Derive the equation of a parabola given a focus and directrix."
 )
 ("HSG.GPE.A.3"
  "Derive the equations of ellipses and hyperbolas given the foci, using the fact that the sum or difference of distances from the foci is constant."
 )
 ("HSG.GPE.B"
  "Use coordinates to prove simple geometric theorems algebraically."
 )
 ("HSG.GPE.B.5"
  "Prove the slope criteria for parallel and perpendicular lines and use them to solve geometric problems."
 )
 ("HSG.GPE.B.6"
  "Find the point on a directed line segment between two given points that partitions the segment in a given ratio."
 )
 ("HSG.GPE.B.7"
  "Use coordinates to compute perimeters of polygons and areas of triangles and rectangles, e.g., using the distance formula."
 )
 ("HSG.GMD.A"
  "Explain volume formulas and use them to solve problems."
 )
 ("HSG.GMD.A.1"
  "Give an informal argument for the formulas for the circumference of a circle, area of a circle, volume of a cylinder, pyramid, and cone."
 )
 ("HSG.GMD.A.2"
  "Give an informal argument using Cavalieri's principle for the formulas for the volume of a sphere and other solid figures."
 )
 ("HSG.GMD.A.3"
  "Use volume formulas for cylinders, pyramids, cones, and spheres to solve problems."
 )
 ("HSG.GMD.B"
  "Visualize relationships between two-dimensional and three-dimensional objects."
 )
 ("HSG.GMD.B.4"
  "Identify the shapes of two-dimensional cross-sections of three-dimensional objects, and identify three-dimensional objects generated by rotations of two-dimensional objects."
 )
 ("HSG.MG.A"
  "Apply geometric concepts in modeling situations."
 )
 ("HSG.MG.A.1"
  "Use geometric shapes, their measures, and their properties to describe objects."
 )
 ("HSG.MG.A.2"
  "Apply concepts of density based on area and volume in modeling situations."
 )
 ("HSG.MG.A.3"
  "Apply geometric methods to solve design problems."
 )
 ("HSS.ID.A"
  "Summarize, represent, and interpret data on a single count or measurement variable."
 )
 ("HSS.ID.A.1"
  "Represent data with plots on the real number line (dot plots, histograms, and box plots)."
 )
 ("HSS.ID.A.2"
  "Use statistics appropriate to the shape of the data distribution to compare center (median, mean) and spread (interquartile range, standard deviation) of two or more different data sets."
 )
 ("HSS.ID.A.3"
  "Interpret differences in shape, center, and spread in the context of the data sets, accounting for possible effects of extreme data points (outliers)."
 )
 ("HSS.ID.A.4"
  "Use the mean and standard deviation of a data set to fit it to a normal distribution and to estimate population percentages. Recognize that there are data sets for which such a procedure is not appropriate. Use calculators, spreadsheets, and tables to estimate areas under the normal curve."
 )
 ("HSS.ID.B"
  "Summarize, represent, and interpret data on two categorical and quantitative variables."
 )
 ("HSS.ID.B.5" 
  "Summarize categorical data for two categories in two-way frequency tables. Interpret relative frequencies in the context of the data (including joint, marginal, and conditional relative frequencies). Recognize possible associations and trends in the data."
 )
 ("HSS.ID.B.6"
  "Represent data on two quantitative variables on a scatter plot, and describe how the variables are related."
 )
 ("HSS.ID.B.6.A"
  "Fit a function to the data; use functions fitted to data to solve problems in the context of the data. Use given functions or choose a function suggested by the context. Emphasize linear, quadratic, and exponential models."
 )
 ("HSS.ID.B.6.B"
  "Informally assess the fit of a function by plotting and analyzing residuals."
 )
 ("HSS.ID.B.6.C"
  "Fit a linear function for a scatter plot that suggests a linear association."
 )
 ("HSS.ID.C"
  "Interpret linear models."
 )
 ("HSS.ID.C.7"
  "Interpret the slope (rate of change) and the intercept (constant term) of a linear model in the context of the data."
 )
 ("HSS.ID.C.8"
  "Compute (using technology) and interpret the correlation coefficient of a linear fit."
 )
 ("HSS.ID.C.9"
  "Distinguish between correlation and causation."
 )
 ("HSS.IC.A"
  "Understand and evaluate random processes underlying statistical experiments."
 )
 ("HSS.IC.A.1"
  "Understand statistics as a process for making inferences about population parameters based on a random sample from that population."
 )
 ("HSS.IC.A.2"
  "Decide if a specified model is consistent with results from a given data-generating process, e.g., using simulation."
 )
 ("HSS.IC.B"
  "Make inferences and justify conclusions from sample surveys, experiments, and observational studies."
 )
 ("HSS.IC.B.3"
  "Recognize the purposes of and differences among sample surveys, experiments, and observational studies; explain how randomization relates to each."
 )
 ("HSS.IC.B.4"
  "Use data from a sample survey to estimate a population mean or proportion; develop a margin of error through the use of simulation models for random sampling."
 )
 ("HSS.IC.B.5"
  "Use data from a randomized experiment to compare two treatments; use simulations to decide if differences between parameters are significant."
 )
 ("HSS.IC.B.6"
  "Evaluate reports based on data."
 )
 ("HSS.CP.A"
  "Understand independence and conditional probability and use them to interpret data."
 )
 ("HSS.CP.A.1"
  "Describe events as subsets of a sample space (the set of outcomes) using characteristics (or categories) of the outcomes, or as unions, intersections, or complements of other events ("or," "and," "not")."
 )
 ("HSS.CP.A.2"
  "Understand that two events A and B are independent if the probability of A and B occurring together is the product of their probabilities, and use this characterization to determine if they are independent."
 )
 ("HSS.CP.A.3"
  "Understand the conditional probability of A given B as P(A and B)/P(B), and interpret independence of A and B as saying that the conditional probability of A given B is the same as the probability of A, and the conditional probability of B given A is the same as the probability of B."
 )
 ("HSS.CP.A.4"
  "Construct and interpret two-way frequency tables of data when two categories are associated with each object being classified. Use the two-way table as a sample space to decide if events are independent and to approximate conditional probabilities."
 )
 ("HSS.CP.A.5"
  "Recognize and explain the concepts of conditional probability and independence in everyday language and everyday situations."
 )
 ("HSS.CP.B"
  "Use the rules of probability to compute probabilities of compound events."
 )
 ("HSS.CP.B.6"
  "Find the conditional probability of A given B as the fraction of B's outcomes that also belong to A, and interpret the answer in terms of the model."
 )
 ("HSS.CP.B.7"
  "Apply the Addition Rule, P(A or B) = P(A) + P(B) - P(A and B), and interpret the answer in terms of the model."
 )
 ("HSS.CP.B.8"
  "Apply the general Multiplication Rule in a uniform probability model, P(A and B) = P(A)P(B|A) = P(B)P(A|B), and interpret the answer in terms of the model."
 )
 ("HSS.CP.B.9"
  "Use permutations and combinations to compute probabilities of compound events and solve problems."
 )
 ("HSS.MD.A"
  "Calculate expected values and use them to solve problems."
 )
 ("HSS.MD.A.1"
  "Define a random variable for a quantity of interest by assigning a numerical value to each event in a sample space; graph the corresponding probability distribution using the same graphical displays as for data distributions."
 )
 ("HSS.MD.A.2"
  "Calculate the expected value of a random variable; interpret it as the mean of the probability distribution."
 )
 ("HSS.MD.A.3"
  "Develop a probability distribution for a random variable defined for a sample space in which theoretical probabilities can be calculated; find the expected value."
 )
 ("HSS.MD.A.4"
  "Develop a probability distribution for a random variable defined for a sample space in which probabilities are assigned empirically; find the expected value."
 )
 ("HSS.MD.B"
  "Use probability to evaluate outcomes of decisions."
 )
 ("HSS.MD.B.5"
  "Weigh the possible outcomes of a decision by assigning probabilities to payoff values and finding expected values."
 )
 ("HSS.MD.B.5.A"
  "Find the expected payoff for a game of chance."
 )
 ("HSS.MD.B.5.B"
  "Evaluate and compare strategies on the basis of expected values."
 )
 ("HSS.MD.B.6"
  "Use probabilities to make fair decisions."
 )
 ("HSS.MD.B.7"
  "Analyze decisions and strategies using probability concepts."
 )
 ))
 
