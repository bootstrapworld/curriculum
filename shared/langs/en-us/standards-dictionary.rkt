#lang racket

(provide *standards-list*)

(define *standards-list*
'(
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
 
 
 
 
 
 
 ;Old versions of standards below this line
 ("N-Q"
  "The student reasons quantitatively in using units to solve problems"
  "selection of appropriate units when solving a problem"
  "correct interpretation of units consistently in formulas"
  "selection of appropriate scale and origin in graphs and data displays"
  "selection of (Identification of) appropriate quantities for the purpose of descriptive modeling"
  "selection of a level of accuracy appropriate to limitations on measurement when reporting quantities"
  )
 ("5.G.1-2"
  "Graph points on the coordinate plane to solve real-world and mathematical problems"
  "Use a pair of perpendicular number lines, called axes, to define a coordinate system"
  "Represent real world and mathematical problems by graphing points in the first quadrant of the coordinate plane, and interpret coordinate values of points in the context of the situation."
  )
 ("5.OA.1-2"
  "Write and interpret numerical expressions"
  "Use parentheses, brackets, or braces in numerical expressions, and evaluate expressions with these symbols"
  "Write simple expressions that record calculations with numbers, and interpret numerical expressions without evaluating them."
  )
 ("6.NS.5-8"
  "The student performs operations with negative numbers, works with the number line and coordinate plane, order and absolute value of numbers, and solves real-world problems with rational numbers."
  "representation of opposite quantities with positive and negative numbers."
  "graphs of negative numbers on the number line."
  "plots of coordinate pairs in all four quadrants of the coordinate plane."
  "definition of and determination of absolute value of rational numbers."
  "interpretation of order of rational numbers in real-world contexts."
  "calculation of distance between points with the same first coordinate or same second coordinate."
  )
 ("7.EE.1-2"
  "The student uses properties of operations to generate equivalent expressions"
  "addition, subtraction, factoring, and expansion of linear expressions with rational coefficients by applying properties of operations"
  "rewriting of an expression in different forms in a problem context to shed light on the problem and how the quantities in it are related"
  )
 ("7.EE.3-4"
  "The student uses numerical and algebraic expressions and equations to solve real-life and mathematical problems"
  "use of positive and negative rational numbers in any form (whole numbers, fractions, and decimals) to solve multi-step real-life and mathematical problems"
  "conversions between forms of rational numbers to perform appropriate calculations"
  "estimation of answers using mental computation to assess the reasonableness of solutions"
  "use of variables to represent quantities in a real-world or mathematical problem"
  "construction of simple equations and inequalities to solve problems by reasoning about the quantities"
  "solution of word problems leading to equations of the form px + q = r and p(x + q) = r, where p, q, and r are specific rational numbers"
  "determination of solutions of equations of these forms"
  "comparison of an algebraic solution to an arithmetic solution, identifying the sequence of the operations used in each approach"
  "determination of solutions of word problems leading to inequalities of the form px + q > r or px + q < r, where p, q, and r are specific rational numbers"
  "interpretation in context of solutions of word problems leading to inequalities"
  "construction of a graph of the solution set of an inequality and interpretation of it in the context of the problem"
  )
 ("8.EE.1-4"
  "The student performs operations with radicals and integer exponents"
  "1. generation of equivalent numerical expressions by applying the properties of integer exponents"
  "2. use of square root and cube root symbols to represent solutions to equations of the form x2 = p, where p is a positive rational number, and x3 = p, where p is a positive or negative rational number"
  "3. evaluation of square roots of small perfect squares and cube roots of small perfect cubes"
  "4. identification of ‹ê2 as irrational"
  "5. estimation of very large or very small quantities using numbers expressed in the form of a single digit times an integer power of 10"
  "6. comparison of very large or very small quantities by expressing how many times as much one is than the other"
  "7. operations with numbers expressed in scientific notation, including problems where both decimal and scientific notation are used"
  "8. selection of units of appropriate size for measurements of very large or very small quantities"
  "9. interpretation of scientific notation that has been generated by technology"
  )
 ("8.EE.5-6"
  "The student draws connections between proportional relationships, lines, and linear equations"
  "1. interpretation of the unit rate as the slope of the graph of a proportional relationship"
  "2. comparison of two different proportional relationships represented in different ways (for example, graph and equation)"
  "3. use of similar triangles to explain why the slope, m, is the same between any two distinct points on a non-vertical line in the coordinate plane"
  "4. derivation of the equation y = mx for a line through the origin and the equation y = mx + b for a line intercepting the vertical axis at b"
  )
 ("8.EE.7"
  "The student analyzes and solves linear equations and pairs of simultaneous linear equations (simultaneous linear equations will be taught in 8th grade)"
  "1. determination of solutions of linear equations in one variable"
  "2. identification of linear equations in one variable as having one solution, infinitely many solutions, or no solutions"
  "3. transformation of given equations into simpler forms, until an equivalent equation of the form x = a, a = a, or a = b results (where a and b are different numbers)"
  "4. solutions of linear equations with rational number coefficients, including equations whose solutions require expanding expressions using the distributive property and collecting like terms"
  )
 ("7.G.1"
  "The student draws, constructs, and describes geometrical figures and describes the relationships between them"
  "1. computation of lengths and areas from scale drawings of geometric figures"
  "2. reproduction of a scale drawing at a different scale"
  )
 ("7.G.2"
  ""
  "3. use of given conditions to draw geometric shapes (freehand, with ruler and protractor, and with technology)"
  "4. use of the measures of three angles or sides to construct a triangle and determine when the conditions determine a unique triangle, more than one triangle, or no triangle"
  )
 ("7.G.3"
  ""
  "5. description of the two-dimensional figures that result from slicing three dimensional figures, as in plane sections of right rectangular prisms and right rectangular pyramids"
  )
 ("7.G.5"
  "The student solves real-life and mathematical problems involving angle measure, area, surface area, and volume (Area, SA, Volume in 6th)"
  "3. determination of solution to a multi-step problem requiring use of facts about supplementary, complementary, vertical, and adjacent angles to write and solve simple equations for an unknown angle in a figure"
  )
 ("8.G.1-5"
  "The student uses physical models, transparencies, or geometry software to examine congruence and similarity"
  "1. rotations, reflections, and translations of lines taken to lines, and line segments to line segments of the same length"
  "2. rotations, reflections, and translations of angles taken to angles of the same measure"
  "3. rotations, reflections, and translations of parallel lines taken to parallel lines"
  "4. creation of a two-dimensional figure, congruent to a first figure, obtained by a sequence of rotations, reflections, and translations"
  "5. description of the sequence of rotations, reflections, and translations used to create a second congruent figure from a first"
  "6. descriptions of the effect of dilations, translations, rotations, and reflections on two-dimensional figures using coordinates"
  "7. creation of a second, similar, two-dimensional figure obtained by a sequence of rotations, reflections, translations, and dilations performed on a figure"
  "8. description of the sequence of rotations, reflections, translations, and dilations used to create a second similar figure from a first"
  "9. use of informal arguments establishing facts about the angle sum and exterior angle of triangles, about the angles created when parallel lines are cut by a transversal, and the angle-angle criterion for similarity of triangles"
  )
 ("8.G.6-8"
  "The student uses the Pythagorean Theorem to solve real-world and mathematical problems"
  "1. explanation of a proof of the Pythagorean Theorem and its converse"
  "2. application of the Pythagorean Theorem to determine unknown side lengths in right triangles in real-world and mathematical problems in two and three dimensions"
  "3. application of the Pythagorean Theorem to find the distance between two points in a coordinate system"
  )
 ("8.G.9"
  "The student uses formulas involving volume of cylinders, cones, and spheres to solve real-world and mathematical problems"
  "1. use of the formulas for the volumes of cones, cylinders, and spheres to solve real-world and mathematical problems"
  "2. determination of the validity of a sample and the inferences based on that sample"
  )
 ("6.SP.1-3"
  "The student develops an understanding of statistical variability."
  "1. Recognize a statistical question as one that anticipates variability in the data related to the question and accounts for it in the answers"
  "2. Understand that a set of data collected to answer a statistical question has a distribution which can be described by its center, spread, and overall shape."
  "3. Recognize that a measure of center for a numerical data set summarizes all of its values with a single number, while a measure of variation describes how its values vary with a single number."
  )
 ("6.SP.4-5"
  "The student summarizes and describes distributions"
  "4. Display numerical data in plots on a number line, including dot plots, histograms, and box plots."
  "5. Summarize numerical data sets in relation to their context, such as by: Reporting the number of observations, Describing the nature of the attribute under investigation, including how it was measured and its units of measurement, Giving quantitative measures of center (median and/or mean) and variability (interquartile range and/or mean absolute deviation), as well as describing any overall pattern and any striking deviations from the overall pattern with reference to the context in which the data were gathered, or Relating the choice of measures of center and variability to the shape of the data distribution and the context in which the data were gathered."
  )
 ("7.SP.1-2"
  "The student draws inferences about a population by using random sampling"
  "1. use of sampling to gain information about a population"
  "2. determination of the validity of a sample and the inferences based on that sample"
  "3. use of data from a random sample to draw inferences about a population with an unknown characteristic of interest"
  "4. creation of multiple samples (or simulated samples) of the same size to gauge the variation in estimates or predictions"
  )
 ("7.SP.3-4"
  "The student draws informal comparative inferences about two populations"
  "1. Informally assess the degree of visual overlap of two numerical data distributions with similar variabilities, measuring the difference between the centers by expressing it as a multiple of a measure of variability"
  "2. Use measures of center and measures of variability for numerical data from random samples to draw informal comparative inferences about two populations"
  )
 ("7.SP.5-8"
  "The student develops, uses, and evaluates probability models to investigate chance processes"
  "1. Understand that the probability of a chance event is a number between 0 and 1 that expresses the likelihood of the event occurring. Larger numbers indicate greater likelihood."
  "2. Approximate the probability of a chance event by collecting data on the chance process that produces it and observing its long-run relative frequency, and predict the approximate relative frequency given the probability."
  "3. Develop a probability model and use it to find probabilities of events. Compare probabilities from a model to observed frequencies; if the agreement is not good, explain possible sources of the discrepancy."
  "4. Find probabilities of compound events using organized lists, tables, tree diagrams, and simulation."
  )
 ("7.SP.1"
  "The student draws inferences about a population by using random sampling"
  "1. use of sampling to gain information about a population"
  )
 ("8.SP.1-4"
  "The student investigates patterns of association in bivariate data"
  "1. investigation of patterns of association between two quantities by constructing and interpreting scatter plots for bivariate measurement data"
  "2. description of patterns such as clustering, outliers, positive or negative association, linear association, and nonlinear association"
  "3. use of straight lines to model relationships between two quantitative variables"
  "4. determination of the fit of a linear model to a scatter plot that suggests a linear association by judging the closeness of the data points to the line"
  "5. interpretation of the slope and intercept of the equation of a linear model used to solve problems in the context of bivariate measurement data"
  "6. displaying of frequencies and relative frequencies of bivariate categorical data in a two-way table to evaluate patterns of association"
  "7. construction and interpretation of a two-way table summarizing data on two categorical variables collected from the same subjects"
  "8. use of relative frequencies calculated for rows or columns to describe possible association between the two variables"
  )
 ("8.F.1-3"
  "The student defines, evaluates, and compares functions"
  "1. description of a function as a rule that assigns to each input exactly one output"
  "2. construction of the graph of a function as the set of ordered pairs consisting of an input and the corresponding output"
  "3. comparison of properties of two functions each represented in a different way (algebraically, graphically, numerically in tables, or by verbal descriptions)"
  "4. identification of the equation y = mx + b as a linear function, whose graph is a straight line"
  "5. identification of functions that are not linear, such as A = s2, by the fact that their graphs do not form a straight line"
  )
 ("8.F.4"
  "The student models relationships between quantities using functions"
  "1. construction of a function to model a linear relationship between two quantities"
  "2. determination of the rate of change and initial value of a function from a description of a relationship or from two (x, y) values, including reading these from a table or from a graph"
  "3. interpretation of the rate of change and initial value of a linear function in terms of the situation it models, and in terms of its graph or a table of values"
  )
 ("8.F.5"
  "The student models relationships between quantities using functions"
  "4. use of a qualitative description (e.g., where the function is increasing or decreasing, linear or nonlinear) to describe the functional relationship between two quantities"
  "5. sketch of a graph that exhibits the qualitative features of a function that has been described verbally"
  )
 ("N-RN"
  "The student extends the properties of exponents to rational exponents"
  "1. use of the properties of exponents to describe rational exponents and relate them to radicals"
  "2. explanation of how the definition of the meaning of rational exponents follows from extending the properties of integer exponents to those values, allowing for a notation for radicals in terms of rational exponents (for example, we define 51/3 to be the cube root of 5 because we want (51/3)3 = 5(1/3)3 to hold, so (51/3)3 must equal 5)"
  "3. use of the properties of exponents to simplify expressions involving radicals and rational exponents"
  "4. Rewritten expressions involving radicals and rational exponents using the properties of exponents"
  "The student uses properties of rational and irrational numbers"
  "1. explanation for why the sum or product of two rational numbers is rational"
  "2. explanation that the sum of a rational number and an irrational number is irrational"
  "3. explanation that the product of a nonzero rational number and an irrational number is irrational"
  )
 ("A-REI.1-2"
  "The student explains the reasoning for the process of solving equations"
  "1. construction of a viable argument to justify each step in solving a simple equation"
  "2. reasoning for the existence of extraneous solutions in simple rational and radical equations in one variable"
  )
 ("A-REI.3-4"
  "The student solves linear and quadratic equations and inequalities in one variable"
  "1. solution of linear equations and inequalities in one variable, including equations with coefficients represented by letters"
  "2. solution of quadratic equations in one variable"
  "3. use of completing the square to transform any quadratic equation into an equation of the form (x _ p)^2 = q"
  "4. use of completing the square to derive the quadratic formula"
  "5. use of an appropriate algebraic method (inspection, taking square roots, completing the square, the quadratic formula, or factoring) to solve quadratic equations"
  )
 ("A-REI.5-9"
  "The student solves systems of linear equations and simple systems of a linear and a quadratic equation"
  "1. proof that given a system of two equations in two variables, replacing one equation by the sum of that equation and a multiple of the other produces a system with the same solutions"
  "2. solution to systems of linear equations exactly and approximately (e.g., with graphs), focusing on pairs of linear equations in two variables"
  "3. solution to a simple system of a linear equation and a quadratic equation in two variables algebraically and graphically"
  )
 ("A-REI.10-12"
  "The student uses a graph to represent and solve equations and inequalities"
  "1. use of a graph of an equation in two variables to identify all solutions of the curve plotted on the coordinate plane"
  "2. representation of the solution of the equation f(x) = g(x) as the x-coordinates of the points where the graphs of the equations y = f(x) and y = g(x) intersect"
  "3. use of approximation by technology to find the solution of a system of equations, where f(x) and/or g(x) are linear, polynomial, rational, absolute value, exponential, and logarithmic functions"
  "4. graph of the solutions to a linear inequality in two variables as a half-plane (excluding the boundary in the case of a strict inequality)"
  "5. graph of the solution set to a system of linear inequalities in two variables as the intersection of the corresponding half-planes"
  )
 ("F-IF.1-3"
  "The student uses function notation to describe, evaluate, and interpret functions in terms of domain and range"
  "description of a function using terms domain and range"
  "explanation that if f is a function and x is an element of its domain, then f(x) denotes the output of f corresponding to the input x"
  "graph of f as the graph of the equation y = f(x)"
  "evaluation of functions using function notation for inputs in their domains"
  "interpretation of statements that use function notation in terms of a context"
  )
 ("F-IF.4-6"
  "The student interprets the behavior of functions that arise in applications in terms of the context"
  "interpretation of a relationship between two quantities in a table or graph in terms of key features"
  "use of verbal descriptions of key features to graph a function"
  "relation of the domain of a function to its graph and, where applicable, to the quantitative relationship it describes"
  "calculation and interpretation of the average rate of change of a function (presented symbolically or as a table) over a specified interval"
  "estimation of the rate of change from a graph"
  )
 ("F-IF.7-9"
  "The student uses different representations of a function to make generalizations about key features of function behavior and to compare functions to one another"
  "graphs of linear and quadratic functions showing intercepts, maxima, and minima"
  "graphs of square root, cube root, and piecewise-defined functions, including step functions."
  "Graph polynomial functions, identifying zeros when suitable factorizations are available, and showing end behavior."
  "Graph rational functions, identifying zeros and asymptotes

when suitable factorizations are available, and showing end

behavior"
  "graphs of exponential and logarithmic functions, showing intercepts and end behavior."
  "Use the process of factoring and completing the square in a

quadratic function to show zeros, extreme values, and symmetry

of the graph, and interpret these in terms of a context."
  "use of properties of exponents to interpret expressions for exponential functions and classify them as exponential growth or decay."
  "comparison of properties of two functions each represented in a different way (algebraically, graphically, numerically in tables, or by verbal descriptions)"
  )
 ("F-LE.1-4"
  "The student constructs linear, quadratic, and exponential models to solve problems"
  "determination of whether a situation can be modeled with a linear or exponential function"
  "use of proofs to show that linear functions grow by equal differences over equal intervals, and that exponential functions grow by equal factors over equal intervals"
  "identification of situations in which one quantity changes at a constant rate per unit interval relative to another"
  "identification of situations in which a quantity grows or decays by a constant percent rate per unit interval relative to another"
  "construction of linear and exponential functions, including arithmetic and geometric sequences from a graph, a description of a relationship, or two input-output pairs (include reading these from a table). NOTE: Limit to consecutive input-output pairs for exponential functions"
  "use of graphs and tables to show that a quantity increasing exponentially eventually exceeds a quantity increasing linearly, quadratically, or (more generally) as a polynomial function"
  )
 ("F-LE.5"
  "The student interprets expressions for functions in terms of the situations they model"
  "1. interpretation of the parameters in a linear or exponential function in terms of a context"
  )
 ("A-SSE.1-2"
  "The student interprets the structure of expressions to solve problems in context"
  "1. interpretation of expressions that represent a quantity in context"
  "2. interpretation of terms, factors, and coefficients of an expression"
  "3. interpretation of complicated expressions by viewing one or more of their parts as a single entity"
  "4. manipulation of the structure of an expression, for example, writing x4 _ y4 as a difference of squares"
  )
 ("A-SSE.3-4"
  "The student solves problems by writing expressions in equivalent forms"
  "1. transformation of expressions for exponential functions using properties of exponents"
  "2. derivation of the formula for the sum of a finite geometric series (when the common ratio is not 1)"
  "3. use of the formula for the sum of a finite geometric series to solve problems"
  )
 ("A-APR.1"
  "The student performs operations (addition, subtraction, and multiplication) with polynomials"
  "1. description of the system of polynomials as closed under the operations of addition, subtraction, and multiplication"
  "2. addition, subtraction, and multiplication of polynomials"
  )
 ("A-APR.2-3"
  "The student identifies and uses the relationship between zeros and factors of polynomials"
  "1. use of the Remainder Theorem to identify factors of a polynomial p(x)"
  "2. use of factoring to identify zeros of polynomials"
  "3. use of the zeros of a polynomial function to construct a rough graph of the function"
  )
 ("A-APR.4"
  "The student solves problems by using polynomial identities"
  "1. proofs of polynomial identities"
  "2. use of polynomial identities to describe numerical relationships"
  )
 ("A-APR.6"
  "The student rewrites rational expressions"
  "1. manipulation of simple rational expressions to write them in different forms"
  "2. use of inspection, long division, or (for more complicated examples) a computer algebra system to write a(x)/b(x) in the form q(x) + r(x)/b(x), where a(x), b(x), q(x), and r(x) are polynomials with the degree of r(x) less than the degree of b(x)"
  )
 ("A-CED.1-4"
  "The student solves equations and inequalities in one or more variable that describe numbers or relationships"
  "1. creation of equations and inequalities in one variable, including linear and quadratic functions, and simple radical and exponential functions"
  )
 ("S-ID.1-4"
  "The student uses data summary techniques to aid interpretation of a single count or measurement variable"
  "1. plots on the real number line (dot plots, histograms, and box plots) to represent data"
  "2. comparison of two or more different data sets by measure of center (median, mean) and spread (interquartile range) appropriate to the shape of the data distribution"
  )
 ("S-ID.5-6"
  "The student uses data summary techniques to aid interpretation of two categorical and quantitative variables"
  "1. use of two-way frequency tables to summarize categorical data for two categories"
  "2. interpretation of relative frequencies in the context of the data (including joint, marginal, and conditional relative frequencies)"
  "3. identification of possible associations and trends in the data"
  "4. use of a scatter plot to represent data on two quantitative variables and describe how the variables are related"
  "5. use of a given linear, quadratic, or exponential function to match a function to the data"
  "6. use of functions fitted to data to solve problems in the context of the data"
  "7. informal assessment of the fit of a function by plotting and analyzing residuals"
  "8. determination of a linear function for a scatter plot that suggests a linear association"
  )
 ("S-ID.7-9"
  "The student interprets linear models representing data"
  "1. use of the context of the data to interpret the slope (rate of change) and the intercept (constant term) of a linear model"
  "2. use of technology to compute (using technology) and interpret the correlation coefficient of a linear fit"
  "3. identification of the difference between correlation and causation"
  )
 ("N-CN"
  "The student performs operations (addition, subtraction, and multiplication) with complex numbers"
  "1. use of the imaginary number i, such that i^2 = _1, to write complex numbers in the form a + bi with a and b real"
  "2. use of the commutative, associative, and distributive properties to add, subtract, and multiply complex numbers"
  )
 ("N-CN.7"
  "The student uses complex numbers in polynomial identities and equations"
  "1. solution of quadratic equations with real coefficients that have complex solutions"
  "2. solution of problems using equations and inequalities in one variable"
  "3. representation of relationships between two quantities by equations in two or more variables"
  "4. use of coordinate axes with labels and scales to graph equations"
  "5. use of problem constraints to interpret solutions as viable or nonviable in modeling an equation, inequality, or systems of equations and/or inequalities"
  "6. manipulation of a formula to solve for a specific variable to highlight a particular quantity of interest"
  )
 ("F-BF.1-2"
  "The student models a relationship between two quantities by building a function"
  "4. use of recursive and explicit formulas to write arithmetic and geometric sequences to model situations"
  "5. translation between recursive and explicit forms"
  )
 ("F-BF.3-4"
  "The student builds new functions from existing functions."
  "1. identification of the effect on the graph of replacing f(x) by f(x) + k, k f(x), f(kx), and f(x + k) for specific values of k (both positive and negative)"
  "2. determination of the value of k given a graph"
  "3. use of technology to experiment with cases to illustrate and explain the effect algebraic changes have on the graph of a function"
  "4. inversion of a function"
  "5. solution of an equation of the form f(x) = c for a simple function f that has an inverse in order to write the inverse"
  )
 ("F-TF.1-2"
  "The student uses the unit circle to extend the domain of trigonometric functions"
  "1. use of radian measure to represent the length of the arc on the unit circle subtended by the angle"
  "2. extension of trigonometric functions to all real numbers using the unit circle in the coordinate plane"
  "3 interpretation of radian measures as angles traversed counterclockwise around the unit circle"
  )
 ("F-TF.5"
  "The student models periodic phenomena with trigonometric functions"
  "1. selection of trigonometric functions that model periodic phenomena with specified amplitude, frequency, and midline"
  )
 ("F-TF.8"
  "The student uses trigonometric identities in proofs and application"
  "1. use of the Pythagorean identity sin2(_) + cos2(_) = 1 to find sin(_), cos(_), or tan(_) given sin(_), cos(_), or tan(_) and the quadrant of the angle"
  )
 ("G-GPE.1-2"
  "The student translates between the geometric description and the equation for a conic section"
  "3. use of a given focus and directrix to derive the equation of a parabola"
  )
 ("S-IC.1-2"
  "The student evaluates random processes underlying statistical experiments"
  "1. explanation of statistics as a process for making inferences about population parameters based on a random sample from that population"
  "2. determination whether a specified model is consistent with results from a given data-generating process"
  )
 ("S-IC.3-6"
  "The student makes justifiable inferences from sample surveys, experiments, and observational studies"
  "1. identification of the purposes of and differences among sample surveys, experiments, and observational studies"
  "2. explanation of how randomization relates to sample surveys, experiments, and observational studies"
  "3. use of data from a sample survey to estimate a population mean or proportion"
  "4. use of simulation models for random sampling to develop a margin of error"
  "5. use of data from a randomized experiment to compare two treatments"
  "6. use of simulations to decide if differences between parameters are significant"
  "7. evaluation of reports based on data"
  )
 ("S-CP.1-5"
  "The student uses independence and conditional probability to interpret data"
  "1. description of events as subsets of a sample space (the set of outcomes) using characteristics (or categories) of the outcomes"
  "2. use of unions, intersections, or complements to describe events"
  "3. determination of whether two events A and B are independent by identifying the probability of A and B occurring together as the product of their individual probabilities"
  "4. identification of conditional probability of A given B as P(A and B)/P(B)"
  "5. interpretation of independence of A and B as saying that the conditional probability of A given B is the same as the probability of A, and the conditional probability of B given A is the same as the probability of B"
  "6. construction and interpretation of two-way frequency tables of data when two categories are associated with each object being classified"
  "7. use of the two-way table as a sample space to decide if events are independent and to approximate conditional probabilities"
  "8. use of everyday language and situations to explain the concepts of conditional probability and independence"
  )
 ("S-CP.6-7"
  "The student computes probabilities of compound events in a uniform probability model using the rules of probability"
  "1. determination of the conditional probability of A given B as the fraction of B's outcomes that also belong to A, and interpret the answer in terms of the model"
  "2. determination of the conditional probability of A given B as the fraction of B's outcomes that also belong to A, and interpret the answer in terms of the model."
  )
 ("HSS.ID.A"
  "Summarize, represent, and interpret data on a single count or measurement variable"
  "Represent data with plots on the real number line (dot plots, histograms, and box plots)."
  "Use statistics appropriate to the shape of the data distribution to compare center (median, mean) and spread (interquartile range, standard deviation) of two or more different data sets."
  "Interpret differences in shape, center, and spread in the context of the data sets, accounting for possible effects of extreme data points (outliers)."
  "Use the mean and standard deviation of a data set to fit it to a normal distribution and to estimate population percentages. Recognize that there are data sets for which such a procedure is not appropriate. Use calculators, spreadsheets, and tables to estimate areas under the normal curve."
  )
 ("HSS.ID.B"
  "Summarize, represent, and interpret data on two categorical and quantitative variables"
  "Summarize categorical data for two categories in two-way frequency tables. Interpret relative frequencies in the context of the data (including joint, marginal, and conditional relative frequencies). Recognize possible associations and trends in the data."
  "Represent data on two quantitative variables on a scatter plot, and describe how the variables are related."
  "Fit a function to the data; use functions fitted to data to solve problems in the context of the data. Use given functions or choose a function suggested by the context. Emphasize linear, quadratic, and exponential models."
  "Informally assess the fit of a function by plotting and analyzing residuals."
  "Fit a linear function for a scatter plot that suggests a linear association."
  )
 ("HSS.ID.C"
  "Interpret linear models"
  "Interpret the slope (rate of change) and the intercept (constant term) of a linear model in the context of the data."
  "Compute (using technology) and interpret the correlation coefficient of a linear fit."
  "Distinguish between correlation and causation."
  )
 ("HSS.IC.A"
  "Understand and evaluate random processes underlying statistical experiments"
  "Understand statistics as a process for making inferences about population parameters based on a random sample from that population."
  "Decide if a specified model is consistent with results from a given data-generating process, e.g., using simulation. For example, a model says a spinning coin falls heads up with probability 0.5. Would a result of 5 tails in a row cause you to question the model?"
  )
 ("HSS.IC.B"
  "Make inferences and justify conclusions from sample surveys, experiments, and observational studies"
  "Recognize the purposes of and differences among sample surveys, experiments, and observational studies; explain how randomization relates to each."
  "Use data from a sample survey to estimate a population mean or proportion; develop a margin of error through the use of simulation models for random sampling."
  "Use data from a randomized experiment to compare two treatments; use simulations to decide if differences between parameters are significant."
  "Evaluate reports based on data."
  )
 ("BS-M"
  "The student models a problem in context and determines the data needed to describe the problem"
  "identifying which quantities are fixed and which are variable"
  "identifying the datatype of a given quantity, in context"
  "identifying the difference between types and values"
  )
 ("BS-CE"
  "The student translates between structured expressions as arithmetic, code, and Circles of Evaluation"
  "translating a simple (1-operation) equation into a Circle of Evaluation"
  "translating a nested (multi-operation) equation into a Circle of Evaluation"
  "translating a Circle of Evaluation into its equivalent arithmetic expression"
  "translating a Circle of Evaluation into its equivalent programming syntax"
  )
 ("BS-IDE"
  "The student is familiar with using a REPL, entering expressions properly, and interpreting error messages"
  "enter and evaluate expressions on the computer"
  "look to error messages as a way of diagnosing syntax errors"
  )
 ("BS-PL.1"
  "The student is familiar with declaring values and applying built-in functions using the programming language"
  "representing (numeric, string, boolean, image, etc) values in the programming language"
  "interpreting a function application and identifying its arguments"
  )
 ("BS-PL.2"
  "The student is comfortable using and writing Contracts for built-in functions"
  "representing a function's input and output using a contract"
  "using a function by refering to its contract"
  )
 ("BS-PL.3"
  "The student is able to use the syntax of the programming language to define values and functions"
  "defining and retrieving values"
  "writing test cases"
  "defining and using functions"
  )
 ("BS-PL.4"
  "The student is familiar with the syntax for conditionals"
  "defining and using functions than involve conditionals"
  )
 ("BS-DR.1"
  "The student is able to translate a word problem into a Contract and Purpose Statement"
  "given a word problem, identify the domain and range of a function"
  "given a word problem, write a Purpose Statement (i.e. - rewrite the problem in their own words)"
  )
 ("BS-DR.2"
  "The student can derive test cases for a given contract and purpose statement"
  "given a Contract and a Purpose Statement, write multiple examples or test cases"
  "identifying correct and incorrect test cases for a function, based on its contract"
  "given multiple examples, identify patterns in order to label and name the variables"
  )
 ("BS-DR.3"
  "Given multiple test cases, the student can define a function"
  "given examples and labeled variable(s), define the function"
  "identifying correct and incorrect definitions for a function, based on its test cases"
  )
 ("BS-DR.4"
  "The student can solve word problems that involve data structures"
  "write examples for a function that prodiuces a data structure"
  "write functions that produce data structures"
  "write piecewise functions that consume and produce data structures"
  )
 ("BS-DS.1"
  "The student is able to read data blocks"
  "given a data block, identify that it is a data structure"
  "given a data block, identify the constructor function and dot-accessors"
  "given a data block, identify the correct datatypes for each field of that structure"
  "given a data block, create instances of the data structure"
  "given a data block, use dot-accessors to access fields of the data structure"
  )
 ("BS-DS.2"
  "The student is able to solve problems using data structures"
  "identify problems that require use of a data structure"
  "given a problem, define a data structure"
  "add fields to a pre-existing data structure"
  )
 ("BS-R"
  "The student is able to write interactive programs using the 'Reactor' construct"
  "identify how an updating function changes a data structure"
  "identify how a drawing function creates a static image"
  "identify how a reactor uses drawing and updating functions to create an animation"
  "identify how functions work together to create and maintain a complex program"
  "modify parts of a complex program by altering functions or data structures"
  )
 ("BS-PL.P"
  "The Student is comfortable using the Pyret syntax for the Design Recipe"
  )
 ("111.47.4"
  "Categorical and quantitative data. The student applies the mathematical process standards to represent and analyze both categorical and quantitative data."
  "Distinguish between categorical and quantitative data"
  "Represent and summarize data and justify the representation"
  "Analyze the distribution characteristics of quantitative data, including determining the possible existence and impact of outliers"
  "Compare and contrast different graphical or visual representations given the same data set"
  )
 ("111.47.7"
  "Bivariate data. The student applies the mathematical process standards to analyze relationships among bivariate quantitative data."
  "Analyze scatterplots for patterns, linearity, outliers, and influential points"
  )
 ("Creativity 1.1.1"
  "Apply a creative development process when creating computational artifacts."
  "A creative process in the development of a computational artifact can include, but is not limited to, employing nontraditional, nonprescribed techniques; the use of novel combinations of artifacts, tools, and techniques; and the exploration of personal curiosities."
  "Creating computational artifacts employs an iterative and often exploratory process to translate ideas into tangible form."
  )
 ("Creativity 1.2.1"
  "Create a computational artifact for creative expression."
  "A computational artifact is anything created by a human using a computer and can be, but is not limited to, a program, an image, audio, video, a presentation, or a web page file."
  "Creating computational artifacts requires understanding and using software tools and services."
  "Computing tools and techniques are used to create computational artifacts and can include, but are not limited to, programming IDEs, spreadsheets, 3D printers, or text editors."
  "A creatively developed computational artifact can be created by using nontraditional, nonprescribed computing techniques."
  "Creative expressions in a computational artifact can reflect personal expressions of ideas or interests."
  )
 ("Creativity 1.2.2"
  "Create a computational artifact using computing tools and techniques to solve a problem."
  "Computing tools and techniques can enhance the process of finding a solution to a problem."
  "A creative development process for creating computational artifacts can be used to solve problems when traditional or prescribed computing techniques are not effective."
  )
 ("Creativity 1.2.3"
  "Create a new computational artifact by combining or modifying existing artifacts."
  "Creating computational artifacts can be done by combining and modifying existing artifacts or by creating new artifacts."
  "Computation facilitates the creation and modification of computational artifacts with enhanced detail and precision."
  "Combining or modifying existing artifacts can show personal expression of ideas."
  )
 ("Creativity 1.2.4"
  "Collaborate in the creation of computational artifacts."
  "A collaboratively created computational artifact reflects effort by more than one person."
  "Effective collaborative teams consider the use of online collaborative tools."
  "Effective collaborative teams practice interpersonal communication, consensus building, conflict resolution, and negotiation."
  "Effective collaboration strategies enhance performance."
  "Collaboration facilitates the application of multiple perspectives (including sociocultural perspectives) and diverse talents and skills in developing computational artifacts."
  "A collaboratively created computational artifact can reflect personal expressions of ideas."
  )
 ("Creativity 1.2.5"
  "Analyze the correctness, usability, functionality, and suitability of computational artifacts."
  "The context in which an artifact is used determines the correctness, usability, functionality, and suitability of the artifact."
  "A computational artifact may have weaknesses, mistakes, or errors depending on the type of artifact."
  "The functionality of a computational artifact may be related to how it is used or perceived."
  "The suitability (or appropriateness) of a computational artifact may be related to how it is used or perceived."
  )
 ("Creativity 1.3.1"
  "Use computing tools and techniques for creative expression."
  "Creating digital effects, images, audio, video, and animations has transformed industries."
  "Digital audio and music can be created by synthesizing sounds, sampling existing audio and music, and recording and manipulating sounds, including layering and looping."
  "Digital images can be created by generating pixel patterns, manipulating existing digital images, or combining images."
  "Digital effects and animations can be created by using existing software or modified software that includes functionality to implement the effects and animations."
  "Computing enables creative exploration of both real and virtual phenomena."
  )
 ("Abstraction 2.1.1"
  "Describe the variety of abstractions used to represent data."
  "Digital data is represented by abstractions at different levels."
  "At the lowest level, all digital data are represented by bits."
  "At a higher level, bits are grouped to represent abstractions, including but not limited to numbers, characters, and color."
  "Number bases, including binary, decimal, and hexadecimal, are used to represent and investigate digital data."
  "At one of the lowest levels of abstraction, digital data is represented in binary (base 2) using only combinations of the digits zero and one."
  "Hexadecimal (base 16) is used to represent digital data because hexadecimal representation uses fewer digits than binary."
  "Numbers can be converted from any base to any other base."
  )
 ("Abstraction 2.1.2"
  "Explain how binary sequences are used to represent digital data."
  "A finite representation is used to model the infinite mathematical concept of a number."
  "In many programming languages, the fixed number of bits used to represent characters or integers limits the range of integer values and mathematical operations; this limitation can result in overflow or other errors.",,,"
"Exclusion Statement (2.1.2B): Range limitations of any one language, compiler, or architecture are beyond the scope of this course and the AP Exam."
"In many programming languages, the fixed number of bits used to represent real numbers (as floating-point numbers) limits the range of floating- point values and mathematical operations; this limitation can result in round-off and other errors."
  "The interpretation of a binary sequence depends on how it is used."
  "A sequence of bits may represent instructions or data."
  "A sequence of bits may represent different types of data in different contexts."
  )
 ("Abstraction 2.2.1"
  "Develop an abstraction when writing a program or creating other computational artifacts."
  "The process of developing an abstraction involves removing detail and generalizing functionality."
  "An abstraction extracts common features from specific examples in order to generalize concepts."
  "An abstraction generalizes functionality with input parameters that allow software reuse."
  )
 ("Abstraction 2.2.2"
  "Use multiple levels of abstraction to write programs."
  "Software is developed using multiple levels of abstractions, such as constants, expressions, statements, procedures, and libraries."
  "Being aware of and using multiple levels of abstraction in developing programs helps to more effectively apply available resources and tools to solve problems."
  )
 ("Abstraction 2.2.3"
  "Identify multiple levels of abstractions that are used when writing programs."
  "Different programming languages offer different levels of abstraction."
  "High-level programming languages provide more abstractions for the programmer and make it easier for people to read and write a program."
  "Code in a programming language is often translated into code in another (lower-level) language to be executed on a computer."
  "In an abstraction hierarchy, higher levels of abstraction (the most general concepts) would be placed toward the top and lower-level abstractions (the more specific concepts) toward the bottom."
  "Binary data is processed by physical layers of computing hardware, including gates, chips, and components."
  "A logic gate is a hardware abstraction that is modeled by a Boolean function."
  "A chip is an abstraction composed of low- level components and circuits that perform a specific function."
  "A hardware component can be low level like a transistor or high level like a video card."
  "Hardware is built using multiple levels of abstractions, such as transistors, logic gates, chips, memory, motherboards, special purposes cards, and storage devices."
  "Applications and systems are designed, developed, and analyzed using levels of hardware, software, and conceptual abstractions."
  "Lower-level abstractions can be combined to make higher-level abstractions, such as short message services (SMS) or email messages, images, audio files, and videos"
  )
 ("Abstraction 2.3.1"
  "Use models and simulations to represent phenomena."
  "Models and simulations are simplified representations of more complex objects or phenomena."
  "Models may use different abstractions or levels of abstraction depending on the objects or phenomena being posed."
  "Models often omit unnecessary features of the objects or phenomena that are being modeled."
  "Simulations mimic real-world events without the cost or danger of building and testing the phenomena in the real world."
  )
 ("Abstraction 2.3.2"
  "Use models and simulations to formulate, refine, and test hypotheses."
  "Models and simulations facilitate the formulation and refinement of hypotheses related to the objects or phenomena under consideration."
  "Hypotheses are formulated to explain the objects or phenomena being modeled."
  "Hypotheses are refined by examining the insights that models and simulations provide into the objects or phenomena."
  "The results of simulations may generate new knowledge and new hypotheses related to the phenomena being modeled."
  "Simulations allow hypotheses to be tested without the constraints of the real world."
  "Simulations can facilitate extensive and rapid testing of models."
  "The time required for simulations is impacted by the level of detail and quality of the models, and the software and hardware used for the simulation."
  "Rapid and extensive testing allows models to be changed to accurately reflect the objects or phenomena being modeled."
  )
 ("Data 3.1.1"
  "Use computers to process information, find patterns, and test hypotheses about digitally processed information to gain insight and knowledge. [P4]"
  "Computers are used in an iterative and interactive way when processing digital information to gain insight and knowledge."
  "Digital information can be filtered and cleaned by using computers to process information."
  "Combining data sources, clustering data, and data classification are part of the process of using computers to process information."
  "Insight and knowledge can be obtained from translating and transforming digitally represented information."
  "Patterns can emerge when data is transformed using computational tools."
  )
 ("Data 3.1.2"
  "Collaborate when processing information to gain insight and knowledge."
  "Collaboration is an important part of solving data-driven problems."
  "Collaboration facilitates solving computational problems by applying multiple perspectives, experiences, and skill sets."
  "Communication between participants working on data-driven problems gives rise to enhanced insights and knowledge."
  "Collaboration in developing hypotheses and questions, and in testing hypotheses and answering questions, about data helps participants gain insight and knowledge."
  "Collaborating face-to-face and using online collaborative tools can facilitate processing information to gain insight and knowledge."
  "Investigating large data sets collaboratively can lead to insight and knowledge not obtained when working alone."
  )
 ("Data 3.1.3"
  "Explain the insight and knowledge gained from digitally processed data by using appropriate visualizations, notations, and precise language."
  "Visualization tools and software can communicate information about data."
  "Tables, diagrams, and textual displays can be used in communicating insight and knowledge gained from data."
  "Summaries of data analyzed computationally can be effective in communicating insight and knowledge gained from digitally represented information."
  "Transforming information can be effective in communicating knowledge gained from data."
  "Interactivity with data is an aspect of communicating."
  )
 ("Data 3.2.1"
  "Extract information from data to discover and explain connections, patterns, or trends."
  "Large data sets provide opportunities and challenges for extracting information and knowledge."
  "Large data sets provide opportunities for identifying trends, making connections in data, and solving problems."
  "Computing tools facilitate the discovery of connections in information within large data sets."
  "Search tools are essential for efficiently finding information."
  "Information filtering systems are important tools for finding information and recognizing patterns in the information."
  "Software tools, including spreadsheets and databases, help to efficiently organize and find trends in information."
  "Metadata is data about data."
  "Metadata can be descriptive data about an image, a Web page, or other complex objects."
  "Metadata can increase the effective use of data or data sets by providing additional information about various aspects of that data."
  )
 ("Data 3.2.2"
  "Use large data sets to explore and discover information and knowledge."
  "Large data sets include data such as transactions, measurements, text, sound, images, and video."
  "The storing, processing, and curating of large data sets is challenging."
  "Structuring large data sets for analysis can be challenging."
  "Maintaining privacy of large data sets containing personal information can be challenging."
  "Scalability of systems is an important consideration when data sets are large."
  "The size or scale of a system that stores data affects how that data set is used."
  "The effective use of large data sets requires computational solutions."
  "Analytical techniques to store, manage, transmit, and process data sets change as the size of data sets scale."
  )
 ("Data 3.3.1"
  "Analyze how data representation, storage, security, and transmission of data involve computational manipulation of information."
  "Digital data representations involve trade- offs related to storage, security, and privacy concerns."
  "Security concerns engender trade-offs in storing and transmitting information."
  "There are trade-offs in using lossy and lossless compression techniques for storing and transmitting data."
  "Lossless data compression reduces the number of bits stored or transmitted but allows complete reconstruction of the original data."
  "Lossy data compression can significantly reduce the number of bits stored or transmitted at the cost of being able to reconstruct only an approximation of the original data."
  "Security and privacy concerns arise with data containing personal information."
  "Data is stored in many formats depending on its characteristics (e.g., size and intended use)."
  "The choice of storage media affects both the methods and costs of manipulating the data it contains."
  "Reading data and updating data have different storage requirements."
  )
 ("Algorithms 4.1.1"
  "Develop an algorithm for implementation in a program."
  "Sequencing, selection, and iteration are building blocks of algorithms."
  "Sequencing is the application of each step of an algorithm in the order in which the statements are given."
  "Selection uses a Boolean condition to determine which of two parts of an algorithm is used."
  "Iteration is the repetition of part of an algorithm until a condition is met or for a specified number of times."
  "Algorithms can be combined to make new algorithms."
  "Using existing correct algorithms as building blocks for constructing a new algorithm helps ensure the new algorithm is correct."
  "Knowledge of standard algorithms can help in constructing new algorithms."
  "Different algorithms can be developed to solve the same problem."
  "Developing a new algorithm to solve a problem can yield insight into the problem."
  )
 ("Algorithms 4.1.2"
  "Express an algorithm in a language."
  "Languages for algorithms include natural language, pseudocode, and visual and textual programming languages."
  "Natural language and pseudocode describe algorithms so that humans can understand them."
  "Algorithms described in programming languages can be executed on a computer."
  "Different languages are better suited for expressing different algorithms."
  "Some programming languages are designed for specific domains and are better for expressing algorithms in those domains."
  "The language used to express an algorithm can affect characteristics such as clarity or readability but not whether an algorithmic solution exists."
  "Every algorithm can be constructed using only sequencing, selection, and iteration."
  "Nearly all programming languages are equivalent in terms of being able to express any algorithm."
  "Clarity and readability are important considerations when expressing an algorithm in a language."
  )
 ("Algorithms 4.2.1"
  "Explain the difference between algorithms that run in a reasonable time and those that do not run in a reasonable time."
  "Many problems can be solved in a reasonable time."
  "Reasonable time means that as the input size grows, the number of steps the algorithm takes is proportional to the square (or cube, fourth power, fifth power, etc.) of the size of the input."
  "Some problems cannot be solved in a reasonable time, even for small input sizes."
  "Some problems can be solved but not in a reasonable time. In these cases, heuristic approaches may be helpful to find solutions in reasonable time."
  )
 ("Algorithms 4.2.2"
  "Explain the difference between solvable and unsolvable problems in computer science. ,A heuristic is a technique that may allow us to find an approximate solution when typical methods fail to find an exact solution."
  "Heuristics may be helpful for finding an approximate solution more quickly when exact methods are too slow."
  "Some optimization problems such as _find the bestŠ— or _find the smallestŠ— cannot be solved in a reasonable time, but approximations to the optimal solution can."
  "Some problems cannot be solved using any algorithm."
  )
 ("Algorithms 4.2.3"
  "Explain the existence of undecidable problems in computer science."
  "An undecidable problem may have instances that have an algorithmic solution, but there is no algorithmic solution that solves all instances of the problem."
  "A decidable problem is one in which an algorithm can be constructed to answer _yesŠ— or _noŠ— for all inputs (e.g., _is the number even?Š—)."
  "An undecidable problem is one in which no algorithm can be constructed that always leads to a correct yes-or-no answer."
  )
 ("Algorithms 4.2.4"
  "Evaluate algorithms analytically and empirically for efficiency, correctness, and clarity."
  "Determining an algorithm‹ês efficiency is done by reasoning formally or mathematically about the algorithm."
  "Empirical analysis of an algorithm is done by implementing the algorithm and running it on different inputs."
  "The correctness of an algorithm is determined by reasoning formally or mathematically about the algorithm, not by testing an implementation of the algorithm."
  "Different correct algorithms for the same problem can have different efficiencies."
  "Sometimes more efficient algorithms are more complex."
  "Finding an efficient algorithm for a problem can help solve larger instances of the problem."
  "Efficiency includes both execution time and memory usage."
  "Linear search can be used when searching for an item in any list; binary search can be used only when the list is sorted."
  )
 ("Programming 5.1.1"
  "Develop a program for creative expression, to satisfy personal curiosity, or to create new knowledge."
  "Programs are developed and used in a variety of ways by a wide range of people depending on the goals of the programmer."
  "Programs developed for creative expression, to satisfy personal curiosity, or to create new knowledge may have visual, audible, or tactile inputs and outputs."
  "Programs developed for creative expression, to satisfy personal curiosity, or to create new knowledge may be developed with different standards or methods than programs developed for widespread distribution."
  "Additional desired outcomes may be realized independently of the original purpose of the program."
  "A computer program or the results of running a program may be rapidly shared with a large number of users and can have widespread impact on individuals, organizations, and society."
  "Advances in computing have generated and increased creativity in other fields."
  )
 ("Programming 5.1.2"
  "Develop a correct program to solve problems."
  "An iterative process of program development helps in developing a correct program to solve problems."
  "Developing correct program components and then combining them helps in creating correct programs."
  "Incrementally adding tested program segments to correct, working programs helps create large correct programs."
  "Program documentation helps programmers develop and maintain correct programs to efficiently solve problems."
  "Documentation about program components, such as blocks and procedures, helps in developing and maintaining programs."
  "Documentation helps in developing and maintaining programs when working individually or in collaborative programming environments."
  "Program development includes identifying programmer and user concerns that affect the solution to problems."
  "Consultation and communication with program users is an important aspect of program development to solve problems."
  "A programmer‹ês knowledge and skill affects how a program is developed and how it is used to solve a problem."
  "A programmer designs, implements, tests, debugs, and maintains programs when solving problems."
  )
 ("Programming 5.1.3"
  "Collaborate to develop a program."
  "Collaboration can decrease the size and complexity of tasks required of individual programmers."
  "Collaboration facilitates multiple perspectives in developing ideas for solving problems by programming."
  "Collaboration in the iterative development of a program requires different skills than developing a program alone."
  "Collaboration can make it easier to find and correct errors when developing programs."
  "Collaboration facilitates developing program components independently."
  "Effective communication between participants is required for successful collaboration when developing programs."
  )
 ("Programming 5.2.1"
  "Explain how programs implement algorithms."
  "Algorithms are implemented using program instructions that are processed during program execution."
  "Program instructions are executed sequentially."
  "Program instructions may involve variables that are initialized and updated, read, and written."
  "An understanding of instruction processing and program execution is useful for programming."
  "Program execution automates processes."
  "Processes use memory, a central processing unit (CPU), and input and output."
  "A process may execute by itself or with other processes."
  "A process may execute on one or several CPUs."
  "Executable programs increase the scale of problems that can be addressed."
  "Simple algorithms can solve a large set of problems when automated."
  "Improvements in algorithms, hardware, and software increase the kinds of problems and the size of problems solvable by programming."
  )
 ("Programming 5.3.1"
  "Use abstraction to manage complexity in programs. ,Procedures are reusable programming abstractions."
  "A function is a named grouping of programming instructions."
  "Procedures reduce the complexity of writing and maintaining programs."
  "Procedures have names and may have parameters and return values."
  "Parameterization can generalize a specific solution."
  "Parameters generalize a solution by allowing a function to be used instead of duplicated code."
  "Parameters provide different values as input to procedures when they are called in a program."
  "Data abstraction provides a means of separating behavior from implementation."
  "Strings and string operations, including concatenation and some form of substring, are common in many programs."
  "Integers and floating-point numbers are used in programs without requiring understanding of how they are implemented."
  "Lists and list operations, such as add, remove, and search, are common in many programs."
  "Using lists and procedures as abstractions in programming can result in programs that are easier to develop and maintain."
  "Application program interfaces (APIs) and libraries simplify complex programming tasks."
  "Documentation for an API/library is an important aspect of programming."
  "APIs connect software components, allowing them to communicate."
  )
 ("Programming 5.4.1"
  "Evaluate the correctness of a program."
  "Program style can affect the determination of program correctness."
  "Duplicated code can make it harder to reason about a program."
  "Meaningful names for variables and procedures help people better understand programs."
  "Longer code blocks are harder to reason about than shorter code blocks in a program."
  "Locating and correcting errors in a program is called debugging the program."
  "Knowledge of what a program is supposed to do is required in order to find most program errors."
  "Examples of intended behavior on specific inputs help people understand what a program is supposed to do."
  "Visual displays (or different modalities) of program state can help in finding errors."
  "Programmers justify and explain a program‹ês correctness."
  "Justification can include a written explanation about how a program meets its specifications."
  "Correctness of a program depends on correctness of program components, including code blocks and procedures."
  "An explanation of a program helps people understand the functionality and purpose of it."
  "The functionality of a program is often described by how a user interacts with it."
  "The functionality of a program is best described at a high level by what the program does, not at the lower level of how the program statements work to accomplish this."
  )
 ("Programming 5.5.1"
  "Employ appropriate mathematical and logical concepts in programming. ,Numbers and numerical concepts are fundamental to programming."
  "Integers may be constrained in the maximum and minimum values that can be represented in a program because of storage limitations."
  "Real numbers are approximated by floating- point representations that do not necessarily have infinite precision."
  "Mathematical expressions using arithmetic operators are part of most programming languages."
  "Logical concepts and Boolean algebra are fundamental to programming."
  "Compound expressions using and, or, and not are part of most programming languages."
  "Intuitive and formal reasoning about program components using Boolean concepts helps in developing correct programs."
  "Computational methods may use lists and collections to solve problems."
  "Lists and other collections can be treated as abstract data types (ADTs) in developing programs."
  "Basic operations on collections include adding elements, removing elements, iterating over all elements, and determining whether an element is in a collection."
  )
 ("Internet 6.1.1"
  "Explain the abstractions in the Internet and how the Internet functions."
  "The Internet connects devices and networks all over the world."
  "An end-to-end architecture facilitates connecting new devices and networks on the Internet."
  "Devices and networks that make up the Internet are connected and communicate using addresses and protocols."
  "The Internet and the systems built on it facilitate collaboration."
  "Connecting new devices to the Internet is enabled by assignment of an Internet protocol (IP) address."
  "The Internet is built on evolving standards, including those for addresses and names."
  "The domain name system (DNS) translates names to IP addresses."
  "The number of devices that could use an IP address has grown so fast that a new protocol (IPv6) has been established to handle routing of many more devices."
  "Standards such as hypertext transfer protocol (HTTP), IP, and simple mail transfer protocol (SMTP) are developed and overseen by the Internet Engineering Task Force (IETF)."
  )
 ("Internet 6.2.1"
  "Explain characteristics of the Internet and the systems built on it."
  "The Internet and the systems built on it are hierarchical and redundant."
  "The domain name syntax is hierarchical."
  "IP addresses are hierarchical."
  "Routing on the Internet is fault tolerant and redundant."
  )
 ("Internet 6.2.2"
  "Explain how the characteristics of the Internet influence the systems built on it."
  "Hierarchy and redundancy help systems scale."
  "The redundancy of routing (i.e., more than one way to route data) between two points on the Internet increases the reliability of the Internet and helps it scale to more devices and more people."
  "Hierarchy in the DNS helps that system scale."
  "Interfaces and protocols enable widespread use of the Internet."
  "Open standards fuel the growth of the Internet."
  "The Internet is a packet-switched system through which digital data is sent by breaking the data into blocks of bits called packets, which contain both the data being transmitted and control information for routing the data."
  "Standards for packets and routing include transmission control protocol/Internet protocol (TCP/IP)."
  "Standards for sharing information and communicating between browsers and servers on the Web include HTTP and secure sockets layer/transport layer security (SSL/TLS)."
  "The size and speed of systems affect their use."
  "The bandwidth of a system is a measure of bit rate Š—¾ the amount of data (measured in bits) that can be sent in a fixed amount of time."
  "The latency of a system is the time elapsed between the transmission and the receipt of a request."
  )
 ("Internet 6.3.1"
  "Identify existing cybersecurity concerns and potential options to address these issues with the Internet and the systems built on it. ,The trust model of the Internet involves trade-offs."
  "The domain name system (DNS) was not designed to be completely secure."
  "Implementing cybersecurity has software, hardware, and human components."
  "Cyber warfare and cyber crime have widespread and potentially devastating effects."
  "Distributed denial-of-service attacks (DDoS) compromise a target by flooding it with requests from multiple systems."
  "Phishing, viruses, and other attacks have human and software components."
  "Antivirus software and firewalls can help prevent unauthorized access to private data."
  "Cryptography is essential to many models of cybersecurity."
  "Cryptography has a mathematical foundation."
  "Open standards help ensure cryptography is secure."
  "Symmetric encryption is a method of encryption involving one key for encryption and decryption."
  "Public key encryption, which is not symmetric, is an encryption method that is widely used because of the enhanced security associated with its use."
  "Certificate authorities (CAs) issue digital certificates that validate the ownership of encrypted keys used in secured communication and are based on a trust model."
  )
 ("Global Impact 7.1.1"
  "Explain how computing innovations affect communication, interaction, and cognition."
  "Email, short message service (SMS), and chat have fostered new ways to communicate and collaborate."
  "Video conferencing and video chat have fostered new ways to communicate and collaborate."
  "Social media continues to evolve and foster new ways to communicate."
  "Cloud computing fosters new ways to communicate and collaborate."
  "Widespread access to information facilitates the identification of problems, development of solutions, and dissemination of results."
  "Public data provides widespread access and enables solutions to identified problems."
  "Search trends are predictors."
  "Social media, such as blogs and Twitter, have enhanced dissemination."
  "Global Positioning System (GPS) and related technologies have changed how humans travel, navigate, and find information related to geolocation."
  "Sensor networks facilitate new ways of interacting with the environment and with physical systems."
  "Smart grids, smart buildings, and smart transportation are changing and facilitating human capabilities."
  "Computing contributes to many assistive technologies that enhance human capabilities."
  "The Internet and the Web have enhanced methods of and opportunities for communication and collaboration."
  "The Internet and the Web have changed many areas, including e-commerce, health care, access to information and entertainment, and online learning."
  "The Internet and the Web have impacted productivity, positively and negatively, in many areas."
  )
 ("Global Impact 7.1.2"
  "Explain how people participate in a problem- solving process that scales. ,Distributed solutions must scale to solve some problems."
  "Science has been impacted by using scale and _citizen scienceŠ— to solve scientific problems using home computers in scientific research."
  "Human computation harnesses contributions from many humans to solve problems related to digital data and the Web."
  "Human capabilities are enhanced by digitally enabled collaboration."
  "Some online services use the contributions of many people to benefit both individuals and society."
  "Crowdsourcing offers new models for collaboration, such as connecting people with jobs and businesses with funding."
  "The move from desktop computers to a proliferation of always-on mobile computers is leading to new applications."
  )
 ("Global Impact 7.2.1"
  "Explain how computing has impacted innovations in other fields."
  "Machine learning and data mining have enabled innovation in medicine, business, and science."
  "Scientific computing has enabled innovation in science and business."
  "Computing enables innovation by providing access to and sharing of information."
  "Open access and Creative Commons have enabled broad access to digital information."
  "Open and curated scientific databases have benefited scientific researchers."
  "Moore's law has encouraged industries that use computers to effectively plan future research and development based on anticipated increases in computing power."
  "Advances in computing as an enabling technology have generated and increased the creativity in other fields."
  )
 ("Global Impact 7.3.1"
  "Analyze the beneficial and harmful effects of computing."
  "Innovations enabled by computing raise legal and ethical concerns."
  "Commercial access to music and movie downloads and streaming raises legal and ethical concerns."
  "Access to digital content via peer-to-peer networks raises legal and ethical concerns."
  "Both authenticated and anonymous access to digital information raise legal and ethical concerns."
  "Commercial and governmental censorship of digital information raise legal and ethical concerns."
  "Open source and licensing of software and content raise legal and ethical concerns."
  "Privacy and security concerns arise in the development and use of computational systems and artifacts."
  "Aggregation of information, such as geolocation, cookies, and browsing history, raises privacy and security concerns."
  "Anonymity in online interactions can be enabled through the use of online anonymity software and proxy servers."
  "Technology enables the collection, use, and exploitation of information about, by, and for individuals, groups, and institutions."
  "People can have instant access to vast amounts of information online; accessing this information can enable the collection of both individual and aggregate data that can be used and collected."
  "Commercial and governmental curation of information may be exploited if privacy and other protections are ignored."
  "Targeted advertising is used to help individuals, but it can be misused at both individual and aggregate levels."
  "Widespread access to digitized information raises questions about intellectual property."
  "Creation of digital audio, video, and textual content by combining existing content has been impacted by copyright concerns."
  "The Digital Millennium Copyright Act (DMCA) has been a benefit and a challenge in making copyrighted digital material widely available."
  "Open source and free software have practical, business, and ethical impacts on widespread access to programs, libraries, and code."
  )
 ("Global Impact 7.4.1"
  "Explain the connections between computing and economic, social, and cultural contexts."
  "The innovation and impact of social media and online access is different in different countries and in different socioeconomic groups."
  "Mobile, wireless, and networked computing have an impact on innovation throughout the world."
  "The global distribution of computing resources raises issues of equity, access, and power."
  "Groups and individuals are affected by the \"digital divide\" -- differing access to computing and the internet based on socioeconomic or geographic characteristics."
  "Networks and infrastructure are supported by both commercial and governmental initiatives."
  )
 ("Global Impact 7.5.1,,Online databases and libraries catalog and house secondary and some primary sources."
  "Advance search tools, Boolean logic, and key words can refine the search focus and/or limit search results based on a variety of factors (e.g. data, peer-review status, types of publication)"
  "Plagiarism is a serious offense that occurs when a person presents another's ideas or words as his or her own. Plagiarism may be avoided by accurately acknowledgin sources."
  )
 ("Global Impact 7.5.2"
  ""
  "Determing the credibility of a source requires considering and evaluating the reputation and credentials of the author(s), publisher(s), site owner(s), and/or sponsor(s)."
  "Information from a source is considered relevant when it supports an appropriate claim or the purpose of the investigation."
  )
 ("2-CS-01"
  "Recommend improvements to the design of computing devices, based on an analysis of how users interact with the devices."
  )
 ("2-CS-02"
  "Design projects that combine hardware and software components to collect and exchange data."
  )
 ("2-CS-03"
  "Systematically identify and fix problems with computing devices and their components."
  )
 ("2-NI-04"
  "Model the role of protocols in transmitting data across networks and the Internet."
  )
 ("2-NI-05"
  "Explain how physical and digital security measures protect electronic information."
  )
 ("2-NI-06"
  "Apply multiple methods of encryption to model the secure transmission of information"
  )
 ("2-DA-07"
  "Represent data using multiple encoding schemes."
  )
 ("2-DA-08"
  "Collect data using computational tools and transform the data to make it more useful and reliable."
  )
 ("2-DA-09"
  "Refine computational models based on the data they have generated."
  )
 ("2-AP-10"
  "Use flowcharts and/or pseudocode to address complex problems as algorithms"
  )
 ("2-AP-11"
  "Create clearly named variables that represent different data types and perform operations on their values."
  )
 ("2-AP-12"
  "Design and iteratively develop programs that combine control structures, including nested loops and compound conditionals"
  )
 ("2-AP-13"
  "Decompose problems and subproblems into parts to facilitate the design, implementation, and review of programs"
  )
 ("2-AP-14"
  "Create procedures with parameters to organize code and make it easier to reuse."
  )
 ("2-AP-15"
  "Seek and incorporate feedback from team members and users to refine a solution that meets user needs."
  )
 ("2-AP-16"
  "Incorporate existing code, media, and libraries into original programs, and give attribution."
  )
 ("2-AP-17"
  "Systematically test and refine programs using a range of test cases"
  )
 ("2-AP-18"
  "Distribute tasks and maintain a project timeline when collaboratively developing computational artifacts."
  )
 ("2-AP-19"
  "Document programs in order to make them easier to follow, test, and debug."
  )
 ("2-IC-20"
  "Compare tradeoffs associated with computing technologies that affect people's everyday activities and career options."
  )
 ("2-IC-21"
  "Discuss issues of bias and accessibility in the design of existing technologies"
  )
 ("2-IC-22"
  "Collaborate with many contributors through strategies such as crowdsourcing or surveys when creating a computational artifact."
  )
 ("2-IC-23"
  "Describe tradeoffs between allowing information to be public and keeping information private and secure."
  )
 ("3A-CS-01"
  "Explain how abstractions hide the underlying implementation details of computing systems embedded in everyday objects."
  )
 ("3A-CS-02"
  "Compare levels of abstraction and interactions between application software, system software, and hardware layers"
  )
 ("3A-CS-03"
  "Develop guidelines that convey systematic troubleshooting strategies that others can use to identify and fix errors"
  )
 ("3A-NI-04"
  "Evaluate the scalability and reliability of networks, by describing the relationship between routers, switches, servers, topology, and addressing."
  )
 ("3A-NI-05"
  "Give examples to illustrate how sensitive data can be affected by malware and other attacks"
  )
 ("3A-NI-06"
  "Recommend security measures to address various scenarios based on factors such as efficiency, feasibility, and ethical impacts."
  )
 ("3A-NI-07"
  "Compare various security measures, considering tradeoffs between the usability and security of a computing system"
  )
 ("3A-NI-08"
  "Explain tradeoffs when selecting and implementing cybersecurity recommendations."
  )
 ("3A-DA-09"
  "Translate between different bit representations of real-world phenomena, such as characters, numbers, and images."
  )
 ("3A-DA-10"
  "Evaluate the tradeoffs in how data elements are organized and where data is stored."
  )
 ("3A-DA-11"
  "Create interactive data visualizations using software tools to help others better understand real-world phenomena."
  )
 ("3A-DA-12"
  "Create computational models that represent the relationships among different elements of data collected from a phenomenon or process."
  )
 ("3A-AP-13"
  "Create prototypes that use algorithms to solve computational problems by leveraging prior student knowledge and personal interests."
  )
 ("3A-AP-14"
  "Use lists to simplify solutions, generalizing computational problems instead of repeatedly using simple variables"
  )
 ("3A-AP-15"
  "Justify the selection of specific control structures when tradeoffs involve implementation, readability, and program performance, and explain the benefits and drawbacks of choices made."
  )
 ("3A-AP-16"
  "Design and iteratively develop computational artifacts for practical intent, personal expression, or to address a societal issue by using events to initiate instructions."
  )
 ("3A-AP-17"
  "Decompose problems into smaller components through systematic analysis, using constructs such as procedures, modules, and/or objects."
  )
 ("3A-AP-18"
  "Create artifacts by using procedures within a program, combinations of data and procedures, or independent but interrelated programs."
  )
 ("3A-AP-19"
  "Systematically design and develop programs for broad audiences by incorporating feedback from users"
  )
 ("3A-AP-20"
  "Evaluate licenses that limit or restrict use of computational artifacts when using resources such as libraries"
  )
 ("3A-AP-21"
  "Evaluate and refine computational artifacts to make them more usable and accessible."
  )
 ("3A-AP-22"
  "Design and develop computational artifacts working in team roles using collaborative tools"
  )
 ("3A-AP-23"
  "Document design decisions using text, graphics, presentations, and/or demonstrations in the development of complex programs."
  )
 ("3A-IC-24"
  "Evaluate the ways computing impacts personal, ethical, social, economic, and cultural practices"
  )
 ("3A-IC-25"
  "Test and refine computational artifacts to reduce bias and equity deficits."
  )
 ("3A-IC-26"
  "Demonstrate ways a given algorithm applies to problems across disciplines."
  )
 ("3A-IC-27"
  "Use tools and methods for collaboration on a project to increase connectivity of people in different cultures and career fields"
  )
 ("3A-IC-28"
  "Explain the beneficial and harmful effects that intellectual property laws can have on innovation."
  )
 ("3A-IC-29"
  "Explain the privacy concerns related to the collection and generation of data through automated processes that may not be evident to users."
  )
 ("3A-IC-30"
  "Evaluate the social and economic implications of privacy in the context of safety, law, or ethics."
  )
 ("3B-CS-01"
  "Categorize the roles of operating system software."
  )
 ("3B-CS-02"
  "Illustrate ways computing systems implement logic, input, and output through hardware components"
  )
 ("3B-NI-03"
  "Describe the issues that impact network functionality (e.g., bandwidth, load, delay, topology)."
  )
 ("3B-NI-04"
  "Compare ways software developers protect devices and information from unauthorized access."
  )
 ("3B-NI-05"
  "Use data analysis tools and techniques to identify patterns in data representing complex systems"
  )
 ("3B-NI-06"
  "Select data collection tools and techniques to generate data sets that support a claim or communicate information."
  )
 ("3B-NI-07"
  "Evaluate the ability of models and simulations to test and support the refinement of hypotheses."
  )
 ("3B-AP-08"
  "Describe how artificial intelligence drives many software and physical systems."
  )
 ("3B-AP-09"
  "Implement an artificial intelligence algorithm to play a game against a human opponent or solve a problem."
  )
 ("3B-AP-10"
  "Use and adapt classic algorithms to solve computational problems."
  )
 ("3B-AP-11"
  "Evaluate algorithms in terms of their efficiency, correctness, and clarity."
  )
 ("3B-AP-12"
  "Compare and contrast fundamental data structures and their uses."
  )
 ("3B-AP-13"
  "Illustrate the flow of execution of a recursive algorithm"
  )
 ("3B-AP-14"
  "Construct solutions to problems using student-created components, such as procedures, modules and/or objects."
  )
 ("3B-AP-15"
  "Analyze a large-scale computational problem and identify generalizable patterns that can be applied to a solution"
  )
 ("3B-AP-16"
  "Demonstrate code reuse by creating programming solutions using libraries and APIs."
  )
 ("3B-AP-17"
  "Plan and develop programs for broad audiences using a software life cycle process."
  )
 ("3B-AP-18"
  "Explain security issues that might lead to compromised computer programs"
  )
 ("3B-AP-19"
  "Develop programs for multiple computing platforms."
  )
 ("3B-AP-20"
  "Use version control systems, integrated development environments (IDEs), and collaborative tools and practices (code documentation) in a group software project."
  )
 ("3B-AP-21"
  "Develop and use a series of test cases to verify that a program performs according to its design specifications."
  )
 ("3B-AP-22"
  "Modify an existing program to add additional functionality and discuss intended and unintended implications (e.g., breaking other functionality)."
  )
 ("3B-AP-23"
  "Evaluate key qualities of a program through a process such as a code review"
  )
 ("3B-AP-24"
  "Compare multiple programming languages and discuss how their features make them suitable for solving different types of problems."
  )
 ("3B-IC-25"
  "Evaluate computational artifacts to maximize their beneficial effects and minimize harmful effects on society."
  )
 ("3B-IC-26"
  "Evaluate the impact of equity, access, and influence on the distribution of computing resources in a global society."
  )
 ("3B-IC-27"
  "Predict how computational innovations that have revolutionized aspects of our culture might evolve."
  )
 ("3B-IC-28"
  "Debate laws and regulations that impact the development and use of software."
  )
 ))
