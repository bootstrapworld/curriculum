let dictionaries = {
  "standards": {
    "CCSS-Math": {
      "5.OA.A": {
        "description": "Write and interpret numerical expressions.",
        "lessons": ["order-of-operations", ]
      },
      "5.OA.A.1": {
        "description": "Use parentheses, brackets, or braces in numerical expressions, and evaluate expressions with these symbols.",
        "lessons": ["order-of-operations", "translating", "computation", ]
      },
      "5.OA.A.2": {
        "description": "Write simple expressions that record calculations with numbers, and interpret numerical expressions without evaluating them.",
        "lessons": ["translating", "commutative-property", "associative-property", ]
      },
      "5.OA.B": {
        "description": "Analyze patterns and relationships.",
        "lessons": []
      },
      "5.OA.B.3": {
        "description": "Generate two numerical patterns using two given rules. Identify apparent relationships between corresponding terms. Form ordered pairs consisting of corresponding terms from the two patterns, and graph the ordered pairs on a coordinate plane.",
        "lessons": []
      },
      "5.NBT.A": {
        "description": "Understand the place value system.",
        "lessons": []
      },
      "5.NBT.A.1": {
        "description": "Recognize that in a multi-digit number, a digit in one place represents 10 times as much as it represents in the place to its right and 1/10 of what it represents in the place to its left.",
        "lessons": []
      },
      "5.NBT.A.2": {
        "description": "Explain patterns in the number of zeros of the product when multiplying a number by powers of 10, and explain patterns in the placement of the decimal point when a decimal is multiplied or divided by a power of 10. Use whole-number exponents to denote powers of 10.",
        "lessons": []
      },
      "5.NBT.A.3": {
        "description": "Read, write, and compare decimals to thousandths.",
        "lessons": []
      },
      "5.NBT.A.3.A": {
        "description": "Read and write decimals to thousandths using base-ten numerals, number names, and expanded form.",
        "lessons": []
      },
      "5.NBT.A.3.B": {
        "description": "Compare two decimals to thousandths based on meanings of the digits in each place, using >, =, and < symbols to record the results of comparisons.",
        "lessons": []
      },
      "5.NBT.A.4": {
        "description": "Use place value understanding to round decimals to any place.",
        "lessons": []
      },
      "5.MD.A": {
        "description": "Convert like measurements units within a given measurement system.",
        "lessons": []
      },
      "5.MD.A.1": {
        "description": "Convert among different-sized standard measurement units within a given measurement system (e.g., convert 5 cm to 0.05 m), and use these conversions in solving multi-step, real world problems.",
        "lessons": []
      },
      "5.MD.B": {
        "description": "Represent and interpret data.",
        "lessons": []
      },
      "5.MD.C": {
        "description": "Geometric measurement: understand concepts of volume.",
        "lessons": []
      },
      "5.MD.C.3": {
        "description": "Recognize volume as an attribute of solid figures and understand concepts of volume measurement.",
        "lessons": []
      },
      "5.MD.C.3.A": {
        "description": "A cube with side length 1 unit, called a \"unit cube,\" is said to have \"one cubic unit\" of volume, and can be used to measure volume.",
        "lessons": []
      },
      "5.MD.C.3.B": {
        "description": "A solid figure which can be packed without gaps or overlaps using n unit cubes is said to have a volume of n cubic units.",
        "lessons": []
      },
      "5.MD.C.4": {
        "description": "Measure volumes by counting unit cubes, using cubic cm, cubic in, cubic ft, and improvised units.",
        "lessons": []
      },
      "5.MD.C.5": {
        "description": "Relate volume to the operations of multiplication and addition and solve real world and mathematical problems involving volume.",
        "lessons": []
      },
      "5.MD.C.5.A": {
        "description": "Find the volume of a right rectangular prism with whole-number side lengths by packing it with unit cubes, and show that the volume is the same as would be found by multiplying the edge lengths, equivalently by multiplying the height by the area of the base. Represent threefold whole-number products as volumes, e.g., to represent the associative property of multiplication.",
        "lessons": []
      },
      "5.MD.C.5.B": {
        "description": "Apply the formulas V = l × w × h and V = b × h for rectangular prisms to find volumes of right rectangular prisms with whole-number edge lengths in the context of solving real world and mathematical problems.",
        "lessons": []
      },
      "5.MD.C.5.C": {
        "description": "Recognize volume as additive. Find volumes of solid figures composed of two non-overlapping right rectangular prisms by adding the volumes of the non-overlapping parts, applying this technique to solve real world problems.",
        "lessons": []
      },
      "5.G.A": {
        "description": "Graph points on the coordinate plane to solve real-world and mathematical problems.",
        "lessons": ["hoc-winter-parley", ]
      },
      "5.G.A.1": {
        "description": "Use a pair of perpendicular number lines, called axes, to define a coordinate system, with the intersection of the lines (the origin) arranged to coincide with the 0 on each line and a given point in the plane located by using an ordered pair of numbers, called its coordinates. Understand that the first number indicates how far to travel from the origin in the direction of one axis, and the second number indicates how far to travel in the direction of the second axis, with the convention that the names of the two axes and the coordinates correspond (e.g., x-axis and x-coordinate, y-axis and y-coordinate).",
        "lessons": ["coordinates", ]
      },
      "5.G.A.2": {
        "description": "Represent real world and mathematical problems by graphing points in the first quadrant of the coordinate plane, and interpret coordinate values of points in the context of the situation.",
        "lessons": ["hoc-winter-parley", ]
      },
      "5.G.B": {
        "description": "Classify two-dimensional figures into categories based on their properties.",
        "lessons": ["hoc-winter-parley", ]
      },
      "5.G.B.3": {
        "description": "Understand that attributes belonging to a category of two-dimensional figures also belong to all subcategories of that category.",
        "lessons": []
      },
      "5.G.B.4": {
        "description": "Classify two-dimensional figures in a hierarchy based on properties.",
        "lessons": []
      },
      "6.RP.A": {
        "description": "Understand ratio concepts and use ratio reasoning to solve problems.",
        "lessons": ["bar-and-pie-charts", "flags", ]
      },
      "6.RP.A.1": {
        "description": "Understand the concept of a ratio and use ratio language to describe a ratio relationship between two quantities.",
        "lessons": ["flags", ]
      },
      "6.RP.A.2": {
        "description": "Understand the concept of a unit rate a/b associated with a ratio a:b with b ≠ 0, and use rate language in the context of a ratio relationship.",
        "lessons": []
      },
      "6.RP.A.3": {
        "description": "Use ratio and rate reasoning to solve real-world and mathematical problems, e.g., by reasoning about tables of equivalent ratios, tape diagrams, double number line diagrams, or equations.",
        "lessons": ["hoc-data", ]
      },
      "6.RP.A.3.A": {
        "description": "Make tables of equivalent ratios relating quantities with whole-number measurements, find missing values in the tables, and plot the pairs of values on the coordinate plane. Use tables to compare ratios.",
        "lessons": []
      },
      "6.RP.A.3.B": {
        "description": "Solve unit rate problems including those involving unit pricing and constant speed.",
        "lessons": []
      },
      "6.RP.A.3.C": {
        "description": "Find a percent of a quantity as a rate per 100; solve problems involving finding the whole, given a part and the percent.",
        "lessons": []
      },
      "6.RP.A.3.D": {
        "description": "Use ratio reasoning to convert measurement units; manipulate and transform units appropriately when multiplying or dividing quantities.",
        "lessons": ["flags", ]
      },
      "6.NS.A": {
        "description": "Apply and extend previous understandings of multiplication and division to divide fractions by fractions.",
        "lessons": []
      },
      "6.NS.A.1": {
        "description": "Interpret and compute quotients of fractions, and solve word problems involving division of fractions by fractions, e.g., by using visual fraction models and equations to represent the problem.",
        "lessons": []
      },
      "6.NS.B": {
        "description": "Compute fluently with multi-digit numbers and find common factors and multiples.",
        "lessons": []
      },
      "6.NS.B.2": {
        "description": "Fluently divide multi-digit numbers using the standard algorithm.",
        "lessons": []
      },
      "6.NS.B.3": {
        "description": "Fluently add, subtract, multiply, and divide multi-digit decimals using the standard algorithm for each operation.",
        "lessons": []
      },
      "6.NS.B.4": {
        "description": "Find the greatest common factor of two whole numbers less than or equal to 100 and the least common multiple of two whole numbers less than or equal to 12. Use the distributive property to express a sum of two whole numbers 1-100 with a common factor as a multiple of a sum of two whole numbers with no common factor.",
        "lessons": ["distributive-property", ]
      },
      "6.NS.C": {
        "description": "Apply and extend previous understandings of numbers to the system of rational numbers.",
        "lessons": []
      },
      "6.NS.C.5": {
        "description": "Understand that positive and negative numbers are used together to describe quantities having opposite directions or values (e.g., temperature above/below zero, elevation above/below sea level, credits/debits, positive/negative electric charge); use positive and negative numbers to represent quantities in real-world contexts, explaining the meaning of 0 in each situation.",
        "lessons": ["absolute-value-and-opposites", "absolute-value-and-opposites-2", ]
      },
      "6.NS.C.6": {
        "description": "Understand a rational number as a point on the number line. Extend number line diagrams and coordinate axes familiar from previous grades to represent points on the line and in the plane with negative number coordinates.",
        "lessons": []
      },
      "6.NS.C.6.A": {
        "description": "Recognize opposite signs of numbers as indicating locations on opposite sides of 0 on the number line; recognize that the opposite of the opposite of a number is the number itself, e.g., -(-3) = 3, and that 0 is its own opposite.",
        "lessons": ["absolute-value-and-opposites", "absolute-value-and-opposites-2", ]
      },
      "6.NS.C.6.B": {
        "description": "Understand signs of numbers in ordered pairs as indicating locations in quadrants of the coordinate plane; recognize that when two ordered pairs differ only by signs, the locations of the points are related by reflections across one or both axes.",
        "lessons": []
      },
      "6.NS.C.6.C": {
        "description": "Find and position integers and other rational numbers on a horizontal or vertical number line diagram; find and position pairs of integers and other rational numbers on a coordinate plane.",
        "lessons": ["hoc-winter-parley", ]
      },
      "6.NS.C.7": {
        "description": "Understand ordering and absolute value of rational numbers.",
        "lessons": []
      },
      "6.NS.C.7.A": {
        "description": "Interpret statements of inequality as statements about the relative position of two numbers on a number line diagram.",
        "lessons": []
      },
      "6.NS.C.7.B": {
        "description": "Write, interpret, and explain statements of order for rational numbers in real-world contexts.",
        "lessons": []
      },
      "6.NS.C.7.C": {
        "description": "Understand the absolute value of a rational number as its distance from 0 on the number line; interpret absolute value as magnitude for a positive or negative quantity in a real-world situation.",
        "lessons": ["absolute-value-and-opposites", "absolute-value-and-opposites-2", ]
      },
      "6.NS.C.7.D": {
        "description": "Distinguish comparisons of absolute value from statements about order.",
        "lessons": []
      },
      "6.NS.C.8": {
        "description": "Solve real-world and mathematical problems by graphing points in all four quadrants of the coordinate plane. Include use of coordinates and absolute value to find distances between points with the same first coordinate or the same second coordinate.",
        "lessons": []
      },
      "6.EE.A": {
        "description": "Apply and extend previous understandings of arithmetic to algebraic expressions.",
        "lessons": []
      },
      "6.EE.A.1": {
        "description": "Write and evaluate numerical expressions involving whole-number exponents.",
        "lessons": ["evaluating-exponents", ]
      },
      "6.EE.A.2": {
        "description": "Write, read, and evaluate expressions in which letters stand for numbers.",
        "lessons": ["evaluating-exponents", ]
      },
      "6.EE.A.2.A": {
        "description": "Write expressions that record operations with numbers and with letters standing for numbers.",
        "lessons": ["translating", ]
      },
      "6.EE.A.2.B": {
        "description": "Identify parts of an expression using mathematical terms (sum, term, product, factor, quotient, coefficient); view one or more parts of an expression as a single entity.",
        "lessons": ["translating", ]
      },
      "6.EE.A.2.C": {
        "description": "Evaluate expressions at specific values of their variables. Include expressions that arise from formulas used in real-world problems. Perform arithmetic operations, including those involving whole-number exponents, in the conventional order when there are no parentheses to specify a particular order (Order of Operations).",
        "lessons": []
      },
      "6.EE.A.3": {
        "description": "Apply the properties of operations to generate equivalent expressions.",
        "lessons": ["commutative-property", "associative-property", "identity-property", "distributive-property", ]
      },
      "6.EE.A.4": {
        "description": "Identify when two expressions are equivalent (i.e., when the two expressions name the same number regardless of which value is substituted into them).",
        "lessons": ["equivalence", "identity-property", "distributive-property", ]
      },
      "6.EE.B": {
        "description": "Reason about and solve one-variable equations and inequalities.",
        "lessons": ["inequalities1-simple", "inequalities2-compound", ]
      },
      "6.EE.B.5": {
        "description": "Understand solving an equation or inequality as a process of answering a question: which values from a specified set, if any, make the equation or inequality true? Use substitution to determine whether a given number in a specified set makes an equation or inequality true.",
        "lessons": ["equivalence", ]
      },
      "6.EE.B.6": {
        "description": "Use variables to represent numbers and write expressions when solving a real-world or mathematical problem; understand that a variable can represent an unknown number, or, depending on the purpose at hand, any number in a specified set.",
        "lessons": ["linear-regression", "grouped-samples", "defining-table-functions", "surface-area-rect-prism", "problem-decomposition", "player-animation", "inequalities3-sam", "inequalities-collision", "functions-for-character-animation", "function-definition-linear", "function-composition", "distance-formula", "piecewise-functions-conditionals", "defining-values", "functions-dr", "functions-examples-definitions", "functions-make-life-easier", "equivalence", ]
      },
      "6.EE.B.7": {
        "description": "Solve real-world and mathematical problems by writing and solving equations of the form x + p = q and px = q for cases in which p, q and x are all nonnegative rational numbers.",
        "lessons": []
      },
      "6.EE.B.8": {
        "description": "Write an inequality of the form x > c or x < c to represent a constraint or condition in a real-world or mathematical problem. Recognize that inequalities of the form x > c or x < c have infinitely many solutions; represent solutions of such inequalities on number line diagrams.",
        "lessons": ["inequalities3-sam", "inequalities1-simple", ]
      },
      "6.EE.C": {
        "description": "Represent and analyze quantitative relationships between dependent and independent variables.",
        "lessons": []
      },
      "6.EE.C.9": {
        "description": "Use variables to represent two quantities in a real-world problem that change in relationship to one another; write an equation to express one quantity, thought of as the dependent variable, in terms of the other quantity, thought of as the independent variable. Analyze the relationship between the dependent and independent variables using graphs and tables, and relate these to the equation.",
        "lessons": []
      },
      "6.G.A": {
        "description": "Solve real-world and mathematical problems involving area, surface area, and volume.",
        "lessons": ["surface-area-rect-prism", ]
      },
      "6.G.A.1": {
        "description": "Find the area of right triangles, other triangles, special quadrilaterals, and polygons by composing into rectangles or decomposing into triangles and other shapes; apply these techniques in the context of solving real-world and mathematical problems.",
        "lessons": []
      },
      "6.G.A.2": {
        "description": "Find the volume of a right rectangular prism with fractional edge lengths by packing it with unit cubes of the appropriate unit fraction edge lengths, and show that the volume is the same as would be found by multiplying the edge lengths of the prism. Apply the formulas V = l w h and V = b h to find volumes of right rectangular prisms with fractional edge lengths in the context of solving real-world and mathematical problems.",
        "lessons": []
      },
      "6.G.A.3": {
        "description": "Draw polygons in the coordinate plane given coordinates for the vertices; use coordinates to find the length of a side joining points with the same first coordinate or the same second coordinate. Apply these techniques in the context of solving real-world and mathematical problems.",
        "lessons": []
      },
      "6.G.A.4": {
        "description": "Represent three-dimensional figures using nets made up of rectangles and triangles, and use the nets to find the surface area of these figures. Apply these techniques in the context of solving real-world and mathematical problems.",
        "lessons": ["surface-area-rect-prism", ]
      },
      "6.SP.A": {
        "description": "Develop understanding of statistical variability.",
        "lessons": ["measures-of-center", "histograms", "histograms2", "box-plots", ]
      },
      "6.SP.A.1": {
        "description": "Recognize a statistical question as one that anticipates variability in the data related to the question and accounts for it in the answers.",
        "lessons": ["ds-intro", "choosing-your-dataset", "data-cycle", ]
      },
      "6.SP.A.2": {
        "description": "Understand that a set of data collected to answer a statistical question has a distribution which can be described by its center, spread, and overall shape.",
        "lessons": ["measures-of-center", "histograms", "histograms2", "box-plots", "standard-deviation", ]
      },
      "6.SP.A.3": {
        "description": "Recognize that a measure of center for a numerical data set summarizes all of its values with a single number, while a measure of variation describes how its values vary with a single number.",
        "lessons": ["standard-deviation", "box-plots", ]
      },
      "6.SP.B": {
        "description": "Summarize and describe distributions.",
        "lessons": ["measures-of-center", "histograms2", "box-plots", "project-exploration-paper", "project-research-paper", ]
      },
      "6.SP.B.4": {
        "description": "Display numerical data in plots on a number line, including dot plots, histograms, and box plots.",
        "lessons": ["standard-deviation", "box-plots", "histograms2", "histograms", "project-exploration-paper", "project-research-paper", ]
      },
      "6.SP.B.5": {
        "description": "Summarize numerical data sets in relation to their context.",
        "lessons": ["standard-deviation", "box-plots", "measures-of-center", "project-exploration-paper", "project-research-paper", ]
      },
      "6.SP.B.5.A": {
        "description": "Summarize numerical data sets in relation to their context by reporting the number of observations.",
        "lessons": []
      },
      "6.SP.B.5.B": {
        "description": "Summarize numerical data sets in relation to their context by describing the nature of the attribute under investigation, including how it was measured and its units of measurement.",
        "lessons": []
      },
      "6.SP.B.5.C": {
        "description": "Summarize numerical data sets in relation to their context by giving quantitative measures of center (median and/or mean) and variability (interquartile range and/or mean absolute deviation), as well as describing any overall pattern and any striking deviations from the overall pattern with reference to the context in which the data were gathered.",
        "lessons": ["standard-deviation", "box-plots", "measures-of-center", "project-exploration-paper", "project-research-paper", ]
      },
      "6.SP.B.5.D": {
        "description": "Summarize numerical data sets in relation to their context by relating the choice of measures of center and variability to the shape of the data distribution and the context in which the data were gathered.",
        "lessons": ["measures-of-center", "project-exploration-paper", "project-research-paper", ]
      },
      "7.RP.A": {
        "description": "Analyze proportional relationships and use them to solve real-world and mathematical problems.",
        "lessons": ["flags", "making-game-images", ]
      },
      "7.RP.A.1": {
        "description": "Compute unit rates associated with ratios of fractions, including ratios of lengths, areas and other quantities measured in like or different units.",
        "lessons": ["flags", ]
      },
      "7.RP.A.2": {
        "description": "Recognize and represent proportional relationships between quantities.",
        "lessons": []
      },
      "7.RP.A.2.A": {
        "description": "Decide whether two quantities are in a proportional relationship, e.g., by testing for equivalent ratios in a table or graphing on a coordinate plane and observing whether the graph is a straight line through the origin.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "7.RP.A.2.B": {
        "description": "Identify the constant of proportionality (unit rate) in tables, graphs, equations, diagrams, and verbal descriptions of proportional relationships.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "7.RP.A.2.C": {
        "description": "Represent proportional relationships by equations.",
        "lessons": []
      },
      "7.RP.A.2.D": {
        "description": "Explain what a point (x, y) on the graph of a proportional relationship means in terms of the situation, with special attention to the points (0, 0) and (1, r) where r is the unit rate.",
        "lessons": []
      },
      "7.RP.A.3": {
        "description": "Use proportional relationships to solve multistep ratio and percent problems.",
        "lessons": ["hoc-data", ]
      },
      "7.NS.A": {
        "description": "Apply and extend previous understandings of operations with fractions.",
        "lessons": []
      },
      "7.NS.A.1": {
        "description": "Apply and extend previous understandings of addition and subtraction to add and subtract rational numbers; represent addition and subtraction on a horizontal or vertical number line diagram.",
        "lessons": []
      },
      "7.NS.A.1.A": {
        "description": "Describe situations in which opposite quantities combine to make 0.",
        "lessons": []
      },
      "7.NS.A.1.B": {
        "description": "Understand p + q as the number located a distance |q| from p, in the positive or negative direction depending on whether q is positive or negative. Show that a number and its opposite have a sum of 0 (are additive inverses). Interpret sums of rational numbers by describing real-world contexts.",
        "lessons": []
      },
      "7.NS.A.1.C": {
        "description": "Understand subtraction of rational numbers as adding the additive inverse, p - q = p + (-q). Show that the distance between two rational numbers on the number line is the absolute value of their difference, and apply this principle in real-world contexts.",
        "lessons": ["absolute-value-and-opposites", "absolute-value-and-opposites-2", ]
      },
      "7.NS.A.1.D": {
        "description": "Apply properties of operations as strategies to add and subtract rational numbers.",
        "lessons": []
      },
      "7.NS.A.2": {
        "description": "Apply and extend previous understandings of multiplication and division and of fractions to multiply and divide rational numbers.",
        "lessons": []
      },
      "7.NS.A.2.A": {
        "description": "Understand that multiplication is extended from fractions to rational numbers by requiring that operations continue to satisfy the properties of operations, particularly the distributive property, leading to products such as (-1)(-1) = 1 and the rules for multiplying signed numbers. Interpret products of rational numbers by describing real-world contexts.",
        "lessons": ["absolute-value-and-opposites", "absolute-value-and-opposites-2", "distributive-property", ]
      },
      "7.NS.A.2.B": {
        "description": "Understand that integers can be divided, provided that the divisor is not zero, and every quotient of integers (with non-zero divisor) is a rational number. If p and q are integers, then -(p/q) = (-p)/q = p/(-q). Interpret quotients of rational numbers by describing real-world contexts.",
        "lessons": []
      },
      "7.NS.A.2.C": {
        "description": "Apply properties of operations as strategies to multiply and divide rational numbers.",
        "lessons": ["commutative-property", "associative-property", "distributive-property", "associative-property", ]
      },
      "7.NS.A.2.D": {
        "description": "Convert a rational number to a decimal using long division; know that the decimal form of a rational number terminates in 0s or eventually repeats.",
        "lessons": []
      },
      "7.NS.A.3": {
        "description": "Solve real-world and mathematical problems involving the four operations with rational numbers.",
        "lessons": []
      },
      "7.EE.A": {
        "description": "Use properties of operations to generate equivalent expressions.",
        "lessons": ["computation", "commutative-property", "associative-property", "distributive-property", "identity-property", "equivalence", ]
      },
      "7.EE.A.1": {
        "description": "Apply properties of operations as strategies to add, subtract, factor, and expand linear expressions with rational coefficients.",
        "lessons": []
      },
      "7.EE.A.2": {
        "description": "Understand that rewriting an expression in different forms in a problem context can shed light on the problem and how the quantities in it are related.",
        "lessons": ["problem-decomposition", ]
      },
      "7.EE.B": {
        "description": "Solve real-life and mathematical problems using numerical and algebraic expressions and equations.",
        "lessons": ["problem-decomposition", "player-animation", "inequalities3-sam", "distance-formula", "piecewise-functions-conditionals", "functions-dr", ]
      },
      "7.EE.B.3": {
        "description": "Solve multi-step real-life and mathematical problems posed with positive and negative rational numbers in any form (whole numbers, fractions, and decimals), using tools strategically. Apply properties of operations to calculate with numbers in any form; convert between forms as appropriate; and assess the reasonableness of answers using mental computation and estimation strategies.",
        "lessons": []
      },
      "7.EE.B.4": {
        "description": "Use variables to represent quantities in a real-world or mathematical problem, and construct simple equations and inequalities to solve problems by reasoning about the quantities.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", "defining-values", "functions-dr", "functions-make-life-easier", ]
      },
      "7.EE.B.4.A": {
        "description": "Solve word problems leading to equations of the form px + q = r and p(x + q) = r, where p, q, and r are specific rational numbers. Solve equations of these forms fluently. Compare an algebraic solution to an arithmetic solution, identifying the sequence of the operations used in each approach.",
        "lessons": []
      },
      "7.EE.B.4.B": {
        "description": "Solve word problems leading to inequalities of the form px + q > r or px + q < r, where p, q, and r are specific rational numbers. Graph the solution set of the inequality and interpret it in the context of the problem.",
        "lessons": []
      },
      "7.G.A": {
        "description": "Draw, construct, and describe geometical figures and describe the relationships between them.",
        "lessons": ["hoc-winter-parley", ]
      },
      "7.G.A.1": {
        "description": "Solve problems involving scale drawings of geometric figures, including computing actual lengths and areas from a scale drawing and reproducing a scale drawing at a different scale.",
        "lessons": []
      },
      "7.G.A.2": {
        "description": "Draw (freehand, with ruler and protractor, and with technology) geometric shapes with given conditions. Focus on constructing triangles from three measures of angles or sides, noticing when the conditions determine a unique triangle, more than one triangle, or no triangle.",
        "lessons": []
      },
      "7.G.A.3": {
        "description": "Describe the two-dimensional figures that result from slicing three-dimensional figures, as in plane sections of right rectangular prisms and right rectangular pyramids.",
        "lessons": []
      },
      "7.G.B": {
        "description": "Solve real-life and mathematical problems involving angle measure, area, surface area, and volume.",
        "lessons": []
      },
      "7.G.B.4": {
        "description": "Know the formulas for the area and circumference of a circle and use them to solve problems; give an informal derivation of the relationship between the circumference and area of a circle.",
        "lessons": ["functions-dr", ]
      },
      "7.G.B.5": {
        "description": "Use facts about supplementary, complementary, vertical, and adjacent angles in a multi-step problem to write and solve simple equations for an unknown angle in a figure.",
        "lessons": []
      },
      "7.G.B.6": {
        "description": "Solve real-world and mathematical problems involving area, volume and surface area of two- and three-dimensional objects composed of triangles, quadrilaterals, polygons, cubes, and right prisms.",
        "lessons": ["surface-area-rect-prism", "functions-dr", ]
      },
      "7.SP.A": {
        "description": "Use random sampling to draw inferences about a population.",
        "lessons": ["probability-inference", ]
      },
      "7.SP.A.1": {
        "description": "Understand that statistics can be used to gain information about a population by examining a sample of the population; generalizations about a population from a sample are valid only if the sample is representative of that population. Understand that random sampling tends to produce representative samples and support valid inferences.",
        "lessons": ["probability-inference", "hoc-data", ]
      },
      "7.SP.A.2": {
        "description": "Use data from a random sample to draw inferences about a population with an unknown characteristic of interest. Generate multiple samples (or simulated samples) of the same size to gauge the variation in estimates or predictions.",
        "lessons": ["probability-inference", ]
      },
      "7.SP.B": {
        "description": "Draw informal comparative inferences about two populations.",
        "lessons": ["bar-and-pie-charts", "project-exploration-paper", "project-research-paper", "hoc-data", ]
      },
      "7.SP.B.3": {
        "description": "Informally assess the degree of visual overlap of two numerical data distributions with similar variabilities, measuring the difference between the centers by expressing it as a multiple of a measure of variability.",
        "lessons": ["project-exploration-paper", "project-research-paper", ]
      },
      "7.SP.B.4": {
        "description": "Use measures of center and measures of variability for numerical data from random samples to draw informal comparative inferences about two populations.",
        "lessons": ["project-exploration-paper", "project-research-paper", ]
      },
      "7.SP.C": {
        "description": "Investigate chance processes and develop, use, and evaluate probability models.",
        "lessons": []
      },
      "7.SP.C.5": {
        "description": "Understand that the probability of a chance event is a number between 0 and 1 that expresses the likelihood of the event occurring. Larger numbers indicate greater likelihood. A probability near 0 indicates an unlikely event, a probability around 1/2 indicates an event that is neither unlikely nor likely, and a probability near 1 indicates a likely event.",
        "lessons": []
      },
      "7.SP.C.6": {
        "description": "Approximate the probability of a chance event by collecting data on the chance process that produces it and observing its long-run relative frequency, and predict the approximate relative frequency given the probability.",
        "lessons": []
      },
      "7.SP.C.7": {
        "description": "Develop a probability model and use it to find probabilities of events. Compare probabilities from a model to observed frequencies; if the agreement is not good, explain possible sources of the discrepancy.",
        "lessons": []
      },
      "7.SP.C.7.A": {
        "description": "Develop a uniform probability model by assigning equal probability to all outcomes, and use the model to determine probabilities of events.",
        "lessons": []
      },
      "7.SP.C.7.B": {
        "description": "Develop a probability model (which may not be uniform) by observing frequencies in data generated from a chance process.",
        "lessons": []
      },
      "7.SP.C.8": {
        "description": "Find probabilities of compound events using organized lists, tables, tree diagrams, and simulation.",
        "lessons": []
      },
      "7.SP.C.8.A": {
        "description": "Understand that, just as with simple events, the probability of a compound event is the fraction of outcomes in the sample space for which the compound event occurs.",
        "lessons": []
      },
      "7.SP.C.8.B": {
        "description": "Represent sample spaces for compound events using methods such as organized lists, tables and tree diagrams. For an event described in everyday language (e.g., \"rolling double sixes\"), identify the outcomes in the sample space which compose the event.",
        "lessons": []
      },
      "7.SP.C.8.C": {
        "description": "Design and use a simulation to generate frequencies for compound events.",
        "lessons": []
      },
      "8.NS.A": {
        "description": "Know that there are numbers that are not rational, and approximate them by rational numbers.",
        "lessons": []
      },
      "8.NS.A.1": {
        "description": "Know that numbers that are not rational are called irrational. Understand informally that every number has a decimal expansion; for rational numbers show that the decimal expansion repeats eventually, and convert a decimal expansion which repeats eventually into a rational number.",
        "lessons": []
      },
      "8.NS.A.2": {
        "description": "Use rational approximations of irrational numbers to compare the size of irrational numbers, locate them approximately on a number line diagram, and estimate the value of expressions (e.g., π²).",
        "lessons": []
      },
      "8.EE.A": {
        "description": "Expressions and equations work with radicals and integer exponents.",
        "lessons": []
      },
      "8.EE.A.1": {
        "description": "Know and apply the properties of integer exponents to generate equivalent numerical expressions.",
        "lessons": []
      },
      "8.EE.A.2": {
        "description": "Use square root and cube root symbols to represent solutions to equations of the form x2 = p and x3 = p, where p is a positive rational number. Evaluate square roots of small perfect squares and cube roots of small perfect cubes. Know that √2 is irrational.",
        "lessons": []
      },
      "8.EE.A.3": {
        "description": "Use numbers expressed in the form of a single digit times an integer power of 10 to estimate very large or very small quantities, and to express how many times as much one is than the other.",
        "lessons": []
      },
      "8.EE.A.4": {
        "description": "Perform operations with numbers expressed in scientific notation, including problems where both decimal and scientific notation are used. Use scientific notation and choose units of appropriate size for measurements of very large or very small quantities. Interpret scientific notation that has been generated by technology.",
        "lessons": []
      },
      "8.EE.B": {
        "description": "Understand the connections between proportional relationships, lines, and linear equations.",
        "lessons": ["function-definition-linear", "functions-can-be-linear", ]
      },
      "8.EE.B.5": {
        "description": "Graph proportional relationships, interpreting the unit rate as the slope of the graph. Compare two different proportional relationships represented in different ways.",
        "lessons": ["function-definition-linear", "functions-can-be-linear", ]
      },
      "8.EE.B.6": {
        "description": "Use similar triangles to explain why the slope m is the same between any two distinct points on a non-vertical line in the coordinate plane; derive the equation y = mx for a line through the origin and the equation y = mx + b for a line intercepting the vertical axis at b.",
        "lessons": []
      },
      "8.EE.C": {
        "description": "Analyze and solve linear equations and pairs of simultaneous linear equations.",
        "lessons": []
      },
      "8.EE.C.7": {
        "description": "Solve linear equations in one variable.",
        "lessons": []
      },
      "8.EE.C.7.A": {
        "description": "Give examples of linear equations in one variable with one solution, infinitely many solutions, or no solutions. Show which of these possibilities is the case by successively transforming the given equation into simpler forms, until an equivalent equation of the form x = a, a = a, or a = b results (where a and b are different numbers).",
        "lessons": []
      },
      "8.EE.C.7.B": {
        "description": "Solve linear equations with rational number coefficients, including equations whose solutions require expanding expressions using the distributive property and collecting like terms.",
        "lessons": []
      },
      "8.EE.C.8": {
        "description": "Analyze and solve pairs of simultaneous linear equations.",
        "lessons": []
      },
      "8.EE.C.8.A": {
        "description": "Understand that solutions to a system of two linear equations in two variables correspond to points of intersection of their graphs, because points of intersection satisfy both equations simultaneously.",
        "lessons": []
      },
      "8.EE.C.8.B": {
        "description": "Solve systems of two linear equations in two variables algebraically, and estimate solutions by graphing the equations. Solve simple cases by inspection.",
        "lessons": []
      },
      "8.EE.C.8.C": {
        "description": "Solve real-world and mathematical problems leading to two linear equations in two variables.",
        "lessons": []
      },
      "8.F.A.1": {
        "description": "Understand that a function is a rule that assigns to each input exactly one output. The graph of a function is the set of ordered pairs consisting of an input and the corresponding output.",
        "lessons": ["contracts", "functions-vertical-line-test", ]
      },
      "8.F.A.2": {
        "description": "Compare properties of two functions each represented in a different way (algebraically, graphically, numerically in tables, or by verbal descriptions).",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "8.F.A.3": {
        "description": "Interpret the equation y = mx + b as defining a linear function, whose graph is a straight line; give examples of functions that are not linear. ",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "8.F.B": {
        "description": "Use functions to model relationships between quantities.",
        "lessons": ["functions-for-character-animation", "functions-dr", "functions-make-life-easier", "function-definition-linear", "problem-decomposition", ]
      },
      "8.F.B.4": {
        "description": "Construct a function to model a linear relationship between two quantities. Determine the rate of change  and initial value of the function from a description of a relationship or from two (x, y) values, including reading these from a table or from a graph. Interpret the rate of change and initial value of a linear function in terms of the situation it models, and in terms of its graph or a table of values.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "8.F.B.5": {
        "description": "Describe qualitatively the functional relationship between two quantities by analyzing a graph (e.g., where the function is increasing or decreasing, linear or nonlinear). Sketch a graph that exhibits the qualitative features of a function that has been described verbally.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "8.G.A": {
        "description": "Understand congruence and similarity using physical models, transparencies, or geometry software.",
        "lessons": []
      },
      "8.G.A.1": {
        "description": "Verify experimentally the properties of rotations, reflections, and translations.",
        "lessons": ["making-game-images", ]
      },
      "8.G.A.1.A": {
        "description": "Lines are taken to lines, and line segments to line segments of the same length.",
        "lessons": []
      },
      "8.G.A.1.B": {
        "description": "Angles are taken to angles of the same measure.",
        "lessons": []
      },
      "8.G.A.1.C": {
        "description": "Parallel lines are taken to parallel lines.",
        "lessons": []
      },
      "8.G.A.2": {
        "description": "Understand that a two-dimensional figure is congruent to another if the second can be obtained from the first by a sequence of rotations, reflections, and translations; given two congruent figures, describe a sequence that exhibits the congruence between them.",
        "lessons": []
      },
      "8.G.A.3": {
        "description": "Describe the effect of dilations, translations, rotations, and reflections on two-dimensional figures using coordinates.",
        "lessons": []
      },
      "8.G.A.4": {
        "description": "Understand that a two-dimensional figure is similar to another if the second can be obtained from the first by a sequence of rotations, reflections, translations, and dilations; given two similar two-dimensional figures, describe a sequence that exhibits the similarity between them.",
        "lessons": []
      },
      "8.G.A.5": {
        "description": "Use informal arguments to establish facts about the angle sum and exterior angle of triangles, about the angles created when parallel lines are cut by a transversal, and the angle-angle criterion for similarity of triangles. ",
        "lessons": []
      },
      "8.G.B": {
        "description": "Understand and apply the Pythagorean Theorem.",
        "lessons": ["distance-formula", ]
      },
      "8.G.B.6": {
        "description": "Explain a proof of the Pythagorean Theorem and its converse.",
        "lessons": []
      },
      "8.G.B.7": {
        "description": "Apply the Pythagorean Theorem to determine unknown side lengths in right triangles in real-world and mathematical problems in two and three dimensions.",
        "lessons": ["distance-formula", ]
      },
      "8.G.B.8": {
        "description": "Apply the Pythagorean Theorem to find the distance between two points in a coordinate system.",
        "lessons": ["distance-formula", ]
      },
      "8.G.C": {
        "description": "Solve real-world and mathematical problems involving volume of cylinders, cones, and spheres.",
        "lessons": []
      },
      "8.G.C.9": {
        "description": "Know the formulas for the volumes of cones, cylinders, and spheres and use them to solve real-world and mathematical problems.",
        "lessons": []
      },
      "8.SP.A.1": {
        "description": "Construct and interpret scatter plots for bivariate measurement data to investigate patterns of association between two quantities. Describe patterns such as clustering, outliers, positive or negative association, linear association, and nonlinear association.",
        "lessons": ["scatter-plots", "linear-regression", "grouped-samples", "correlations", ]
      },
      "8.SP.A.2": {
        "description": "Know that straight lines are widely used to model relationships between two quantitative variables. For scatter plots that suggest a linear association, informally fit a straight line, and informally assess the model fit by judging the closeness of the data points to the line.",
        "lessons": ["scatter-plots", "linear-regression", "correlations", ]
      },
      "8.SP.A.3": {
        "description": "Use the equation of a linear model to solve problems in the context of bivariate measurement data, interpreting the slope and intercept. ",
        "lessons": ["linear-regression", ]
      },
      "8.SP.A.4": {
        "description": "Understand that patterns of association can also be seen in bivariate categorical data by displaying frequencies and relative frequencies in a two-way table. Construct and interpret a two-way table summarizing data on two categorical variables collected from the same subjects. Use relative frequencies calculated for rows or columns to describe possible association between the two variables. ",
        "lessons": []
      },
      "HSN.NS.A": {
        "description": "Extend the properties of exponents to rational exponents.",
        "lessons": []
      },
      "HSN.NS.A.1": {
        "description": "Explain how the definition of the meaning of rational exponents follows from extending the properties of integer exponents to those values, allowing for a notation for radicals in terms of rational exponents.",
        "lessons": []
      },
      "HSN.NS.A.2": {
        "description": "Rewrite expressions involving radicals and rational exponents using the properties of exponents.",
        "lessons": []
      },
      "HSN.NS.B": {
        "description": "Use properties of rational and irrational numbers.",
        "lessons": []
      },
      "HSN.NS.B.3": {
        "description": "Explain why the sum or product of two rational numbers is rational; that the sum of a rational number and an irrational number is irrational; and that the product of a nonzero rational number and an irrational number is irrational.",
        "lessons": []
      },
      "HSN.Q.A": {
        "description": "Reason quantitatively and use units to solve problems.",
        "lessons": ["flags", ]
      },
      "HSN.Q.A.1": {
        "description": "Use units as a way to understand problems and to guide the solution of multi-step problems; choose and interpret units consistently in formulas; choose and interpret the scale and the origin in graphs and data displays.",
        "lessons": []
      },
      "HSN.Q.A.2": {
        "description": "Define appropriate quantities for the purpose of descriptive modeling.",
        "lessons": []
      },
      "HSN.Q.A.3": {
        "description": "Choose a level of accuracy appropriate to limitations on measurement when reporting quantities.",
        "lessons": []
      },
      "HSN.CN.A": {
        "description": "Perform arithmetic operations with complex numbers.",
        "lessons": []
      },
      "HSN.CN.A.1": {
        "description": "Know there is a complex number i such that i2 = -1, and every complex number has the form a + bi with a and b real.",
        "lessons": []
      },
      "HSN.CN.A.2": {
        "description": "Use the relation i2 = -1 and the commutative, associative, and distributive properties to add, subtract, and multiply complex numbers.",
        "lessons": []
      },
      "HSN.CN.A.3": {
        "description": "Find the conjugate of a complex number; use conjugates to find moduli and quotients of complex numbers.",
        "lessons": []
      },
      "HSN.CN.B": {
        "description": "Represent complex numbers and their operations on the complex plane.",
        "lessons": []
      },
      "HSN.CN.B.4": {
        "description": "Represent complex numbers on the complex plane in rectangular and polar form (including real and imaginary numbers), and explain why the rectangular and polar forms of a given complex number represent the same number.",
        "lessons": []
      },
      "HSN.CN.B.5": {
        "description": "Represent addition, subtraction, multiplication, and conjugation of complex numbers geometrically on the complex plane; use properties of this representation for computation.",
        "lessons": []
      },
      "HSN.CN.B.6": {
        "description": "Calculate the distance between numbers in the complex plane as the modulus of the difference, and the midpoint of a segment as the average of the numbers at its endpoints.",
        "lessons": []
      },
      "HSN.CN.C": {
        "description": "Use complex numbers in polynomial identities and equations.",
        "lessons": []
      },
      "HSN.CN.C.7": {
        "description": "Solve quadratic equations with real coefficients that have complex solutions.",
        "lessons": []
      },
      "HSN.CN.C.8": {
        "description": "Extend polynomial identities to the complex numbers.",
        "lessons": []
      },
      "HSN.CN.C.9": {
        "description": "Know the Fundamental Theorem of Algebra; show that it is true for quadratic polynomials.",
        "lessons": []
      },
      "HSN.VM.A": {
        "description": "Represent and model with vector quantities.",
        "lessons": []
      },
      "HSN.VM.A.1": {
        "description": "Recognize vector quantities as having both magnitude and direction. Represent vector quantities by directed line segments, and use appropriate symbols for vectors and their magnitudes (e.g., v, |v|, ||v||, v).",
        "lessons": []
      },
      "HSN.VM.A.2": {
        "description": "Find the components of a vector by subtracting the coordinates of an initial point from the coordinates of a terminal point.",
        "lessons": []
      },
      "HSN.VM.A.3": {
        "description": "Solve problems involving velocity and other quantities that can be represented by vectors.",
        "lessons": []
      },
      "HSN.VM.B": {
        "description": "Perform operations on vectors.",
        "lessons": []
      },
      "HSN.VM.B.4": {
        "description": "Add and subtract vectors.",
        "lessons": []
      },
      "HSN.VM.B.4.A": {
        "description": "Add vectors end-to-end, component-wise, and by the parallelogram rule. Understand that the magnitude of a sum of two vectors is typically not the sum of the magnitudes.",
        "lessons": []
      },
      "HSN.VM.B.4.B": {
        "description": "Given two vectors in magnitude and direction form, determine the magnitude and direction of their sum.",
        "lessons": []
      },
      "HSN.VM.B.4.C": {
        "description": "Understand vector subtraction v - w as v + (-w), where -w is the additive inverse of w, with the same magnitude as w and pointing in the opposite direction. Represent vector subtraction graphically by connecting the tips in the appropriate order, and perform vector subtraction component-wise.",
        "lessons": []
      },
      "HSN.VM.B.5": {
        "description": "Multiply a vector by a scalar.",
        "lessons": []
      },
      "HSN.VM.B.5.A": {
        "description": "Represent scalar multiplication graphically by scaling vectors and possibly reversing their direction; perform scalar multiplication component-wise, e.g., as c(vx, vy) = (cvx, cvy).",
        "lessons": []
      },
      "HSN.VM.B.5.B": {
        "description": "Compute the magnitude of a scalar multiple cv using ||cv|| = |c|v. Compute the direction of cv knowing that when |c|v ≠ 0, the direction of cv is either along v (for c > 0) or against v (for c < 0).",
        "lessons": []
      },
      "HSN.VM.C": {
        "description": "Perform operations on matrices and use matrices in applications.",
        "lessons": []
      },
      "HSN.VM.C.6.": {
        "description": "Use matrices to represent and manipulate data, e.g., to represent payoffs or incidence relationships in a network.",
        "lessons": []
      },
      "HSN.VM.C.7": {
        "description": "Multiply matrices by scalars to produce new matrices, e.g., as when all of the payoffs in a game are doubled.",
        "lessons": []
      },
      "HSN.VM.C.8": {
        "description": "Add, subtract, and multiply matrices of appropriate dimensions.",
        "lessons": []
      },
      "HSN.VM.C.9": {
        "description": "Understand that, unlike multiplication of numbers, matrix multiplication for square matrices is not a commutative operation, but still satisfies the associative and distributive properties.",
        "lessons": []
      },
      "HSN.VM.C.10": {
        "description": "Understand that the zero and identity matrices play a role in matrix addition and multiplication similar to the role of 0 and 1 in the real numbers. The determinant of a square matrix is nonzero if and only if the matrix has a multiplicative inverse.",
        "lessons": []
      },
      "HSN.VM.C.11": {
        "description": "Multiply a vector (regarded as a matrix with one column) by a matrix of suitable dimensions to produce another vector. Work with matrices as transformations of vectors.",
        "lessons": []
      },
      "HSN.VM.C.12": {
        "description": "Work with 2 × 2 matrices as a transformations of the plane, and interpret the absolute value of the determinant in terms of area.",
        "lessons": []
      },
      "HSA.SSE.A.1": {
        "description": "Interpret expressions that represent a quantity in terms of its context.",
        "lessons": ["defining-values", "functions-make-life-easier", "functions-dr", ]
      },
      "HSA.SSE.A.1.A": {
        "description": "Interpret parts of an expression, such as terms, factors, and coefficients.",
        "lessons": ["player-animation", "piecewise-functions-conditionals", ]
      },
      "HSA.SSE.A.1.B": {
        "description": "Interpret complicated expressions by viewing one or more of their parts as a single entity.",
        "lessons": ["advanced-displays", "player-animation", "piecewise-functions-conditionals", ]
      },
      "HSA.SSE.A.2": {
        "description": "Use the structure of an expression to identify ways to rewrite it.",
        "lessons": ["order-of-operations", ]
      },
      "HSA.SSE.B": {
        "description": "Write expressions in equivalent forms to solve problems.",
        "lessons": ["order-of-operations", ]
      },
      "HSA.SSE.B.3": {
        "description": "Choose and produce an equivalent form of an expression to reveal and explain properties of the quantity represented by the expression.",
        "lessons": []
      },
      "HSA.SSE.B.3.A": {
        "description": "Factor a quadratic expression to reveal the zeros of the function it defines.",
        "lessons": []
      },
      "HSA.SSE.B.3.B": {
        "description": "Complete the square in a quadratic expression to reveal the maximum or minimum value of the function it defines.",
        "lessons": []
      },
      "HSA.SSE.B.3.C": {
        "description": "Use the properties of exponents to transform expressions for exponential functions.",
        "lessons": []
      },
      "HSA.SSE.B.4": {
        "description": "Derive the formula for the sum of a finite geometric series (when the common ratio is not 1), and use the formula to solve problems.",
        "lessons": []
      },
      "HSA.APR.A": {
        "description": "Perform arithmetic operations on polynomials.",
        "lessons": []
      },
      "HSA.APR.A.1": {
        "description": "Understand that polynomials form a system analogous to the integers, namely, they are closed under the operations of addition, subtraction, and multiplication; add, subtract, and multiply polynomials.",
        "lessons": []
      },
      "HSA.APR.B": {
        "description": "Understand the relationship between zeros and factors of polynomials.",
        "lessons": []
      },
      "HSA.APR.B.2": {
        "description": "Know and apply the Remainder Theorem: For a polynomial p(x) and a number a, the remainder on division by x - a is p(a), so p(a) = 0 if and only if (x - a) is a factor of p(x).",
        "lessons": []
      },
      "HSA.APR.B.3": {
        "description": "Identify zeros of polynomials when suitable factorizations are available, and use the zeros to construct a rough graph of the function defined by the polynomial.",
        "lessons": []
      },
      "HSA.APR.C": {
        "description": "Use polynomial identities to solve problems.",
        "lessons": []
      },
      "HSA.APR.C.4": {
        "description": "Prove polynomial identities and use them to describe numerical relationships.",
        "lessons": []
      },
      "HSA.APR.C.5": {
        "description": "Know and apply the Binomial Theorem for the expansion of (x + y)n in powers of x and y for a positive integer n, where x and y are any numbers, with coefficients determined for example by Pascal's Triangle.",
        "lessons": []
      },
      "HSA.APR.D": {
        "description": "Rewrite rational expressions.",
        "lessons": []
      },
      "HSA.APR.D.6": {
        "description": "Rewrite simple rational expressions in different forms; write a(x)/b(x) in the form q(x) + r(x)/b(x), where a(x), b(x), q(x), and r(x) are polynomials with the degree of r(x) less than the degree of b(x), using inspection, long division, or, for the more complicated examples, a computer algebra system.",
        "lessons": []
      },
      "HSA.APR.D.7": {
        "description": "Understand that rational expressions form a system analogous to the rational numbers, closed under addition, subtraction, multiplication, and division by a nonzero rational expression; add, subtract, multiply, and divide rational expressions.",
        "lessons": []
      },
      "HSA.CED.A": {
        "description": "Create equations that describe numbers or relationships.",
        "lessons": ["problem-decomposition", "inequalities3-sam", "functions-dr", "surface-area-rect-prism", ]
      },
      "HSA.CED.A.1": {
        "description": "Create equations and inequalities in one variable and use them to solve problems.",
        "lessons": ["inequalities3-sam", ]
      },
      "HSA.CED.A.2": {
        "description": "Create equations in two or more variables to represent relationships between quantities; graph equations on coordinate axes with labels and scales.",
        "lessons": ["inequalities3-sam", ]
      },
      "HSA.CED.A.3": {
        "description": "Represent constraints by equations or inequalities, and by systems of equations and/or inequalities, and interpret solutions as viable or nonviable options in a modeling context.",
        "lessons": ["inequalities3-sam", ]
      },
      "HSA.CED.A.4": {
        "description": "Rearrange formulas to highlight a quantity of interest, using the same reasoning as in solving equations.",
        "lessons": []
      },
      "HSA.REI.A": {
        "description": "Understand solving equations as a proces of reasoning and explain the reasoning.",
        "lessons": []
      },
      "HSA.REI.A.1": {
        "description": "Explain each step in solving a simple equation as following from the equality of numbers asserted at the previous step, starting from the assumption that the original equation has a solution. Construct a viable argument to justify a solution method.",
        "lessons": []
      },
      "HSA.REI.A.2": {
        "description": "Solve simple rational and radical equations in one variable, and give examples showing how extraneous solutions may arise.",
        "lessons": []
      },
      "HSA.REI.B": {
        "description": "Solve equations and inequalities in one variable.",
        "lessons": []
      },
      "HSA.REI.B.3": {
        "description": "Solve linear equations and inequalities in one variable, including equations with coefficients represented by letters.",
        "lessons": []
      },
      "HSA.REI.B.4": {
        "description": "Solve quadratic equations in one variable.",
        "lessons": []
      },
      "HSA.REI.B.4.A": {
        "description": "Use the method of completing the square to transform any quadratic equation in x into an equation of the form (x - p)2 = q that has the same solutions. Derive the quadratic formula from this form.",
        "lessons": []
      },
      "HSA.REI.B.4.B": {
        "description": "Solve quadratic equations by inspection (e.g., for x2 = 49), taking square roots, completing the square, the quadratic formula and factoring, as appropriate to the initial form of the equation. Recognize when the quadratic formula gives complex solutions and write them as a ± bi for real numbers a and b.",
        "lessons": []
      },
      "HSA.REI.C": {
        "description": "Solve systems of equations.",
        "lessons": []
      },
      "HSA.REI.C.5": {
        "description": "Prove that, given a system of two equations in two variables, replacing one equation by the sum of that equation and a multiple of the other produces a system with the same solutions.",
        "lessons": []
      },
      "HSA.REI.C.6": {
        "description": "Solve systems of linear equations exactly and approximately (e.g., with graphs), focusing on pairs of linear equations in two variables.",
        "lessons": []
      },
      "HSA.REI.C.7": {
        "description": "Solve a simple system consisting of a linear equation and a quadratic equation in two variables algebraically and graphically. For example, find the points of intersection between the line y = -3x and the circle x2 + y2 = 3.",
        "lessons": []
      },
      "HSA.REI.C.8": {
        "description": "Represent a system of linear equations as a single matrix equation in a vector variable.",
        "lessons": []
      },
      "HSA.REI.C.9": {
        "description": "Find the inverse of a matrix if it exists and use it to solve systems of linear equations (using technology for matrices of dimension 3 × 3 or greater).",
        "lessons": []
      },
      "HSA.REI.D": {
        "description": "Represent and solve equations and inequalities graphically.",
        "lessons": []
      },
      "HSA.REI.D.10": {
        "description": "Understand that the graph of an equation in two variables is the set of all its solutions plotted in the coordinate plane, often forming a curve (which could be a line).",
        "lessons": []
      },
      "HSA.REI.D.11": {
        "description": "Explain why the x-coordinates of the points where the graphs of the equations y = f(x) and y = g(x) intersect are the solutions of the equation f(x) = g(x); find the solutions approximately, e.g., using technology to graph the functions, make tables of values, or find successive approximations. Include cases where f(x) and/or g(x) are linear, polynomial, rational, absolute value, exponential, and logarithmic functions.",
        "lessons": []
      },
      "HSA.REI.D.12": {
        "description": "Graph the solutions to a linear inequality in two variables as a half-plane (excluding the boundary in the case of a strict inequality), and graph the solution set to a system of linear inequalities in two variables as the intersection of the corresponding half-planes.",
        "lessons": []
      },
      "HSF.IF.A": {
        "description": "Understand the concept of a function and use function notation.",
        "lessons": ["functions-make-life-easier", "function-notation", ]
      },
      "HSF.IF.A.1": {
        "description": "Understand that a function from one set (called the domain) to another set (called the range) assigns to each element of the domain exactly one element of the range. If f is a function and x is an element of its domain, then f(x) denotes the output of f corresponding to the input x. The graph of f is the graph of the equation y = f(x).",
        "lessons": ["functions-vertical-line-test", "contracts", ]
      },
      "HSF.IF.A.2": {
        "description": "Use function notation, evaluate functions for inputs in their domains, and interpret statements that use function notation in terms of a context.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", "function-definition-linear", "functions-dr", "problem-decomposition", "function-notation", "functions-for-character-animation", "defining-table-functions", "flags", "contracts", ]
      },
      "HSF.IF.A.3": {
        "description": "Recognize that sequences are functions, sometimes defined recursively, whose domain is a subset of the integers.",
        "lessons": []
      },
      "HSF.IF.B": {
        "description": "Interpret functions that arise in applications in terms of the context.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", "function-definition-linear", "functions-dr", "problem-decomposition", "function-notation", "functions-for-character-animation", "defining-table-functions", ]
      },
      "HSF.IF.B.4": {
        "description": "For a function that models a relationship between two quantities, interpret key features of graphs and tables in terms of the quantities, and sketch graphs showing key features given a verbal description of the relationship.",
        "lessons": []
      },
      "HSF.IF.B.5": {
        "description": "Relate the domain of a function to its graph and, where applicable, to the quantitative relationship it describes.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "HSF.IF.B.6": {
        "description": "Calculate and interpret the average rate of change of a function (presented symbolically or as a table) over a specified interval. Estimate the rate of change from a graph.",
        "lessons": []
      },
      "HSF.IF.C": {
        "description": "Analyze functions using different representations.",
        "lessons": ["function-definition-linear", "functions-vertical-line-test", "functions-can-be-linear", "functions-dr", "functions-examples-definitions", ]
      },
      "HSF.IF.C.7": {
        "description": "Graph functions expressed symbolically and show key features of the graph, by hand in simple cases and using technology for more complicated cases.",
        "lessons": []
      },
      "HSF.IF.C.7.A": {
        "description": "Graph linear and quadratic functions and show intercepts, maxima, and minima.",
        "lessons": []
      },
      "HSF.IF.C.7.B": {
        "description": "Graph square root, cube root, and piecewise-defined functions, including step functions and absolute value functions.",
        "lessons": []
      },
      "HSF.IF.C.7.C": {
        "description": "Graph polynomial functions, identifying zeros when suitable factorizations are available, and showing end behavior.",
        "lessons": []
      },
      "HSF.IF.C.7.D": {
        "description": "Graph rational functions, identifying zeros and asymptotes when suitable factorizations are available, and showing end behavior.",
        "lessons": []
      },
      "HSF.IF.C.7.E": {
        "description": "Graph exponential and logarithmic functions, showing intercepts and end behavior, and trigonometric functions, showing period, midline, and amplitude.",
        "lessons": []
      },
      "HSF.IF.C.8": {
        "description": "Write a function defined by an expression in different but equivalent forms to reveal and explain different properties of the function.",
        "lessons": []
      },
      "HSF.IF.C.8.A": {
        "description": "Use the process of factoring and completing the square in a quadratic function to show zeros, extreme values, and symmetry of the graph, and interpret these in terms of a context.",
        "lessons": []
      },
      "HSF.IF.C.8.B": {
        "description": "Use the properties of exponents to interpret expressions for exponential functions. For example, identify percent rate of change in functions such as y = (1.02)ᵗ, y = (0.97)ᵗ, y = (1.01)12ᵗ, y = (1.2)ᵗ/10, and classify them as representing exponential growth or decay.",
        "lessons": []
      },
      "HSF.IF.C.9": {
        "description": "Compare properties of two functions each represented in a different way (algebraically, graphically, numerically in tables, or by verbal descriptions).",
        "lessons": ["function-definition-linear", "functions-can-be-linear", "problem-decomposition", ]
      },
      "HSF.BF.A": {
        "description": "Build a function that models a relationship between two quantities.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", "function-definition-linear", "functions-dr", "problem-decomposition", "function-notation", "functions-for-character-animation", "defining-table-functions", ]
      },
      "HSF.BF.A.1": {
        "description": "Write a function that describes a relationship between two quantities.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", "function-definition-linear", "functions-dr", "problem-decomposition", "function-notation", "functions-for-character-animation", "defining-table-functions", ]
      },
      "HSF.BF.A.1.A": {
        "description": "Determine an explicit expression, a recursive process, or steps for calculation from a context.",
        "lessons": []
      },
      "HSF.BF.A.1.B": {
        "description": "Combine standard function types using arithmetic operations.",
        "lessons": ["function-composition", ]
      },
      "HSF.BF.A.1.C": {
        "description": "Compose functions.",
        "lessons": ["problem-decomposition", "inequalities3-sam", "function-composition", "inequalities-collision", ]
      },
      "HSF.BF.A.2": {
        "description": "Write arithmetic and geometric sequences both recursively and with an explicit formula, use them to model situations, and translate between the two forms.",
        "lessons": []
      },
      "HSF.BF.B": {
        "description": "Build new functions from existing functions.",
        "lessons": ["problem-decomposition", "inequalities3-sam", "inequalities-collision", ]
      },
      "HSF.BF.B.3": {
        "description": "Identify the effect on the graph of replacing f(x) by f(x) + k, k f(x), f(kx), and f(x + k) for specific values of k (both positive and negative); find the value of k given the graphs. Experiment with cases and illustrate an explanation of the effects on the graph using technology. Include recognizing even and odd functions from their graphs and algebraic expressions for them.",
        "lessons": []
      },
      "HSF.BF.B.4": {
        "description": "Find inverse functions.",
        "lessons": []
      },
      "HSF.BF.B.4.A": {
        "description": "Solve an equation of the form f(x) = c for a simple function f that has an inverse and write an expression for the inverse.",
        "lessons": []
      },
      "HSF.BF.B.4.B": {
        "description": "Verify by composition that one function is the inverse of another.",
        "lessons": []
      },
      "HSF.BF.B.4.C": {
        "description": "Read values of an inverse function from a graph or a table, given that the function has an inverse.",
        "lessons": []
      },
      "HSF.BF.B.4.D": {
        "description": "Produce an invertible function from a non-invertible function by restricting the domain.",
        "lessons": []
      },
      "HSF.BF.B.5": {
        "description": "Understand the inverse relationship between exponents and logarithms and use this relationship to solve problems involving logarithms and exponents.",
        "lessons": []
      },
      "HSF.LE.A": {
        "description": "Construct and compare linear, quadratic, and exponential models and solve problems.",
        "lessons": []
      },
      "HSF.LE.A.1": {
        "description": "Distinguish between situations that can be modeled with linear functions and with exponential functions.",
        "lessons": []
      },
      "HSF.LE.A.1.A": {
        "description": "Prove that linear functions grow by equal differences over equal intervals, and that exponential functions grow by equal factors over equal intervals.",
        "lessons": []
      },
      "HSF.LE.A.1.B": {
        "description": "Recognize situations in which one quantity changes at a constant rate per unit interval relative to another.",
        "lessons": []
      },
      "HSF.LE.A.1.C": {
        "description": "Recognize situations in which a quantity grows or decays by a constant percent rate per unit interval relative to another.",
        "lessons": []
      },
      "HSF.LE.A.2": {
        "description": "Construct linear and exponential functions, including arithmetic and geometric sequences, given a graph, a description of a relationship, or two input-output pairs (include reading these from a table).",
        "lessons": []
      },
      "HSF.LE.A.3": {
        "description": "Observe using graphs and tables that a quantity increasing exponentially eventually exceeds a quantity increasing linearly, quadratically, or (more generally) as a polynomial function.",
        "lessons": []
      },
      "HSF.LE.A.4": {
        "description": "For exponential models, express as a logarithm the solution to abct = d where a, c, and d are numbers and the base b is 2, 10, or e; evaluate the logarithm using technology.",
        "lessons": []
      },
      "HSF.LE.B": {
        "description": "Interpret expressions for functions in terms of the situation they model.",
        "lessons": []
      },
      "HSF.LE.B.5": {
        "description": "Interpret the parameters in a linear or exponential function in terms of a context.",
        "lessons": []
      },
      "HSF.TF.A": {
        "description": "Extend the domain of trigonometric functions using the unit circle.",
        "lessons": []
      },
      "HSF.TF.A.1": {
        "description": "Understand radian measure of an angle as the length of the arc on the unit circle subtended by the angle.",
        "lessons": []
      },
      "HSF.TF.A.2": {
        "description": "Explain how the unit circle in the coordinate plane enables the extension of trigonometric functions to all real numbers, interpreted as radian measures of angles traversed counterclockwise around the unit circle.",
        "lessons": []
      },
      "HSF.TF.A.3": {
        "description": "Use special triangles to determine geometrically the values of sine, cosine, tangent for π/3, π/4 and π/6, and use the unit circle to express the values of sine, cosine, and tangent for x, π + x, and 2π - x in terms of their values for x, where x is any real number.",
        "lessons": []
      },
      "HSF.TF.A.4": {
        "description": "Use the unit circle to explain symmetry (odd and even) and periodicity of trigonometric functions.",
        "lessons": []
      },
      "HSF.TF.B": {
        "description": "Model periodic phenomena with trigonometric functions.",
        "lessons": []
      },
      "HSF.TF.B.5": {
        "description": "Choose trigonometric functions to model periodic phenomena with specified amplitude, frequency, and midline.",
        "lessons": []
      },
      "HSF.TF.B.6": {
        "description": "Understand that restricting a trigonometric function to a domain on which it is always increasing or always decreasing allows its inverse to be constructed.",
        "lessons": []
      },
      "HSF.TF.B.7": {
        "description": "Use inverse functions to solve trigonometric equations that arise in modeling contexts; evaluate the solutions using technology, and interpret them in terms of the context.",
        "lessons": []
      },
      "HSF.TF.C": {
        "description": "Prove and apply trigonometric identities.",
        "lessons": []
      },
      "HSF.TF.C.8": {
        "description": "Prove the Pythagorean identity sin2(θ) + cos2(θ) = 1 and use it to find sin(θ), cos(θ), or tan(θ) given sin(θ), cos(θ), or tan(θ) and the quadrant of the angle.",
        "lessons": []
      },
      "HSF.TF.C.9": {
        "description": "Prove the addition and subtraction formulas for sine, cosine, and tangent and use them to solve problems.",
        "lessons": []
      },
      "HSG.CO.A": {
        "description": "Experiment with transformations in the plane.",
        "lessons": []
      },
      "HSG.CO.A.1": {
        "description": "Know precise definitions of angle, circle, perpendicular line, parallel line, and line segment, based on the undefined notions of point, line, distance along a line, and distance around a circular arc.",
        "lessons": []
      },
      "HSG.CO.A.2": {
        "description": "Represent transformations in the plane using, e.g., transparencies and geometry software; describe transformations as functions that take points in the plane as inputs and give other points as outputs. Compare transformations that preserve distance and angle to those that do not (e.g., translation versus horizontal stretch).",
        "lessons": []
      },
      "HSG.CO.A.3": {
        "description": "Given a rectangle, parallelogram, trapezoid, or regular polygon, describe the rotations and reflections that carry it onto itself.",
        "lessons": []
      },
      "HSG.CO.A.4": {
        "description": "Develop definitions of rotations, reflections, and translations in terms of angles, circles, perpendicular lines, parallel lines, and line segments.",
        "lessons": []
      },
      "HSG.CO.A.5": {
        "description": "Given a geometric figure and a rotation, reflection, or translation, draw the transformed figure using, e.g., graph paper, tracing paper, or geometry software. Specify a sequence of transformations that will carry a given figure onto another.",
        "lessons": []
      },
      "HSG.CO.B": {
        "description": "Understand congruence in terms of rigid motions",
        "lessons": []
      },
      "HSG.CO.B.6": {
        "description": "Use geometric descriptions of rigid motions to transform figures and to predict the effect of a given rigid motion on a given figure; given two figures, use the definition of congruence in terms of rigid motions to decide if they are congruent.",
        "lessons": []
      },
      "HSG.CO.B.7": {
        "description": "Use the definition of congruence in terms of rigid motions to show that two triangles are congruent if and only if corresponding pairs of sides and corresponding pairs of angles are congruent.",
        "lessons": []
      },
      "HSG.CO.B.8": {
        "description": "Explain how the criteria for triangle congruence (ASA, SAS, and SSS) follow from the definition of congruence in terms of rigid motions.",
        "lessons": []
      },
      "HSG.CO.C": {
        "description": "Prove geometric theorems.",
        "lessons": []
      },
      "HSG.CO.C.9": {
        "description": "Prove theorems about lines and angles.",
        "lessons": []
      },
      "HSG.CO.C.10": {
        "description": "Prove theorems about triangles.",
        "lessons": []
      },
      "HSG.CO.C.11": {
        "description": "Prove theorems about parallelograms.",
        "lessons": []
      },
      "HSG.CO.D": {
        "description": "Make geometric constructions.",
        "lessons": []
      },
      "HSG.CO.D.12": {
        "description": "Make formal geometric constructions with a variety of tools and methods.",
        "lessons": []
      },
      "HSG.CO.D.13": {
        "description": "Construct an equilateral triangle, a square, and a regular hexagon inscribed in a circle.",
        "lessons": []
      },
      "HSG.SRT.A": {
        "description": "Understand similarity in terms of similarity transformations.",
        "lessons": []
      },
      "HSG.SRT.A.1": {
        "description": "Verify experimentally the properties of dilations given by a center and a scale factor.",
        "lessons": []
      },
      "HSG.SRT.A.1.A": {
        "description": "A dilation takes a line not passing through the center of the dilation to a parallel line, and leaves a line passing through the center unchanged.",
        "lessons": []
      },
      "HSG.SRT.A.1.B": {
        "description": "The dilation of a line segment is longer or shorter in the ratio given by the scale factor.",
        "lessons": []
      },
      "HSG.SRT.A.2": {
        "description": "Given two figures, use the definition of similarity in terms of similarity transformations to decide if they are similar; explain using similarity transformations the meaning of similarity for triangles as the equality of all corresponding pairs of angles and the proportionality of all corresponding pairs of sides.",
        "lessons": []
      },
      "HSG.SRT.A.3": {
        "description": "Use the properties of similarity transformations to establish the AA criterion for two triangles to be similar.",
        "lessons": []
      },
      "HSG.SRT.B": {
        "description": "Prove theorems involving similarity.",
        "lessons": []
      },
      "HSG.SRT.B.4": {
        "description": "Prove theorems about triangles (similarity).",
        "lessons": []
      },
      "HSG.SRT.B.5": {
        "description": "Use congruence and similarity criteria for triangles to solve problems and to prove relationships in geometric figures.",
        "lessons": []
      },
      "HSG.SRT.C": {
        "description": "Define trigonometric ratios and solve problems involving right triangles.",
        "lessons": []
      },
      "HSG.SRT.C.6": {
        "description": "Understand that by similarity, side ratios in right triangles are properties of the angles in the triangle, leading to definitions of trigonometric ratios for acute angles.",
        "lessons": []
      },
      "HSG.SRT.C.7": {
        "description": "Explain and use the relationship between the sine and cosine of complementary angles.",
        "lessons": []
      },
      "HSG.SRT.C.8": {
        "description": "Use trigonometric ratios and the Pythagorean Theorem to solve right triangles in applied problems.",
        "lessons": []
      },
      "HSG.SRT.D": {
        "description": "Apply trigonometry to general triangles.",
        "lessons": []
      },
      "HSG.SRT.D.9": {
        "description": "Derive the formula A = 1/2 ab sin(C) for the area of a triangle by drawing an auxiliary line from a vertex perpendicular to the opposite side.",
        "lessons": []
      },
      "HSG.SRT.D.10": {
        "description": "Prove the Laws of Sines and Cosines and use them to solve problems.",
        "lessons": []
      },
      "HSG.SRT.D.11": {
        "description": "Understand and apply the Law of Sines and the Law of Cosines to find unknown measurements in right and non-right triangles.",
        "lessons": []
      },
      "HSG.C.A": {
        "description": "Understand and apply theorems about circles.",
        "lessons": []
      },
      "HSG.C.A.1": {
        "description": "Prove that all circles are similar.",
        "lessons": []
      },
      "HSG.C.A.2": {
        "description": "Identify and describe relationships among inscribed angles, radii, and chords.",
        "lessons": []
      },
      "HSG.C.A.3": {
        "description": "Construct the inscribed and circumscribed circles of a triangle, and prove properties of angles for a quadrilateral inscribed in a circle.",
        "lessons": []
      },
      "HSG.C.A.4": {
        "description": "Construct a tangent line from a point outside a given circle to the circle.",
        "lessons": []
      },
      "HSG.C.B": {
        "description": "Find arc lengths and areas of sectors of circles.",
        "lessons": []
      },
      "HSG.C.B.5": {
        "description": "Derive using similarity the fact that the length of the arc intercepted by an angle is proportional to the radius, and define the radian measure of the angle as the constant of proportionality; derive the formula for the area of a sector.",
        "lessons": []
      },
      "HSG.GPE.A": {
        "description": "Translate between the geometric description and the equation for a conic section.",
        "lessons": []
      },
      "HSG.GPE.A.1": {
        "description": "Derive the equation of a circle of given center and radius using the Pythagorean Theorem; complete the square to find the center and radius of a circle given by an equation.",
        "lessons": []
      },
      "HSG.GPE.A.2": {
        "description": "Derive the equation of a parabola given a focus and directrix.",
        "lessons": []
      },
      "HSG.GPE.A.3": {
        "description": "Derive the equations of ellipses and hyperbolas given the foci, using the fact that the sum or difference of distances from the foci is constant.",
        "lessons": []
      },
      "HSG.GPE.B": {
        "description": "Use coordinates to prove simple geometric theorems algebraically.",
        "lessons": []
      },
      "HSG.GPE.B.5": {
        "description": "Prove the slope criteria for parallel and perpendicular lines and use them to solve geometric problems.",
        "lessons": []
      },
      "HSG.GPE.B.6": {
        "description": "Find the point on a directed line segment between two given points that partitions the segment in a given ratio.",
        "lessons": []
      },
      "HSG.GPE.B.7": {
        "description": "Use coordinates to compute perimeters of polygons and areas of triangles and rectangles, e.g., using the distance formula.",
        "lessons": []
      },
      "HSG.GMD.A": {
        "description": "Explain volume formulas and use them to solve problems.",
        "lessons": []
      },
      "HSG.GMD.A.1": {
        "description": "Give an informal argument for the formulas for the circumference of a circle, area of a circle, volume of a cylinder, pyramid, and cone.",
        "lessons": []
      },
      "HSG.GMD.A.2": {
        "description": "Give an informal argument using Cavalieri's principle for the formulas for the volume of a sphere and other solid figures.",
        "lessons": []
      },
      "HSG.GMD.A.3": {
        "description": "Use volume formulas for cylinders, pyramids, cones, and spheres to solve problems.",
        "lessons": []
      },
      "HSG.GMD.B": {
        "description": "Visualize relationships between two-dimensional and three-dimensional objects.",
        "lessons": []
      },
      "HSG.GMD.B.4": {
        "description": "Identify the shapes of two-dimensional cross-sections of three-dimensional objects, and identify three-dimensional objects generated by rotations of two-dimensional objects.",
        "lessons": []
      },
      "HSG.MG.A": {
        "description": "Apply geometric concepts in modeling situations.",
        "lessons": []
      },
      "HSG.MG.A.1": {
        "description": "Use geometric shapes, their measures, and their properties to describe objects.",
        "lessons": []
      },
      "HSG.MG.A.2": {
        "description": "Apply concepts of density based on area and volume in modeling situations.",
        "lessons": []
      },
      "HSG.MG.A.3": {
        "description": "Apply geometric methods to solve design problems.",
        "lessons": []
      },
      "HSS.ID.A": {
        "description": "Summarize, represent, and interpret data on a single count or measurement variable.",
        "lessons": ["bar-and-pie-charts", "measures-of-center", "histograms", "histograms2", "box-plots", ]
      },
      "HSS.ID.A.1": {
        "description": "Represent data with plots on the real number line (dot plots, histograms, and box plots).",
        "lessons": ["standard-deviation", "box-plots", "histograms2", "histograms", ]
      },
      "HSS.ID.A.2": {
        "description": "Use statistics appropriate to the shape of the data distribution to compare center (median, mean) and spread (interquartile range, standard deviation) of two or more different data sets.",
        "lessons": ["standard-deviation", "box-plots", "measures-of-center", "histograms", ]
      },
      "HSS.ID.A.3": {
        "description": "Interpret differences in shape, center, and spread in the context of the data sets, accounting for possible effects of extreme data points (outliers).",
        "lessons": ["standard-deviation", "box-plots", "measures-of-center", "histograms2", "histograms", ]
      },
      "HSS.ID.A.4": {
        "description": "Use the mean and standard deviation of a data set to fit it to a normal distribution and to estimate population percentages. Recognize that there are data sets for which such a procedure is not appropriate. Use calculators, spreadsheets, and tables to estimate areas under the normal curve.",
        "lessons": []
      },
      "HSS.ID.B": {
        "description": "Summarize, represent, and interpret data on two categorical and quantitative variables.",
        "lessons": ["scatter-plots", "correlations", ]
      },
      "HSS.ID.B.5": {
        "description": "Summarize categorical data for two categories in two-way frequency tables. Interpret relative frequencies in the context of the data (including joint, marginal, and conditional relative frequencies). Recognize possible associations and trends in the data.",
        "lessons": []
      },
      "HSS.ID.B.6": {
        "description": "Represent data on two quantitative variables on a scatter plot, and describe how the variables are related.",
        "lessons": ["scatter-plots", "correlations", "hoc-data", ]
      },
      "HSS.ID.B.6.A": {
        "description": "Fit a function to the data; use functions fitted to data to solve problems in the context of the data. Use given functions or choose a function suggested by the context. Emphasize linear, quadratic, and exponential models.",
        "lessons": ["linear-regression", ]
      },
      "HSS.ID.B.6.B": {
        "description": "Informally assess the fit of a function by plotting and analyzing residuals.",
        "lessons": []
      },
      "HSS.ID.B.6.C": {
        "description": "Fit a linear function for a scatter plot that suggests a linear association.",
        "lessons": ["linear-regression", ]
      },
      "HSS.ID.C": {
        "description": "Interpret linear models.",
        "lessons": ["linear-regression", ]
      },
      "HSS.ID.C.7": {
        "description": "Interpret the slope (rate of change) and the intercept (constant term) of a linear model in the context of the data.",
        "lessons": ["linear-regression", ]
      },
      "HSS.ID.C.8": {
        "description": "Compute (using technology) and interpret the correlation coefficient of a linear fit.",
        "lessons": ["scatter-plots", "linear-regression", "correlations", ]
      },
      "HSS.ID.C.9": {
        "description": "Distinguish between correlation and causation.",
        "lessons": ["linear-regression", "correlations", ]
      },
      "HSS.IC.A": {
        "description": "Understand and evaluate random processes underlying statistical experiments.",
        "lessons": ["probability-inference", ]
      },
      "HSS.IC.A.1": {
        "description": "Understand statistics as a process for making inferences about population parameters based on a random sample from that population.",
        "lessons": ["probability-inference", ]
      },
      "HSS.IC.A.2": {
        "description": "Decide if a specified model is consistent with results from a given data-generating process, e.g., using simulation.",
        "lessons": []
      },
      "HSS.IC.B": {
        "description": "Make inferences and justify conclusions from sample surveys, experiments, and observational studies.",
        "lessons": ["data-collection", "hoc-data", ]
      },
      "HSS.IC.B.3": {
        "description": "Recognize the purposes of and differences among sample surveys, experiments, and observational studies; explain how randomization relates to each.",
        "lessons": ["probability-inference", "data-collection", ]
      },
      "HSS.IC.B.4": {
        "description": "Use data from a sample survey to estimate a population mean or proportion; develop a margin of error through the use of simulation models for random sampling.",
        "lessons": ["data-collection", ]
      },
      "HSS.IC.B.5": {
        "description": "Use data from a randomized experiment to compare two treatments; use simulations to decide if differences between parameters are significant.",
        "lessons": []
      },
      "HSS.IC.B.6": {
        "description": "Evaluate reports based on data.",
        "lessons": ["threats-to-validity", ]
      },
      "HSS.CP.A": {
        "description": "Understand independence and conditional probability and use them to interpret data.",
        "lessons": []
      },
      "HSS.CP.A.1": {
        "description": "Describe events as subsets of a sample space (the set of outcomes) using characteristics (or categories) of the outcomes, or as unions, intersections, or complements of other events ('or', 'and', 'not').",
        "lessons": ["inequalities2-compound", ]
      },
      "HSS.CP.A.2": {
        "description": "Understand that two events A and B are independent if the probability of A and B occurring together is the product of their probabilities, and use this characterization to determine if they are independent.",
        "lessons": []
      },
      "HSS.CP.A.3": {
        "description": "Understand the conditional probability of A given B as P(A and B)/P(B), and interpret independence of A and B as saying that the conditional probability of A given B is the same as the probability of A, and the conditional probability of B given A is the same as the probability of B.",
        "lessons": []
      },
      "HSS.CP.A.4": {
        "description": "Construct and interpret two-way frequency tables of data when two categories are associated with each object being classified. Use the two-way table as a sample space to decide if events are independent and to approximate conditional probabilities.",
        "lessons": []
      },
      "HSS.CP.A.5": {
        "description": "Recognize and explain the concepts of conditional probability and independence in everyday language and everyday situations.",
        "lessons": []
      },
      "HSS.CP.B": {
        "description": "Use the rules of probability to compute probabilities of compound events.",
        "lessons": []
      },
      "HSS.CP.B.6": {
        "description": "Find the conditional probability of A given B as the fraction of B's outcomes that also belong to A, and interpret the answer in terms of the model.",
        "lessons": []
      },
      "HSS.CP.B.7": {
        "description": "Apply the Addition Rule, P(A or B) = P(A) + P(B) - P(A and B), and interpret the answer in terms of the model.",
        "lessons": []
      },
      "HSS.CP.B.8": {
        "description": "Apply the general Multiplication Rule in a uniform probability model, P(A and B) = P(A)P(B|A) = P(B)P(A|B), and interpret the answer in terms of the model.",
        "lessons": []
      },
      "HSS.CP.B.9": {
        "description": "Use permutations and combinations to compute probabilities of compound events and solve problems.",
        "lessons": ["combinatorics-combination", "combinatorics-permutation", ]
      },
      "HSS.MD.A": {
        "description": "Calculate expected values and use them to solve problems.",
        "lessons": []
      },
      "HSS.MD.A.1": {
        "description": "Define a random variable for a quantity of interest by assigning a numerical value to each event in a sample space; graph the corresponding probability distribution using the same graphical displays as for data distributions.",
        "lessons": []
      },
      "HSS.MD.A.2": {
        "description": "Calculate the expected value of a random variable; interpret it as the mean of the probability distribution.",
        "lessons": []
      },
      "HSS.MD.A.3": {
        "description": "Develop a probability distribution for a random variable defined for a sample space in which theoretical probabilities can be calculated; find the expected value.",
        "lessons": []
      },
      "HSS.MD.A.4": {
        "description": "Develop a probability distribution for a random variable defined for a sample space in which probabilities are assigned empirically; find the expected value.",
        "lessons": []
      },
      "HSS.MD.B": {
        "description": "Use probability to evaluate outcomes of decisions.",
        "lessons": []
      },
      "HSS.MD.B.5": {
        "description": "Weigh the possible outcomes of a decision by assigning probabilities to payoff values and finding expected values.",
        "lessons": []
      },
      "HSS.MD.B.5.A": {
        "description": "Find the expected payoff for a game of chance.",
        "lessons": []
      },
      "HSS.MD.B.5.B": {
        "description": "Evaluate and compare strategies on the basis of expected values.",
        "lessons": []
      },
      "HSS.MD.B.6": {
        "description": "Use probabilities to make fair decisions.",
        "lessons": []
      },
      "HSS.MD.B.7": {
        "description": "Analyze decisions and strategies using probability concepts.",
        "lessons": []
      },
      "WHST.6-8.1": {
        "description": "Write arguments focused on discipline-specific content.",
        "lessons": []
      },
    },
    "CC-ELA": {
      "WHST.6-8.1.A": {
        "description": "Introduce claim(s) about a topic or issue, acknowledge and distinguish the claim(s) from alternate or opposing claims, and organize the reasons and evidence logically.",
        "lessons": []
      },
      "WHST.6-8.1.B": {
        "description": "Support claim(s) with logical reasoning and relevant, accurate data and evidence that demonstrate an understanding of the topic or text, using credible sources.",
        "lessons": []
      },
      "WHST.6-8.1.C": {
        "description": "Use words, phrases, and clauses to create cohesion and clarify the relationships among claim(s), counterclaims, reasons, and evidence.",
        "lessons": []
      },
      "WHST.6-8.1.D": {
        "description": "Establish and maintain a formal style.",
        "lessons": []
      },
      "WHST.6-8.1.E": {
        "description": "Provide a concluding statement or section that follows from and supports the argument presented.",
        "lessons": []
      },
      "WHST.6-8.2": {
        "description": "Write informative/explanatory texts, including the narration of historical events, scientific procedures/ experiments, or technical processes.",
        "lessons": []
      },
      "WHST.6-8.2.A": {
        "description": "Introduce a topic clearly, previewing what is to follow; organize ideas, concepts, and information into broader categories as appropriate to achieving purpose; include formatting (e.g., headings), graphics (e.g., charts, tables), and multimedia when useful to aiding comprehension.",
        "lessons": []
      },
      "WHST.6-8.2.B": {
        "description": "Develop the topic with relevant, well-chosen facts, definitions, concrete details, quotations, or other information and examples.",
        "lessons": []
      },
      "WHST.6-8.2.C": {
        "description": "Use appropriate and varied transitions to create cohesion and clarify the relationships among ideas and concepts.",
        "lessons": []
      },
      "WHST.6-8.2.D": {
        "description": "Use precise language and domain-specific vocabulary to inform about or explain the topic.",
        "lessons": []
      },
      "WHST.6-8.2.E": {
        "description": "Establish and maintain a formal style and objective tone.",
        "lessons": []
      },
      "WHST.6-8.2.F": {
        "description": "Provide a concluding statement or section that follows from and supports the information or explanation presented.",
        "lessons": []
      },
      "WHST.6-8.4": {
        "description": "Produce clear and coherent writing in which the development, organization, and style are appropriate to task, purpose, and audience.",
        "lessons": []
      },
      "WHST.6-8.5": {
        "description": "With some guidance and support from peers and adults, develop and strengthen writing as needed by planning, revising, editing, rewriting, or trying a new approach, focusing on how well purpose and audience have been addressed.",
        "lessons": []
      },
      "WHST.6-8.6": {
        "description": "Use technology, including the Internet, to produce and publish writing and present the relationships between information and ideas clearly and efficiently.",
        "lessons": []
      },
      "WHST.6-8.7": {
        "description": "Conduct short research projects to answer a question (including a self-generated question), drawing on several sources and generating additional related, focused questions that allow for multiple avenues of exploration.",
        "lessons": []
      },
      "WHST.6-8.8": {
        "description": "Gather relevant information from multiple print and digital sources, using search terms effectively; assess the credibility and accuracy of each source; and quote or paraphrase the data and conclusions of others while avoiding plagiarism and following a standard format for citation.",
        "lessons": []
      },
      "WHST.6-8.9": {
        "description": "Draw evidence from informational texts to support analysis, reflection, and research.",
        "lessons": []
      },
      "WHST.6-8.10": {
        "description": "Write routinely over extended time frames (time for reflection and revision) and shorter time frames (a single sitting or a day or two) for a range of discipline-specific tasks, purposes, and audiences.",
        "lessons": []
      },
      "RST.6-8.1": {
        "description": "Cite specific textual evidence to support analysis of science and technical texts.",
        "lessons": []
      },
      "RST.6-8.2": {
        "description": "Determine the central ideas or conclusions of a text; provide an accurate summary of the text distinct from prior knowledge or opinions.",
        "lessons": []
      },
      "RST.6-8.3": {
        "description": "Follow precisely a multistep procedure when carrying out experiments, taking measurements, or performing technical tasks.",
        "lessons": []
      },
      "RST.6-8.4": {
        "description": "Determine the meaning of symbols, key terms, and other domain-specific words and phrases as they are used in a specific scientific or technical context relevant to grades 6-8 texts and topics.",
        "lessons": []
      },
      "RST.6-8.5": {
        "description": "Analyze the structure an author uses to organize a text, including how the major sections contribute to the whole and to an understanding of the topic.",
        "lessons": []
      },
      "RST.6-8.6": {
        "description": "Analyze the author's purpose in providing an explanation, describing a procedure, or discussing an experiment in a text.",
        "lessons": []
      },
      "RST.6-8.7": {
        "description": "Integrate quantitative or technical information expressed in words in a text with a version of that information expressed visually (e.g., in a flowchart, diagram, model, graph, or table).",
        "lessons": []
      },
      "RST.6-8.8": {
        "description": "Distinguish among facts, reasoned judgment based on research findings, and speculation in a text.",
        "lessons": []
      },
      "RST.6-8.9": {
        "description": "Compare and contrast the information gained from experiments, simulations, video, or multimedia sources with that gained from reading a text on the same topic.",
        "lessons": []
      },
      "RST.6-8.10": {
        "description": "By the end of grade 8, read and comprehend science/technical texts in the grades 6-8 text complexity band independently and proficiently.",
        "lessons": []
      },
      "WHST.9-10.1": {
        "description": "Write arguments focused on discipline-specific content.",
        "lessons": []
      },
      "WHST.9-10.1.A": {
        "description": "Introduce precise claim(s), distinguish the claim(s) from alternate or opposing claims, and create an organization that establishes clear relationships among the claim(s), counterclaims, reasons, and evidence.",
        "lessons": []
      },
      "WHST.9-10.1.B": {
        "description": "Develop claim(s) and counterclaims fairly, supplying data and evidence for each while pointing out the strengths and limitations of both claim(s) and counterclaims in a discipline-appropriate form and in a manner that anticipates the audience's knowledge level and concerns.",
        "lessons": []
      },
      "WHST.9-10.1.C": {
        "description": "Use words, phrases, and clauses to link the major sections of the text, create cohesion, and clarify the relationships between claim(s) and reasons, between reasons and evidence, and between claim(s) and counterclaims.",
        "lessons": []
      },
      "WHST.9-10.1.D": {
        "description": "Establish and maintain a formal style and objective tone while attending to the norms and conventions of the discipline in which they are writing.",
        "lessons": []
      },
      "WHST.9-10.1.E": {
        "description": "Provide a concluding statement or section that follows from or supports the argument presented.",
        "lessons": []
      },
      "WHST.9-10.2": {
        "description": "Write informative/explanatory texts, including the narration of historical events, scientific procedures/ experiments, or technical processes.",
        "lessons": []
      },
      "WHST.9-10.2.A": {
        "description": "Introduce a topic and organize ideas, concepts, and information to make important connections and distinctions; include formatting (e.g., headings), graphics (e.g., figures, tables), and multimedia when useful to aiding comprehension.",
        "lessons": []
      },
      "WHST.9-10.2.B": {
        "description": "Develop the topic with well-chosen, relevant, and sufficient facts, extended definitions, concrete details, quotations, or other information and examples appropriate to the audience's knowledge of the topic.",
        "lessons": []
      },
      "WHST.9-10.2.C": {
        "description": "Use varied transitions and sentence structures to link the major sections of the text, create cohesion, and clarify the relationships among ideas and concepts.",
        "lessons": []
      },
      "WHST.9-10.2.D": {
        "description": "Use precise language and domain-specific vocabulary to manage the complexity of the topic and convey a style appropriate to the discipline and context as well as to the expertise of likely readers.",
        "lessons": []
      },
      "WHST.9-10.2.E": {
        "description": "Establish and maintain a formal style and objective tone while attending to the norms and conventions of the discipline in which they are writing.",
        "lessons": []
      },
      "WHST.9-10.2.F": {
        "description": "Provide a concluding statement or section that follows from and supports the information or explanation presented (e.g., articulating implications or the significance of the topic).",
        "lessons": []
      },
      "WHST.9-10.4": {
        "description": "Produce clear and coherent writing in which the development, organization, and style are appropriate to task, purpose, and audience.",
        "lessons": []
      },
      "WHST.9-10.5": {
        "description": "Develop and strengthen writing as needed by planning, revising, editing, rewriting, or trying a new approach, focusing on addressing what is most significant for a specific purpose and audience.",
        "lessons": []
      },
      "WHST.9-10.6": {
        "description": "Use technology, including the Internet, to produce, publish, and update individual or shared writing products, taking advantage of technology's capacity to link to other information and to display information flexibly and dynamically.",
        "lessons": []
      },
      "WHST.9-10.7": {
        "description": "Conduct short as well as more sustained research projects to answer a question (including a self-generated question) or solve a problem; narrow or broaden the inquiry when appropriate; synthesize multiple sources on the subject, demonstrating understanding of the subject under investigation.",
        "lessons": []
      },
      "WHST.9-10.8": {
        "description": "Gather relevant information from multiple authoritative print and digital sources, using advanced searches effectively; assess the usefulness of each source in answering the research question; integrate information into the text selectively to maintain the flow of ideas, avoiding plagiarism and following a standard format for citation.",
        "lessons": []
      },
      "WHST.9-10.9": {
        "description": "Draw evidence from informational texts to support analysis, reflection, and research.",
        "lessons": []
      },
      "WHST.9-10.10": {
        "description": "Write routinely over extended time frames (time for reflection and revision) and shorter time frames (a single sitting or a day or two) for a range of discipline-specific tasks, purposes, and audiences.",
        "lessons": []
      },
      "RST.9-10.1": {
        "description": "Cite specific textual evidence to support analysis of science and technical texts, attending to the precise details of explanations or descriptions.",
        "lessons": []
      },
      "RST.9-10.2": {
        "description": "Determine the central ideas or conclusions of a text; trace the text's explanation or depiction of a complex process, phenomenon, or concept; provide an accurate summary of the text.",
        "lessons": []
      },
      "RST.9-10.3": {
        "description": "Follow precisely a complex multistep procedure when carrying out experiments, taking measurements, or performing technical tasks, attending to special cases or exceptions defined in the text.",
        "lessons": []
      },
      "RST.9-10.4": {
        "description": "Determine the meaning of symbols, key terms, and other domain-specific words and phrases as they are used in a specific scientific or technical context relevant to grades 9-10 texts and topics.",
        "lessons": []
      },
      "RST.9-10.5": {
        "description": "Analyze the structure of the relationships among concepts in a text, including relationships among key terms (e.g., force, friction, reaction force, energy).",
        "lessons": []
      },
      "RST.9-10.6": {
        "description": "Analyze the author's purpose in providing an explanation, describing a procedure, or discussing an experiment in a text, defining the question the author seeks to address.",
        "lessons": []
      },
      "RST.9-10.7": {
        "description": "Translate quantitative or technical information expressed in words in a text into visual form (e.g., a table or chart) and translate information expressed visually or mathematically (e.g., in an equation) into words.",
        "lessons": []
      },
      "RST.9-10.8": {
        "description": "Assess the extent to which the reasoning and evidence in a text support the author's claim or a recommendation for solving a scientific or technical problem.",
        "lessons": []
      },
      "RST.9-10.9": {
        "description": "Compare and contrast findings presented in a text to those from other sources (including their own experiments), noting when the findings support or contradict previous explanations or accounts.",
        "lessons": []
      },
      "RST.9-10.10": {
        "description": "By the end of grade 10, read and comprehend science/technical texts in the grades 9-10 text complexity band independently and proficiently.",
        "lessons": []
      },
      "WHST.11-12.1": {
        "description": "Write arguments focused on discipline-specific content.",
        "lessons": []
      },
      "WHST.11-12.1.A": {
        "description": "Introduce precise, knowledgeable claim(s), establish the significance of the claim(s), distinguish the claim(s) from alternate or opposing claims, and create an organization that logically sequences the claim(s), counterclaims, reasons, and evidence.",
        "lessons": []
      },
      "WHST.11-12.1.B": {
        "description": "Develop claim(s) and counterclaims fairly and thoroughly, supplying the most relevant data and evidence for each while pointing out the strengths and limitations of both claim(s) and counterclaims in a discipline-appropriate form that anticipates the audience's knowledge level, concerns, values, and possible biases.",
        "lessons": []
      },
      "WHST.11-12.1.C": {
        "description": "Use words, phrases, and clauses as well as varied syntax to link the major sections of the text, create cohesion, and clarify the relationships between claim(s) and reasons, between reasons and evidence, and between claim(s) and counterclaims.",
        "lessons": []
      },
      "WHST.11-12.1.D": {
        "description": "Establish and maintain a formal style and objective tone while attending to the norms and conventions of the discipline in which they are writing.",
        "lessons": []
      },
      "WHST.11-12.1.E": {
        "description": "Provide a concluding statement or section that follows from or supports the argument presented.",
        "lessons": []
      },
      "WHST.11-12.2": {
        "description": "Write informative/explanatory texts, including the narration of historical events, scientific procedures/experiments, or technical processes.",
        "lessons": []
      },
      "WHST.11-12.2.A": {
        "description": "Introduce a topic and organize complex ideas, concepts, and information so that each new element builds on that which precedes it to create a unified whole; include formatting (e.g., headings), graphics (e.g., figures, tables), and multimedia when useful to aiding comprehension.",
        "lessons": []
      },
      "WHST.11-12.2.B": {
        "description": "Develop the topic thoroughly by selecting the most significant and relevant facts, extended definitions, concrete details, quotations, or other information and examples appropriate to the audience's knowledge of the topic.",
        "lessons": []
      },
      "WHST.11-12.2.C": {
        "description": "Use varied transitions and sentence structures to link the major sections of the text, create cohesion, and clarify the relationships among complex ideas and concepts.",
        "lessons": []
      },
      "WHST.11-12.2.D": {
        "description": "Use precise language, domain-specific vocabulary and techniques such as metaphor, simile, and analogy to manage the complexity of the topic; convey a knowledgeable stance in a style that responds to the discipline and context as well as to the expertise of likely readers.",
        "lessons": []
      },
      "WHST.11-12.2.E": {
        "description": "Provide a concluding statement or section that follows from and supports the information or explanation provided (e.g., articulating implications or the significance of the topic).",
        "lessons": []
      },
      "WHST.11-12.4": {
        "description": "Produce clear and coherent writing in which the development, organization, and style are appropriate to task, purpose, and audience.",
        "lessons": []
      },
      "WHST.11-12.5": {
        "description": "Develop and strengthen writing as needed by planning, revising, editing, rewriting, or trying a new approach, focusing on addressing what is most significant for a specific purpose and audience.",
        "lessons": []
      },
      "WHST.11-12.6": {
        "description": "Use technology, including the Internet, to produce, publish, and update individual or shared writing products in response to ongoing feedback, including new arguments or information.",
        "lessons": []
      },
      "WHST.11-12.7": {
        "description": "Conduct short as well as more sustained research projects to answer a question (including a self-generated question) or solve a problem; narrow or broaden the inquiry when appropriate; synthesize multiple sources on the subject, demonstrating understanding of the subject under investigation.",
        "lessons": []
      },
      "WHST.11-12.8": {
        "description": "Gather relevant information from multiple authoritative print and digital sources, using advanced searches effectively; assess the strengths and limitations of each source in terms of the specific task, purpose, and audience; integrate information into the text selectively to maintain the flow of ideas, avoiding plagiarism and overreliance on any one source and following a standard format for citation.",
        "lessons": []
      },
      "WHST.11-12.9": {
        "description": "Draw evidence from informational texts to support analysis, reflection, and research.",
        "lessons": []
      },
      "WHST.11-12.10": {
        "description": "Write routinely over extended time frames (time for reflection and revision) and shorter time frames (a single sitting or a day or two) for a range of discipline-specific tasks, purposes, and audiences.",
        "lessons": []
      },
      "RST.11-12.1": {
        "description": "Cite specific textual evidence to support analysis of science and technical texts, attending to important distinctions the author makes and to any gaps or inconsistencies in the account.",
        "lessons": []
      },
      "RST.11-12.2": {
        "description": "Determine the central ideas or conclusions of a text; summarize complex concepts, processes, or information presented in a text by paraphrasing them in simpler but still accurate terms.",
        "lessons": []
      },
      "RST.11-12.3": {
        "description": "Follow precisely a complex multistep procedure when carrying out experiments, taking measurements, or performing technical tasks; analyze the specific results based on explanations in the text.",
        "lessons": []
      },
      "RST.11-12.4": {
        "description": "Determine the meaning of symbols, key terms, and other domain-specific words and phrases as they are used in a specific scientific or technical context relevant to grades 11-12 texts and topics.",
        "lessons": []
      },
      "RST.11-12.5": {
        "description": "Analyze how the text structures information or ideas into categories or hierarchies, demonstrating understanding of the information or ideas.",
        "lessons": []
      },
      "RST.11-12.6": {
        "description": "Analyze the author's purpose in providing an explanation, describing a procedure, or discussing an experiment in a text, identifying important issues that remain unresolved.",
        "lessons": []
      },
      "RST.11-12.7": {
        "description": "Integrate and evaluate multiple sources of information presented in diverse formats and media (e.g., quantitative data, video, multimedia) in order to address a question or solve a problem.",
        "lessons": []
      },
      "RST.11-12.8": {
        "description": "Evaluate the hypotheses, data, analysis, and conclusions in a science or technical text, verifying the data when possible and corroborating or challenging conclusions with other sources of information.",
        "lessons": []
      },
      "RST.11-12.9": {
        "description": "Synthesize information from a range of sources (e.g., texts, experiments, simulations) into a coherent understanding of a process, phenomenon, or concept, resolving conflicting information when possible.",
        "lessons": []
      },
      "RST.11-12.10": {
        "description": "By the end of grade 12, read and comprehend science/technical texts in the grades 11-CCR text complexity band independently and proficiently.",
        "lessons": []
      },
      "SL.6.1": {
        "description": "Engage effectively in a range of collaborative discussions (one-on-one, in groups, and teacher-led) with diverse partners on grade 6 topics, texts, and issues, building on others' ideas and expressing their own clearly.",
        "lessons": []
      },
      "SL.6.1.A": {
        "description": "Come to discussions prepared, having read or studied required material; explicitly draw on that preparation by referring to evidence on the topic, text, or issue to probe and reflect on ideas under discussion.",
        "lessons": []
      },
      "SL.6.1.B": {
        "description": "Follow rules for collegial discussions, set specific goals and deadlines, and define individual roles as needed.",
        "lessons": []
      },
      "SL.6.1.C": {
        "description": "Pose and respond to specific questions with elaboration and detail by making comments that contribute to the topic, text, or issue under discussion.",
        "lessons": []
      },
      "SL.6.1.D": {
        "description": "Review the key ideas expressed and demonstrate understanding of multiple perspectives through reflection and paraphrasing.",
        "lessons": []
      },
      "SL.6.2": {
        "description": "Interpret information presented in diverse media and formats (e.g., visually, quantitatively, orally) and explain how it contributes to a topic, text, or issue under study.",
        "lessons": []
      },
      "SL.6.3": {
        "description": "Delineate a speaker's argument and specific claims, distinguishing claims that are supported by reasons and evidence from claims that are not.",
        "lessons": []
      },
      "SL.6.4": {
        "description": "Present claims and findings, sequencing ideas logically and using pertinent descriptions, facts, and details to accentuate main ideas or themes; use appropriate eye contact, adequate volume, and clear pronunciation.",
        "lessons": []
      },
      "SL.6.5": {
        "description": "Include multimedia components (e.g., graphics, images, music, sound) and visual displays in presentations to clarify information.",
        "lessons": []
      },
      "SL.6.6": {
        "description": "Adapt speech to a variety of contexts and tasks, demonstrating command of formal English when indicated or appropriate. (See grade 6 Language standards 1 and 3 for specific expectations.)",
        "lessons": []
      },
      "SL.7.1": {
        "description": "Engage effectively in a range of collaborative discussions (one-on-one, in groups, and teacher-led) with diverse partners on grade 7 topics, texts, and issues, building on others' ideas and expressing their own clearly.",
        "lessons": []
      },
      "SL.7.1.A": {
        "description": "Come to discussions prepared, having read or researched material under study; explicitly draw on that preparation by referring to evidence on the topic, text, or issue to probe and reflect on ideas under discussion.",
        "lessons": []
      },
      "SL.7.1.B": {
        "description": "Follow rules for collegial discussions, track progress toward specific goals and deadlines, and define individual roles as needed.",
        "lessons": []
      },
      "SL.7.1.C": {
        "description": "Pose questions that elicit elaboration and respond to others' questions and comments with relevant observations and ideas that bring the discussion back on topic as needed.",
        "lessons": []
      },
      "SL.7.1.D": {
        "description": "Acknowledge new information expressed by others and, when warranted, modify their own views.",
        "lessons": []
      },
      "SL.7.2": {
        "description": "Analyze the main ideas and supporting details presented in diverse media and formats (e.g., visually, quantitatively, orally) and explain how the ideas clarify a topic, text, or issue under study.",
        "lessons": []
      },
      "SL.7.3": {
        "description": "Delineate a speaker's argument and specific claims, evaluating the soundness of the reasoning and the relevance and sufficiency of the evidence.",
        "lessons": []
      },
      "SL.7.4": {
        "description": "Present claims and findings, emphasizing salient points in a focused, coherent manner with pertinent descriptions, facts, details, and examples; use appropriate eye contact, adequate volume, and clear pronunciation.",
        "lessons": []
      },
      "SL.7.5": {
        "description": "Include multimedia components and visual displays in presentations to clarify claims and findings and emphasize salient points.",
        "lessons": []
      },
      "SL.7.6": {
        "description": "Adapt speech to a variety of contexts and tasks, demonstrating command of formal English when indicated or appropriate. (See grade 7 Language standards 1 and 3 here for specific expectations.)",
        "lessons": []
      },
      "SL.8.1": {
        "description": "Engage effectively in a range of collaborative discussions (one-on-one, in groups, and teacher-led) with diverse partners on grade 8 topics, texts, and issues, building on others' ideas and expressing their own clearly.",
        "lessons": []
      },
      "SL.8.1.A": {
        "description": "Come to discussions prepared, having read or researched material under study; explicitly draw on that preparation by referring to evidence on the topic, text, or issue to probe and reflect on ideas under discussion.",
        "lessons": []
      },
      "SL.8.1.B": {
        "description": "Follow rules for collegial discussions and decision-making, track progress toward specific goals and deadlines, and define individual roles as needed.",
        "lessons": []
      },
      "SL.8.1.C": {
        "description": "Pose questions that connect the ideas of several speakers and respond to others' questions and comments with relevant evidence, observations, and ideas.",
        "lessons": []
      },
      "SL.8.1.D": {
        "description": "Acknowledge new information expressed by others, and, when warranted, qualify or justify their own views in light of the evidence presented.",
        "lessons": []
      },
      "SL.8.2": {
        "description": "Analyze the purpose of information presented in diverse media and formats (e.g., visually, quantitatively, orally) and evaluate the motives (e.g., social, commercial, political) behind its presentation.",
        "lessons": []
      },
      "SL.8.3": {
        "description": "Delineate a speaker's argument and specific claims, evaluating the soundness of the reasoning and relevance and sufficiency of the evidence and identifying when irrelevant evidence is introduced.",
        "lessons": []
      },
      "SL.8.4": {
        "description": "Present claims and findings, emphasizing salient points in a focused, coherent manner with relevant evidence, sound valid reasoning, and well-chosen details; use appropriate eye contact, adequate volume, and clear pronunciation.",
        "lessons": []
      },
      "SL.8.5": {
        "description": "Integrate multimedia and visual displays into presentations to clarify information, strengthen claims and evidence, and add interest.",
        "lessons": []
      },
      "SL.8.6": {
        "description": "Adapt speech to a variety of contexts and tasks, demonstrating command of formal English when indicated or appropriate. (See grade 8 Language standards 1 and 3 here for specific expectations.)",
        "lessons": []
      },
      "SL.9-10.1": {
        "description": "Initiate and participate effectively in a range of collaborative discussions (one-on-one, in groups, and teacher-led) with diverse partners on grades 9-10 topics, texts, and issues, building on others' ideas and expressing their own clearly and persuasively.",
        "lessons": ["ds-intro", ]
      },
      "SL.9-10.1.A": {
        "description": "Come to discussions prepared, having read and researched material under study; explicitly draw on that preparation by referring to evidence from texts and other research on the topic or issue to stimulate a thoughtful, well-reasoned exchange of ideas.",
        "lessons": []
      },
      "SL.9-10.1.B": {
        "description": "Work with peers to set rules for collegial discussions and decision-making (e.g., informal consensus, taking votes on key issues, presentation of alternate views), clear goals and deadlines, and individual roles as needed.",
        "lessons": []
      },
      "SL.9-10.1.C": {
        "description": "Propel conversations by posing and responding to questions that relate the current discussion to broader themes or larger ideas; actively incorporate others into the discussion; and clarify, verify, or challenge ideas and conclusions.",
        "lessons": []
      },
      "SL.9-10.1.D": {
        "description": "Respond thoughtfully to diverse perspectives, summarize points of agreement and disagreement, and, when warranted, qualify or justify their own views and understanding and make new connections in light of the evidence and reasoning presented.",
        "lessons": []
      },
      "SL.9-10.2": {
        "description": "Integrate multiple sources of information presented in diverse media or formats (e.g., visually, quantitatively, orally) evaluating the credibility and accuracy of each source.",
        "lessons": []
      },
      "SL.9-10.3": {
        "description": "Evaluate a speaker's point of view, reasoning, and use of evidence and rhetoric, identifying any fallacious reasoning or exaggerated or distorted evidence.",
        "lessons": []
      },
      "SL.9-10.4": {
        "description": "Present information, findings, and supporting evidence clearly, concisely, and logically such that listeners can follow the line of reasoning and the organization, development, substance, and style are appropriate to purpose, audience, and task.",
        "lessons": []
      },
      "SL.9-10.5": {
        "description": "Make strategic use of digital media (e.g., textual, graphical, audio, visual, and interactive elements) in presentations to enhance understanding of findings, reasoning, and evidence and to add interest.",
        "lessons": []
      },
      "SL.9-10.6": {
        "description": "Adapt speech to a variety of contexts and tasks, demonstrating command of formal English when indicated or appropriate. (See grades 9-10 Language standards 1 and 3 here for specific expectations.)",
        "lessons": []
      },
      "SL.11-12.1": {
        "description": "Initiate and participate effectively in a range of collaborative discussions (one-on-one, in groups, and teacher-led) with diverse partners on grades 11-12 topics, texts, and issues, building on others' ideas and expressing their own clearly and persuasively.",
        "lessons": []
      },
      "SL.11-12.1.A": {
        "description": "Come to discussions prepared, having read and researched material under study; explicitly draw on that preparation by referring to evidence from texts and other research on the topic or issue to stimulate a thoughtful, well-reasoned exchange of ideas.",
        "lessons": []
      },
      "SL.11-12.1.B": {
        "description": "Work with peers to set rules for collegial discussions and decision-making (e.g., informal consensus, taking votes on key issues, presentation of alternate views), clear goals and deadlines, and individual roles as needed.",
        "lessons": []
      },
      "SL.11-12.1.C": {
        "description": "Propel conversations by posing and responding to questions that relate the current discussion to broader themes or larger ideas; actively incorporate others into the discussion; and clarify, verify, or challenge ideas and conclusions.",
        "lessons": []
      },
      "SL.11-12.1.D": {
        "description": "Respond thoughtfully to diverse perspectives, summarize points of agreement and disagreement, and, when warranted, qualify or justify their own views and understanding and make new connections in light of the evidence and reasoning presented.",
        "lessons": []
      },
      "SL.11-12.2": {
        "description": "Integrate multiple sources of information presented in diverse media or formats (e.g., visually, quantitatively, orally) evaluating the credibility and accuracy of each source.",
        "lessons": []
      },
      "SL.11-12.3": {
        "description": "Evaluate a speaker's point of view, reasoning, and use of evidence and rhetoric, identifying any fallacious reasoning or exaggerated or distorted evidence.",
        "lessons": []
      },
      "SL.11-12.4": {
        "description": "Present information, findings, and supporting evidence clearly, concisely, and logically such that listeners can follow the line of reasoning and the organization, development, substance, and style are appropriate to purpose, audience, and task.",
        "lessons": []
      },
      "SL.11-12.5": {
        "description": "Make strategic use of digital media (e.g., textual, graphical, audio, visual, and interactive elements) in presentations to enhance understanding of findings, reasoning, and evidence and to add interest.",
        "lessons": []
      },
      "SL.11-12.6": {
        "description": "Adapt speech to a variety of contexts and tasks, demonstrating command of formal English when indicated or appropriate. (See grades 9-10 Language standards 1 and 3 here for specific expectations.)",
        "lessons": []
      },
    },
    "CSTA": {
      "1B-CS-01": {
        "description": "Describe how internal and external parts of computing devices function to form a system.",
        "lessons": []
      },
      "1B-CS-02": {
        "description": "Model how computer hardware and software work together as a system to accomplish tasks.",
        "lessons": []
      },
      "1B-CS-03": {
        "description": "Determine potential solutions to solve simple hardware and software problems using common troubleshooting strategies.",
        "lessons": []
      },
      "2-CS-01": {
        "description": "Recommend improvements to the design of computing devices, based on an analysis of how users interact with the devices.",
        "lessons": []
      },
      "2-CS-02": {
        "description": "Design projects that combine hardware and software components to collect and exchange data.",
        "lessons": []
      },
      "2-CS-03": {
        "description": "Systematically identify and fix problems with computing devices and their components.",
        "lessons": []
      },
      "3A-CS-01": {
        "description": "Explain how abstractions hide the underlying implementation details of computing systems embedded in everyday objects.",
        "lessons": []
      },
      "3A-CS-02": {
        "description": "Compare levels of abstraction and interactions between application software, system software, and hardware layers",
        "lessons": []
      },
      "3A-CS-03": {
        "description": "Develop guidelines that convey systematic troubleshooting strategies that others can use to identify and fix errors",
        "lessons": []
      },
      "3B-CS-01": {
        "description": "Categorize the roles of operating system software.",
        "lessons": []
      },
      "3B-CS-02": {
        "description": "Illustrate ways computing systems implement logic, input, and output through hardware components",
        "lessons": []
      },
      "1B-NI-04": {
        "description": "Model how information is broken down into smaller pieces, transmitted as packets through multiple devices over networks and the Internet, and reassembled at the destination.",
        "lessons": []
      },
      "1B-NI-05": {
        "description": "Discuss real-world cybersecurity problems and how personal information can be protected.",
        "lessons": []
      },
      "2-NI-04": {
        "description": "Model the role of protocols in transmitting data across networks and the Internet.",
        "lessons": []
      },
      "2-NI-05": {
        "description": "Explain how physical and digital security measures protect electronic information.",
        "lessons": []
      },
      "2-NI-06": {
        "description": "Apply multiple methods of encryption to model the secure transmission of information",
        "lessons": []
      },
      "3A-NI-04": {
        "description": "Evaluate the scalability and reliability of networks, by describing the relationship between routers, switches, servers, topology, and addressing.",
        "lessons": []
      },
      "3A-NI-05": {
        "description": "Give examples to illustrate how sensitive data can be affected by malware and other attacks",
        "lessons": []
      },
      "3A-NI-06": {
        "description": "Recommend security measures to address various scenarios based on factors such as efficiency, feasibility, and ethical impacts.",
        "lessons": []
      },
      "3A-NI-07": {
        "description": "Compare various security measures, considering tradeoffs between the usability and security of a computing system",
        "lessons": []
      },
      "3A-NI-08": {
        "description": "Explain tradeoffs when selecting and implementing cybersecurity recommendations.",
        "lessons": []
      },
      "3B-NI-03": {
        "description": "Describe the issues that impact network functionality (e.g., bandwidth, load, delay, topology).",
        "lessons": []
      },
      "3B-NI-04": {
        "description": "Compare ways software developers protect devices and information from unauthorized access.",
        "lessons": []
      },
      "3B-NI-05": {
        "description": "Use data analysis tools and techniques to identify patterns in data representing complex systems",
        "lessons": ["scatter-plots", "linear-regression", "advanced-displays", "correlations", ]
      },
      "3B-NI-06": {
        "description": "Select data collection tools and techniques to generate data sets that support a claim or communicate information.",
        "lessons": ["project-research-paper", ]
      },
      "3B-NI-07": {
        "description": "Evaluate the ability of models and simulations to test and support the refinement of hypotheses.",
        "lessons": ["threats-to-validity", "correlations", ]
      },
      "1B-DA-06": {
        "description": "Organize and present collected data visually to highlight relationships and support a claim.",
        "lessons": ["project-research-paper", "project-exploration-paper", "scatter-plots", "standard-deviation", "box-plots", "linear-regression", "histograms2", "correlations", ]
      },
      "1B-DA-07": {
        "description": "Use data to highlight or propose cause-and-effect relationships, predict outcomes, or communicate an idea.",
        "lessons": ["project-research-paper", "project-exploration-paper", "scatter-plots", "linear-regression", "hoc-data", ]
      },
      "2-DA-07": {
        "description": "Represent data using multiple encoding schemes.",
        "lessons": ["project-video-game", ]
      },
      "2-DA-08": {
        "description": "Collect data using computational tools and transform the data to make it more useful and reliable.",
        "lessons": ["project-research-paper", "project-exploration-paper", "table-methods", "probability-inference", "advanced-displays", "grouped-samples", "bar-and-pie-charts", ]
      },
      "2-DA-09": {
        "description": "Refine computational models based on the data they have generated.",
        "lessons": ["project-research-paper", "project-exploration-paper", "scatter-plots", "probability-inference", "grouped-samples", "correlations", ]
      },
      "3A-DA-09": {
        "description": "Translate between different bit representations of real-world phenomena, such as characters, numbers, and images.",
        "lessons": ["hoc-winter-parley", ]
      },
      "3A-DA-10": {
        "description": "Evaluate the tradeoffs in how data elements are organized and where data is stored.",
        "lessons": []
      },
      "3A-DA-11": {
        "description": "Create interactive data visualizations using software tools to help others better understand real-world phenomena.",
        "lessons": ["project-research-paper", "project-exploration-paper", "scatter-plots", "standard-deviation", "box-plots", "linear-regression", "histograms2", "histograms", "bar-and-pie-charts", "choosing-your-dataset", ]
      },
      "3A-DA-12": {
        "description": "Create computational models that represent the relationships among different elements of data collected from a phenomenon or process.",
        "lessons": ["project-research-paper", "project-exploration-paper", "scatter-plots", "linear-regression", ]
      },
      "1B-AP-08": {
        "description": "Compare and refine multiple algorithms for the same task and determine which is the most appropriate.",
        "lessons": ["order-of-operations", "commutative-property", "associative-property", "equivalence", "identity-property", "distributive-property", ]
      },
      "1B-AP-09": {
        "description": "Create programs that use variables to store and modify data.",
        "lessons": ["re-adding-collisions", "re-build-your-own-animation", "re-your-own-drawing-functions", "re-key-events", "re-structures-reactors-animations", "project-research-paper", "project-exploration-paper", "project-video-game", "defining-values", "equivalence", ]
      },
      "1B-AP-10": {
        "description": "Create programs that include sequences, events, loops, and conditionals.",
        "lessons": ["re-adding-collisions", "re-key-events", "re-structures-reactors-animations", "project-research-paper", "project-exploration-paper", "composing-table-operations", "advanced-displays", "project-video-game", "player-animation", "functions-for-character-animation", "piecewise-functions-conditionals", ]
      },
      "1B-AP-11": {
        "description": "Decompose (break down) problems into smaller, manageable subproblems to facilitate the program development process.",
        "lessons": ["re-nested-structures", "re-refactoring", "project-research-paper", "project-exploration-paper", "choosing-your-dataset", "project-video-game", "problem-decomposition", "order-of-operations", "commutative-property", "associative-property", "equivalence", "identity-property", "distributive-property", "absolute-value-and-opposites", "absolute-value-and-opposites-2", "evaluating-exponents", "exponent-expressions-with-negatives", ]
      },
      "1B-AP-12": {
        "description": "Modify, remix, or incorporate portions of an existing program into one's own work, to develop something new or add more advanced features.",
        "lessons": ["hoc-winter-parley", "re-refactoring", "re-key-events", "re-structures-reactors-animations", "re-intro-to-data-structures", "project-research-paper", "project-exploration-paper", "advanced-displays", "project-video-game", "player-animation", "making-game-images", "piecewise-functions-conditionals", ]
      },
      "1B-AP-13": {
        "description": "Use an iterative process to plan the development of a program by including others' perspectives and considering user preferences.",
        "lessons": ["project-research-paper", "project-exploration-paper", "project-video-game", ]
      },
      "1B-AP-14": {
        "description": "Observe intellectual property rights and give appropriate attribution when creating or remixing programs.",
        "lessons": ["project-video-game", "making-game-images", ]
      },
      "1B-AP-15": {
        "description": "Test and debug (identify and fix errors) a program or algorithm to ensure it runs as intended.",
        "lessons": ["hoc-winter-parley", "re-refactoring", "project-research-paper", "project-exploration-paper", "checking-your-work", "project-video-game", "debugging", "functions-make-life-easier", "commutative-property", "associative-property", "equivalence", "identity-property", "distributive-property", "absolute-value-and-opposites", "absolute-value-and-opposites-2", "evaluating-exponents", "exponent-expressions-with-negatives", ]
      },
      "1B-AP-16": {
        "description": "Take on varying roles, with teacher guidance, when collaborating with peers during the design, implementation, and review stages of program development.",
        "lessons": ["project-research-paper", "project-exploration-paper", "project-video-game", ]
      },
      "1B-AP-17": {
        "description": "Describe choices made during program development using code comments, presentations, and demonstrations.",
        "lessons": ["re-functions-that-ask-questions", "re-intro-to-data-structures", "project-research-paper", "project-exploration-paper", "order-of-operations", "commutative-property", "associative-property", "equivalence", "identity-property", "distributive-property", "absolute-value-and-opposites", "absolute-value-and-opposites-2", "evaluating-exponents", "exponent-expressions-with-negatives", ]
      },
      "2-AP-10": {
        "description": "Use flowcharts and/or pseudocode to address complex problems as algorithms",
        "lessons": ["re-structures-reactors-animations", "order-of-operations", "commutative-property", "associative-property", "equivalence", "identity-property", "distributive-property", "absolute-value-and-opposites", "absolute-value-and-opposites-2", "evaluating-exponents", "exponent-expressions-with-negatives", ]
      },
      "2-AP-11": {
        "description": "Create clearly named variables that represent different data types and perform operations on their values.",
        "lessons": ["re-structures-reactors-animations", "re-intro-to-data-structures", "project-research-paper", "project-exploration-paper", "advanced-displays", "grouped-samples", "project-video-game", "surface-area-rect-prism", "problem-decomposition", "player-animation", "inequalities-collision", "functions-for-character-animation", "function-composition", "distance-formula", "simple-data-types", "piecewise-functions-conditionals", "defining-values", "functions-make-life-easier", ]
      },
      "2-AP-12": {
        "description": "Design and iteratively develop programs that combine control structures, including nested loops and compound conditionals",
        "lessons": ["re-nested-structures", "re-making-pong", "re-adding-levels", "re-build-your-own-animation", "project-research-paper", "project-exploration-paper", ]
      },
      "2-AP-13": {
        "description": "Decompose problems and subproblems into parts to facilitate the design, implementation, and review of programs",
        "lessons": ["re-nested-structures", "re-refactoring", "project-research-paper", "project-exploration-paper", "composing-table-operations", "defining-table-functions", "project-video-game", "problem-decomposition", "order-of-operations", "commutative-property", "associative-property", "equivalence", "identity-property", "distributive-property", "absolute-value-and-opposites", "absolute-value-and-opposites-2", "evaluating-exponents", "exponent-expressions-with-negatives", ]
      },
      "2-AP-14": {
        "description": "Create procedures with parameters to organize code and make it easier to reuse.",
        "lessons": ["re-scoring", "re-your-own-drawing-functions", "re-refactoring", "re-key-events", "re-functions-that-ask-questions", "re-intro-to-data-structures", "project-research-paper", "project-exploration-paper", "defining-table-functions", "project-video-game", "functions-make-life-easier", ]
      },
      "2-AP-15": {
        "description": "Seek and incorporate feedback from team members and users to refine a solution that meets user needs.",
        "lessons": ["project-video-game", ]
      },
      "2-AP-16": {
        "description": "Incorporate existing code, media, and libraries into original programs, and give attribution.",
        "lessons": ["project-research-paper", "project-exploration-paper", "project-video-game", "making-game-images", ]
      },
      "2-AP-17": {
        "description": "Systematically test and refine programs using a range of test cases",
        "lessons": ["re-making-pong", "re-scoring", "re-key-events", "re-functions-that-ask-questions", "project-research-paper", "project-exploration-paper", "composing-table-operations", "advanced-displays", "defining-table-functions", "checking-your-work", "project-video-game", "surface-area-rect-prism", "problem-decomposition", "player-animation", "inequalities-collision", "functions-for-character-animation", "function-composition", "distance-formula", "piecewise-functions-conditionals", "functions-make-life-easier", ]
      },
      "2-AP-18": {
        "description": "Distribute tasks and maintain a project timeline when collaboratively developing computational artifacts.",
        "lessons": []
      },
      "2-AP-19": {
        "description": "Document programs in order to make them easier to follow, test, and debug.",
        "lessons": ["project-research-paper", "project-exploration-paper", "advanced-displays", "project-video-game", "surface-area-rect-prism", "problem-decomposition", "player-animation", "inequalities-collision", "functions-for-character-animation", "function-composition", "distance-formula", "piecewise-functions-conditionals", "functions-make-life-easier", ]
      },
      "3A-AP-13": {
        "description": "Create prototypes that use algorithms to solve computational problems by leveraging prior student knowledge and personal interests.",
        "lessons": ["project-research-paper", "project-exploration-paper", ]
      },
      "3A-AP-14": {
        "description": "Use lists to simplify solutions, generalizing computational problems instead of repeatedly using simple variables",
        "lessons": ["project-research-paper", "project-exploration-paper", ]
      },
      "3A-AP-15": {
        "description": "Justify the selection of specific control structures when tradeoffs involve implementation, readability, and program performance, and explain the benefits and drawbacks of choices made.",
        "lessons": []
      },
      "3A-AP-16": {
        "description": "Design and iteratively develop computational artifacts for practical intent, personal expression, or to address a societal issue by using events to initiate instructions.",
        "lessons": ["re-build-your-own-animation", "re-your-own-drawing-functions", "project-research-paper", "project-exploration-paper", "ethics-privacy-and-bias", "choosing-your-dataset", "project-video-game", "player-animation", "functions-for-character-animation", ]
      },
      "3A-AP-17": {
        "description": "Decompose problems into smaller components through systematic analysis, using constructs such as procedures, modules, and/or objects.",
        "lessons": ["re-nested-structures", "re-refactoring", "project-research-paper", "project-exploration-paper", "composing-table-operations", "defining-table-functions", "choosing-your-dataset", "project-video-game", "problem-decomposition", ]
      },
      "3A-AP-18": {
        "description": "Create artifacts by using procedures within a program, combinations of data and procedures, or independent but interrelated programs.",
        "lessons": ["re-timers", "re-adding-levels", "re-scoring", "project-research-paper", "project-exploration-paper", "composing-table-operations", "defining-table-functions", "project-video-game", "making-game-images", "flags", ]
      },
      "3A-AP-19": {
        "description": "Systematically design and develop programs for broad audiences by incorporating feedback from users",
        "lessons": []
      },
      "3A-AP-20": {
        "description": "Evaluate licenses that limit or restrict use of computational artifacts when using resources such as libraries",
        "lessons": ["making-game-images", ]
      },
      "3A-AP-21": {
        "description": "Evaluate and refine computational artifacts to make them more usable and accessible.",
        "lessons": []
      },
      "3A-AP-22": {
        "description": "Design and develop computational artifacts working in team roles using collaborative tools",
        "lessons": ["project-research-paper", "project-exploration-paper", "project-video-game", ]
      },
      "3A-AP-23": {
        "description": "Document design decisions using text, graphics, presentations, and/or demonstrations in the development of complex programs.",
        "lessons": ["project-research-paper", "project-exploration-paper", "choosing-your-dataset", ]
      },
      "3B-AP-08": {
        "description": "Describe how artificial intelligence drives many software and physical systems.",
        "lessons": []
      },
      "3B-AP-09": {
        "description": "Implement an artificial intelligence algorithm to play a game against a human opponent or solve a problem.",
        "lessons": []
      },
      "3B-AP-10": {
        "description": "Use and adapt classic algorithms to solve computational problems.",
        "lessons": ["inequalities3-sam", "inequalities2-compound", "inequalities1-simple", "distance-formula", ]
      },
      "3B-AP-11": {
        "description": "Evaluate algorithms in terms of their efficiency, correctness, and clarity.",
        "lessons": ["commutative-property", "associative-property", "equivalence", "identity-property", "distributive-property", "absolute-value-and-opposites", "absolute-value-and-opposites-2", "evaluating-exponents", "exponent-expressions-with-negatives", ]
      },
      "3B-AP-12": {
        "description": "Compare and contrast fundamental data structures and their uses.",
        "lessons": []
      },
      "3B-AP-13": {
        "description": "Illustrate the flow of execution of a recursive algorithm",
        "lessons": ["re-structures-reactors-animations", ]
      },
      "3B-AP-14": {
        "description": "Construct solutions to problems using student-created components, such as procedures, modules and/or objects.",
        "lessons": ["re-timers", "re-adding-levels", "re-adding-collisions", "project-research-paper", "project-exploration-paper", "advanced-displays", "histograms2", "histograms", "choosing-your-dataset", "project-video-game", "problem-decomposition", "player-animation", "inequalities-collision", "functions-for-character-animation", "distance-formula", "piecewise-functions-conditionals", "functions-make-life-easier", ]
      },
      "3B-AP-15": {
        "description": "Analyze a large-scale computational problem and identify generalizable patterns that can be applied to a solution",
        "lessons": ["re-nested-structures", "re-refactoring", ]
      },
      "3B-AP-16": {
        "description": "Demonstrate code reuse by creating programming solutions using libraries and APIs.",
        "lessons": ["project-research-paper", "project-exploration-paper", "project-video-game", ]
      },
      "3B-AP-17": {
        "description": "Plan and develop programs for broad audiences using a software life cycle process.",
        "lessons": []
      },
      "3B-AP-18": {
        "description": "Explain security issues that might lead to compromised computer programs",
        "lessons": []
      },
      "3B-AP-19": {
        "description": "Develop programs for multiple computing platforms.",
        "lessons": []
      },
      "3B-AP-20": {
        "description": "Use version control systems, integrated development environments (IDEs), and collaborative tools and practices (code documentation) in a group software project.",
        "lessons": []
      },
      "3B-AP-21": {
        "description": "Develop and use a series of test cases to verify that a program performs according to its design specifications.",
        "lessons": ["re-functions-that-ask-questions", "project-research-paper", "project-exploration-paper", "checking-your-work", "project-video-game", "problem-decomposition", "player-animation", "inequalities-collision", "functions-for-character-animation", "function-composition", "distance-formula", "piecewise-functions-conditionals", "functions-make-life-easier", ]
      },
      "3B-AP-22": {
        "description": "Modify an existing program to add additional functionality and discuss intended and unintended implications (e.g., breaking other functionality).",
        "lessons": ["re-timers", "re-scoring", "re-functions-that-ask-questions", "project-research-paper", "project-exploration-paper", "project-video-game", "player-animation", ]
      },
      "3B-AP-23": {
        "description": "Evaluate key qualities of a program through a process such as a code review",
        "lessons": ["project-research-paper", "project-exploration-paper", "project-video-game", ]
      },
      "3B-AP-24": {
        "description": "Compare multiple programming languages and discuss how their features make them suitable for solving different types of problems.",
        "lessons": []
      },
      "1B-IC-18": {
        "description": "Discuss computing technologies that have changed the world, and express how those technologies influence, and are influenced by, cultural practices.",
        "lessons": ["project-research-paper", "project-exploration-paper", ]
      },
      "1B-IC-19": {
        "description": "Brainstorm ways to improve the accessibility and usability of technology products for the diverse needs and wants of users.",
        "lessons": []
      },
      "1B-IC-20": {
        "description": "Seek diverse perspectives for the purpose of improving computational artifacts.",
        "lessons": []
      },
      "1B-IC-21": {
        "description": "Use public domain or creative commons media, and refrain from copying or using material created by others without permission.",
        "lessons": ["project-video-game", "making-game-images", ]
      },
      "2-IC-20": {
        "description": "Compare tradeoffs associated with computing technologies that affect people's everyday activities and career options.",
        "lessons": []
      },
      "2-IC-21": {
        "description": "Discuss issues of bias and accessibility in the design of existing technologies",
        "lessons": ["project-research-paper", "project-exploration-paper", "threats-to-validity", ]
      },
      "2-IC-22": {
        "description": "Collaborate with many contributors through strategies such as crowdsourcing or surveys when creating a computational artifact.",
        "lessons": []
      },
      "2-IC-23": {
        "description": "Describe tradeoffs between allowing information to be public and keeping information private and secure.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
      "3A-IC-24": {
        "description": "Evaluate the ways computing impacts personal, ethical, social, economic, and cultural practices",
        "lessons": ["project-research-paper", "project-exploration-paper", "ethics-privacy-and-bias", ]
      },
      "3A-IC-25": {
        "description": "Test and refine computational artifacts to reduce bias and equity deficits.",
        "lessons": ["project-research-paper", "project-exploration-paper", ]
      },
      "3A-IC-26": {
        "description": "Demonstrate ways a given algorithm applies to problems across disciplines.",
        "lessons": []
      },
      "3A-IC-27": {
        "description": "Use tools and methods for collaboration on a project to increase connectivity of people in different cultures and career fields",
        "lessons": []
      },
      "3A-IC-28": {
        "description": "Explain the beneficial and harmful effects that intellectual property laws can have on innovation.",
        "lessons": []
      },
      "3A-IC-29": {
        "description": "Explain the privacy concerns related to the collection and generation of data through automated processes that may not be evident to users.",
        "lessons": ["project-research-paper", "project-exploration-paper", "ethics-privacy-and-bias", ]
      },
      "3A-IC-30": {
        "description": "Evaluate the social and economic implications of privacy in the context of safety, law, or ethics.",
        "lessons": ["project-research-paper", "project-exploration-paper", "ethics-privacy-and-bias", ]
      },
      "3B-IC-25": {
        "description": "Evaluate computational artifacts to maximize their beneficial effects and minimize harmful effects on society.",
        "lessons": ["project-research-paper", "project-exploration-paper", ]
      },
      "3B-IC-26": {
        "description": "Evaluate the impact of equity, access, and influence on the distribution of computing resources in a global society.",
        "lessons": ["project-research-paper", "project-exploration-paper", ]
      },
      "3B-IC-27": {
        "description": "Predict how computational innovations that have revolutionized aspects of our culture might evolve.",
        "lessons": []
      },
      "3B-IC-28": {
        "description": "Debate laws and regulations that impact the development and use of software.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
    },
    "K12CS": {
      "9-12.Computing Systems.Devices": {
        "description": "Computing devices are often integrated with other systems, including biological, mechanical, and social systems. These devices can share data with one another. The usability, dependability, security, and accessibility of these devices, and the systems they are integrated with, are important considerations in their design as they evolve.",
        "lessons": []
      },
      "6-8.Computing Systems.Devices": {
        "description": "The interaction between humans and computing devices presents advantages, disadvantages, and unintended consequences. The study of human–computer interaction can improve the design of devices and extend the abilities of humans.",
        "lessons": ["hoc-data", ]
      },
      "9-12.Computing Systems.Hardware and Software": {
        "description": "Levels of interaction exist between the hardware, software, and user of a computing system. The most common levels of software that a user interacts with include system software and applications. System software controls the flow of information between hardware components used for input, output, storage, and processing.",
        "lessons": []
      },
      "6-8.Computing Systems.Hardware and Software": {
        "description": "Hardware and software determine a computing system’s capability to store and process information. The design or selection of a computing system involves multiple considerations and potential tradeoffs, such as functionality, cost, size, speed, accessibility, and aesthetics.",
        "lessons": []
      },
      "9-12.Computing Systems.Troubleshooting": {
        "description": "Troubleshooting complex problems involves the use of multiple sources when researching, evaluating, and implementing potential solutions. Troubleshooting also relies on experience, such as when people recognize that a problem is similar to one they have seen before or adapt solutions that have worked in the past.",
        "lessons": ["checking-your-work", ]
      },
      "6-8.Computing Systems.Troubleshooting": {
        "description": "Comprehensive troubleshooting requires knowledge of how computing devices and components work and interact. A systematic process will identify the source of a problem, whether within a device or in a larger system of connected devices.",
        "lessons": ["checking-your-work", ]
      },
      "9-12.Networks and the Internet.Network Communication and Organization": {
        "description": "Network topology is determined, in part, by how many devices can be supported. Each device is assigned an address that uniquely identifies it on the network. The scalability and reliability of the Internet are enabled by the hierarchy and redundancy in networks.",
        "lessons": []
      },
      "6-8.Networks and the Internet.Network Communication and Organization": {
        "description": "Computers send and receive information based on a set of rules called protocols. Protocols define how messages between computers are structured and sent. Considerations of security, speed, and reliability are used to determine the best path to send and receive data.",
        "lessons": []
      },
      "9-12.Networks and the Internet.Cybersecurity": {
        "description": "Network security depends on a combination of hardware, software, and practices that control access to data and systems. The needs of users and the sensitivity of data determine the level of security implemented.",
        "lessons": []
      },
      "6-8.Networks and the Internet.Cybersecurity": {
        "description": "The information sent and received across networks can be protected from unauthorized access and modification in a variety of ways, such as encryption to maintain its confidentiality and restricted access to maintain its integrity. Security measures to safeguard online information proactively address the threat of breaches to personal and private data.",
        "lessons": []
      },
      "9-12.Data and Analysis.Collection": {
        "description": "Data is constantly collected or generated through automated processes that are not always evident, raising privacy concerns. The different collection methods and tools that are used influence the amount and quality of the data that is observed and recorded.",
        "lessons": ["data-collection", "ethics-privacy-and-bias", ]
      },
      "6-8.Data and Analysis.Collection": {
        "description": "People design algorithms and tools to automate the collection of data by computers. When data collection is automated, data is sampled and converted into a form that a computer can process. For example, data from an analog sensor must be converted into a digital form. The method used to automate data collection is influenced by the availability of tools and the intended use of the data.",
        "lessons": ["data-collection", "threats-to-validity", ]
      },
      "9-12.Data and Analysis.Storage": {
        "description": "Data can be composed of multiple data elements that relate to one another. For example, population data may contain information about age, gender, and height. People make choices about how data elements are organized and where data is stored. These choices affect cost, speed, reliability, accessibility, privacy, and integrity.",
        "lessons": []
      },
      "6-8.Data and Analysis.Storage": {
        "description": "Applications store data as a representation. Representations occur at multiple levels, from the arrangement of information into organized formats (such as tables in software) to the physical storage of bits. The software tools used to access information translate the low-level representation of bits into a form understandable by people.",
        "lessons": []
      },
      "9-12.Data and Analysis.Visualization and Transformation": {
        "description": "Data can be transformed to remove errors, highlight or expose relationships, and/or make it easier for computers to process.",
        "lessons": ["scatter-plots", "standard-deviation", "box-plots", "histograms2", "choosing-your-dataset", ]
      },
      "6-8.Data and Analysis.Visualization and Transformation": {
        "description": "Computer models can be used to simulate events, examine theories and inferences, or make predictions with either few or millions of data points. Computer models are abstractions that represent phenomena and use data and algorithms to emphasize key features and relationships within a system. As more data is automatically collected, models can be refined.",
        "lessons": ["scatter-plots", "correlations", "linear-regression", ]
      },
      "9-12.Data and Analysis.Inference and Models": {
        "description": "The accuracy of predictions or inferences depends upon the limitations of the computer model and the data the model is built upon. The amount, quality, and diversity of data and the features chosen can affect the quality of a model and ability to understand a system. Predictions or inferences are tested to validate models.",
        "lessons": ["threats-to-validity", "linear-regression", ]
      },
      "6-8.Data and Analysis.Inference and Models": {
        "description": "People transform, generalize, simplify, and present large data sets in different ways to influence how other people interpret and understand the underlying information. Examples include visualization, aggregation, rearrangement, and application of mathematical operations.",
        "lessons": ["standard-deviation", "box-plots", "measures-of-center", "advanced-displays", "choosing-your-dataset", ]
      },
      "9-12.Algorithms and Programming.Algorithms": {
        "description": "People evaluate and select algorithms based on performance, reusability, and ease of implementation. Knowledge of common algorithms improves how people develop software, secure data, and store information.",
        "lessons": []
      },
      "6-8.Algorithms and Programming.Algorithms": {
        "description": "Algorithms affect how people interact with computers and the way computers respond. People design algorithms that are generalizable to many situations. Algorithms that are readable are easier to follow, test, and debug.",
        "lessons": []
      },
      "9-12.Algorithms and Programming.Variables": {
        "description": "Data structures are used to manage program complexity. Programmers choose data structures based on functionality, storage, and performance tradeoffs.",
        "lessons": ["re-intro-to-data-structures", "re-nested-structures", ]
      },
      "6-8.Algorithms and Programming.Variables": {
        "description": "Programmers create variables to store data values of selected types. A meaningful identifier is assigned to each variable to access and perform operations on the value by name. Variables enable the flexibility to represent different situations, process different sets of data, and produce varying outputs.",
        "lessons": ["re-intro-to-data-structures", "defining-values", "functions-dr", "inequalities3-sam", "inequalities-collision", "functions-for-character-animation", "re-functions-that-ask-questions", "re-refactoring", "re-key-events", "re-timers", "re-timers", "hoc-winter-parley", ]
      },
      "9-12.Algorithms and Programming.Control": {
        "description": "Programmers consider tradeoffs related to implementation, readability, and program performance when selecting and combining control structures.",
        "lessons": ["composing-table-operations", "advanced-displays", "piecewise-functions-conditionals", ]
      },
      "6-8.Algorithms and Programming.Control": {
        "description": "Programmers select and combine control structures, such as loops, event handlers, and conditionals, to create more complex program behavior.",
        "lessons": ["re-intro-to-data-structures", "defining-values", "functions-dr", "inequalities3-sam", "inequalities-collision", "functions-for-character-animation", "re-functions-that-ask-questions", "re-refactoring", "re-key-events", "re-timers", "re-timers", "composing-table-operations", "codap-transformers-1", "codap-transformers-2", ]
      },
      "9-12.Algorithms and Programming.Modularity": {
        "description": "Complex programs are designed as systems of interacting modules, each with a specific role, coordinating for a common overall purpose. These modules can be procedures within a program; combinations of data and procedures; or independent, but interrelated, programs. Modules allow for better management of complex tasks.",
        "lessons": ["composing-table-operations", "defining-table-functions", "functions-make-life-easier", ]
      },
      "6-8.Algorithms and Programming.Modularity": {
        "description": "Programs use procedures to organize code, hide implementation details, and make code easier to reuse. Procedures can be repurposed in new programs. Defining parameters for procedures can generalize behavior and increase reusability.",
        "lessons": ["re-refactoring", "defining-table-functions", "functions-make-life-easier", "inequalities3-sam", ]
      },
      "9-12.Algorithms and Programming.Program Development": {
        "description": "Diverse teams can develop programs with a broad impact through careful review and by drawing on the strengths of members in different roles. Design decisions often involve tradeoffs. The development of complex programs is aided by resources such as libraries and tools to edit and manage parts of the program. Systematic analysis is critical for identifying the effects of lingering bugs.",
        "lessons": []
      },
      "6-8.Algorithms and Programming.Program Development": {
        "description": "People design meaningful solutions for others by defining a problem’s criteria and constraints, carefully considering the diverse needs and wants of the community, and testing whether criteria and constraints were met.",
        "lessons": []
      },
      "9-12.Impacts of Computing.Culture": {
        "description": "The design and use of computing technologies and artifacts can improve, worsen, or maintain inequitable access to information and opportunities.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
      "6-8.Impacts of Computing.Culture": {
        "description": "Advancements in computing technology change people’s everyday activities. Society is faced with tradeoffs due to the increasing globalization and automation that computing brings.",
        "lessons": []
      },
      "9-12.Impacts of Computing.Social Interactions": {
        "description": "Many aspects of society, especially careers, have been affected by the degree of communication afforded by computing. The increased connectivity between people in different cultures and in different career fields has changed the nature and content of many careers.",
        "lessons": ["computing-needs-all-voices", ]
      },
      "6-8.Impacts of Computing.Social Interactions": {
        "description": "People can organize and engage around issues and topics of interest through various communication platforms enabled by computing, such as social networks and media outlets. These interactions allow issues to be examined using multiple viewpoints from a diverse audience.",
        "lessons": []
      },
      "9-12.Impacts of Computing.Safety, Law, and Ethics": {
        "description": "Laws govern many aspects of computing, such as privacy, data, property, information, and identity. These laws can have beneficial and harmful effects, such as expediting or delaying advancements in computing and protecting or infringing upon people’s rights. International differences in laws and ethics have implications for computing.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
      "6-8.Impacts of Computing.Safety, Law, and Ethics": {
        "description": "There are tradeoffs between allowing information to be public and keeping information private and secure. People can be tricked into revealing personal information when more public information is available about them online.",
        "lessons": []
      },
    },
    "NGSS": {
      "MS-SEP1-1": {
        "description": "Ask questions that require sufficient and appropriate empirical evidence to answer.",
        "lessons": []
      },
      "MS-SEP1-2": {
        "description": "Ask questions that arise from careful observation of phenomena, models, or unexpected results, to clarify and/or seek additional information.",
        "lessons": ["hoc-data", ]
      },
      "MS-SEP1-3": {
        "description": "Ask questions to identify and/or clarify evidence and/or the premise(s) of an argument.",
        "lessons": []
      },
      "MS-SEP1-4": {
        "description": "Ask questions to determine relationships between independent and dependent variables and relationships in models.",
        "lessons": []
      },
      "MS-SEP1-5": {
        "description": "Ask questions to clarify and/or refine a model, an explanation, or an engineering problem.",
        "lessons": []
      },
      "MS-SEP1-6": {
        "description": "Ask questions that can be investigated within the scope of the classroom, outdoor environment, and museums and other public facilities with available resources and, when appropriate, frame a hypothesis based on observations and scientific principles.",
        "lessons": []
      },
      "MS-SEP1-7": {
        "description": "Define a design problem that can be solved through the development of an object, tool, process or system and includes multiple criteria and constraints, including scientific knowledge that may limit possible solutions.",
        "lessons": []
      },
      "MS-SEP1-8": {
        "description": "Ask questions that challenge the premise(s) of an argument or the interpretation of a data set.",
        "lessons": ["hoc-data", ]
      },
      "HS-SEP1-1": {
        "description": "Ask questions that arise from careful observation of phenomena, or unexpected results, to clarify and/or seek additional information.",
        "lessons": []
      },
      "HS-SEP1-2": {
        "description": "Ask questions that arise from examining models or a theory, to clarify and/or seek additional information and relationships.",
        "lessons": []
      },
      "HS-SEP1-3": {
        "description": "Ask questions to determine relationships, including quantitative relationships, between independent and dependent variables.",
        "lessons": []
      },
      "HS-SEP1-4": {
        "description": "Ask questions to clarify and refine a model, an explanation, or an engineering problem.",
        "lessons": []
      },
      "HS-SEP1-5": {
        "description": "Evaluate a question to determine if it is testable and relevant.",
        "lessons": []
      },
      "HS-SEP1-6": {
        "description": "Ask questions that can be investigated within the scope of the school laboratory, research facilities, or field (e.g., outdoor environment) with available resources and, when appropriate, frame a hypothesis based on a model or theory.",
        "lessons": []
      },
      "HS-SEP1-7": {
        "description": "Ask and/or evaluate questions that challenge the premise(s) of an argument, the interpretation of a data set, or the suitability of the design.",
        "lessons": []
      },
      "HS-SEP1-8": {
        "description": "Define a design problem that involves the development of a process or system with interacting components and criteria and constraints that may include social, technical and/or environmental considerations.",
        "lessons": []
      },
      "HS-SEP1-9": {
        "description": "Analyze complex real-world problems by specifying criteria and constraints for successful solutions.",
        "lessons": []
      },
      "MS-SEP2-1": {
        "description": "Evaluate limitations of a model for a proposed object or tool.",
        "lessons": []
      },
      "MS-SEP2-2": {
        "description": "Develop or modify a model—based on evidence – to match what happens if a variable or component of a system is changed.",
        "lessons": []
      },
      "MS-SEP2-3": {
        "description": "Use and/or develop a model of simple systems with uncertain and less predictable factors.",
        "lessons": []
      },
      "MS-SEP2-4": {
        "description": "Develop and/or revise a model to show the relationships among variables, including those that are not observable but predict observable phenomena.",
        "lessons": []
      },
      "MS-SEP2-5": {
        "description": "Develop and/or use a model to predict and/or describe phenomena.",
        "lessons": []
      },
      "MS-SEP2-6": {
        "description": "Develop a model to describe unobservable mechanisms.",
        "lessons": []
      },
      "MS-SEP2-7": {
        "description": "Develop and/or use a model to generate data to test ideas about phenomena in natural or designed systems, including those representing inputs and outputs, and those at unobservable scales.",
        "lessons": []
      },
      "HS-SEP2-1": {
        "description": "Evaluate merits and limitations of two different models of the same proposed tool, process, mechanism, or system in order to select or revise a model that best fits the evidence or design criteria.",
        "lessons": []
      },
      "HS-SEP2-2": {
        "description": "Design a test of a model to ascertain its reliability.",
        "lessons": []
      },
      "HS-SEP2-3": {
        "description": "Develop, revise, and/or use a model based on evidence to illustrate and/or predict the relationships between systems or between components of a system.",
        "lessons": []
      },
      "HS-SEP2-4": {
        "description": "Develop and/or use multiple types of models to provide mechanistic accounts and/or predict phenomena, and move flexibly between model types based on merits and limitations.",
        "lessons": []
      },
      "HS-SEP2-5": {
        "description": "Use a model to provide mechanistic accounts of phenomena.",
        "lessons": []
      },
      "HS-SEP2-6": {
        "description": "Develop a complex model that allows for manipulation and testing of a proposed process or system.",
        "lessons": []
      },
      "HS-SEP2-7": {
        "description": "Develop and/or use a model (including mathematical and computational) to generate data to support explanations, predict phenomena, analyze systems, and/or solve problems.",
        "lessons": []
      },
      "MS-SEP3-1": {
        "description": "Plan an investigation individually and collaboratively, and in the design: identify independent and dependent variables and controls, what tools are needed to do the gathering, how measurements will be recorded, and how many data are needed to support a claim.",
        "lessons": []
      },
      "MS-SEP3-2": {
        "description": "Conduct an investigation and/or evaluate and/or revise the experimental design to produce data to serve as the basis for evidence that meet the goals of the investigation.",
        "lessons": []
      },
      "MS-SEP3-3": {
        "description": "Evaluate the accuracy of various methods for collecting data.",
        "lessons": []
      },
      "MS-SEP3-4": {
        "description": "Collect data to produce data to serve as the basis for evidence to answer scientific questions or test design solutions under a range of conditions.",
        "lessons": []
      },
      "MS-SEP3-5": {
        "description": "Collect data about the performance of a proposed object, tool, process, or system under a range of conditions.",
        "lessons": []
      },
      "HS-SEP3-1": {
        "description": "Plan an investigation or test a design individually and collaboratively to produce data to serve as the basis for evidence as part of building and revising models, supporting explanations for phenomena, or testing solutions to problems. Consider possible variables or effects and evaluate the confounding investigation’s design to ensure variables are controlled.",
        "lessons": []
      },
      "HS-SEP3-2": {
        "description": "Plan and conduct an investigation individually and collaboratively to produce data to serve as the basis for evidence, and in the design: decide on types, how much, and accuracy of data needed to produce reliable measurements and consider limitations on the precision of the data (e.g., number of trials, cost, risk, time), and refine the design accordingly.",
        "lessons": []
      },
      "HS-SEP3-3": {
        "description": "Plan and conduct an investigation or test a design solution in a safe and ethical manner including considerations of environmental, social, and personal impacts.",
        "lessons": []
      },
      "HS-SEP3-4": {
        "description": "Select appropriate tools to collect, record, analyze, and evaluate data.",
        "lessons": []
      },
      "HS-SEP3-5": {
        "description": "Make directional hypotheses that specify what happens to a dependent variable when an independent variable is manipulated.",
        "lessons": []
      },
      "HS-SEP3-6": {
        "description": "Manipulate variables and collect data about a complex model of a proposed process or system to identify failure points or improve performance relative to criteria for success or other variables.",
        "lessons": []
      },
      "MS-SEP4-1": {
        "description": "Construct, analyze, and/or interpret graphical displays of data and/or large data sets to identify linear and nonlinear relationships.",
        "lessons": []
      },
      "MS-SEP4-2": {
        "description": "Use graphical displays (e.g., maps, charts, graphs, and/or tables) of large data sets to identify temporal and spatial relationships.",
        "lessons": []
      },
      "MS-SEP4-3": {
        "description": "Distinguish between causal and correlational relationships in data.",
        "lessons": []
      },
      "MS-SEP4-4": {
        "description": "Analyze and interpret data to provide evidence for phenomena.",
        "lessons": ["hoc-data", ]
      },
      "MS-SEP4-5": {
        "description": "Apply concepts of statistics and probability (including mean, median, mode, and variability) to analyze and characterize data, using digital tools when feasible.",
        "lessons": []
      },
      "MS-SEP4-6": {
        "description": "Consider limitations of data analysis (e.g., measurement error), and/or seek to improve precision and accuracy of data with better technological tools and methods (e.g., multiple trials).",
        "lessons": []
      },
      "MS-SEP4-7": {
        "description": "Analyze and interpret data to determine similarities and differences in findings.",
        "lessons": ["hoc-data", ]
      },
      "MS-SEP4-8": {
        "description": "Analyze data to define an optimal operational range for a proposed object, tool, process or system that best meets criteria for success.",
        "lessons": []
      },
      "HS-SEP4-1": {
        "description": "Analyze data using tools, technologies, and/or models (e.g., computational, mathematical) in order to make valid and reliable scientific claims or determine an optimal design solution.",
        "lessons": []
      },
      "HS-SEP4-2": {
        "description": "Apply concepts of statistics and probability (including determining function fits to data, slope, intercept, and correlation coefficient for linear fits) to scientific and engineering questions and problems, using digital tools when feasible.",
        "lessons": []
      },
      "HS-SEP4-3": {
        "description": "Consider limitations of data analysis (e.g., measurement error, sample selection) when analyzing and interpreting data.",
        "lessons": []
      },
      "HS-SEP4-4": {
        "description": "Compare and contrast various types of data sets (e.g., self-generated, archival) to examine consistency of measurements and observations.",
        "lessons": []
      },
      "HS-SEP4-5": {
        "description": "Evaluate the impact of new data on a working explanation and/or model of a proposed process or system.",
        "lessons": []
      },
      "HS-SEP4-6": {
        "description": "Analyze data to identify design features or characteristics of the components of a proposed process or system to optimize it relative to criteria for success.",
        "lessons": []
      },
      "MS-SEP5-1": {
        "description": "Use digital tools (e.g., computers) to analyze very large data sets for patterns and trends.",
        "lessons": []
      },
      "MS-SEP5-2": {
        "description": "Use mathematical representations to describe and/or support scientific conclusions and design solutions.",
        "lessons": []
      },
      "MS-SEP5-3": {
        "description": "Create algorithms (a series of ordered steps) to solve a problem.",
        "lessons": []
      },
      "MS-SEP5-4": {
        "description": "Apply mathematical concepts and/or processes (such as ratio, rate, percent, basic operations, and simple algebra) to scientific and engineering questions and problems.",
        "lessons": ["hoc-data", ]
      },
      "MS-SEP5-5": {
        "description": "Use digital tools and/or mathematical concepts and arguments to test and compare proposed solutions to an engineering design problem.",
        "lessons": []
      },
      "HS-SEP5-1": {
        "description": "Create and/or revise a computational model or simulation of a phenomenon, designed device, process, or system.",
        "lessons": []
      },
      "HS-SEP5-2": {
        "description": "Use mathematical, computational, and/or algorithmic representations of phenomena or design solutions to describe and/or support claims and/or explanations.",
        "lessons": ["hoc-data", ]
      },
      "HS-SEP5-3": {
        "description": "Apply techniques of algebra and functions to represent and solve scientific and engineering problems.",
        "lessons": []
      },
      "HS-SEP5-4": {
        "description": "Use simple limit cases to test mathematical expressions, computer programs, algorithms, or simulations of a process or system to see if a model “makes sense” by comparing the outcomes with what is known about the real world.",
        "lessons": []
      },
      "HS-SEP5-5": {
        "description": "Apply ratios, rates, percentages, and unit conversions in the context of complicated measurement problems involving quantities with derived or compound units (such as mg/mL, kg/m3, acre-feet, etc.).",
        "lessons": []
      },
      "MS-SEP6-1": {
        "description": "Construct an explanation that includes qualitative or quantitative relationships between variables that predict(s) and/or describe(s) phenomena.",
        "lessons": []
      },
      "MS-SEP6-2": {
        "description": "Construct an explanation using models or representations.",
        "lessons": []
      },
      "MS-SEP6-3": {
        "description": "Construct a scientific explanation based on valid and reliable evidence obtained from sources (including the students’ own experiments) and the assumption that theories and laws that describe the natural world operate today as they did in the past and will continue to do so in the future.",
        "lessons": []
      },
      "MS-SEP6-4": {
        "description": "Apply scientific ideas, principles, and/or evidence to construct, revise and/or use an explanation for real-world phenomena, examples, or events.",
        "lessons": []
      },
      "MS-SEP6-5": {
        "description": "Apply scientific reasoning to show why the data or evidence is adequate for the explanation or conclusion.",
        "lessons": []
      },
      "MS-SEP6-6": {
        "description": "Apply scientific ideas or principles to design, construct, and/or test a design of an object, tool, process or system.",
        "lessons": []
      },
      "MS-SEP6-7": {
        "description": "Undertake a design project, engaging in the design cycle, to construct and/or implement a solution that meets specific design criteria and constraints.",
        "lessons": []
      },
      "MS-SEP6-8": {
        "description": "Optimize performance of a design by prioritizing criteria, making tradeoffs, testing, revising, and re-testing.",
        "lessons": []
      },
      "HS-SEP6-1": {
        "description": "Make a quantitative and/or qualitative claim regarding the relationship between dependent and independent variables.",
        "lessons": []
      },
      "HS-SEP6-2": {
        "description": "Construct and revise an explanation based on valid and reliable evidence obtained from a variety of sources (including students’ own investigations, models, theories, simulations, peer review) and the assumption that theories and laws that describe the natural world operate today as they did in the past and will continue to do so in the future.",
        "lessons": []
      },
      "HS-SEP6-3": {
        "description": "Apply scientific ideas, principles, and/or evidence to provide an explanation of phenomena and solve design problems, taking into account possible unanticipated effects.",
        "lessons": []
      },
      "HS-SEP6-4": {
        "description": "Apply scientific reasoning, theory, and/or models to link evidence to the claims to assess the extent to which the reasoning and data support the explanation or conclusion.",
        "lessons": []
      },
      "HS-SEP6-5": {
        "description": "Design, evaluate, and/or refine a solution to a complex real-world problem, based on scientific knowledge, student-generated sources of evidence, prioritized criteria, and tradeoff considerations.",
        "lessons": []
      },
      "MS-SEP7-1": {
        "description": "Compare and critique two arguments on the same topic and analyze whether they emphasize similar or different evidence and/or interpretations of facts.",
        "lessons": []
      },
      "MS-SEP7-2": {
        "description": "Respectfully provide and receive critiques about one’s explanations, procedures, models and questions by citing relevant evidence and posing and responding to questions that elicit pertinent elaboration and detail.",
        "lessons": []
      },
      "MS-SEP7-3": {
        "description": "Construct, use, and/or present an oral and written argument supported by empirical evidence and scientific reasoning to support or refute an explanation or a model for a phenomenon or a solution to a problem.",
        "lessons": []
      },
      "MS-SEP7-4": {
        "description": "Make an oral or written argument that supports or refutes the advertised performance of a device, process, or system, based on empirical evidence concerning whether or not the technology meets relevant criteria and constraints.",
        "lessons": []
      },
      "MS-SEP7-5": {
        "description": "Evaluate competing design solutions based on jointly developed and agreed-upon design criteria.",
        "lessons": []
      },
      "HS-SEP7-1": {
        "description": "Compare and evaluate competing arguments or design solutions in light of currently accepted explanations, new evidence, limitations (e.g., trade-offs), constraints, and ethical issues.",
        "lessons": []
      },
      "HS-SEP7-2": {
        "description": "Evaluate the claims, evidence, and/or reasoning behind currently accepted explanations or solutions to determine the merits of arguments.",
        "lessons": []
      },
      "HS-SEP7-3": {
        "description": "Respectfully provide and/or receive critiques on scientific arguments by probing reasoning and evidence and challenging ideas and conclusions, responding thoughtfully to diverse perspectives, and determining what additional information is required to resolve contradictions.",
        "lessons": []
      },
      "HS-SEP7-4": {
        "description": "Construct, use, and/or present an oral and written argument or counter-arguments based on data and evidence.",
        "lessons": []
      },
      "HS-SEP7-5": {
        "description": "Make and defend a claim based on evidence about the natural world or the effectiveness of a design solution that reflects scientific knowledge, and student-generated evidence.",
        "lessons": []
      },
      "HS-SEP7-6": {
        "description": "Evaluate competing design solutions to a real-world problem based on scientific ideas and principles, empirical evidence, and logical arguments regarding relevant factors (e.g. economic, societal, environmental, ethical considerations).",
        "lessons": []
      },
      "MS-SEP8-1": {
        "description": "Critically read scientific texts adapted for classroom use to determine the central ideas and/or obtain scientific and/or technical information to describe patterns in and/or evidence about the natural and designed world(s).",
        "lessons": []
      },
      "MS-SEP8-2": {
        "description": "Integrate qualitative and/or quantitative scientific and/or technical information in written text with that contained in media and visual displays to clarify claims and findings.",
        "lessons": []
      },
      "MS-SEP8-3": {
        "description": "Gather, read, synthesize information from multiple appropriate sources and assess the credibility, accuracy, and possible bias of each publication and methods used, and describe how they are supported or not supported by evidence.",
        "lessons": []
      },
      "MS-SEP8-4": {
        "description": "Evaluate data, hypotheses, and/or conclusions in scientific and technical texts in light of competing information or accounts.",
        "lessons": []
      },
      "MS-SEP8-5": {
        "description": "Communicate scientific and/or technical information (e.g. about a proposed object, tool, process, system) in writing and/or through oral presentations.",
        "lessons": []
      },
      "HS-SEP8-1": {
        "description": "Critically read scientific literature adapted for classroom use to determine the central ideas or conclusions and/or to obtain scientific and/or technical information to summarize complex evidence, concepts, processes, or information presented in a text by paraphrasing them in simpler but still accurate terms.",
        "lessons": []
      },
      "HS-SEP8-2": {
        "description": "Compare, integrate and evaluate sources of information presented in different media or formats (e.g., visually, quantitatively) as well as in words in order to address a scientific question or solve a problem.",
        "lessons": []
      },
      "HS-SEP8-3": {
        "description": "Gather, read, and evaluate scientific and/or technical information from multiple authoritative sources, assessing the evidence and usefulness of each source.",
        "lessons": []
      },
      "HS-SEP8-4": {
        "description": "Evaluate the validity and reliability of and/or synthesize multiple claims, methods, and/or designs that appear in scientific and technical texts or media reports, verifying the data when possible.",
        "lessons": []
      },
      "HS-SEP8-5": {
        "description": "Communicate scientific and/or technical information or ideas (e.g. about phenomena and/or the process of development and the design and performance of a proposed process or system) in multiple formats (including orally, graphically, textually, and mathematically).",
        "lessons": []
      },
    },
    "IA": {
      "21.6-8.ES.1": {
        "description": "Communicate and work productively with others, considering different perspectives, and cultural views to increase the quality of work.",
        "lessons": []
      },
      "21.6-8.ES.2": {
        "description": "Adapt and adjust to various roles and responsibilities in an environment of change.",
        "lessons": []
      },
      "21.6-8.ES.3": {
        "description": "Demonstrate leadership, integrity, ethical behavior, and social responsibility in all environments.",
        "lessons": []
      },
      "21.6-8.ES.4": {
        "description": "Demonstrate initiative, self–direction, creativity, and entrepreneurial thinking while exploring individual talents and skills necessary to be successful.",
        "lessons": []
      },
      "21.6-8.ES.5": {
        "description": "Demonstrate productivity and accountability while aspiring to meet high expectations.",
        "lessons": []
      },
      "21.6-8.TL.1": {
        "description": "Demonstrate creative thinking in the design and development of innovative technology products and problem solving.",
        "lessons": []
      },
      "21.6-8.TL.2": {
        "description": "Collaborate with peers, experts, and others using interactive technology.",
        "lessons": []
      },
      "21.6-8.TL.3": {
        "description": "Plan strategies utilizing digital tools to gather, evaluate, and use information.",
        "lessons": []
      },
      "21.6-8.TL.4": {
        "description": "Use critical thinking skills to conduct research, solve problems, and make informed decisions using appropriate technological tools and resources.",
        "lessons": []
      },
      "21.6-8.TL.5": {
        "description": "Understand the legal and ethical issues of technology as related to individuals, cultures, and societies.",
        "lessons": []
      },
      "21.6-8.TL.6": {
        "description": "Understand the underlying structure and application of technology systems.",
        "lessons": []
      },
      "21.9-12.ES.1": {
        "description": "Communicate and work productively with others, incorporating different perspectives and cross cultural understanding, to increase innovation and the quality of work.",
        "lessons": []
      },
      "21.9-12.ES.2": {
        "description": "Adapt to various roles and responsibilities and work flexibly in climates of ambiguity and changing priorities.",
        "lessons": []
      },
      "21.9-12.ES.3": {
        "description": "Demonstrate leadership skills, integrity, ethical behavior, and social responsibility while collaborating to achieve common goals.",
        "lessons": []
      },
      "21.9-12.ES.4": {
        "description": "Demonstrate initiative and self–direction through high achievement and lifelong learning while exploring the ways individual talents and skills can be used for productive outcomes in personal and professional life.",
        "lessons": []
      },
      "21.9-12.ES.5": {
        "description": "Demonstrate productivity and accountability by meeting high expectations.",
        "lessons": []
      },
      "21.9-12.TL.1": {
        "description": "Demonstrate creative thinking, construct knowledge, and develop innovative products and processes using technology.",
        "lessons": []
      },
      "21.9-12.TL.2": {
        "description": "Use digital media and environments to communicate and work collaboratively, including at a distance, to support individual learning and contribute to the learning of others.",
        "lessons": []
      },
      "21.9-12.TL.3": {
        "description": "Apply digital tools to gather, evaluate, and use information.",
        "lessons": []
      },
      "21.9-12.TL.4": {
        "description": "Demonstrate critical thinking skills using appropriate tools and resources to plan and conduct research, manage projects, solve problems and make informed decisions.",
        "lessons": []
      },
      "21.9-12.TL.5": {
        "description": "Understand human, cultural, and societal issues related to technology and practice legal and ethical behavior.",
        "lessons": []
      },
      "21.9-12.TL.6": {
        "description": "Demonstrate a sound understanding of technology concepts, systems and operations.",
        "lessons": []
      },
    },
    "MA": {
      "K-2.CAS.a.1": {
        "description": "Demonstrate proper ergonomics (e.g., body position, stretching) when using devices.",
        "lessons": []
      },
      "K-2.CAS.a.2": {
        "description": "Use electrical devices safely and in moderation (e.g., unplug devices by pulling the plug rather than the cord, do not mix water/food and electric devices, avoid gaming and walking).",
        "lessons": []
      },
      "K-2.CAS.a.3": {
        "description": "Care for devices appropriately (e.g., handling devices gently, completely shutting down devices when not in use, storing devices in the appropriate container).",
        "lessons": []
      },
      "K-2.CAS.a.4": {
        "description": "Explain that a password helps protect the privacy of information.",
        "lessons": []
      },
      "K-2.CAS.a.5": {
        "description": "Identify safe and unsafe examples of online communications.",
        "lessons": []
      },
      "K-2.CAS.a.6": {
        "description": "Explain why we keep personal information (e.g., name, location, phone number, home address) private.",
        "lessons": []
      },
      "K-2.CAS.a.7": {
        "description": "Identify which personal information (e.g., user name or real name, school name or home address) should and should not be shared online and with whom.",
        "lessons": []
      },
      "K-2.CAS.a.8": {
        "description": "Explain why it is necessary to report inappropriate electronic content or contact.",
        "lessons": []
      },
      "K-2.CAS.b.1": {
        "description": "Define good digital citizenship as using technology safely, responsibly, and ethically.",
        "lessons": []
      },
      "K-2.CAS.b.2": {
        "description": "Demonstrate responsible use of computers, peripheral devices, and resources as outlined in school rules (Acceptable Use Policy [AUP] for K-2).",
        "lessons": []
      },
      "K-2.CAS.b.3": {
        "description": "Explain that most digital artifacts have owners.",
        "lessons": []
      },
      "K-2.CAS.b.4": {
        "description": "Explain the importance of giving credit to media creators/owners when using their work.",
        "lessons": []
      },
      "K-2.CAS.c.1": {
        "description": "Identify and describe how people (e.g., students, parents, police officers) use many types of technologies in their daily work and personal lives.",
        "lessons": []
      },
      "K-2.CAS.c.2": {
        "description": "Recognize when the purpose of content is to provide information or to influence you to act.",
        "lessons": []
      },
      "K-2.DTC.a.1": {
        "description": "Operate a variety of digital tools (e.g., open/close, find, save/print, navigate, use input/output devices).",
        "lessons": []
      },
      "K-2.DTC.a.2": {
        "description": "Identify, locate, and use letters, numbers, and special keys on a keyboard (e.g., Space Bar, Shift, Delete).",
        "lessons": []
      },
      "K-2.DTC.a.3": {
        "description": "Create a simple digital artifact.",
        "lessons": []
      },
      "K-2.DTC.a.4": {
        "description": "Use appropriate digital tools individually and collaboratively to create, review, and revise simple artifacts that include text, images and audio.",
        "lessons": []
      },
      "K-2.DTC.b.1": {
        "description": "Collaboratively use digital tools and media resources to communicate key ideas and details in a way that informs, persuades, and/or entertains.",
        "lessons": []
      },
      "K-2.DTC.b.2": {
        "description": "Use a variety of digital tools to exchange information and feedback with teachers.",
        "lessons": []
      },
      "K-2.DTC.b.3": {
        "description": "Use a variety of digital tools to present information to others.",
        "lessons": []
      },
      "K-2.DTC.c.1": {
        "description": "Conduct basic keyword searches to gather information from teacher-provided digital sources (e.g., online library catalog, databases).",
        "lessons": []
      },
      "K-2.DTC.c.2": {
        "description": "Create an artifact individually and collaboratively that answers a research question, while clearly expressing thoughts and ideas.",
        "lessons": []
      },
      "K-2.DTC.c.3": {
        "description": "Acknowledge and name sources of information or media (e.g., title of book, author of book, website).",
        "lessons": []
      },
      "K-2.CS.a.1": {
        "description": "Identify different kinds of computing devices in the classroom and other places (e.g., laptops, tablets, smart phones, desktops).",
        "lessons": []
      },
      "K-2.CS.a.2": {
        "description": "Identify visible components of computing devices (e.g., keyboard, screen, monitor, printer, pointing device).",
        "lessons": []
      },
      "K-2.CS.a.3": {
        "description": "Explain that computing devices function when applications, programs, or commands are executed.",
        "lessons": []
      },
      "K-2.CS.a.4": {
        "description": "Operate a variety of computing systems (e.g., turn on, use input/output devices such as a mouse, keyboard, or touch screen; find, navigate, launch a program).",
        "lessons": []
      },
      "K-2.CS.b.1": {
        "description": "Explain that computing devices are machines that are not alive, but can be used to help humans with tasks.",
        "lessons": []
      },
      "K-2.CS.b.2": {
        "description": "Recognize that some tasks are best completed by humans and others by computing devices (e.g., a human might be able to rescue someone in a normal environment, but robots would be better to use in a dangerous environment).",
        "lessons": []
      },
      "K-2.CS.b.3": {
        "description": "Recognize that different tools can solve the same problem (e.g., pen and paper, calculators, and smart phones can all be used to solve simple mathematical problems).",
        "lessons": []
      },
      "K-2.CS.c.1": {
        "description": "Explain that networks link computers and devices locally and around the world allowing people to access and communicate information.",
        "lessons": []
      },
      "K-2.CT.a.1": {
        "description": "List the attributes of a common object, for example, cars have a color, type (e.g., pickup, van, sedan), number of seats, etc.",
        "lessons": []
      },
      "K-2.CT.b.1": {
        "description": "Define an algorithm as a sequence of defined steps.",
        "lessons": []
      },
      "K-2.CT.b.2": {
        "description": "Create a simple algorithm, individually and collaboratively, without using computers to complete a task (e.g., making a sandwich, getting ready for school, checking a book out of the library).",
        "lessons": []
      },
      "K-2.CT.b.3": {
        "description": "Enact an algorithm using tangible materials (e.g., manipulatives, your body) or present the algorithm in a visual medium (e.g., storyboard).",
        "lessons": []
      },
      "K-2.CT.c.1": {
        "description": "Identify different kinds of information (e.g., text, charts, graphs, numbers, pictures, audio, video, collections of objects).",
        "lessons": []
      },
      "K-2.CT.c.2": {
        "description": "Identify, research, and collect information on a topic, issue, problem, or question using age-appropriate digital technologies.",
        "lessons": []
      },
      "K-2.CT.c.3": {
        "description": "Individually and collaboratively propose a solution to a problem or question based on an analysis of information.",
        "lessons": []
      },
      "K-2.CT.c.4": {
        "description": "Individually and collaboratively create information visualizations (e.g., charts, infographics).",
        "lessons": []
      },
      "K-2.CT.c.5": {
        "description": "Explain that computers can save information as data that can be stored, searched, retrieved, and deleted.",
        "lessons": []
      },
      "K-2.CT.d.1": {
        "description": "Define a computer program as a set of commands created by people to do something.",
        "lessons": []
      },
      "K-2.CT.d.2": {
        "description": "Explain that computers only follow the programÕs instructions.",
        "lessons": []
      },
      "K-2.CT.d.3": {
        "description": "Individually or collaboratively create a simple program using visual instructions or tools that do not require a textual programming language (e.g., ÒunpluggedÓ programming activities, a block-based programming language).",
        "lessons": []
      },
      "K-2.CT.e.1": {
        "description": "Describe how models represent a real-life system (e.g., globe, map, solar system, digital elevation model, weather map).",
        "lessons": []
      },
      "K-2.CT.e.2": {
        "description": "Define simulation and identify the concepts illustrated by a simple simulation (e.g., growth and health, butterfly life cycle).",
        "lessons": []
      },
      "3-5.CAS.a.1": {
        "description": "Describe how to use proper ergonomics (e.g., body position, lighting, positioning of equipment, taking breaks) when using devices.",
        "lessons": []
      },
      "3-5.CAS.a.2": {
        "description": "Describe the threats to safe and efficient use of devices (e.g., SPAM, spyware, phishing, viruses) associated with various forms of technology use (e.g., downloading and executing software programs, following hyperlinks, opening files).",
        "lessons": []
      },
      "3-5.CAS.a.3": {
        "description": "Identify appropriate and inappropriate uses of technology when posting to social media, sending e-mail or texts, and browsing the Internet.",
        "lessons": []
      },
      "3-5.CAS.a.4": {
        "description": "Explain the proper use and operation of security technologies (e.g., passwords, virus protection software, spam filters, popup blockers, cookies).",
        "lessons": []
      },
      "3-5.CAS.a.5": {
        "description": "Describe ways to employ safe practices and avoid the potential risks/dangers associated with various forms of online communications, downloads, linking, Internet purchases, advertisements, and inappropriate content within constrained environments.",
        "lessons": []
      },
      "3-5.CAS.a.6": {
        "description": "Identify different types of cyberbullying (e.g., harassment, flaming, excluding people, outing, and impersonation).",
        "lessons": []
      },
      "3-5.CAS.a.7": {
        "description": "Explain that if you encounter cyberbullying or other inappropriate content, you should immediately tell a responsible adult (e.g., teacher, parent).",
        "lessons": []
      },
      "3-5.CAS.b.1": {
        "description": "Demonstrate responsible use of computers, peripheral devices, and resources as outlined in school rules (Acceptable Use Policy [AUP]).",
        "lessons": []
      },
      "3-5.CAS.b.2": {
        "description": "Describe the difference between digital artifacts that are open or free and those that are protected by copyright.",
        "lessons": ["making-game-images", ]
      },
      "3-5.CAS.b.3": {
        "description": "Explain the guidelines for the fair use of downloading, sharing, or modifying of digital artifacts",
        "lessons": []
      },
      "3-5.CAS.b.4": {
        "description": "Describe the purpose of copyright and the possible consequences for inappropriate use of digital artifacts that are protected by copyright.",
        "lessons": []
      },
      "3-5.CAS.b.5": {
        "description": "Explain that laws exist (e.g., Section 508, Telecommunication Act of 1996) that help ensure that people with disabilities can access electronic and information technology.",
        "lessons": []
      },
      "3-5.CAS.c.1": {
        "description": "Explain the different forms of web advertising (e.g., search ads, pay-per-click ads, banner ads, targeted ads, in-game ads, e-mail ads).",
        "lessons": []
      },
      "3-5.CAS.c.2": {
        "description": "Explain why websites, digital resources, and artifacts may include advertisements and collect personal information.",
        "lessons": []
      },
      "3-5.CAS.c.3": {
        "description": "Define the digital divide as unequal access to technology on the basis of differences, such as income, education, age, and geographic location.",
        "lessons": []
      },
      "3-5.CAS.c.4": {
        "description": "Use critical thinking to explain how access to technology helps empower individuals and groups (e.g., gives them access to information, the ability to communicate with others around the world, allows them to buy and sell things).",
        "lessons": []
      },
      "3-5.CAS.c.5": {
        "description": "Identify resources in the community that can give people access to technology (e.g., libraries, community centers, education programs, schools, hardware/software donation programs).",
        "lessons": []
      },
      "3-5.CAS.c.6": {
        "description": "Identify ways in which people with disabilities access and use technology (e.g., audio players and recorders, FM listening systems, magnifiers).",
        "lessons": []
      },
      "3-5.CAS.c.7": {
        "description": "Identify the impact of social media and cyberbullying on individuals, families, and society.",
        "lessons": []
      },
      "3-5.DTC.a.1": {
        "description": "Type five words-per-minute times grade level (e.g., for Grade 5, type 25 words/minute).",
        "lessons": []
      },
      "3-5.DTC.a.2": {
        "description": "Navigate between local, networked, or online/cloud environments and transfer files between each (upload/download).",
        "lessons": []
      },
      "3-5.DTC.a.3": {
        "description": "Use digital tools (local and online) to manipulate and publish multimedia artifacts.",
        "lessons": []
      },
      "3-5.DTC.b.1": {
        "description": "Communicate key ideas and details individually or collaboratively in a way that informs, persuades, and/or entertains using digital tools and media-rich resources",
        "lessons": []
      },
      "3-5.DTC.b.2": {
        "description": "Collaborate through online digital tools under teacher supervision.",
        "lessons": []
      },
      "3-5.DTC.c.1": {
        "description": "Identify digital information sources to answer research questions (e.g., online library catalog, online encyclopedias, databases, websites).",
        "lessons": []
      },
      "3-5.DTC.c.2": {
        "description": "Perform searches to locate information using two or more key words and techniques to refine and limit such searches.",
        "lessons": []
      },
      "3-5.DTC.c.3": {
        "description": "Evaluate digital sources for accuracy, relevancy, and appropriateness.",
        "lessons": []
      },
      "3-5.DTC.c.4": {
        "description": "Gather and organize information from digital sources by quoting, paraphrasing, and/or summarizing.",
        "lessons": []
      },
      "3-5.DTC.c.5": {
        "description": "Create an artifact that answers a research question and clearly communicates thoughts and ideas.",
        "lessons": []
      },
      "3-5.DTC.c.6": {
        "description": "Cite text-based sources using a school- or district-adopted format.",
        "lessons": []
      },
      "3-5.DTC.c.7": {
        "description": "Provide basic source information (e.g., Uniform Resource Locator [URL], date accessed) for non-text-based sources (e.g., images, audio, video).",
        "lessons": []
      },
      "3-5.CS.a.1": {
        "description": "Identify a broad range of computing devices (e.g., computers, smart phones, tablets, robots, e-textiles) and appropriate uses for them.",
        "lessons": []
      },
      "3-5.CS.a.2": {
        "description": "Describe the function and purpose of various input and output devices (e.g., monitor, keyboard, speakers, controller, probes, sensors, Bluetooth transmitters, synthesizers).",
        "lessons": []
      },
      "3-5.CS.a.3": {
        "description": "Demonstrate an appropriate level of proficiency (connect and record data, print, send command, connect to Internet, search) in using a range of computing devices (e.g., probes, sensors, printers, robots, computers).",
        "lessons": []
      },
      "3-5.CS.a.4": {
        "description": "Identify and solve simple hardware and software problems that may occur during everyday use (e.g., power, connections, application window or toolbar).",
        "lessons": []
      },
      "3-5.CS.a.5": {
        "description": "Describe the differences between hardware and software.",
        "lessons": []
      },
      "3-5.CS.a.6": {
        "description": "Identify and explain that some computing functions are always active (e.g., locations function on smart phones).",
        "lessons": []
      },
      "3-5.CS.b.1": {
        "description": "Compare and contrast human and computer performance on similar tasks (e.g., sorting alphabetically, finding a path across a cluttered room) to understand which is best suited to the task.",
        "lessons": []
      },
      "3-5.CS.b.2": {
        "description": "Explain how hardware and applications (e.g., Global Positioning System [GPS] navigation for driving directions, text-to-speech translation, language translation) can enable everyone, including people with disabilities, to do things they could not do otherwise.",
        "lessons": []
      },
      "3-5.CS.b.3": {
        "description": "Explain advantages and limitations of technology (e.g., a spell-checker can check thousands of words faster than a human could look them up, however, a spell-checker might not know whether ÔunderservedÕ is correct or if the authorÕs intent was to type Ôundeserved.Õ",
        "lessons": []
      },
      "3-5.CS.c.1": {
        "description": "Describe how a network is made up of a variety of components and identify the common components (e.g., links, nodes, networking devices).",
        "lessons": []
      },
      "3-5.CS.c.2": {
        "description": "Describe the need for authentication of users and devices as it relates to access permissions, privacy, and security.",
        "lessons": []
      },
      "3-5.CS.c.3": {
        "description": "Define and explain why devices are numbered/labeled in networks (e.g., the World Wide Web Uniform Resource Locator [URL], the Internet Protocol [IP] address, the Machine Access Code [MAC]).",
        "lessons": []
      },
      "3-5.CS.c.4": {
        "description": "Recognize that there are many sources of and means for accessing information within a network (e.g., websites, e-mail protocols, search engines)",
        "lessons": []
      },
      "3-5.CS.d.1": {
        "description": "Identify common services (e.g., driving directions apps that access remote map services, digital personal assistants that access remote information services).",
        "lessons": []
      },
      "3-5.CT.a.1": {
        "description": "Use numbers or letters to represent information in another form (e.g., secret codes, Roman numerals, abbreviations).",
        "lessons": []
      },
      "3-5.CT.a.2": {
        "description": "Organize information in different ways to make it more useful/relevant (e.g., sorting, tables).",
        "lessons": []
      },
      "3-5.CT.a.3": {
        "description": "Make a list of sub-problems to consider, while addressing a larger problem.",
        "lessons": []
      },
      "3-5.CT.b.1": {
        "description": "Define an algorithm as a sequence of instructions that can be processed by a computer.",
        "lessons": []
      },
      "3-5.CT.b.2": {
        "description": "Recognize that different solutions exist for the same problem (or sub-problem).",
        "lessons": []
      },
      "3-5.CT.b.3": {
        "description": "Use logical reasoning to predict outcomes of an algorithm.",
        "lessons": []
      },
      "3-5.CT.b.4": {
        "description": "Individually and collaboratively create an algorithm to solve a problem (e.g., move a character/robot/person through a maze).",
        "lessons": []
      },
      "3-5.CT.b.5": {
        "description": "Detect and correct logical errors in various algorithms (e.g., written, mapped, live action, or digital).",
        "lessons": []
      },
      "3-5.CT.c.1": {
        "description": "Describe examples of databases from everyday life (e.g., library catalogs, school records, telephone directories, contact lists).",
        "lessons": []
      },
      "3-5.CT.c.2": {
        "description": "Individually and collaboratively collect and manipulate data to answer a question using a variety of computing methods (e.g., sorting, totaling, averaging) and tools (such as a spreadsheet) to collect, organize, graph, and analyze data.",
        "lessons": []
      },
      "3-5.CT.d.1": {
        "description": "Individually and collaboratively create, test, and modify a program in a graphical environment (e.g., block-based visual programming language).",
        "lessons": []
      },
      "3-5.CT.d.2": {
        "description": "Use arithmetic operators, conditionals, and repetition in programs.",
        "lessons": []
      },
      "3-5.CT.d.3": {
        "description": "Use interactive debugging to detect and correct simple program errors.",
        "lessons": []
      },
      "3-5.CT.d.4": {
        "description": "Recognize that programs need known starting values (e.g., set initial score to zero in a game).",
        "lessons": []
      },
      "3-5.CT.e.1": {
        "description": "Individually and collaboratively create a simple model of a system (e.g., water cycle, solar system) and explain what the model shows and does not show.",
        "lessons": []
      },
      "3-5.CT.e.2": {
        "description": "Identify the concepts, features, and behaviors illustrated by a simulation (e.g., object motion, weather, ecosystem, predator/prey) and those that were not included.",
        "lessons": []
      },
      "3-5.CT.e.3": {
        "description": "Individually and collaboratively use data from a simulation to answer a question.",
        "lessons": []
      },
      "6-8.CAS.a.1": {
        "description": "Identify threats and actively protect devices and networks from viruses, intrusion, vandalism, and other malicious activities.",
        "lessons": []
      },
      "6-8.CAS.a.2": {
        "description": "Describe how cyberbullying can be prevented and managed.",
        "lessons": []
      },
      "6-8.CAS.a.3": {
        "description": "Explain the connection between the persistence of data on the Internet, personal online identity, and personal privacy.",
        "lessons": []
      },
      "6-8.CAS.a.4": {
        "description": "Describe and use safe, appropriate, and responsible practices (netiquette) when participating in online communities (e.g., discussion groups, blogs, social networking sites).",
        "lessons": []
      },
      "6-8.CAS.a.5": {
        "description": "Differentiate between appropriate and inappropriate content on the Internet.",
        "lessons": []
      },
      "6-8.CAS.b.1": {
        "description": "Explain how copyright law and licensing protect the owner of intellectual property.",
        "lessons": ["making-game-images", ]
      },
      "6-8.CAS.b.2": {
        "description": "Explain possible consequences of violating intellectual property law and plagiarism.",
        "lessons": []
      },
      "6-8.CAS.b.3": {
        "description": "Apply fair use for using copyrighted materials (e.g., images, music, video, text).",
        "lessons": []
      },
      "6-8.CAS.b.4": {
        "description": "Identify the legal consequences of sending or receiving inappropriate content (e.g., cyberbullying, harassment, sexting).",
        "lessons": []
      },
      "6-8.CAS.b.5": {
        "description": "Differentiate among open source and proprietary software licenses and their  applicability to different types of software and media.",
        "lessons": []
      },
      "6-8.CAS.b.6": {
        "description": "Demonstrate compliance with the schoolÕs Acceptable Use Policy [AUP].",
        "lessons": []
      },
      "6-8.CAS.b.7": {
        "description": "Identify software license agreements and application permissions.",
        "lessons": []
      },
      "6-8.CAS.b.8": {
        "description": "Explain positive and malicious purposes of hacking.",
        "lessons": []
      },
      "6-8.CAS.b.9": {
        "description": "License original content and extend license for sharing in the public domain (e.g., creative commons).",
        "lessons": []
      },
      "6-8.CAS.c.1": {
        "description": "Describe current events and emerging technologies in computing and the effects they may have on education, the workplace, individuals, communities, and global society.",
        "lessons": []
      },
      "6-8.CAS.c.2": {
        "description": "Identify and discuss the technology proficiencies needed in the classroom and the workplace, and how to meet the needs.",
        "lessons": []
      },
      "6-8.CAS.c.3": {
        "description": "Relate the distribution of computing resources in a global society to issues of equity, access, and power.",
        "lessons": []
      },
      "6-8.CAS.c.4": {
        "description": "Evaluate how media and technology can be used to distort, exaggerate, and misrepresent information.",
        "lessons": ["measures-of-center", "threats-to-validity", ]
      },
      "6-8.CAS.c.5": {
        "description": "Evaluate the bias of digital information sources, including websites.",
        "lessons": []
      },
      "6-8.DTC.a.1": {
        "description": "Identify and explain the strengths, weaknesses, and capabilities of a variety of digital tools.",
        "lessons": []
      },
      "6-8.DTC.a.2": {
        "description": "Identify the kinds of content associated with different file types and why different file types exist (e.g., formats for word processing, images, music, three-dimensional drawings.).",
        "lessons": []
      },
      "6-8.DTC.a.3": {
        "description": "Integrate information from multiple file formats into a single artifact.",
        "lessons": []
      },
      "6-8.DTC.a.4": {
        "description": "Individually and collaboratively use advanced tools to design and create online content (e.g., digital portfolio, multimedia, blog, webpage).",
        "lessons": ["making-game-images", "functions-for-character-animation", "inequalities3-sam", "inequalities-collision", "distance-formula", "player-animation", "project-video-game", ]
      },
      "6-8.DTC.a.5": {
        "description": "Individually and collaboratively develop and conduct an online survey.",
        "lessons": ["data-collection", ]
      },
      "6-8.DTC.b.1": {
        "description": "Communicate and publish key ideas and details individually or collaboratively in a way that informs, persuades, and/or entertains using a variety of digital tools and media-rich resources.",
        "lessons": ["project-research-paper", ]
      },
      "6-8.DTC.b.2": {
        "description": "Collaborate synchronously and asynchronously through online digital tools.",
        "lessons": []
      },
      "6-8.DTC.b.3": {
        "description": "Demonstrate ability to communicate appropriately through various online tools (e.g., email, social media, texting, blog comments).",
        "lessons": []
      },
      "6-8.DTC.c.1": {
        "description": "Perform advanced searches to locate information using a variety of digital sources (e.g., Boolean Operators, limiters like reading level, subject, media type).",
        "lessons": []
      },
      "6-8.DTC.c.2": {
        "description": "Evaluate quality of digital sources for reliability, including currency, relevancy, authority, accuracy, and purpose of digital information.",
        "lessons": []
      },
      "6-8.DTC.c.3": {
        "description": "Gather, organize, and analyze information from digital sources by quoting, paraphrasing, and/or summarizing.",
        "lessons": []
      },
      "6-8.DTC.c.4": {
        "description": "Create an artifact, individually and collaboratively, that answers a research question and communicates results and conclusions.",
        "lessons": ["project-research-paper", ]
      },
      "6-8.DTC.c.5": {
        "description": "Use digital citation tools to cite sources using a school- or district-adopted format (e.g., Modern Language Association [MLA]), including proper citation for all text and nontext sources (e.g., images, audio, video).",
        "lessons": []
      },
      "6-8.CS.a.1": {
        "description": "Describe the main functions of an operating system.",
        "lessons": []
      },
      "6-8.CS.a.2": {
        "description": "Recognize that there is a wide range of application software.",
        "lessons": []
      },
      "6-8.CS.a.3": {
        "description": "Identify and describe the function of the main internal parts of a basic computing device (e.g., motherboard, hard drive, Central Processing Unit [CPU]).",
        "lessons": []
      },
      "6-8.CS.a.4": {
        "description": "Identify and describe the use of sensors, actuators, and control systems in an embodied system (e.g., a robot, an e-textile, installation art, smart room).",
        "lessons": []
      },
      "6-8.CS.a.5": {
        "description": "Individually and collaboratively design and demonstrate the use of a device (e.g., robot, e-textile) to accomplish a task.",
        "lessons": []
      },
      "6-8.CS.a.6": {
        "description": "Use a variety of computing devices (e.g., probes, sensors, handheld devices, Global Positioning System [GPS]) to individually and collaboratively collect, analyze, and present information for content-related problems.",
        "lessons": []
      },
      "6-8.CS.a.7": {
        "description": "Identify steps involved in diagnosing and solving routine hardware and software problems (e.g., power, connections, application window or toolbar, cables, ports, network resources, video, sound) that occur during everyday computer use.",
        "lessons": []
      },
      "6-8.CS.b.1": {
        "description": "Explain why some problems can be solved more easily by computers or humans based on a general understanding of types of tasks at which each excels.",
        "lessons": []
      },
      "6-8.CS.b.2": {
        "description": "Describe how humans and machines interact to solve problems that cannot be solved by either alone (e.g., Òbig dataÓ experiments that involve drawing conclusions by analyzing vast amounts of data).",
        "lessons": []
      },
      "6-8.CS.c.1": {
        "description": "Explain the difference between physical (wired), local and wide area, wireless, and mobile networks.",
        "lessons": []
      },
      "6-8.CS.c.2": {
        "description": "Model the components of a network, including devices, routers, switches, cables, wires, and transponders.",
        "lessons": []
      },
      "6-8.CS.c.3": {
        "description": "Describe how information, both text and non-text, is translated and communicated between digital devices over a computer network.",
        "lessons": []
      },
      "6-8.CS.d.1": {
        "description": "Identify capabilities of devices that are enabled through services (e.g., a wearable device that stores fitness data in the cloud, a mobile device that uses location services for navigation).",
        "lessons": []
      },
      "6-8.CT.a.1": {
        "description": "Describe how data is abstracted by listing attributes of everyday items to represent, order and compare those items (e.g., street address as an abstraction for locations; car make, model, and license plate number as an abstraction for cars).",
        "lessons": []
      },
      "6-8.CT.a.2": {
        "description": "Define a simple function that represents a more complex task/problem and can be reused to solve similar tasks/problems.",
        "lessons": ["functions-make-life-easier", "functions-dr", "functions-for-character-animation", "problem-decomposition", "inequalities1-simple", "inequalities2-compound", "inequalities3-sam", "re-refactoring", "re-structures-reactors-animations", "re-nested-structures", "re-intro-to-data-structures", "re-functions-that-ask-questions", "re-key-events", "re-timers", "re-scoring", ]
      },
      "6-8.CT.a.3": {
        "description": "Use decomposition to define and apply a hierarchical classification scheme to a complex system, such as the human body, animal classification, or in computing.",
        "lessons": []
      },
      "6-8.CT.b.1": {
        "description": "Design solutions that use repetition and conditionals.",
        "lessons": ["piecewise-functions-conditionals", "player-animation", "table-methods", "codap-transformers-1", "codap-transformers-2", "defining-table-functions", ]
      },
      "6-8.CT.b.2": {
        "description": "Use logical reasoning to predict outputs given varying inputs.",
        "lessons": ["functions-make-life-easier", "functions-dr", "functions-for-character-animation", "problem-decomposition", "inequalities1-simple", "inequalities2-compound", "inequalities3-sam", "re-refactoring", "re-structures-reactors-animations", "re-nested-structures", "re-intro-to-data-structures", "re-functions-that-ask-questions", "re-key-events", "re-timers", "re-scoring", ]
      },
      "6-8.CT.b.3": {
        "description": "Individually and collaboratively decompose a problem and create a sub-solution for each of its parts (e.g., video game, robot obstacle course, making dinner).",
        "lessons": ["problem-decomposition", "inequalities-collision", ]
      },
      "6-8.CT.b.4": {
        "description": "Recognize that more than one algorithm can solve a given problem.",
        "lessons": []
      },
      "6-8.CT.b.5": {
        "description": "Recognize that boundaries need to be taken into account for an algorithm to produce correct results.",
        "lessons": ["inequalities3-sam", ]
      },
      "6-8.CT.c.1": {
        "description": "Demonstrate that numbers can be represented in different base systems (e.g., binary, octal, and hexadecimal) and text can be represented in different ways (e.g., American Standard Code for Information Interchange [ASCII]).",
        "lessons": []
      },
      "6-8.CT.c.2": {
        "description": "Describe how computers store, manipulate, and transfer data types and files (e.g., integers, real numbers, Boolean Operators) in a binary system.",
        "lessons": []
      },
      "6-8.CT.c.3": {
        "description": "Create, modify, and use a database (e.g., define field formats, add new records, manipulate data), individually and collaboratively, to analyze data and propose solutions for a task/problem.",
        "lessons": []
      },
      "6-8.CT.c.4": {
        "description": "Perform a variety of operations such as sorting, filtering, and searching in a database to organize and display information in a variety of ways such as number formats (scientific notation and percentages), charts, tables, and graphs.",
        "lessons": ["table-methods", "codap-transformers-1", "codap-transformers-2", ]
      },
      "6-8.CT.c.5": {
        "description": "Select and use data-collection technology (e.g., probes, handheld devices, geographic mapping systems) to individually and collaboratively gather, view, organize, analyze, and report results for content-related problems.",
        "lessons": ["data-collection", ]
      },
      "6-8.CT.d.1": {
        "description": "Individually and collaboratively compare algorithms to solve a problem, based on a given criteria (e.g., time, resource, accessibility).",
        "lessons": []
      },
      "6-8.CT.d.2": {
        "description": "Use functions to hide the detail in a program.",
        "lessons": ["functions-make-life-easier", "functions-dr", "functions-for-character-animation", "problem-decomposition", "inequalities1-simple", "inequalities2-compound", "inequalities3-sam", "re-refactoring", "re-structures-reactors-animations", "re-nested-structures", "re-intro-to-data-structures", "re-functions-that-ask-questions", "re-key-events", "re-timers", "re-scoring", ]
      },
      "6-8.CT.d.3": {
        "description": "Create a program, individually and collaboratively, that implements an algorithm to achieve a given goal.",
        "lessons": []
      },
      "6-8.CT.d.4": {
        "description": "Implement problem solutions using a programming language, including all of the following: looping behavior, conditional statements, expressions, variables, and functions.",
        "lessons": ["project-research-paper", "project-exploration-paper", "project-video-game", "codap-transformers-1", "codap-transformers-2", "piecewise-functions-conditionals", "player-animation", ]
      },
      "6-8.CT.d.5": {
        "description": "Trace programs step-by-step in order to predict their behavior.",
        "lessons": ["functions-make-life-easier", "functions-dr", "functions-for-character-animation", "problem-decomposition", "inequalities1-simple", "inequalities2-compound", "inequalities3-sam", "re-refactoring", "re-structures-reactors-animations", "re-nested-structures", "re-intro-to-data-structures", "re-functions-that-ask-questions", "re-key-events", "re-timers", "re-scoring", ]
      },
      "6-8.CT.d.6": {
        "description": "Use an iterative approach in development and debugging to understand the dimensions of a problem clearly.",
        "lessons": ["debugging", ]
      },
      "6-8.CT.e.1": {
        "description": "Create a model of a real-world system and explain why some details, features and behaviors were required in the model and why some could be ignored.",
        "lessons": []
      },
      "6-8.CT.e.2": {
        "description": "Use and modify simulations to analyze and illustrate a concept in depth (e.g., light rays/mechanical waves interaction with materials, genetic variation).",
        "lessons": []
      },
      "6-8.CT.e.3": {
        "description": "Select and use computer simulations, individually and collaboratively, to gather, view, analyze, and report results for content-related problems (e.g., migration, trade, cellular function).",
        "lessons": []
      },
      "9-12.CAS.a.1": {
        "description": "Evaluate and design an ergonomic work environment.",
        "lessons": []
      },
      "9-12.CAS.a.2": {
        "description": "Explain safe practices when collaborating online, including how to anticipate potentially dangerous situations.",
        "lessons": []
      },
      "9-12.CAS.a.3": {
        "description": "Construct strategies to combat cyberbullying/harassment.",
        "lessons": []
      },
      "9-12.CAS.a.4": {
        "description": "Identify the mental health consequences of cyberbullying/harassment.",
        "lessons": []
      },
      "9-12.CAS.a.5": {
        "description": "Explain how peer pressure in social computing settings influences choices.",
        "lessons": []
      },
      "9-12.CAS.a.6": {
        "description": "Apply strategies for managing negative peer pressure and encouraging positive peer pressure.",
        "lessons": []
      },
      "9-12.CAS.b.1": {
        "description": "Model mastery of the schoolÕs Acceptable Use Policy [AUP].",
        "lessons": []
      },
      "9-12.CAS.b.2": {
        "description": "Identify computer-related laws and analyze their impact on digital privacy, security, intellectual property, network access, contracts, and consequences of sexting and harassment.",
        "lessons": []
      },
      "9-12.CAS.b.3": {
        "description": "Discuss the legal and ethical implications associated with malicious hacking and software piracy.",
        "lessons": []
      },
      "9-12.CAS.b.4": {
        "description": "Interpret software license agreements and application permissions.",
        "lessons": []
      },
      "9-12.CAS.c.1": {
        "description": "Explain the impact of the digital divide on access to critical information.",
        "lessons": []
      },
      "9-12.CAS.c.2": {
        "description": "Discuss the impact of computing technology on business and commerce (e.g., automated tracking of goods, automated financial transaction, e-commerce, cloud computing).",
        "lessons": []
      },
      "9-12.CAS.c.3": {
        "description": "Describe the role that assistive technology can play in peopleÕs lives.",
        "lessons": []
      },
      "9-12.CAS.c.4": {
        "description": "Create a digital artifact that is designed to be accessible (e.g., closed captioning for audio, alternative text for images).",
        "lessons": []
      },
      "9-12.CAS.c.5": {
        "description": "Analyze the beneficial and harmful effects of computing innovations (e.g., social networking, delivery of news and other public media, intercultural communication).",
        "lessons": []
      },
      "9-12.CAS.c.6": {
        "description": "Cultivate a positive web presence (e.g., digital resume, portfolio, social media).",
        "lessons": []
      },
      "9-12.CAS.c.7": {
        "description": "Identify ways to use technology to support lifelong learning.",
        "lessons": []
      },
      "9-12.CAS.c.8": {
        "description": "Analyze the impact of values and points of view that are presented in media messages (e.g., racial, gender, political).",
        "lessons": []
      },
      "9-12.CAS.c.9": {
        "description": "Discuss the social and economic implications associated with malicious hacking, software piracy, and cyber terrorism.",
        "lessons": []
      },
      "9-12.DTC.a.1": {
        "description": "Use digital tools to design and develop a significant digital artifact (e.g., multipage website, online portfolio, simulation).",
        "lessons": ["project-research-paper", "project-exploration-paper", "project-video-game", ]
      },
      "9-12.DTC.a.2": {
        "description": "Select digital tools or resources based on their efficiency and effectiveness to use for a project or assignment, and justify the selection.",
        "lessons": []
      },
      "9-12.DTC.b.1": {
        "description": "Communicate and publish key ideas and details to a variety of audiences using digital tools and media-rich resources.",
        "lessons": []
      },
      "9-12.DTC.b.2": {
        "description": "Collaborate on a substantial project with outside experts or others through online digital tools (e.g., science fair project, community service project, capstone project).",
        "lessons": []
      },
      "9-12.DTC.c.1": {
        "description": "Generate, evaluate, and prioritize questions that can be researched through digital resources or tools.",
        "lessons": ["ds-intro", "project-research-paper", "project-exploration-paper", ]
      },
      "9-12.DTC.c.2": {
        "description": "Perform advanced searches to locate information and/or design a data-collection approach to gather original data (e.g., qualitative interviews, surveys, prototypes, simulations).",
        "lessons": []
      },
      "9-12.DTC.c.3": {
        "description": "Evaluate digital sources needed to solve a given problem (e.g., reliability, point of view, relevancy).",
        "lessons": []
      },
      "9-12.DTC.c.4": {
        "description": "Gather, organize, analyze, and synthesize information using a variety of digital tools.",
        "lessons": ["data-collection", ]
      },
      "9-12.DTC.c.5": {
        "description": "Create an artifact that answers a research question, communicates results and conclusions, and cites sources.",
        "lessons": ["project-research-paper", "project-exploration-paper", ]
      },
      "9-12.CS.a.1": {
        "description": "Select computing devices (e.g., probe, sensor, tablet) to accomplish a real-world task (e.g., collecting data in a field experiment) and justify the selection.",
        "lessons": []
      },
      "9-12.CS.a.2": {
        "description": "Examine how the components of computing devices are controlled by and react to programmed commands.",
        "lessons": []
      },
      "9-12.CS.a.3": {
        "description": "Apply strategies for identifying and solving routine hardware and software problems that occur in everyday life (e.g., update software patches, virus scan, empty trash, run utility software, close all programs, reboot, use help sources).",
        "lessons": []
      },
      "9-12.CS.a.4": {
        "description": "Explain and demonstrate how specialized computing devices can be used for problem solving, decision-making and creativity in all subject areas.",
        "lessons": []
      },
      "9-12.CS.a.5": {
        "description": "Describe how computing devices manage and allocate shared resources (e.g., memory, Central Processing Unit [CPU]).",
        "lessons": []
      },
      "9-12.CS.a.6": {
        "description": "Examine the historical rate of change in computing devices (e.g., power/energy, computation capacity, speed, size, ease of use) and discuss the implications for the future.",
        "lessons": []
      },
      "9-12.CS.b.1": {
        "description": "Identify a problem that cannot be solved by humans or machines alone and design a solution for it by decomposing the task into sub-problems suited for a human or machine to accomplish (e.g., a human-computer team playing chess, forecasting weather, piloting airplanes).",
        "lessons": []
      },
      "9-12.CS.c.1": {
        "description": "Explain how network topologies and protocols enable users, devices, and systems to communicate with each other.",
        "lessons": []
      },
      "9-12.CS.c.2": {
        "description": "Examine common network vulnerabilities (e.g., cyberattacks, identity theft, privacy) and their associated responses.",
        "lessons": []
      },
      "9-12.CS.c.3": {
        "description": "Examine the issues (e.g., latency, bandwidth, firewalls, server capability) that impact network functionality.",
        "lessons": []
      },
      "9-12.CS.d.1": {
        "description": "Compare the value of using an existing service versus building the equivalent functionality (e.g., using a reference search engine versus creating a database of references for a project).",
        "lessons": []
      },
      "9-12.CS.d.2": {
        "description": "Explain the concept of quality of service (e.g., security, availability, performance) for services providers (e.g., online storefronts that must supply secure transactions for buyer and seller).",
        "lessons": []
      },
      "9-12.CT.a.1": {
        "description": "Discuss and give an example of the value of generalizing and decomposing aspects of a problem in order to solve it more effectively.",
        "lessons": ["problem-decomposition", "inequalities-collision", "re-nested-structures", ]
      },
      "9-12.CT.b.1": {
        "description": "Recognize that the design of an algorithm is distinct from its expression in a programming language.",
        "lessons": []
      },
      "9-12.CT.b.2": {
        "description": "Represent algorithms using structured language, such as pseudocode.",
        "lessons": ["functions-make-life-easier", "functions-dr", "functions-for-character-animation", "problem-decomposition", "inequalities1-simple", "inequalities2-compound", "inequalities3-sam", "re-refactoring", "re-structures-reactors-animations", "re-nested-structures", "re-intro-to-data-structures", "re-functions-that-ask-questions", "re-key-events", "re-timers", "re-scoring", ]
      },
      "9-12.CT.b.3": {
        "description": "Explain how a recursive solution to a problem repeatedly applies the same solution to smaller instances of the problem.",
        "lessons": []
      },
      "9-12.CT.b.4": {
        "description": "Describe that there are ways to characterize how well algorithms perform and that two algorithms can perform differently for the same task.",
        "lessons": []
      },
      "9-12.CT.b.5": {
        "description": "Explain that there are some problems which cannot be computationally solved.",
        "lessons": []
      },
      "9-12.CT.c.1": {
        "description": "Describe how data types, structures, and compression in programs affect data storage and quality (e.g., digital image file sizes are affected by resolution and color depth).",
        "lessons": []
      },
      "9-12.CT.c.2": {
        "description": "Create an appropriate multidimensional data structure that can be filtered, sorted, and searched (e.g., array, list, record).",
        "lessons": ["codap-transformers-1", "codap-transformers-2", "table-methods", "defining-table-functions", ]
      },
      "9-12.CT.c.3": {
        "description": "Create, evaluate, and revise data visualization for communication and knowledge.",
        "lessons": ["bar-and-pie-charts", "codap-bar-charts", "codap-exploring", "histograms", "histograms2", "box-plots", "advanced-displays", "scatter-plots", "correlations", "linear-regression", ]
      },
      "9-12.CT.c.4": {
        "description": "Analyze a complex data set to answer a question or test a hypothesis (e.g., analyze a large set of weather or financial data to predict future patterns).",
        "lessons": []
      },
      "9-12.CT.c.5": {
        "description": "Identify different problems (e.g., large or multipart problems, problems that need specific expertise, problems that affect many constituents) that can benefit from collaboration when processing and analyzing data to develop new insights and knowledge.",
        "lessons": []
      },
      "9-12.CT.d.1": {
        "description": "Use a development process in creating a computational artifact that leads to a minimum viable product and includes reflection, analysis, and iteration (e.g., a data-set analysis program for a science and engineering fair, capstone project that includes a program, term research project based on program data).",
        "lessons": ["project-research-paper", ]
      },
      "9-12.CT.d.2": {
        "description": "Decompose a problem by defining functions which accept parameters and produce return values.",
        "lessons": []
      },
      "9-12.CT.d.3": {
        "description": "Select the appropriate data structure to represent information for a given problem (e.g., records, arrays, lists).",
        "lessons": ["table-methods", "defining-table-functions", "codap-transformers-1", "codap-transformers-2", ]
      },
      "9-12.CT.d.4": {
        "description": "Analyze trade-offs among multiple approaches to solve a given problem (e.g., space/time performance, maintainability, correctness, elegance).",
        "lessons": []
      },
      "9-12.CT.d.5": {
        "description": "Use appropriate looping structures in programs (e.g., FOR, WHILE, RECURSION).",
        "lessons": ["table-methods", "defining-table-functions", "codap-transformers-1", "codap-transformers-2", ]
      },
      "9-12.CT.d.6": {
        "description": "Use appropriate conditional structures in programs (e.g., IF-THEN, IF-THEN-ELSE, SWITCH).",
        "lessons": ["piecewise-functions-conditionals", "player-animation", "re-key-events", ]
      },
      "9-12.CT.d.7": {
        "description": "Use a programming language or tool feature correctly to enforce operator precedence.",
        "lessons": ["order-of-operations", ]
      },
      "9-12.CT.d.8": {
        "description": "Use global and local scope appropriately in program design (e.g., for variables).",
        "lessons": ["project-video-game", "project-research-paper", "project-exploration-paper", "flags", ]
      },
      "9-12.CT.d.9": {
        "description": "Select and employ an appropriate component or library to facilitate programming solutions (e.g., turtle, Global Positioning System [GPS], statistics library).",
        "lessons": []
      },
      "9-12.CT.d.10": {
        "description": "Use an iterative design process, including learning from making mistakes, to gain a better understanding of the problem domain.",
        "lessons": ["project-video-game", "project-research-paper", "project-exploration-paper", "flags", ]
      },
      "9-12.CT.d.11": {
        "description": "Engage in systematic testing and debugging methods to ensure program correctness.",
        "lessons": ["debugging", ]
      },
      "9-12.CT.d.12": {
        "description": "Demonstrate how to document a program so that others can understand its design and implementation.",
        "lessons": ["functions-dr", ]
      },
      "9-12.CT.e.1": {
        "description": "Create models and simulations to help formulate, test, and refine hypotheses.",
        "lessons": []
      },
      "9-12.CT.e.2": {
        "description": "Form a model from a hypothesis generated from research and run a simulation to collect and analyze data to test that hypothesis.",
        "lessons": []
      },
    },
    "OK": {
      "OK.PA.N.1": {
        "description": "Read, write, compare, classify, and represent real numbers and use them to solve problems in various contexts.",
        "lessons": []
      },
      "OK.PA.N.1.1": {
        "description": "Develop and apply the properties of integer exponents, including the zero exponent rule, to generate equivalent numerical and algebraic expressions.",
        "lessons": []
      },
      "OK.PA.N.1.2": {
        "description": "Express and compare approximations of very large and very small numbers using scientific notation.",
        "lessons": []
      },
      "OK.PA.N.1.3": {
        "description": "Multiply and divide numbers expressed in scientific notation, express the answer in scientific notation.",
        "lessons": []
      },
      "OK.PA.N.1.4": {
        "description": "Classify real numbers as rational or irrational. Explain why the rational number system is closed under addition and multiplication and why the irrational system is not. Explain why the sum of a rational number and an irrational number is irrational; and the product of a non-zero rational number and an irrational number is irrational.",
        "lessons": []
      },
      "OK.PA.N.1.5": {
        "description": "Compare real numbers; locate real numbers on a number line. Identify the square root of a perfect square to 400 or, if it is not a perfect square root, locate it as an irrational number between two consecutive positive integers.",
        "lessons": []
      },
      "OK.PA.A.1": {
        "description": "Understand the concept of function in real-world and mathematical situations, and distinguish between linear and nonlinear functions.",
        "lessons": []
      },
      "OK.PA.A.1.1": {
        "description": "Recognize that a function is a relationship between an independent variable and a dependent variable in which the value of the independent variable determines the value of the dependent variable.",
        "lessons": ["player-animation", "piecewise-functions-conditionals", "functions-make-life-easier", "contracts", ]
      },
      "OK.PA.A.1.2": {
        "description": "Use linear functions to represent and explain real-world and mathematical situations.",
        "lessons": ["functions-for-character-animation", "functions-dr", "functions-make-life-easier", ]
      },
      "OK.PA.A.1.3": {
        "description": "Identify a function as linear if it can be expressed in the form y = mx + b or if its graph is a straight line.",
        "lessons": ["functions-dr", ]
      },
      "OK.PA.A.2": {
        "description": "Recognize linear functions in real-world and mathematical situations; represent linear functions and other functions with tables, verbal descriptions, symbols, and graphs; solve problems involving linear functions and interpret results in the original context.",
        "lessons": ["functions-for-character-animation", "functions-dr", ]
      },
      "OK.PA.A.2.1": {
        "description": "Represent linear functions with tables, verbal descriptions, symbols, and graphs; translate from one representation to another.",
        "lessons": ["functions-for-character-animation", "function-definition-linear", "functions-can-be-linear", "functions-dr", ]
      },
      "OK.PA.A.2.2": {
        "description": "Identify, describe, and analyze linear relationships between two variables.",
        "lessons": ["probability-inference", "histograms2", "histograms", "grouped-samples", "choosing-your-dataset", "function-definition-linear", "functions-can-be-linear", ]
      },
      "OK.PA.A.2.3": {
        "description": "Identify graphical properties of linear functions including slope and intercepts. Know that the slope equals the rate of change, and that the yintercept is zero when the function represents a proportional relationship.",
        "lessons": ["function-definition-linear", ]
      },
      "OK.PA.A.2.4": {
        "description": "Predict the effect on the graph of a linear function when the slope or y-intercept changes. Use appropriate tools to examine these effects.",
        "lessons": ["function-definition-linear", "functions-can-be-linear", ]
      },
      "OK.PA.A.2.5": {
        "description": "Solve problems involving linear functions and interpret results in the original context.",
        "lessons": []
      },
      "OK.PA.A.3": {
        "description": "Generate equivalent numerical and algebraic expressions and use algebraic properties to evaluate expressions.",
        "lessons": ["order-of-operations", ]
      },
      "OK.PA.A.3.1": {
        "description": "Use substitution to simplify and evaluate algebraic expressions.",
        "lessons": ["function-composition", "defining-values", ]
      },
      "OK.PA.A.3.2": {
        "description": "Justify steps in generating equivalent expressions by identifying the properties used, including the properties of operations (associative, commutative, and distributive laws) and the order of operations, including grouping symbols.",
        "lessons": []
      },
      "OK.PA.A.4": {
        "description": "Represent real-world and mathematical problems using equations and inequalities involving linear expressions. Solve and graph equations and inequalities symbolically and graphically. Interpret solutions in the original context.",
        "lessons": ["flags", ]
      },
      "OK.PA.A.4.1": {
        "description": "Illustrate, write, and solve mathematical and real-world problems using linear equations with one variable with one solution, infinitely many solutions, or no solutions. Interpret solutions in the original context.",
        "lessons": []
      },
      "OK.PA.A.4.2": {
        "description": "Represent, write, solve, and graph problems leading to linear inequalities with one variable in the form px + q > r and px + q < r, where p, q, and r are rational numbers.",
        "lessons": []
      },
      "OK.PA.A.4.3": {
        "description": "Represent real-world situations using equations and inequalities involving one variable.",
        "lessons": ["inequalities3-sam", "inequalities2-compound", "inequalities1-simple", ]
      },
      "OK.PA.GM.1": {
        "description": "Solve problems involving right triangles using the Pythagorean Theorem.",
        "lessons": ["distance-formula", ]
      },
      "OK.PA.GM.1.1": {
        "description": "Informally justify the Pythagorean Theorem using measurements, diagrams, or dynamic software and use the Pythagorean Theorem to solve problems in two and three dimensions involving right triangles.",
        "lessons": ["distance-formula", ]
      },
      "OK.PA.GM.1.2": {
        "description": "Use the Pythagorean Theorem to find the distance between any two points in a coordinate plane.",
        "lessons": ["inequalities-collision", "distance-formula", ]
      },
      "OK.PA.GM.2": {
        "description": "Calculate surface area and volume of three-dimensional figures.",
        "lessons": ["surface-area-rect-prism", ]
      },
      "OK.PA.GM.2.1": {
        "description": "Calculate the surface area of a rectangular prism using decomposition or nets. Use appropriate units of measure, such as square centimeters.",
        "lessons": ["surface-area-rect-prism", ]
      },
      "OK.PA.GM.2.2": {
        "description": "Calculate the surface area of a cylinder, in terms of pi and using approximations for pi, using decomposition or nets. Use appropriate units of measure, such as square centimeters.",
        "lessons": ["surface-area-rect-prism", ]
      },
      "OK.PA.GM.2.3": {
        "description": "Develop and use the formulas V = lwh and V = Bh to determine the volume of rectangular prisms. Justify why base area (B) and height (h) are\n    multiplied to find the volume of a rectangular prism. Use appropriate measurements such as cubic centimeters.",
        "lessons": []
      },
      "OK.PA.GM.2.4": {
        "description": "Develop and use the formulas V = pi * r^2 * h and V = Bh to determine the volume of right cylinders, in terms of pi and using approximations for pi.\n    Justify why base area (B) and height (h) are multiplied to find the volume of a right cylinder. Use appropriate measurements such as cubic centimeters.",
        "lessons": []
      },
      "OK.PA.D.1": {
        "description": "Display and interpret data in a variety of ways, including using scatterplots and approximate lines of best fit. Use line of best fit and average rate of change to make predictions and draw conclusions about data.",
        "lessons": ["choosing-your-dataset", ]
      },
      "OK.PA.D.1.1": {
        "description": "Describe the impact that inserting or deleting a data point has on the mean and the median of a data set. Know how to create data displays using a spreadsheet and use a calculator to examine this impact.",
        "lessons": ["histograms2", "histograms", "grouped-samples", "choosing-your-dataset", ]
      },
      "OK.PA.D.1.2": {
        "description": "Explain how outliers affect measures of central tendency.",
        "lessons": ["measures-of-center", ]
      },
      "OK.PA.D.1.3": {
        "description": "Collect, display and interpret data using scatterplots. Use the shape of the scatterplot to informally estimate a line of best fit, make statements about average rate of change, and make predictions about values not in the original data set. Use appropriate titles, labels and units.",
        "lessons": ["scatter-plots", "linear-regression", "correlations", ]
      },
      "OK.PA.D.2": {
        "description": "Calculate experimental probabilities and reason about probabilities to solve real-world and mathematical problems.",
        "lessons": []
      },
      "OK.PA.D.2.1": {
        "description": "Calculate experimental probabilities and represent them as percents, fractions and decimals between 0 and 1 inclusive. Use experimental probabilities to make predictions when actual probabilities are unknown.",
        "lessons": []
      },
      "OK.PA.D.2.2": {
        "description": "Determine how samples are chosen (random, limited, biased) to draw and support conclusions about generalizing a sample to a population.",
        "lessons": ["probability-inference", ]
      },
      "OK.PA.D.2.3": {
        "description": "Compare and contrast dependent and independent events.",
        "lessons": []
      },
      "OK.MAP.1": {
        "description": "Develop a deep and flexible conceptual understanding.",
        "lessons": ["flags", ]
      },
      "OK.MAP.2": {
        "description": "Develop accurate and appropriate procedural fluency.",
        "lessons": ["order-of-operations", ]
      },
      "OK.MAP.3": {
        "description": "Develop strategies for problem solving.",
        "lessons": ["functions-for-character-animation", ]
      },
      "OK.MAP.4": {
        "description": "Develop mathematical reasoning.",
        "lessons": ["flags", ]
      },
      "OK.MAP.5": {
        "description": "Develop a productive mathematical disposition.",
        "lessons": ["functions-make-life-easier", ]
      },
      "OK.MAP.6": {
        "description": "Develop the ability to make conjectures, model, and generalize.",
        "lessons": ["functions-make-life-easier", ]
      },
      "OK.MAP.7": {
        "description": "Develop the ability to communicate mathematically.",
        "lessons": ["linear-regression", "functions-dr", ]
      },
      "OK.G.2D.1.8": {
        "description": "Construct logical arguments to prove triangle congruence (SSS, SAS, ASA, AAS and HL) and triangle similarity (AA, SSS, SAS).",
        "lessons": ["contracts", ]
      },
      "OK.G.2D.1.5": {
        "description": "Use coordinate geometry to represent and analyze line segments and polygons, including determining lengths, midpoints, and slopes of line segments.",
        "lessons": ["inequalities-collision", "distance-formula", ]
      },
      "OK.G.3D.1.1": {
        "description": "Solve real-world and mathematical problems\n    using the surface area and volume of prisms, cylinders,\n    pyramids, cones, spheres, and composites of these\n    figures. Use nets, measuring devices, or formulas as\n    appropriate.",
        "lessons": ["surface-area-rect-prism", ]
      },
      "OK.G.RT.1.1": {
        "description": "Apply the distance formula and the Pythagorean Theorem and its\n    converse to solve real-world and mathematical problems, as approximate\n    and exact values, using algebraic and logical reasoning (include Pythagorean\n      Triples).",
        "lessons": ["inequalities-collision", "distance-formula", ]
      },
      "OK.A1.N.1": {
        "description": "Extend the understanding of number and operations to include square roots and cube roots.",
        "lessons": []
      },
      "OK.A1.N.1.1": {
        "description": "Write square roots and cube roots of monomial algebraic expressions in simplest radical form.",
        "lessons": []
      },
      "OK.A1.N.1.2": {
        "description": "Add, subtract, multiply, and simplify square roots of monomial algebraic expressions and divide square roots of whole numbers, rationalizing\n    the denominator when necessary.",
        "lessons": []
      },
      "OK.A1.A.1": {
        "description": "Represent and solve mathematical and real-world problems using linear equations, absolute value equations, and systems of equations; interpret solutions in the original context.",
        "lessons": []
      },
      "OK.A1.A.1.1": {
        "description": "Use knowledge of solving equations with rational values to represent and solve mathematical and real-world problems (e.g., angle measures, geometric formulas, science, or statistics) and interpret the solutions in the original context.",
        "lessons": ["functions-make-life-easier", ]
      },
      "OK.A1.A.1.2": {
        "description": "Solve absolute value equations and interpret the solutions in the original context.",
        "lessons": []
      },
      "OK.A1.A.1.3": {
        "description": "Analyze and solve real-world and mathematical problems involving systems of linear equations with a maximum of two variables by graphing (may include graphing calculator or other appropriate technology), substitution, and elimination. Interpret the solutions in the original context.",
        "lessons": []
      },
      "OK.A1.A.2": {
        "description": "Represent and solve real-world and mathematical problems using linear inequalities, compound inequalities and systems of linear inequalities; interpret solutions in the original context.",
        "lessons": ["inequalities3-sam", ]
      },
      "OK.A1.A.2.1": {
        "description": "Represent relationships in various contexts with linear inequalities; solve the resulting inequalities, graph on a coordinate plane, and interpret the solutions.",
        "lessons": []
      },
      "OK.A1.A.2.2": {
        "description": "Represent relationships in various contexts with compound and absolute value inequalities and solve the resulting inequalities by graphing and interpreting the solutions on a number line.",
        "lessons": ["inequalities3-sam", "inequalities2-compound", ]
      },
      "OK.A1.A.2.3": {
        "description": "Solve systems of linear inequalities with a maximum of two variables; graph and interpret the solutions on a coordinate plane.",
        "lessons": []
      },
      "OK.A1.A.3": {
        "description": "Generate equivalent algebraic expressions and use algebraic properties to evaluate expressions and arithmetic and geometric sequences.",
        "lessons": ["order-of-operations", ]
      },
      "OK.A1.A.3.1": {
        "description": "Solve equations involving several variables for one variable in terms of the others.",
        "lessons": ["problem-decomposition", ]
      },
      "OK.A1.A.3.2": {
        "description": "Simplify polynomial expressions by adding, subtracting, or multiplying.",
        "lessons": []
      },
      "OK.A1.A.3.3": {
        "description": "Factor common monomial factors from polynomial expressions and factor quadratic expressions with a leading coefficient of 1.",
        "lessons": []
      },
      "OK.A1.A.3.4": {
        "description": "Evaluate linear, absolute value, rational, and radical expressions. Include applying a nonstandard operation such as a o b = 2a + b.",
        "lessons": []
      },
      "OK.A1.A.3.5": {
        "description": "Recognize that arithmetic sequences are linear using equations, tables, graphs, and verbal descriptions. Use the pattern, find the next term.",
        "lessons": []
      },
      "OK.A1.A.3.6": {
        "description": "Recognize that geometric sequences are exponential using equations, tables, graphs and verbal descriptions. Given the formula f(x) = a(r)^x, find the next term and define the meaning of a and r within the context of the problem.",
        "lessons": []
      },
      "OK.A1.A.4": {
        "description": "Analyze mathematical change involving linear equations in real-world and mathematical problems.",
        "lessons": ["function-definition-linear", ]
      },
      "OK.A1.A.4.1": {
        "description": "Calculate and interpret slope and the x- and y-intercepts of a line using a graph, an equation, two points, or a set of data points to solve realworld and mathematical problems.",
        "lessons": ["function-definition-linear", ]
      },
      "OK.A1.A.4.2": {
        "description": "Solve mathematical and real-world problems involving lines that are parallel, perpendicular, horizontal, or vertical.",
        "lessons": []
      },
      "OK.A1.A.4.3": {
        "description": "Express linear equations in slope-intercept, point-slope, and standard forms and convert between these forms. Given sufficient information (slope and y-intercept, slope and one-point on the line, two points on the line, x- and y-intercept, or a set of data points), write the equation of a line.",
        "lessons": []
      },
      "OK.A1.A.4.4": {
        "description": "Translate between a graph and a situation described qualitatively.",
        "lessons": []
      },
      "OK.A1.F.1": {
        "description": "Understand functions as descriptions of covariation (how related quantities vary together) in real-world and mathematical problems.",
        "lessons": []
      },
      "OK.A1.F.1.1": {
        "description": "Distinguish between relations and functions.",
        "lessons": []
      },
      "OK.A1.F.1.2": {
        "description": "Identify the dependent and independent variables as well as the domain and range given a function, equation, or graph. Identify restrictions on the domain and range in real-world contexts.",
        "lessons": ["contracts", ]
      },
      "OK.A1.F.1.3": {
        "description": "Write linear functions, using function notation, to model real-world and mathematical situations.",
        "lessons": ["function-composition", "functions-make-life-easier", "contracts", ]
      },
      "OK.A1.F.1.4": {
        "description": "Given a graph modeling a real-world situation, read and interpret the linear piecewise function (excluding step functions).",
        "lessons": ["advanced-displays", "contracts", ]
      },
      "OK.A1.F.2": {
        "description": "Recognize functions and understand that families of functions are characterized by their rate of change.",
        "lessons": []
      },
      "OK.A1.F.2.1": {
        "description": "Distinguish between linear and nonlinear (including exponential) functions arising from real-world and mathematical situations that are represented in tables, graphs, and equations. Understand that linear functions grow by equal intervals and that exponential functions grow by equal factors over equal intervals.",
        "lessons": ["function-definition-linear", "functions-can-be-linear", ]
      },
      "OK.A1.F.2.2": {
        "description": "Recognize the graph of the functions f(x) = x and f(x) = |x| and predict the effects of transformations [ f(x + c) and f(x) + c, where c is a positive or negative constant] algebraically and graphically using various methods and tools that may include graphing calculators.",
        "lessons": []
      },
      "OK.A1.F.3": {
        "description": "Represent functions in multiple ways and use the representation to interpret real-world and mathematical problems.",
        "lessons": ["function-definition-linear", "function-composition", "defining-values", ]
      },
      "OK.A1.F.3.1": {
        "description": "Identify and generate equivalent representations of linear equations, graphs, tables, and real-world situations.",
        "lessons": ["function-definition-linear", "defining-values", ]
      },
      "OK.A1.F.3.2": {
        "description": "Use function notation; evaluate a function, including nonlinear, at a given point in its domain algebraically and graphically. Interpret the results in terms of real-world and mathematical problems.",
        "lessons": ["function-composition", ]
      },
      "OK.A1.F.3.3": {
        "description": "Add, subtract, and multiply functions using function notation.",
        "lessons": ["function-composition", ]
      },
      "OK.A1.D.1": {
        "description": "Display, describe, and compare data. For linear relationships, make predictions and assess the reliability of those predictions.",
        "lessons": []
      },
      "OK.A1.D.1.1": {
        "description": "Describe a data set using data displays, describe and compare data sets using summary statistics, including measures of central tendency, location, and spread. Know how to use calculators, spreadsheets, or other appropriate technology to display data and calculate summary statistics.",
        "lessons": ["histograms2", "histograms", "grouped-samples", "choosing-your-dataset", ]
      },
      "OK.A1.D.1.2": {
        "description": "Collect data and use scatterplots to analyze patterns and describe linear relationships between two variables. Using graphing technology, determine regression lines and correlation coefficients; use regression lines to make predictions and correlation coefficients to assess the reliability of those predictions.",
        "lessons": ["data-collection", ]
      },
      "OK.A1.D.1.3": {
        "description": "Interpret graphs as being discrete or continuous.",
        "lessons": []
      },
      "OK.A1.D.2": {
        "description": "Calculate probabilities and apply probability concepts.",
        "lessons": []
      },
      "OK.A1.D.2.1": {
        "description": "Select and apply counting procedures, such as the multiplication and addition principles and tree diagrams, to determine the size of a sample space (the number of possible outcomes) and to calculate probabilities.",
        "lessons": ["table-methods", "composing-table-operations", "defining-table-functions", ]
      },
      "OK.A1.D.2.2": {
        "description": "Describe the concepts of intersections, unions, and complements using Venn diagrams to evaluate probabilities. Understand the relationships between these concepts and the words AND, OR, and NOT.",
        "lessons": ["inequalities2-compound", ]
      },
      "OK.A1.D.2.3": {
        "description": "Calculate experimental probabilities by performing simulations or experiments involving a probability model and using relative frequencies of outcomes.",
        "lessons": []
      },
      "OK.A1.D.2.4": {
        "description": "Apply probability concepts to real-world situations to make informed decisions.",
        "lessons": []
      },
      "OK.A2.F.1.8": {
        "description": "Graph piecewise functions with no more than three branches (including linear, quadratic, or exponential branches) and analyze the function by\n    identifying the domain, range, intercepts, and intervals for which it is increasing, decreasing, and constant.",
        "lessons": ["advanced-displays", ]
      },
      "OK.A2.D.2.1": {
        "description": "Evaluate reports based on data published in the media by identifying the source of the data, the design of the study, and the way the data are analyzed and displayed. Given spreadsheets, tables, or graphs, recognize and analyze distortions in data displays. Show how graphs and data can be distorted to support different points of view.",
        "lessons": []
      },
      "OK.3.CS.HS.01": {
        "description": "Model how information flows through hardware and software to accomplish tasks.",
        "lessons": []
      },
      "OK.4.CS.HS.01": {
        "description": "Model that information is translated, transmitted, and processed in order to flow through hardware and software.",
        "lessons": []
      },
      "OK.5.CS.HS.01": {
        "description": "Model that information is translated into bits in order to transmit and process between software to accomplish tasks.",
        "lessons": []
      },
      "OK.3.CS.T.01": {
        "description": "Identify, using accurate terminology, simple hardware and software problems that may occur during everyday use, discuss problems with peers and adults, and apply strategies for solving these problems.",
        "lessons": []
      },
      "OK.4.CS.T.01": {
        "description": "Identify, using accurate terminology, simple hardware and software problems that may occur during everyday use, discuss problems with peers and adults, and apply strategies for solving these problems.",
        "lessons": []
      },
      "OK.5.CS.T.01": {
        "description": "Identify, using accurate terminology, simple hardware and software problems that may occur during everyday use. Discuss problems with peers and adults, apply strategies for solving these problems and explain why the strategy should work.",
        "lessons": []
      },
      "OK.3.NI.NCO.01": {
        "description": "Recognize that information is sent and received over physical or wireless paths.",
        "lessons": []
      },
      "OK.4.NI.NCO.01": {
        "description": "Explain how information is sent and received across physical or wireless paths.",
        "lessons": []
      },
      "OK.5.NI.NCO.01": {
        "description": "Model how information is broken down into packets and transmitted through multiple devices over networks and the Internet, and reassembled at the destination.",
        "lessons": []
      },
      "OK.3.NI.C.01": {
        "description": "Identify problems that relate to inappropriate use of computing devices and networks.",
        "lessons": []
      },
      "OK.4.NI.C.01": {
        "description": "Identify and explain issues related to responsible use of technology and information, and describe personal consequences of inappropriate use.",
        "lessons": []
      },
      "OK.5.NI.C.01": {
        "description": "Discuss real-world cybersecurity problems and identify strategies for how personal information can be protected.",
        "lessons": []
      },
      "OK.3.DA.S.01": {
        "description": "Recognize that different types of information are stored in different formats that have associated programs and varied storage requirements.",
        "lessons": []
      },
      "OK.4.DA.S.01": {
        "description": "Choose different storage locations based on the type of file, storage requirements, and sharing requirements.",
        "lessons": []
      },
      "OK.5.DA.S.01": {
        "description": "Evaluate trade-offs, including availability and quality, based on the type of file, storage requirements, and sharing requirements.",
        "lessons": []
      },
      "OK.3.DA.CVT.01": {
        "description": "Collect and organize data in various visual formats.",
        "lessons": ["data-collection", ]
      },
      "OK.4.DA.CVT.01": {
        "description": "Organize and present collected data visually to highlight comparisons.",
        "lessons": ["data-collection", ]
      },
      "OK.5.DA.CVT.01": {
        "description": "Organize and present collected data to highlight comparisons and support a claim.",
        "lessons": ["data-collection", ]
      },
      "OK.3.DA.IM.01": {
        "description": "With guidance, utilize data to make predictions and discuss whether there is adequate data to make reliable predictions.",
        "lessons": ["threats-to-validity", "linear-regression", ]
      },
      "OK.4.DA.IM.01": {
        "description": "Determine how the accuracy of conclusions are influenced by the amount of data collected.",
        "lessons": ["linear-regression", ]
      },
      "OK.5.DA.IM.01": {
        "description": "Use data to highlight or propose cause and effect relationships, predict outcomes, or communicate an idea.",
        "lessons": ["ds-intro", ]
      },
      "OK.3.AP.A.01": {
        "description": "Compare multiple algorithms for the same task.",
        "lessons": ["flags", ]
      },
      "OK.4.AP.A.01": {
        "description": "Compare and refine multiple algorithms for the same task.",
        "lessons": ["composing-table-operations", "flags", ]
      },
      "OK.5.AP.A.01": {
        "description": "Compare and refine multiple algorithms for the same task and determine which is the most efficient.",
        "lessons": ["function-composition", "flags", ]
      },
      "OK.3.A.V.01": {
        "description": "Create programs that use variables to store and modify grade level appropriate data.",
        "lessons": ["defining-values", ]
      },
      "OK.4.AP.V.01": {
        "description": "Create programs that use variables to store and modify grade level appropriate data.",
        "lessons": ["defining-values", ]
      },
      "OK.5.AP.V.01": {
        "description": "Create programs that use variables to store and modify grade level appropriate data.",
        "lessons": ["defining-values", ]
      },
      "OK.3.AP.C.01": {
        "description": "Create programs using a programming language that utilize sequencing, repetition, conditionals, and variables to solve a problem or express ideas both independently and collaboratively.",
        "lessons": ["composing-table-operations", "grouped-samples", ]
      },
      "OK.4.AP.C.01": {
        "description": "Create programs using a programming language that utilize sequencing, repetition, conditionals and variables using math operations manipulate values to solve a problem or express ideas both independently and collaboratively.",
        "lessons": ["flags", ]
      },
      "OK.5.AP.C.01": {
        "description": "Create programs using a programming language that utilize sequencing, repetition, conditionals, event handlers and variables using math operations to manipulate values to solve a problem or express ideas both independently and collaboratively.",
        "lessons": []
      },
      "OK.3.AP.M.01": {
        "description": "Decompose the steps needed to solve a problem into a precise sequence of instructions.",
        "lessons": ["flags", ]
      },
      "OK.4.AP.M.01": {
        "description": "Decompose large problems into smaller, manageable subproblems to facilitate the program development process.",
        "lessons": ["composing-table-operations", "problem-decomposition", ]
      },
      "OK.5.AP.M.01": {
        "description": "Decompose large problems into smaller, manageable subproblems and then into a precise sequence of instructions.",
        "lessons": ["composing-table-operations", "problem-decomposition", ]
      },
      "OK.3.AP.M.02": {
        "description": "With grade appropriate complexity, modify, remix, or incorporate portions of an existing program into one's own work, to develop something new or add more advanced features.",
        "lessons": ["player-animation", "making-game-images", "functions-for-character-animation", ]
      },
      "OK.4.AP.M.02": {
        "description": "With grade appropriate complexity, modify, remix, or incorporate portions of an existing program into one's own work, to develop something new or add more advanced features.",
        "lessons": ["player-animation", "making-game-images", "functions-for-character-animation", ]
      },
      "OK.5.AP.M.02": {
        "description": "With grade appropriate complexity, modify, remix, or incorporate portions of an existing program into one's own work, to develop something new or add more advanced features.",
        "lessons": ["player-animation", "making-game-images", "functions-for-character-animation", ]
      },
      "OK.3.AP.PD.01": {
        "description": "Use an iterative process to plan the development of a program while solving simple problems.",
        "lessons": ["defining-table-functions", "functions-dr", "functions-make-life-easier", ]
      },
      "OK.4.AP.PD.01": {
        "description": "Use an iterative process to plan the development of a program that includes user preferences while solving simple problems.",
        "lessons": []
      },
      "OK.5.AP.PD.01": {
        "description": "Use an iterative process to plan the development of a program that includes others' perspectives and user preferences while solving simple problems.",
        "lessons": []
      },
      "OK.3.AP.PD.02": {
        "description": "Observe intellectual property rights and give appropriate credit when creating or remixing programs.",
        "lessons": ["making-game-images", ]
      },
      "OK.4.AP.PD.02": {
        "description": "Observe intellectual property rights and give appropriate credit when creating or remixing programs.",
        "lessons": []
      },
      "OK.5.AP.PD.02": {
        "description": "Observe intellectual property rights and give appropriate credit when creating or remixing programs.",
        "lessons": ["making-game-images", ]
      },
      "OK.3.AP.PD.03": {
        "description": "Analyze and debug a program that includes sequencing, repetition and variables in a programming language.",
        "lessons": ["flags", "debugging", ]
      },
      "OK.4.AP.PD.03": {
        "description": "Analyze, create, and debug a program that includes sequencing, repetition, conditionals and variables in a programming language.",
        "lessons": ["composing-table-operations", "debugging", ]
      },
      "OK.5.AP.PD.03": {
        "description": "Analyze, create, and debug a program that includes sequencing, repetition, conditionals and variables in a programming language.",
        "lessons": ["composing-table-operations", "debugging", ]
      },
      "OK.3.AP.PD.04": {
        "description": "Communicate and explain your program development using comments, presentations and demonstrations.",
        "lessons": ["functions-dr", ]
      },
      "OK.4.AP.PD.04": {
        "description": "Communicate and explain your program development using comments, presentations and demonstrations.",
        "lessons": ["functions-dr", ]
      },
      "OK.5.AP.PD.04": {
        "description": "Communicate and explain your program development using comments, presentations and demonstrations.",
        "lessons": ["functions-dr", ]
      },
      "OK.3.IC.C.01": {
        "description": "Identify computing technologies that have changed the world, and express how those technologies influence, and are influenced by, cultural practices.",
        "lessons": []
      },
      "OK.4.IC.C.01": {
        "description": "Give examples of computing technologies that have changed the world, and express how those technologies influence, and are influenced by, cultural practices.",
        "lessons": []
      },
      "OK.5.IC.C.01": {
        "description": "Give examples and explain how computing technologies have changed the world, and express how computing technologies influence, and are influenced by, cultural practices.",
        "lessons": []
      },
      "OK.3.IC.C.02": {
        "description": "Identify possible problems and how computing devices have built in features for increasing accessibility to all users.",
        "lessons": []
      },
      "OK.4.IC.C.02": {
        "description": "Brainstorm problems and ways to improve computing devices to increase accessibility to all users.",
        "lessons": []
      },
      "OK.5.IC.C.02": {
        "description": "Develop, test and refine digital artifacts to improve accessibility and usability.",
        "lessons": []
      },
      "OK.3.IC.SI.01": {
        "description": "Develop a code of conduct, explain, and practice grade-level appropriate behavior and responsibilities while participating in an online community. Identify and report inappropriate behavior.",
        "lessons": []
      },
      "OK.4.IC.SI.01": {
        "description": "Develop a code of conduct, explain, and practice grade-level appropriate behavior and responsibilities while participating in an online community. Identify and report inappropriate behavior.",
        "lessons": []
      },
      "OK.5.IC.SI.01": {
        "description": "Develop a code of conduct, explain, and practice grade-level appropriate behavior and responsibilities while participating in an online community. Identify and report inappropriate behavior.",
        "lessons": []
      },
      "OK.3.IC.SI.02": {
        "description": "Identify how computational products may be, or have been, improved to incorporate diverse perspectives.",
        "lessons": []
      },
      "OK.4.IC.SI.02": {
        "description": "As a team, consider each others perspectives on improving a computational product.",
        "lessons": []
      },
      "OK.5.IC.SI.02": {
        "description": "As a team, collaborate with outside resources (other grade levels, online collaborative spaces) to include diverse perspectives to improve computational products.",
        "lessons": []
      },
      "OK.3.IC.SLE.01": {
        "description": "Identify types of digital data that may have intellectual property rights that prevent copying or require attribution.",
        "lessons": []
      },
      "OK.4.IC.SLE.01": {
        "description": "Discuss the social impact of violating intellectual property rights.",
        "lessons": []
      },
      "OK.5.IC.SLE.01": {
        "description": "Observe intellectual property rights and give appropriate credit when using resources.",
        "lessons": []
      },
      "OK.5.GM.1.1": {
        "description": "Describe, classify and construct triangles, including equilateral, right, scalene, and isosceles triangles. Recognize triangles in various contexts.",
        "lessons": ["contracts", ]
      },
      "OK.6.A.1.1": {
        "description": "Plot integer- and rational-valued (limited to halves and fourths) ordered-pairs as coordinates in all four quadrants and recognize the reflective relationships among coordinates that differ only by their signs.",
        "lessons": ["flags", "coordinates", ]
      },
      "OK.6.A.1.3": {
        "description": "Use and evaluate variables in expressions, equations, and inequalities that arise from various contexts, including determining when or if, for a given value of the variable, an equation or inequality involving a variable is true or false.",
        "lessons": ["simple-data-types", ]
      },
      "OK.6.A.3.1": {
        "description": "Represent real-world or mathematical situations using expressions, equations and inequalities involving variables and rational numbers.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", ]
      },
      "OK.6.GM.2.2": {
        "description": "Develop and use the fact that the sum of the interior angles of a triangle is 180° to determine missing angle measures in a triangle.",
        "lessons": ["contracts", ]
      },
      "OK.6.CS.D.01": {
        "description": "Evaluate existing computing devices and recommend improvements to design based on analysis of personal interaction with the device.",
        "lessons": []
      },
      "OK.7.N.1.1": {
        "description": "Know that every rational number can be written as the ratio of two integers or as a terminating or repeating decimal.",
        "lessons": ["simple-data-types", ]
      },
      "OK.7.N.1.2": {
        "description": "Compare and order rational numbers expressed in various forms using the symbols <, >, and =.",
        "lessons": ["simple-data-types", ]
      },
      "OK.7.N.1.3": {
        "description": "Recognize and generate equivalent representations of rational numbers, including equivalent fractions.",
        "lessons": ["simple-data-types", ]
      },
      "OK.7.CS.D.01": {
        "description": "Evaluate existing computing devices and recommend improvements to design based on analysis of how other users interact with the device.",
        "lessons": []
      },
      "OK.7.A.3.1": {
        "description": " Write and solve problems leading to linear equations with one variable in the form px + q = r and p(x + q) = r, where p, q, and r are rational numbers.",
        "lessons": []
      },
      "OK.7.A.3.3": {
        "description": "Represent real-world or mathematical situations using equations and inequalities involving variables and rational numbers.",
        "lessons": ["inequalities3-sam", "inequalities2-compound", "inequalities1-simple", "defining-values", ]
      },
      "OK.7.A.4.2": {
        "description": "Apply understanding of order of operations and grouping symbols when using calculators and other technologies",
        "lessons": ["order-of-operations", ]
      },
      "OK.7.GM.1.1": {
        "description": "Using a variety of tools and strategies, develop the concept that surface area of a rectangular prism with rational-valued edge lengths can be found by wrapping the figure with samesized square units without gaps or overlap. Use appropriate measurements such as cm^2",
        "lessons": ["surface-area-rect-prism", ]
      },
      "OK.7.GM.4.1": {
        "description": "Describe the properties of similarity, compare geometric figures for similarity, and determine scale factors resulting from dilations.",
        "lessons": ["making-game-images", "flags", ]
      },
      "OK.7.GM.4.2": {
        "description": "Apply proportions, ratios, and scale factors to solve problems involving scale drawings and determine side lengths and areas of similar triangles and rectangles.",
        "lessons": ["making-game-images", "flags", ]
      },
      "OK.8.CS.D.01": {
        "description": "Develop and implement a process to evaluate existing computing devices and recommend improvements to design based on analysis of how other users interact with the device.",
        "lessons": []
      },
      "OK.6.CS.HS.01": {
        "description": "Identify ways that hardware and software are combined to collect and exchange data.",
        "lessons": []
      },
      "OK.7.CS.HS.01": {
        "description": "Evaluate and recommend improvements to software and hardware combinations used to collect and exchange data.",
        "lessons": []
      },
      "OK.8.CS.HS.01": {
        "description": "Design and refine projects that combine hardware and software components to collect and exchange data.",
        "lessons": []
      },
      "OK.6.CS.T.01": {
        "description": "Identify increasingly complex software and hardware problems with computing devices and their components.",
        "lessons": []
      },
      "OK.7.CS.T.01": {
        "description": "Identify and fix increasingly complex software and hardware problems with computing devices and their components.",
        "lessons": ["problem-decomposition", ]
      },
      "OK.8.CS.T.01": {
        "description": "Systematically identify, fix, and document increasingly complex software and hardware problems with computing devices and their components.",
        "lessons": ["problem-decomposition", ]
      },
      "OK.6.NI.NCO.01": {
        "description": "Model a simple protocol for transferring information using packets.",
        "lessons": []
      },
      "OK.7.NI.NCO.01": {
        "description": "Explain how a system responds when a packet is lost and the effect it has on the transferred information.",
        "lessons": []
      },
      "OK.8.NI.NCO.01": {
        "description": "Explain protocols and their importance to data transmission; model how packets are broken down into smaller pieces and how they are delivered.",
        "lessons": []
      },
      "OK.6.NI.C.01": {
        "description": "Identify existing cybersecurity concerns with the Internet and systems it uses.",
        "lessons": []
      },
      "OK.7.NI.C.01": {
        "description": "Explain how to protect electronic information, both physical (e.g. hard drive) and digital, identify cybersecurity concerns and options to address issues with the Internet and the systems it uses.",
        "lessons": []
      },
      "OK.8.NI.C.01": {
        "description": "Evaluate physical and digital procedures that could be implemented to protect electronic data/information; explain the impacts of hacking, ransomware, scams, fake scans, and ethical/legal concerns.",
        "lessons": []
      },
      "OK.6.NI.C.02": {
        "description": "Explain the importance of secured websites and describe how one method of encryption works.",
        "lessons": []
      },
      "OK.7.NI.C.02": {
        "description": "Identify and explain two or more methods of encryption used to ensure and secure the transmission of information.",
        "lessons": []
      },
      "OK.8.NI.C.02": {
        "description": "Compare the advantages and disadvantages of multiple methods of encryption to model the secure transmission of information.",
        "lessons": []
      },
      "OK.6.DA.S.01": {
        "description": "Identify how the same data can be represented in multiple ways.",
        "lessons": ["bar-and-pie-charts", ]
      },
      "OK.7.DA.S.01": {
        "description": "Create multiple representations of data.",
        "lessons": ["bar-and-pie-charts", ]
      },
      "OK.8.DA.S.01": {
        "description": "Analyze multiple methods of representing data and choose the most appropriate method for representing data.",
        "lessons": ["standard-deviation", "box-plots", "histograms2", "histograms", "grouped-samples", "bar-and-pie-charts", "choosing-your-dataset", ]
      },
      "OK.6.DA.CVT.01": {
        "description": "Collect data using computational tools and transform the data to make it more useful.",
        "lessons": ["standard-deviation", "box-plots", ]
      },
      "OK.7.DA.CVT.01": {
        "description": "Collect data using computational tools and transform the data to make it more useful and reliable.",
        "lessons": ["standard-deviation", "box-plots", ]
      },
      "OK.8.DA.CVT.01": {
        "description": "Develop, implement, and refine a process that utilizes computational tools to collect and transform data to make it more useful and reliable.",
        "lessons": ["grouped-samples", "ds-intro", ]
      },
      "OK.6.DA.IM.01": {
        "description": "Use models and simulations to formulate, refine, and test hypotheses.",
        "lessons": []
      },
      "OK.7.DA.IM.01": {
        "description": "Discuss the correctness of a model representing a system by comparing the model’s generated results with observed data from the modeled system.",
        "lessons": []
      },
      "OK.8.DA.IM.01": {
        "description": "Refine computational models based on the data generated by the models.",
        "lessons": []
      },
      "OK.6.D.1.3": {
        "description": "Create and analyze box and whisker plots observing how each segment contains one quarter of the data.",
        "lessons": ["standard-deviation", "box-plots", "histograms2", "histograms", "grouped-samples", "bar-and-pie-charts", "choosing-your-dataset", ]
      },
      "OK.7.D.1.2": {
        "description": "Use reasoning with proportions to display and interpret data in circle graphs (pie charts) and histograms. Choose the appropriate data display and know how to create the display using a spreadsheet or other graphing technology.",
        "lessons": ["standard-deviation", "box-plots", "histograms2", "histograms", "grouped-samples", "bar-and-pie-charts", "choosing-your-dataset", ]
      },
      "OK.6.AP.A.01": {
        "description": "Use an existing algorithm in natural language or pseudocode to solve complex problems.",
        "lessons": ["functions-dr", ]
      },
      "OK.7.AP.A.01": {
        "description": "Select and modify an existing algorithm in natural language or pseudocode to solve complex problems.",
        "lessons": ["table-methods", "surface-area-rect-prism", "simple-data-types", "functions-dr", ]
      },
      "OK.8.AP.A.01": {
        "description": "Design algorithms in natural language, flow and control diagrams, comments within code, and/or pseudocode to solve complex problems.",
        "lessons": ["making-game-images", "functions-for-character-animation", "flags", "functions-dr", ]
      },
      "OK.6.AP.C.01": {
        "description": "Develop programs that utilize combinations of repetition, conditionals, and the manipulation of variables representing different data types.",
        "lessons": ["inequalities3-sam", ]
      },
      "OK.7.AP.C.01": {
        "description": "Develop programs that utilize combinations of repetition, compound conditionals, and the manipulation of variables representing different data types.",
        "lessons": []
      },
      "OK.8.AP.C.01": {
        "description": "Develop programs that utilize combinations of nested repetition, compound conditionals, procedures without parameters, and the manipulation of variables representing different data types.",
        "lessons": ["simple-data-types", ]
      },
      "OK.6.AP.M.01": {
        "description": "Decompose problems into parts to facilitate the design, implementation, and review of programs.",
        "lessons": ["problem-decomposition", "inequalities3-sam", "inequalities-collision", "flags", ]
      },
      "OK.7.AP.M.01": {
        "description": "Decompose problems into parts to facilitate the design, implementation, and review of increasingly complex programs.",
        "lessons": ["composing-table-operations", "problem-decomposition", "inequalities3-sam", "inequalities-collision", ]
      },
      "OK.8.AP.M.01": {
        "description": "Decompose problems and subproblems into parts to facilitate the design, implementation, and review of complex programs.",
        "lessons": ["composing-table-operations", "problem-decomposition", "inequalities3-sam", "inequalities-collision", ]
      },
      "OK.6.AP.PD.01": {
        "description": "Seek and incorporate feedback from team members to refine a solution to a problem.",
        "lessons": ["player-animation", "making-game-images", "inequalities-collision", "functions-for-character-animation", "flags", ]
      },
      "OK.7.AP.PD.01": {
        "description": "Seek and incorporate feedback from team members and users to refine a solution to a problem.",
        "lessons": ["player-animation", "making-game-images", "inequalities-collision", "functions-for-character-animation", ]
      },
      "OK.8.AP.PD.01": {
        "description": "Seek and incorporate feedback from team members and users to refine a solution to a problem that meets the needs of diverse users.",
        "lessons": []
      },
      "OK.6.AP.PD.02": {
        "description": "Incorporate existing code, media, and libraries into original programs and give attribution.",
        "lessons": ["making-game-images", ]
      },
      "OK.7.AP.PD.02": {
        "description": "Incorporate existing code, media, and libraries into original programs of increasing complexity and give attribution.",
        "lessons": ["making-game-images", ]
      },
      "OK.8.AP.PD.02": {
        "description": "Incorporate existing code, media, and libraries into original programs of increasing complexity and give attribution.",
        "lessons": ["functions-make-life-easier", ]
      },
      "OK.6.AP.PD.03": {
        "description": "Test and refine programs using teacher provided inputs.",
        "lessons": []
      },
      "OK.7.AP.PD.03": {
        "description": "Test and refine programs using a variety of student created inputs.",
        "lessons": []
      },
      "OK.8.AP.PD.03": {
        "description": "Systematically test and refine programs using a range of student created inputs.",
        "lessons": []
      },
      "OK.6.AP.PD.04": {
        "description": "Break down tasks and follow an individual timeline when developing a computational artifact.",
        "lessons": ["probability-inference", ]
      },
      "OK.7.AP.PD.04": {
        "description": "Distribute tasks and maintain a project timeline when collaboratively developing computational artifacts.",
        "lessons": ["probability-inference", ]
      },
      "OK.8.AP.PD.04": {
        "description": "Explain how effective communication between participants is required for successful collaboration when developing computational artifacts.",
        "lessons": ["functions-dr", ]
      },
      "OK.6.AP.PD.05": {
        "description": "Document text-based programs in order to make them easier to follow, test, and debug.",
        "lessons": ["functions-dr", ]
      },
      "OK.7.AP.PD.05": {
        "description": "Document text-based programs of increasing complexity in order to make them easier to follow, test, and debug.",
        "lessons": ["functions-dr", ]
      },
      "OK.8.AP.PD.05": {
        "description": "Document text-based programs of increasing complexity in order to make them easier to follow, test, and debug.",
        "lessons": ["functions-dr", ]
      },
      "OK.6.IC.C.01": {
        "description": "Explain how computing impacts people's everyday activities.",
        "lessons": ["computing-needs-all-voices", ]
      },
      "OK.7.IC.C.01": {
        "description": "Explain how computing impacts innovation in other fields.",
        "lessons": []
      },
      "OK.8.IC.C.01": {
        "description": "Describe the trade-offs associated with computing technologies (e.g. automation), explaining their effects on economies and global societies, and explore careers related to the field of computer science.",
        "lessons": []
      },
      "OK.6.IC.C.02": {
        "description": "Identify and discuss the technology proficiencies needed in the classroom and the workplace, and how to meet the needs of diverse users.",
        "lessons": []
      },
      "OK.7.IC.C.02": {
        "description": "Relate the distribution of computing resources in a global society to issues of equity, access, and power.",
        "lessons": []
      },
      "OK.8.IC.C.02": {
        "description": "Evaluate and improve the design of existing technologies to meet the needs of diverse users and increase accessibility and usability. Evaluate how technology can be used to distort, exaggerate, and misrepresent information.",
        "lessons": []
      },
      "OK.6.IC.SI.01": {
        "description": "Individually and collaboratively develop and conduct an online survey that seeks input from a broad audience. Describe and use safe, appropriate, and responsible practices (netiquette) when participating in online communities (e.g., discussion groups, blogs, social networking sites).",
        "lessons": []
      },
      "OK.7.IC.SI.01": {
        "description": "Individually and collaboratively use advanced tools to design and create online content (e.g., digital portfolio, multimedia, blog, web page). Describe and use safe, appropriate, and responsible practices (netiquette) when participating in online communities (e.g., discussion groups, blogs, social networking sites).",
        "lessons": []
      },
      "OK.8.IC.SI.01": {
        "description": "Communicate and publish key ideas and details individually or collaboratively in a way that informs, persuades, and/or entertains using a variety of digital tools and media-rich resources. Describe and use safe, appropriate, and responsible practices (netiquette) when participating in online communities (e.g., discussion groups, blogs, social networking sites).",
        "lessons": ["threats-to-validity", "choosing-your-dataset", ]
      },
      "OK.6.IC.SLE.01": {
        "description": "Differentiate between appropriate and inappropriate content on the Internet, and identify unethical and illegal online behavior.",
        "lessons": []
      },
      "OK.7.IC.SLE.01": {
        "description": "Explain the connection between the longevity of data on the Internet, personal online identity, and personal privacy.",
        "lessons": []
      },
      "OK.8.IC.SLE.01": {
        "description": "Discuss the social impacts and ethical considerations associated with cybersecurity, including the positive and malicious purposes of hacking.",
        "lessons": []
      },
      "OK.L1.CS.D.01": {
        "description": "Explain how abstractions hide the underlying implementation details of computing systems embedded in everyday objects.",
        "lessons": ["numbers-inside-video games", "coordinates", ]
      },
      "OK.L1.CS.HS.01": {
        "description": "Explain the interactions between application software, system software, and hardware.",
        "lessons": []
      },
      "OK.L2.CS.HS.01": {
        "description": "Identify and categorize roles of an operating system.",
        "lessons": []
      },
      "OK.L1.CS.T.01": {
        "description": "Develop and apply criteria for systematic discovery of errors and systematic strategies for correction of errors in computing systems.",
        "lessons": ["debugging", ]
      },
      "OK.L2.CS.T.01": {
        "description": "Identify how hardware components facilitate logic, input, output, and storage in computing systems.",
        "lessons": []
      },
      "OK.L1.NI.NCO.01": {
        "description": "Evaluate the scalability and reliability of networks by identifying and illustrating the basic components of computer networks (e.g., routers, switches, servers, etc.) and network protocols (e.g., IP, DNS, etc.).",
        "lessons": []
      },
      "OK.L2.NI.NCO.01": {
        "description": "Describe the issues that impact network functionality (e.g., bandwidth, load, latency, topology).",
        "lessons": []
      },
      "OK.L1.NI.C.01": {
        "description": "Compare physical and cybersecurity measures by evaluating trade-offs between the usability and security of a computing system.",
        "lessons": []
      },
      "OK.L2.NI.C.01": {
        "description": "Compare and refine ways in which software developers protect devices and information from unauthorized access.",
        "lessons": []
      },
      "OK.L1.NI.C.02": {
        "description": "Illustrate how sensitive data can be affected by attacks.",
        "lessons": []
      },
      "OK.L1.NI.C.03": {
        "description": "Recommend security measures to address various scenarios based on information security principles.",
        "lessons": []
      },
      "OK.L1.NI.C.04": {
        "description": "Explain trade-offs when selecting and implementing cybersecurity recommendations from multiple perspectives such as the user, enterprise, and government.",
        "lessons": []
      },
      "OK.L1.DA.S.01": {
        "description": "Translate and compare different bit representations of data types, such as characters, numbers, and images.",
        "lessons": []
      },
      "OK.L1.DA.S.02": {
        "description": "Evaluate the trade-offs in how data is organized and stored digitally.",
        "lessons": []
      },
      "OK.L1.DA.CVT.01": {
        "description": "Use tools and techniques to locate, collect, and create visualizations of small- and largescale data sets (e.g., paper surveys and online data sets).",
        "lessons": ["choosing-your-dataset", ]
      },
      "OK.L2.DA.CVT.01": {
        "description": "Use data analysis tools and techniques to identify patterns from complex real-world data.",
        "lessons": ["linear-regression", ]
      },
      "OK.L2.DA.CVT.02": {
        "description": "Generate data sets that use a variety of data collection tools and analysis techniques to support a claim and/or communicate information.",
        "lessons": ["standard-deviation", "box-plots", ]
      },
      "OK.L1.DA.IM.01": {
        "description": "Show the relationships between collected data elements using computational models.",
        "lessons": ["scatter-plots", "linear-regression", "correlations", ]
      },
      "OK.L2.DA.IM.01": {
        "description": "Use models and simulations to help formulate, refine, and test scientific hypotheses.",
        "lessons": []
      },
      "OK.L1.AP.A.01": {
        "description": "Create a prototype that uses algorithms (e.g., searching, sorting, finding shortest distance) to provide a possible solution for a real-world problem.",
        "lessons": ["grouped-samples", "surface-area-rect-prism", "inequalities3-sam", ]
      },
      "OK.L2.AP.A.01": {
        "description": "Describe how artificial intelligence algorithms drive many software and physical systems (e.g., autonomous robots, computer vision, pattern recognition, text analysis).",
        "lessons": []
      },
      "OK.L2.AP.A.02": {
        "description": "Develop an artificial intelligence algorithm to play a game against a human opponent or solve a real world problem.",
        "lessons": []
      },
      "OK.L2.AP.A.03": {
        "description": "Critically examine and trace classic algorithms (e.g., selection sort, insertion sort, binary search, linear search).",
        "lessons": []
      },
      "OK.L2.AP.A.04": {
        "description": "Evaluate algorithms (e.g., sorting, searching) in terms of their efficiency and clarity.",
        "lessons": []
      },
      "OK.L1.AP.V.01": {
        "description": "Demonstrate the use of lists (e.g., arrays) to simplify solutions, generalizing computational problems instead of repeatedly using primitive variables.",
        "lessons": []
      },
      "OK.L2.AP.V.01": {
        "description": "Compare and contrast simple data structures and their uses (e.g., lists, stacks, queues).",
        "lessons": []
      },
      "OK.L1.AP.C.01": {
        "description": "Justify the selection of specific control structures (e.g., sequence, conditionals, repetition, procedures) considering program efficiencies such as readability, performance, and memory usage.",
        "lessons": []
      },
      "OK.L2.AP.C.01": {
        "description": "Trace the execution of repetition (e.g., loops, recursion), illustrating output and changes in values of named variables.",
        "lessons": []
      },
      "OK.L1.AP.M.01": {
        "description": "Break down a solution into procedures using systematic analysis and design.",
        "lessons": ["composing-table-operations", "advanced-displays", "defining-table-functions", "problem-decomposition", "piecewise-functions-conditionals", ]
      },
      "OK.L2.AP.M.01": {
        "description": "Construct solutions to problems using student-created components (e.g., procedures, modules, objects).",
        "lessons": []
      },
      "OK.L1.AP.M.02": {
        "description": "Create computational artifacts by systematically organizing, manipulating and/or processing data.",
        "lessons": ["table-methods", "composing-table-operations", "advanced-displays", "defining-table-functions", "piecewise-functions-conditionals", ]
      },
      "OK.L2.AP.M.02": {
        "description": "Design or redesign a solution to a large-scale computational problem by identifying generalizable patterns.",
        "lessons": []
      },
      "OK.L2.AP.M.03": {
        "description": "Create programming solutions by reusing existing code (e.g., libraries, Application Programming Interface (APIs), code repositories).",
        "lessons": ["table-methods", "inequalities3-sam", ]
      },
      "OK.L1.AP.PD.01": {
        "description": "Create software by analyzing a problem and/or process, developing and documenting a solution, testing outcomes, and adapting the program for a variety of users.",
        "lessons": []
      },
      "OK.L2.AP.PD.01": {
        "description": "Create software that will provide solutions to a variety of users using the software life cycle process.",
        "lessons": []
      },
      "OK.L1.AP.PD.02": {
        "description": "Define and classify a variety of software licensing schemes (e.g., open source, freeware, commercial) and discuss the advantages and disadvantages of each scheme in software development.",
        "lessons": []
      },
      "OK.L2.AP.PD.02": {
        "description": "Design software in a project team environment using integrated development environments (IDEs), versioning systems, and collaboration systems.",
        "lessons": []
      },
      "OK.L1.AP.PD.03": {
        "description": "While working in a team, develop, test, and refine event-based programs that solve practical problems or allow self expression.",
        "lessons": []
      },
      "OK.L2.AP.PD.03": {
        "description": "Develop programs for multiple computing platforms.",
        "lessons": ["functions-make-life-easier", ]
      },
      "OK.L1.AP.PD.04": {
        "description": "Using visual aids and documentation, illustrate the design elements and data flow (e.g., flowcharts, pseudocode) of the development of a complex program.",
        "lessons": []
      },
      "OK.L2.AP.PD.04": {
        "description": "Systematically check code for correctness, usability, readability, efficiency, portability, and scalability through peer review.",
        "lessons": []
      },
      "OK.L1.AP.PD.05": {
        "description": "Evaluate and refine computational artifacts to make them more user-friendly, efficient and/or accessible.",
        "lessons": ["histograms2", "histograms", ]
      },
      "OK.L2.AP.PD.05": {
        "description": "Develop and use a series of test cases to verify that a program performs according to its design specifications.",
        "lessons": ["functions-dr", ]
      },
      "OK.L2.AP.PD.06": {
        "description": "Explain security issues that might lead to compromised computer programs.",
        "lessons": []
      },
      "OK.L2.AP.PD.07": {
        "description": "Modify an existing program to add additional functionality and discuss intended and unintended implications (e.g., breaking other functionality).",
        "lessons": ["player-animation", ]
      },
      "OK.L1.IC.C.01": {
        "description": "Evaluate the ways computing impacts personal, ethical, social, economic, and cultural practices.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
      "OK.L2.IC.C.01": {
        "description": "Evaluate the beneficial and harmful effects that computational artifacts and innovations have on society.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
      "OK.L1.IC.C.02": {
        "description": "Test and refine computational artifacts to reduce bias and equity deficits.",
        "lessons": ["threats-to-validity", "probability-inference", "grouped-samples", "choosing-your-dataset", "checking-your-work", ]
      },
      "OK.L2.IC.C.02": {
        "description": "Evaluate the impact of equity, access, and influence on the distribution of computing resources in a global society.",
        "lessons": []
      },
      "OK.L1.IC.C.03": {
        "description": "Demonstrate how a given algorithm applies to problems across disciplines.",
        "lessons": []
      },
      "OK.L2.IC.C.03": {
        "description": "Design and implement a study that evaluates or predicts how computation has revolutionized an aspect of our culture and how it might evolve (e.g., education, healthcare, art/entertainment, energy).",
        "lessons": []
      },
      "OK.L1.IC.SI.01": {
        "description": "Demonstrate how computing increases connectivity among people of various cultures.",
        "lessons": []
      },
      "OK.L1.IC.SLE.01": {
        "description": "Explain the beneficial and harmful effects that intellectual property laws can have on innovation.",
        "lessons": []
      },
      "OK.L2.IC.SLE.01": {
        "description": "Debate laws and regulations that impact the development and use of software.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
      "OK.L1.IC.SLE.02": {
        "description": "Explain the privacy concerns related to the large-scale collection and analysis of information about individuals (e.g., how businesses, social media, and the government collects and uses data) that may not be evident to users.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
      "OK.L1.IC.SLE.03": {
        "description": "Evaluate the social and economic consequences of how law and ethics interact with digital aspects of privacy, data, property, information, and identity.",
        "lessons": ["ethics-privacy-and-bias", ]
      },
      "OK.SP.1.5": {
        "description": "Use counting techniques including permutations and combinations to solve mathematical and real-world problems, including determining probabilities of compound events. ",
        "lessons": ["combinatorics-combination", "combinatorics-permutation", ]
      },
    },
    "OR": {
      "5.OA.A": {
        "description": "Write and interpret numerical expressions.",
        "lessons": ["order-of-operations", ]
      },
      "5.OA.A.1": {
        "description": "Write and evaluate numerical expressions that include parentheses.",
        "lessons": ["order-of-operations", ]
      },
      "5.OA.A.2": {
        "description": "Write expressions that record calculations with numbers, and interpret numerical expressions without evaluating them.",
        "lessons": []
      },
      "5.OA.B": {
        "description": "Analyze patterns and relationships.",
        "lessons": []
      },
      "5.OA.B.3": {
        "description": "Generate two numerical patterns using two given rules. Identify and analyze relationships between corresponding terms. Form ordered pairs consisting of corresponding terms from the two patterns, and graph the ordered pairs on a coordinate plane.",
        "lessons": ["flags", ]
      },
      "5.NBT.A": {
        "description": "Understand the place value system.",
        "lessons": []
      },
      "5.NBT.A.1": {
        "description": "Recognize that in a multi-digit number, a digit in one place represents 10 times as much as it represents in the place to its right and 1/10 of what it represents in the place to its left.",
        "lessons": []
      },
      "5.NBT.A.2": {
        "description": "Use whole number exponents to denote powers of 10 and explain the patterns in placement of digits that occur when multiplying and/or dividing whole numbers and decimals by powers of 10.",
        "lessons": []
      },
      "5.NBT.A.3": {
        "description": "Read, write, and compare decimals to thousandths.",
        "lessons": []
      },
      "5.NBT.A.4": {
        "description": "Use place value understanding to round decimals to any place.",
        "lessons": []
      },
      "5.NBT.B": {
        "description": "Perform operations with multi-digit whole numbers and with decimals to hundredths.",
        "lessons": []
      },
      "5.NBT.B.5": {
        "description": "Fluently multiply multi-digit whole numbers using accurate, efficient, and flexible strategies and algorithms based on place value and properties of operations.",
        "lessons": []
      },
      "5.NBT.B.6": {
        "description": "Use a variety of representations and strategies to find whole-number quotients of whole numbers with up to four-digit dividends and two-digit divisors.",
        "lessons": []
      },
      "5.NBT.B.7": {
        "description": "Use a variety of representations and strategies to add, subtract, multiply, and divide decimals to hundredths.  Relate the strategy to a written method and explain the reasoning used.",
        "lessons": []
      },
      "5.NF.A": {
        "description": "Use equivalent fractions as a strategy to add and subtract fractions.",
        "lessons": []
      },
      "5.NF.A.1": {
        "description": "Add and subtract fractions with unlike denominators, including common fractions larger than one and mixed numbers.",
        "lessons": []
      },
      "5.NF.A.2": {
        "description": "Solve problems in authentic contexts involving addition and subtraction of fractions with unlike denominators, including common fractions larger than one and mixed numbers.",
        "lessons": []
      },
      "5.NF.B": {
        "description": "Apply and extend previous understandings of multiplication and division.",
        "lessons": []
      },
      "5.NF.B.3": {
        "description": "Interpret a fraction as division of the numerator by the denominator (a/b = a ÷ b). Solve problems in authentic contexts involving division of whole numbers that result in answers that are common fractions or mixed numbers.",
        "lessons": []
      },
      "5.NF.B.4": {
        "description": "Apply and extend previous understanding and strategies of multiplication to multiply a fraction or whole number by a fraction. Multiply fractional side lengths to find areas of rectangles, and represent fractional products as rectangular areas.",
        "lessons": []
      },
      "5.NF.B.5": {
        "description": "Apply and extend previous understandings of multiplication and division to represent and calculate multiplication and division of fractions. Interpret multiplication as scaling (resizing) by comparing the size of products of two factors.",
        "lessons": []
      },
      "5.NF.B.6": {
        "description": "Solve problems in authentic contexts involving multiplication of common fractions and mixed numbers.",
        "lessons": []
      },
      "5.NF.B.7": {
        "description": "Apply and extend previous understandings of division to divide unit fractions by whole numbers and whole numbers by unit fractions, including solving problems in authentic contexts.",
        "lessons": []
      },
      "5.GM.A": {
        "description": "Graph points on the coordinate plane to solve real-world and mathematical problems.",
        "lessons": ["flags", ]
      },
      "5.GM.A.1": {
        "description": "Graph and name coordinate points in the first quadrant using the standard (x, y) notation. Understand the coordinate points values represent the distance traveled along the horizontal x-axis and vertical y-axis.",
        "lessons": ["flags", ]
      },
      "5.GM.A.2": {
        "description": "Represent authentic contexts and mathematical problems by graphing points in the first quadrant of the coordinate plane. Interpret the meaning of the coordinate values based on the context of a given situation.",
        "lessons": []
      },
      "5.GM.B": {
        "description": "Classify two-dimensional figures into categories based on their properties.",
        "lessons": []
      },
      "5.GM.B.3": {
        "description": "Classify two-dimensional figures within a hierarchy based on their geometrical properties, and explain the relationship across and within different categories of these figures.",
        "lessons": []
      },
      "5.GM.C": {
        "description": "Convert like measurement units within a given measurement system.",
        "lessons": []
      },
      "5.GM.C.4": {
        "description": "Convert between different-sized standard measurement units within a given measurement system.  Use these conversions in solving multi-step problems in authentic contexts.",
        "lessons": []
      },
      "5.GM.D": {
        "description": "Geometric measurement: understand concepts of volume.",
        "lessons": []
      },
      "5.GM.D.5": {
        "description": "Recognize that volume is a measurable attribute of solid figures.",
        "lessons": []
      },
      "5.GM.D.6": {
        "description": "Measure the volume of a rectangular prism by counting unit cubes using standard and nonstandard units.",
        "lessons": []
      },
      "5.GM.D.7": {
        "description": "Relate volume of rectangular prisms to the operations of multiplication and addition.  Solve problems in authentic contexts involving volume using a variety of strategies.",
        "lessons": []
      },
      "5.DR.A": {
        "description": "Pose investigative questions and collect/consider data.",
        "lessons": ["data-cycle", ]
      },
      "5.DR.A.1": {
        "description": "Generate questions to investigate situations within the classroom, school or community.  Determine strategies for collecting or considering data involving operations with fractions for this grade that can naturally answer questions by using information presented in line plots.",
        "lessons": ["data-cycle", ]
      },
      "5.DR.B": {
        "description": "Analyze, represent, and interpret data.",
        "lessons": []
      },
      "5.DR.B.2": {
        "description": "Analyze graphical representations and describe the distribution of the numerical data through line plots or categorical data through bar graphs. Interpret information presented to answer investigative questions.",
        "lessons": ["bar-and-pie-charts", "scatter-plots", ]
      },
      "6.RP.A": {
        "description": "Understand ratio concepts and use ratio reasoning to solve problems.",
        "lessons": ["bar-and-pie-charts", "flags", ]
      },
      "6.RP.A.1": {
        "description": "Understand the concept of a ratio and use ratio language to describe a ratio relationship between two quantities.",
        "lessons": ["flags", ]
      },
      "6.RP.A.2": {
        "description": "Understand the concept of a unit rate in authentic contexts and use rate language in the context of a ratio relationship.",
        "lessons": []
      },
      "6.RP.A.3": {
        "description": "Use ratio and rate reasoning to solve real-world and mathematical problems, e.g., by reasoning about tables of equivalent ratios, tape diagrams, double number line diagrams, or equations.",
        "lessons": ["hoc-data", ]
      },
      "6.NS.A": {
        "description": "Apply and extend previous understandings of multiplication and division to divide fractions by fractions.",
        "lessons": []
      },
      "6.NS.A.1": {
        "description": "Represent, interpret, and compute quotients of fractions to solve problems in authentic contexts involving division of fractions by fractions.",
        "lessons": []
      },
      "6.NS.B": {
        "description": "Compute fluently with multi-digit numbers and find common factors and multiples.",
        "lessons": []
      },
      "6.NS.B.2": {
        "description": "Fluently divide multi-digit numbers using accurate, efficient, and flexible strategies and algorithms based on place value and properties of operations.",
        "lessons": []
      },
      "6.NS.B.3": {
        "description": "Fluently add, subtract, multiply, and divide positive rational numbers using accurate, efficient, and flexible strategies and algorithms.",
        "lessons": []
      },
      "6.NS.B.4": {
        "description": "Determine greatest common factors and least common multiples using a variety of strategies. Apply the distributive property to express a sum of two whole numbers 1–100 with a common factor as a multiple of a sum of two whole numbers with no common factor.",
        "lessons": []
      },
      "6.NS.C": {
        "description": "Apply and extend previous understandings of numbers to the system of rational numbers.",
        "lessons": []
      },
      "6.NS.C.5": {
        "description": "Understand that positive and negative numbers are used together to describe quantities having opposite directions or values. Use positive and negative numbers to represent quantities in authentic contexts, explaining the meaning of zero in each situation.",
        "lessons": []
      },
      "6.NS.C.6": {
        "description": "Represent a rational number as a point on the number line. Extend number line diagrams and coordinate axes to represent points on the line and in the coordinate plane with negative number coordinates.",
        "lessons": []
      },
      "6.NS.C.7": {
        "description": "Interpret statements of inequality as statements about the relative position of two numbers on a number line diagram. Write, interpret, and explain statements of order for rational numbers and absolute value in authentic applications.",
        "lessons": []
      },
      "6.NS.C.8": {
        "description": "Graph points in all four quadrants of the coordinate plane to solve problems in authentic contexts. Include use of coordinates and absolute value to find distances between points with the same first coordinate or the same second coordinate.",
        "lessons": []
      },
      "6.AEE.A": {
        "description": "Apply and extend previous understandings of arithmetic to algebraic expressions.",
        "lessons": []
      },
      "6.AEE.A.1": {
        "description": "Write and evaluate numerical expressions involving whole-number bases and exponents.",
        "lessons": []
      },
      "6.AEE.A.2": {
        "description": "Write, read, and evaluate expressions in which letters stand for numbers.",
        "lessons": []
      },
      "6.AEE.A.3": {
        "description": "Apply the properties of operations to generate equivalent expressions and to determine when two expressions are equivalent.",
        "lessons": []
      },
      "6.AEE.B": {
        "description": "Reason about and solve one-variable equations and inequalities.",
        "lessons": ["inequalities1-simple", "inequalities2-compound", ]
      },
      "6.AEE.B.4": {
        "description": "Understand solving an equation or inequality as a process of answering a questionwhich values from a specified set, if any, make the equation or inequality true. Use substitution to determine which number(s) in a given set make an equation or inequality true.",
        "lessons": []
      },
      "6.AEE.B.5": {
        "description": "Use variables to represent numbers and write expressions when solving problems in authentic contexts.",
        "lessons": ["linear-regression", "grouped-samples", "defining-table-functions", "surface-area-rect-prism", "problem-decomposition", "player-animation", "inequalities3-sam", "inequalities-collision", "functions-for-character-animation", "function-definition-linear", "function-composition", "distance-formula", "piecewise-functions-conditionals", "defining-values", "functions-dr", "functions-examples-definitions", "functions-make-life-easier", ]
      },
      "6.AEE.B.6": {
        "description": "Write and solve equations of the form x + p = q and px = q in problems that arise from authentic contexts for cases in which p, q and x are all nonnegative rational numbers.",
        "lessons": []
      },
      "6.AEE.B.7": {
        "description": "Write inequalities of the form x > c and x < c to represent constraints or conditions to solve problems in authentic contexts.  Describe and graph on a number line solutions of inequalities of the form x > c and x < c.",
        "lessons": ["inequalities3-sam", "inequalities1-simple", ]
      },
      "6.AEE.C": {
        "description": "Represent and analyze quantitative relationships between dependent and independent variables.",
        "lessons": []
      },
      "6.AEE.C.8": {
        "description": "Use variables to represent and analyze two quantities to solve problems in authentic contexts.  Including those that change in relationship to one another; write an equation to express one quantity in terms of the other quantity.",
        "lessons": []
      },
      "6.G.A": {
        "description": "Solve real-world and mathematical problems involving area, surface area, and volume.",
        "lessons": ["surface-area-rect-prism", ]
      },
      "6.GM.A.1": {
        "description": "Find the area of right triangles, other triangles, special quadrilaterals, and polygons by composing into rectangles or decomposing into triangles and other shapes; apply these techniques to solve problems in authentic contexts.",
        "lessons": []
      },
      "6.GM.A.2": {
        "description": "Find the volume of a right rectangular prism with fractional edge lengths by filling it with unit cubes of appropriate unit fraction edge lengths.  Connect and apply to the formulas V = l w h and V = b h to find volumes of right rectangular prisms with fractional edge lengths to solve problems in authentic contexts.",
        "lessons": []
      },
      "6.GM.A.3": {
        "description": "Draw polygons in the four quadrant coordinate plane given coordinates for the vertices and find the length of a side.  Apply these techniques to solve problems in authentic contexts.",
        "lessons": []
      },
      "6.GM.A.4": {
        "description": "Represent three-dimensional figures using nets made up of rectangles and triangles, and use the nets to find the surface area of these figures, including those from authentic contexts.",
        "lessons": ["surface-area-rect-prism", ]
      },
      "6.DR.A": {
        "description": "Formulate Statistical Investigative Questions",
        "lessons": ["data-cycle", "measures-of-center", "histograms", "histograms2", "box-plots", ]
      },
      "6.DR.A.1": {
        "description": "Formulate and recognize statistical investigative questions as those that anticipate changes in descriptive data related to the question and account for it in the answers.",
        "lessons": ["ds-intro", "choosing-your-dataset", "data-cycle", ]
      },
      "6.DR.B": {
        "description": "Collect and Consider Data",
        "lessons": ["choosing-your-dataset", "data-cycle", ]
      },
      "6.DR.B.2": {
        "description": "Collect and record data with technology to identify and describe the characteristics of numerical data sets using quantitative measures of center and variability.",
        "lessons": ["measures-of-center", "histograms", "histograms2", "box-plots", "standard-deviation", ]
      },
      "6.DR.C": {
        "description": "Analyze, summarize, and describe data.",
        "lessons": ["standard-deviation", "box-plots", "measures-of-center", "project-exploration-paper", "project-research-paper", ]
      },
      "6.DR.C.3": {
        "description": "Analyze data representations and describe measures of center and variability of quantitative data using appropriate displays.",
        "lessons": ["measures-of-center", "standard-deviation", "box-plots", ]
      },
      "6.DR.D": {
        "description": "Interpret data and answer investigative questions.",
        "lessons": ["measures-of-center", "histograms2", "box-plots", "project-exploration-paper", "project-research-paper", ]
      },
      "6.DR.D.4": {
        "description": "Interpret quantitative measures of center to describe differences between groups from data collected to answer investigative questions.",
        "lessons": ["measures-of-center", "standard-deviation", "project-exploration-paper", "project-research-paper", ]
      },
      "7.RP.A": {
        "description": "Analyze proportional relationships and use them to solve real-world and mathematical problems.",
        "lessons": ["flags", "making-game-images", ]
      },
      "7.RP.A.1": {
        "description": "Solve problems in authentic contexts involving unit rates associated with ratios of fractions.",
        "lessons": ["flags", ]
      },
      "7.RP.A.2": {
        "description": "Recognize and represent proportional relationships between quantities in tables, graphs, equations, diagrams, and verbal descriptions of proportional relationships. Identify the constant of proportionality (unit rate) within various representations.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "7.RP.A.3": {
        "description": "Use proportional relationships to solve ratio and percent problems in authentic contexts.",
        "lessons": ["hoc-data", ]
      },
      "7.RP.B": {
        "description": "Investigate chance processes and develop, use, and evaluate probability models.",
        "lessons": []
      },
      "7.RP.B.4": {
        "description": "Understand that the probability of a chance event is a number between 0 and 1 that expresses the likelihood of the event occurring. Represent probabilities as fractions, decimals, and percents.",
        "lessons": []
      },
      "7.RP.B.5": {
        "description": "Use experimental data and theoretical probability to make predictions. Understand the probability predictions may not be exact.",
        "lessons": []
      },
      "7.RP.B.6": {
        "description": "Develop a probability model and use it to find probabilities of events. Compare theoretical and experimental probabilities and explain possible sources of discrepancy if any exists.",
        "lessons": []
      },
      "7.RP.B.7": {
        "description": "Find probabilities of compound events using organized lists, tables, tree diagrams, and simulation.",
        "lessons": []
      },
      "7.NS.A": {
        "description": "Apply and extend previous understandings of operations with fractions.",
        "lessons": []
      },
      "7.NS.A.1": {
        "description": "Apply and extend previous understandings of addition, subtraction and absolute value to add and subtract rational numbers in authentic contexts. Understand subtraction as adding the additive inverse, p – q = p + (–q).",
        "lessons": []
      },
      "7.NS.A.2": {
        "description": "Apply and extend previous understandings of multiplication and division and of fractions to multiply and divide rational numbers. Interpret operations of rational numbers solving problems in authentic contexts.",
        "lessons": []
      },
      "7.NS.A.3": {
        "description": "Understand that equivalent rational numbers can be written as fractions, decimals and percents.",
        "lessons": []
      },
      "7.AEE.A": {
        "description": "Use properties of operations to generate equivalent expressions.",
        "lessons": []
      },
      "7.AEE.A.1": {
        "description": "Identify and write equivalent expressions with rational numbers by applying associative, commutative, and distributive properties.",
        "lessons": []
      },
      "7.EE.A.2": {
        "description": "Recognize and represent proportional relationships between quantities in tables, graphs, equations, diagrams, and verbal descriptions of proportional relationships. Identify the constant of proportionality (unit rate) within various representations.",
        "lessons": ["problem-decomposition", ]
      },
      "7.AEE.B": {
        "description": "Solve mathematical problems in authentic contexts using numerical and algebraic expressions and equations.",
        "lessons": ["problem-decomposition", "player-animation", "inequalities3-sam", "distance-formula", "piecewise-functions-conditionals", "functions-dr", ]
      },
      "7.AEE.B.3": {
        "description": "Write and solve problems in authentic contexts using expressions and equations with positive and negative rational numbers in any form.  Contexts can be limited to those that can be solved with one or two-step linear equations.",
        "lessons": []
      },
      "7.EE.B.4": {
        "description": "Use variables to represent quantities and construct one- and two-step linear inequalities with positive rational numbers to solve authentic problems by reasoning about the quantities.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", "defining-values", "functions-dr", "functions-make-life-easier", ]
      },
      "7.GM.A": {
        "description": "Draw, construct, and describe geometical figures and describe the relationships between them.",
        "lessons": ["hoc-winter-parley", ]
      },
      "7.GM.A.1": {
        "description": "Solve problems involving scale drawings of geometric figures.  Reproduce a scale drawing at a different scale and compute actual lengths and areas from a scale drawing.",
        "lessons": []
      },
      "7.GM.A.2": {
        "description": "Draw triangles from three measures of angles or sides.  Understand the possible side lengths and angle measures that determine a unique triangle, more than one triangle, or no triangle.",
        "lessons": []
      },
      "7.GM.B": {
        "description": "Solve mathematical problems in authentic contexts involving angle measure, area, surface area, and volume.",
        "lessons": []
      },
      "7.GM.B.3": {
        "description": "Understand the relationship between area and circumference of circles.  Choose and use the appropriate formula to solve problems with radius, diameter, circumference and area of circles.",
        "lessons": ["functions-dr", ]
      },
      "7.G.B.4": {
        "description": "Apply facts about supplementary, complementary, vertical, and adjacent angles in a multi-step problem to determine an unknown angle in a figure.",
        "lessons": []
      },
      "7.G.B.5": {
        "description": "Solve problems in authentic contexts involving two- and three-dimensional figures.  Given formulas, calculate area, volume and surface area.",
        "lessons": ["surface-area-rect-prism", "functions-dr", ]
      },
      "7.DR.A": {
        "description": "Formulate Statistical Investigative Questions.",
        "lessons": ["data-cycle", ]
      },
      "7.DR.A.1": {
        "description": "Formulate summary, comparative investigative questions to gain information about a population and that a sample is valid only if the sample is representative of that population.",
        "lessons": ["probability-inference", "hoc-data", ]
      },
      "7.DR.B": {
        "description": "Collect and Consider Data",
        "lessons": ["probability-inference", "project-exploration-paper", "project-research-paper", "hoc-data", ]
      },
      "7.DR.B.2": {
        "description": "Collect or consider data from a random sample to compare and draw inferences about a population with an unknown characteristic of interest.",
        "lessons": ["project-exploration-paper", "project-research-paper", ]
      },
      "7.DR.C": {
        "description": "Analyze, summarize and describe data",
        "lessons": ["project-exploration-paper", "project-research-paper", ]
      },
      "7.DR.C.3": {
        "description": "Analyze two data distributions visually to compare multiple measures of center and variability.",
        "lessons": ["project-exploration-paper", "project-research-paper", ]
      },
      "7.DR.D": {
        "description": "Interpret data and answer investigative questions.",
        "lessons": ["project-exploration-paper", "project-research-paper", ]
      },
      "7.DR.D.4": {
        "description": "Interpret measures of center and measures of variability for numerical data from random samples to compare between two populations, and to answer investigative questions.",
        "lessons": ["project-exploration-paper", "project-research-paper", ]
      },
      "8.NS.A": {
        "description": "Know that there are numbers that are not rational, and approximate them by rational numbers.",
        "lessons": []
      },
      "8.NS.A.1": {
        "description": "Know that numbers that are not rational are called irrational.",
        "lessons": []
      },
      "8.NS.A.2": {
        "description": "Use rational approximations of irrational numbers to compare size and locate on a number line.",
        "lessons": []
      },
      "8.AEE.A": {
        "description": "Expressions and equations work with radicals and integer exponents.",
        "lessons": []
      },
      "8.AEE.A.1": {
        "description": "Apply the properties of integer exponents using powers of 10 to generate equivalent numerical expressions.",
        "lessons": []
      },
      "8.AEE.A.2": {
        "description": "Represent solutions to equations using square root and cube root symbols.",
        "lessons": []
      },
      "8.AEE.A.3": {
        "description": "Estimate very large or very small quantities using scientific notation with a single digit times an integer power of ten.",
        "lessons": []
      },
      "8.AEE.A.4": {
        "description": "Perform operations with numbers expressed in scientific notation.",
        "lessons": []
      },
      "8.AEE.B": {
        "description": "Understand the connections between proportional relationships, lines, and linear equations.",
        "lessons": ["function-definition-linear", "functions-can-be-linear", ]
      },
      "8.AEE.B.5": {
        "description": "Graph proportional relationships in authentic contexts. Interpret the unit rate as the slope of the graph, and compare two different proportional relationships represented in different ways.",
        "lessons": ["function-definition-linear", "functions-can-be-linear", ]
      },
      "8.AEE.B.6": {
        "description": "Write the equation for a line in slope intercept form y = mx + b, where m and b are rational numbers, and explain in context why the slope m is the same between any two distinct points.",
        "lessons": []
      },
      "8.AEE.C": {
        "description": "Analyze and solve linear equations and pairs of simultaneous linear equations.",
        "lessons": []
      },
      "8.AEE.C.7": {
        "description": "Solve linear equations with one variable including equations with rational number coefficients, with the variable on both sides, or whose solutions require using the distributive property and/or combining like terms.",
        "lessons": []
      },
      "8.AEE.C.8": {
        "description": "Find, analyze, and interpret solutions to pairs of simultaneous linear equations using graphs or tables.",
        "lessons": []
      },
      "8.AFN.A": {
        "description": "Define, evaluate, and compare functions.",
        "lessons": []
      },
      "8.AFN.A.1": {
        "description": "Understand in authentic contexts, that the graph of a function is the set of ordered pairs consisting of an input and a corresponding output.",
        "lessons": ["contracts", "functions-vertical-line-test", ]
      },
      "8.AFN.A.2": {
        "description": "Compare the properties of two functions represented algebraically, graphically, numerically in tables, or verbally by description.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "8.AFN.A.3": {
        "description": "Understand and identify linear functions, whose graph is a straight line, and identify examples of functions that are not linear.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "8.AFN.B": {
        "description": "Use functions to model relationships between quantities.",
        "lessons": ["functions-for-character-animation", "functions-dr", "functions-make-life-easier", "function-definition-linear", "problem-decomposition", ]
      },
      "8.AFN.B.4": {
        "description": "Construct a function to model a linear relationship in authentic contexts between two quantities.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "8.AFN.B.5": {
        "description": "Describe qualitatively the functional relationship between two quantities in authentic contexts by analyzing a graph.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "8.GM.A": {
        "description": "Understand congruence and similarity using physical models, transparencies, or geometry software.",
        "lessons": []
      },
      "8.GM.A.1": {
        "description": "Verify experimentally the properties of rotations, reflections, and translations.",
        "lessons": ["making-game-images", ]
      },
      "8.GM.A.2": {
        "description": "Understand that a two-dimensional figure is congruent to another if the second can be obtained from the first by a sequence of rotations, reflections, and translations.",
        "lessons": []
      },
      "8.GM.A.3": {
        "description": "Describe the effect of dilations, translations, rotations, and reflections on two-dimensional figures using coordinates.",
        "lessons": []
      },
      "8.GM.A.4": {
        "description": "Understand that a two-dimensional figure is similar to another if the second can be obtained from the first by a sequence of rotations, reflections, translations, and dilations.",
        "lessons": []
      },
      "8.GM.A.5": {
        "description": "Use informal arguments to establish facts about interior and exterior angles of triangles and angles formed by parallel lines cut with a transversal.",
        "lessons": []
      },
      "8.GM.B": {
        "description": "Understand and apply the Pythagorean Theorem.",
        "lessons": ["distance-formula", ]
      },
      "8.GM.B.6": {
        "description": "Distinguish between applications of the Pythagorean Theorem and its Converse in authentic contexts.",
        "lessons": []
      },
      "8.GM.B.7": {
        "description": "Apply the Pythagorean Theorem in authentic contexts to determine unknown side lengths in right triangles.",
        "lessons": ["distance-formula", ]
      },
      "8.GM.B.8": {
        "description": "Apply the Pythagorean Theorem to find the distance between two points in a coordinate system.",
        "lessons": ["distance-formula", ]
      },
      "8.GM.C": {
        "description": "Solve real-world and mathematical problems involving volume of cylinders, cones, and spheres.",
        "lessons": []
      },
      "8.GM.C.9": {
        "description": "Choose and use the appropriate formula for the volume of cones, cylinders, and spheres to solve problems in authentic contexts.",
        "lessons": []
      },
      "8.DR.A": {
        "description": "Formulate Statistical Ivenstigative Questions.",
        "lessons": ["data-cycle", ]
      },
      "8.DR.A.1": {
        "description": "Formulate statistical investigative questions to articulate research topics and uncover patterns of association seen in bivariate categorical data.",
        "lessons": []
      },
      "8.DR.B": {
        "description": "Collect and Consider Data",
        "lessons": []
      },
      "8.DR.B.2": {
        "description": "Collect or consider data using surveys and measurements to capture patterns of association, and critically analyze data collection methods.",
        "lessons": ["scatter-plots", "linear-regression", "correlations", "data-collection", ]
      },
      "8.DR.C": {
        "description": "Analyze, summarize, and describe data",
        "lessons": []
      },
      "8.DR.C.3": {
        "description": "Analyze patterns of association between two quantitative or categorical variables and reason about distributions to compare groups.",
        "lessons": ["scatter-plots", "linear-regression", "grouped-samples", "correlations", ]
      },
      "8.DR.D": {
        "description": "Interpret data and answer investigative questions",
        "lessons": []
      },
      "8.DR.A.4": {
        "description": "Interpret scatter plots for bivariate quantitative data to investigate patterns of association between two quantities to answer investigative questions.",
        "lessons": ["linear-regression", "scatter-plots", "project-research-paper", "project-exploration-paper", ]
      },
      "HS.AEE.A": {
        "description": "Use algebraic reasoning to rewrite expressions in equivalent forms.",
        "lessons": []
      },
      "HS.AEE.A.1": {
        "description": "Interpret an expression which models a quantity by viewing one or more of its parts as a single entity. Reason about how changes in parts of the expression impact the whole, and vice versa.",
        "lessons": ["defining-values", "functions-make-life-easier", "functions-dr", "player-animation", "piecewise-functions-conditionals", ]
      },
      "HS.AEE.A.2": {
        "description": "Create and recognize an equivalent form of an expression to understand the quantity represented in an authentic context.",
        "lessons": []
      },
      "HS.AEE.A.3": {
        "description": "Rearrange formulas and equations to highlight a specific quantity.",
        "lessons": []
      },
      "HS.AEE.B": {
        "description": "Use algebraic reasoning to find solutions to an equation, inequality, and systems of equations or inequalities.",
        "lessons": []
      },
      "HS.AEE.B.4": {
        "description": "Define variables and create equations with two or more variables to represent relationships between quantities in order to solve problems in authentic contexts.",
        "lessons": ["inequalities3-sam", ]
      },
      "HS.AEE.B.5": {
        "description": "Define variables and create inequalities with one or more variables and use them to solve problems in authentic contexts.",
        "lessons": ["inequalities3-sam", ]
      },
      "HS.AEE.B.6": {
        "description": "Solve systems of linear equations and systems of linear inequalities in authentic contexts through reasoning,algebraic means, or strategically using technology.",
        "lessons": []
      },
      "HS.AEE.C": {
        "description": "Analyze the structure of an equation or inequality to determine an efficient strategy to find and justify a solution.",
        "lessons": []
      },
      "HS.AEE.C.7": {
        "description": "Represent constraints by equations or inequalities, and by systems of equations and/or inequalities; interpret solutions as viable or nonviable options in authentic contexts.",
        "lessons": ["inequalities3-sam", ]
      },
      "HS.AEE.C.8": {
        "description": "Construct a viable argument to justify a method for solving equations or inequalities.",
        "lessons": []
      },
      "HS.AEE.D": {
        "description": "Make predictions in different applications using expressions, equations, and inequalities to analyze authentic contexts.",
        "lessons": []
      },
      "HS.AEE.D.9": {
        "description": "Understand that the solution to an equation in two variables is a set of points in the coordinate plane that form a curve, which could be a line.",
        "lessons": []
      },
      "HS.AEE.D.10": {
        "description": "Recognize and explain why the point(s) of intersection of the graphs of f(x) and g(x) are solutions to the equation f(x)=g(x).  Interpret the meaning of the coordinates of these points in authentic contexts.",
        "lessons": []
      },
      "HS.AEE.D.11": {
        "description": "Graph and explain why the points in a half plane are solutions to a linear inequality and the solutions to a system of inequalities are the points in the intersection of corresponding half planes. Interpret the meaning of the coordinates of these points in authentic contexts.",
        "lessons": []
      },
      "HS.AFN.A": {
        "description": "Describe functions by using both symbolic and graphical representations.",
        "lessons": ["functions-make-life-easier", "function-notation", ]
      },
      "HS.AFN.A.1": {
        "description": "Understand a function as a rule that assigns a unique output for every input and that functions model situations where one quantity determines another.",
        "lessons": ["functions-vertical-line-test", "contracts", ]
      },
      "HS.AFN.A.2": {
        "description": "Use function notation and interpret statements that use function notation in terms of the context and the relationship it describes.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", "function-definition-linear", "functions-dr", "problem-decomposition", "function-notation", "functions-for-character-animation", "defining-table-functions", "flags", "contracts", ]
      },
      "HS.AFN.A.3": {
        "description": "Calculate and interpret the average rate of change of a function over a specified interval.",
        "lessons": []
      },
      "HS.AFN.B": {
        "description": "Compare and relate functions using common attributes.",
        "lessons": ["inequalities2-compound", "inequalities1-simple", "function-definition-linear", "functions-dr", "problem-decomposition", "function-notation", "functions-for-character-animation", "defining-table-functions", ]
      },
      "HS.AFN.B.4": {
        "description": "Compare properties of two functions using multiple representations. Distinguish functions as members of the same family using common attributes.",
        "lessons": ["function-definition-linear", "functions-can-be-linear", "problem-decomposition", ]
      },
      "HS.AFN.B.5": {
        "description": "Relate the domain of a function to its graph and to its context.",
        "lessons": ["functions-can-be-linear", "function-definition-linear", ]
      },
      "HS.AFN.C": {
        "description": "Represent functions graphically and interpret key features in terms of the equivalent symbolic representation.",
        "lessons": []
      },
      "HS.AFN.C.6": {
        "description": "Interpret key features of functions, from multiple representations, and conversely predict features of functions from knowledge of context.",
        "lessons": []
      },
      "HS.AFN.C.7": {
        "description": "Graph functions using technology to show key features.",
        "lessons": []
      },
      "HS.AFN.D": {
        "description": "Model a wide variety of authentic situations using functions through the process of making and changing assumptions, assigning variables, and finding solutions to contextual problems.",
        "lessons": []
      },
      "HS.AFN.D.8": {
        "description": "Model situations involving arithmetic patterns. Use a variety of representations such as pictures, graphs, or an explicit formula to describe the pattern.",
        "lessons": []
      },
      "HS.AFN.D.9": {
        "description": "Identify and interpret the effect on the graph of a function when the equation has been transformed.",
        "lessons": []
      },
      "HS.AFN.D.10": {
        "description": "Explain why a situation can be modeled with a linear function, an exponential function, or neither. In a given model, explain the meaning of coefficients and features of functions used, such as slope for a linear model.",
        "lessons": []
      },
      "HS.NQ.A": {
        "description": "Understand and apply the real number system.",
        "lessons": []
      },
      "HS.NQ.A.1": {
        "description": "Use reasoning to establish properties of positive integer exponents. Extend the definition of exponentiation to include negative and rational exponents so as to be consistent with these properties. Utilize exponentiation to model authentic contexts.",
        "lessons": []
      },
      "HS.NQ.A.2": {
        "description": "Compare real numbers presented through different representations, including both rational and irrational numbers.  Apply comparisons in authentic contexts.",
        "lessons": []
      },
      "HS.NQ.B": {
        "description": "Attend to units of measurement needed to solve problems through quantitative reasoning and mathematical modeling.",
        "lessons": ["flags", ]
      },
      "HS.NQ.B.3": {
        "description": "Use reasoning to choose and interpret measurement units consistently in formulas, graphs, and data displays, as a way to understand problems and to guide the solution of multi-step problems.",
        "lessons": []
      },
      "HS.NQ.B.4": {
        "description": "Define, manipulate, and interpret appropriate quantities using rational and irrational numbers to authentically model situations and use reasoning to justify these choices.",
        "lessons": []
      },
      "HS.NQ.B.5": {
        "description": "Use reasoning to choose a level of accuracy appropriate to limitations on measurement when reporting quantities in modeling situations.",
        "lessons": []
      },
      "HS.GM.A": {
        "description": "Apply geometric transformations to figures through analysis of graphs and understanding of functions.",
        "lessons": []
      },
      "HS.GM.A.1": {
        "description": "Apply definitions of rotations, reflections, and translations to transform a figure and map between two congruent figures in authentic contexts.",
        "lessons": []
      },
      "HS.GM.A.2": {
        "description": "Verify experimentally the properties of a dilation given a center and a scale factor.  Solve problems in authentic contexts involving similar triangles or dilations.",
        "lessons": []
      },
      "HS.GM.A.3": {
        "description": "Use the slopes of segments and the coordinates of the vertices of triangles, parallelograms, and trapezoids to solve problems in authentic contexts.",
        "lessons": []
      },
      "HS.GM.A.4": {
        "description": "Use definitions of transformations and symmetry relationships to justify the solutions of problems in authentic contexts.",
        "lessons": []
      },
      "HS.GM.B": {
        "description": "Construct and communicate geometric arguments through use of proofs, logical reasoning, and geometric technology.",
        "lessons": []
      },
      "HS.GM.B.5": {
        "description": "Apply and justify triangle congruence and similarity theorems in authentic contexts.",
        "lessons": []
      },
      "HS.GM.B.6": {
        "description": "Justify theorems of line relationships, angles, triangles, and parallelograms; and use them to solve problems in authentic contexts.",
        "lessons": []
      },
      "HS.GM.B.7": {
        "description": "Perform geometric constructions with a variety of tools and methods.",
        "lessons": []
      },
      "HS.GM.C": {
        "description": "Solve problems and interpret solutions of area and volume of shapes by applying concepts of congruence, similarity, symmetry in authentic contexts.",
        "lessons": []
      },
      "HS.GM.C.8": {
        "description": "Solve authentic modeling problems using area formulas for triangles, parallelograms, trapezoids, regular polygons, and circles.",
        "lessons": []
      },
      "HS.GM.C.9": {
        "description": "Use volume and surface area formulas for prisms, cylinders, pyramids, cones, and spheres to solve problems and apply to authentic contexts.",
        "lessons": []
      },
      "HS.GM.C.10": {
        "description": "Use geometric shapes, their measures, and their properties to describe real world objects, and solve related authentic modeling and design problems.",
        "lessons": []
      },
      "HS.GM.C.11": {
        "description": "Apply concepts of density based on area and volume in authentic modeling situations.",
        "lessons": []
      },
      "HS.GM.D": {
        "description": "Apply concepts of right triangle trigonometry in authentic contexts to solve problems and interpret solutions.",
        "lessons": []
      },
      "HS.GM.D.12": {
        "description": "Apply sine, cosine, and tangent ratios, and the Pythagorean Theorem, to solve problems in authentic contexts.",
        "lessons": []
      },
      "HS.GM.D.13": {
        "description": "Apply the Pythagorean Theorem in authentic contexts, and develop the standard form for the equation of a circle.",
        "lessons": []
      },
      "HS.GM.D.14": {
        "description": "Use the coordinate plane to determine parallel and perpendicular relationships, and the distance between points.",
        "lessons": ["distance-formula", ]
      },
      "HS.DR.A": {
        "description": "Formulate Statistical Investigative Questions.",
        "lessons": ["data-cycle", ]
      },
      "HS.DR.A.1": {
        "description": "Formulate multivariable statistical investigative questions and determine how data from samples can be collected and analyzed to provide an answer.",
        "lessons": ["intro-ds", "probability-inference", "choosing-your-dataset", ]
      },
      "HS.DR.A.2": {
        "description": "Formulate summative, comparative, and associative statistical investigative questions for surveys, observational studies, and experiments using primary or secondary data.",
        "lessons": ["probability-inference", "data-collection", ]
      },
      "HS.DR.A.3": {
        "description": "Formulate inferential statistical investigative questions regarding causality and prediction from correlation.",
        "lessons": ["linear-regression", "correlations", ]
      },
      "HS.DR.A.4": {
        "description": "Use mathematical and statistical reasoning to formulate questions about data to evaluate conclusions and assess risks.",
        "lessons": ["threats-to-validity", ]
      },
      "HS.DR.B": {
        "description": "Collect and Consider Data.",
        "lessons": []
      },
      "HS.DR.B.5": {
        "description": "Articulate what constitutes good practice in designing a sample survey, an experiment, and an observational study. Understand issues of bias and confounding variables in a study and their implications for interpretation.",
        "lessons": ["data-collection", ]
      },
      "HS.DR.B.6": {
        "description": "Distinguish and choose between surveys, observational studies, and experiments to design an appropriate data collection that answers an investigative question of interest.",
        "lessons": ["data-collection", ]
      },
      "HS.DR.B.7": {
        "description": "Apply an appropriate data collection plan when collecting primary data or selecting secondary data for the statistical investigative question of interest.",
        "lessons": ["data-collection", ]
      },
      "HS.DR.C": {
        "description": "Analyze, summarize, and describe data.",
        "lessons": []
      },
      "HS.DR.C.8": {
        "description": "Identify appropriate ways to summarize and then represent the distribution of univariate and bivariate data multiple ways with graphs and/or tables. Use technology to present data that supports interpretation of tabular and graphical representations.",
        "lessons": ["standard-deviation", "box-plots", "histograms2", "histograms", ]
      },
      "HS.DR.C.9": {
        "description": "Use statistics appropriate to the shape of the data distribution to compare the center and spread of two or more different data sets.",
        "lessons": ["standard-deviation", "box-plots", "measures-of-center", "histograms", ]
      },
      "HS.DR.C.10": {
        "description": "Use data to compare two groups, describe sample variability, and decide if differences between parameters are significant based on the statistics.",
        "lessons": ["standard-deviation", "box-plots", "measures-of-center", "histograms2", "histograms", ]
      },
      "HS.DR.D": {
        "description": "Interpret data and answer investigative questions.",
        "lessons": []
      },
      "HS.DR.D.11": {
        "description": "Use statistical evidence from analyses to answer statistical investigative questions, and communicate the findings in a variety of formats (verbal, written, visual) to support informed data-based decisions.",
        "lessons": ["project-research-paper", "project-exploration-paper", ]
      },
      "HS.DR.D.12": {
        "description": "Articulate what it means for an outcome or an estimate of a population characteristic to be plausible or not plausible compared to chance variation.",
        "lessons": ["scatter-plots", "linear-regression", "correlations", ]
      },
      "HS.DR.D.13": {
        "description": "Use multivariate thinking to articulate how variables impact one another, and measure the strength of association using correlation coefficients for regression curves.",
        "lessons": ["linear-regression", "correlations", ]
      },
      "HS.DR.E": {
        "description": "Understand independence and conditional probability and use them to interpret data.",
        "lessons": []
      },
      "HS.DR.E.14": {
        "description": "Describe the possible outcomes for a situation as subsets of a sample space.",
        "lessons": ["inequalities2-compound", ]
      },
      "HS.DR.E.15": {
        "description": "Recognize and explain the concepts of conditional probability and independence in everyday language and everyday situations.",
        "lessons": []
      },
    },
  },
  "textbooks": {
    "CMP": {
      "CMP.6.1": {
        "description": "Prime Time: Factors & Multiples",
        "lessons": ["order-of-operations", "evaluating-exponents", "exponent-expressions-with-negatives", "distributive-property", "equivalence", "computation", ]
      },
      "CMP.6.2": {
        "description": "Comparing Bits and Pieces: Ratios, Rational Numbers and Equivalence",
        "lessons": ["absolute-value-and-opposites", "absolute-value-and-opposites-2", ]
      },
      "CMP.6.3": {
        "description": "Let’s be Rational: Understanding Fraction Operations",
        "lessons": ["equivalence", ]
      },
      "CMP.6.4": {
        "description": "Covering and Surrounding: Two Dimensional Measurement",
        "lessons": ["surface-area-rect-prism", ]
      },
      "CMP.6.5": {
        "description": "Decimal Ops: Computing with Decimals and Percents",
        "lessons": []
      },
      "CMP.6.6": {
        "description": "Variables and Patterns: Focus on Algebra",
        "lessons": ["defining-values", "equivalence", "distributive-property", "associative-property", "identity-property", "commutative-property", ]
      },
      "CMP.6.7": {
        "description": "Data About Us: Statistics and Data Analysis",
        "lessons": ["box-plots", "measures-of-center", ]
      },
      "CMP.7.1": {
        "description": "Shapes and Designs: Two Dimensional Geometry",
        "lessons": []
      },
      "CMP.7.2": {
        "description": "Accentuate the Negative: Integers and Rational Numbers",
        "lessons": ["order-of-operations", "absolute-value-and-opposites", "absolute-value-and-opposites-2", "commutative-property", "distributive-property", "evaluating-exponents", "exponent-expressions-with-negatives", ]
      },
      "CMP.7.3": {
        "description": "Stretching and Shrinking: Understanding Similarity",
        "lessons": []
      },
      "CMP.7.4": {
        "description": "Comparing and Scaling: Ratios, Rates, Percent, Proportions",
        "lessons": []
      },
      "CMP.7.5": {
        "description": "Moving Straight Ahead: Linear Relationships",
        "lessons": ["linearity2", "linearity", ]
      },
      "CMP.7.6": {
        "description": "What Do You Expect: Probability and Expected Values",
        "lessons": []
      },
      "CMP.7.7": {
        "description": "Filling and Wrapping: Three Dimensional Measurement",
        "lessons": ["surface-area-rect-prism", ]
      },
      "CMP.7.8": {
        "description": "Samples and Populations: Making Comparisons and Predictions",
        "lessons": ["probability-inference", ]
      },
      "CMP.8.1": {
        "description": "Thinking with Mathematical Models: Linear and Inverse Variations",
        "lessons": ["scatter-plots", "measures-of-center", "linear-regression", "linearity2", "linearity", "correlations", ]
      },
      "CMP.8.2": {
        "description": "Looking for Pythagoras: The Pythagorean Theorem",
        "lessons": ["distance-formula", ]
      },
      "CMP.8.3": {
        "description": "Growing, Growing, Growing: Exponential Functions",
        "lessons": []
      },
      "CMP.8.4": {
        "description": "Say it with Symbols: Making Sense of Symbols",
        "lessons": ["distributive-property", "associative-property", "identity-property", "commutative-property", "equivalence", ]
      },
      "CMP.8.5": {
        "description": "Butterflies, Pinwheels and Wallpaper: Symmetry and Transformations",
        "lessons": []
      },
      "CMP.8.6": {
        "description": "It’s in the System: Systems of Linear Equations and Inequalities",
        "lessons": []
      },
      "CMP.Alg-Ext.1": {
        "description": "Frogs and Fleas and Painted Cubes: Quadratic Functions",
        "lessons": []
      },
      "CMP.Alg-Ext.2": {
        "description": "Function Junction: Families of Functions",
        "lessons": ["piecewise-functions", ]
      },
    },
    "IM.6": {
      "IM.6.1.3": {
        "description": "Reasoning to Find Area",
        "lessons": ["flags", ]
      },
      "IM.6.1.12": {
        "description": "What is Surface Area?",
        "lessons": ["surface-area-rect-prism", ]
      },
      "IM.6.1.13": {
        "description": "Polyhedra",
        "lessons": ["surface-area-rect-prism", ]
      },
      "IM.6.1.14": {
        "description": "Nets and Surface Area",
        "lessons": ["surface-area-rect-prism", ]
      },
      "IM.6.1.15": {
        "description": "More Nets, More Surface Area",
        "lessons": ["surface-area-rect-prism", ]
      },
      "IM.6.2.5": {
        "description": "Defining Equivalent Ratios",
        "lessons": ["flags", ]
      },
      "IM.6.2.14": {
        "description": "Solving Equivalent Ratio Problems",
        "lessons": ["flags", ]
      },
      "IM.6.3.8": {
        "description": "More about Constant Speed",
        "lessons": ["functions-for-character-animation", ]
      },
      "IM.6.5.5": {
        "description": "Decimal Points in Products",
        "lessons": ["making-game-images", ]
      },
      "IM.6.6.2": {
        "description": "Truth and Equations",
        "lessons": ["defining-values", "equivalence", ]
      },
      "IM.6.6.6": {
        "description": "Write Expressions Where Letters Stand for Numbers",
        "lessons": ["functions-for-character-animation", "equivalence", ]
      },
      "IM.6.6.8": {
        "description": "Equal and Equivalent",
        "lessons": ["problem-decomposition", "equivalence", ]
      },
      "IM.6.6.13": {
        "description": "Expressions with Exponents",
        "lessons": ["order-of-operations", "evaluating-exponents", ]
      },
      "IM.6.6.14": {
        "description": "Evaluating Expressions with Exponents",
        "lessons": ["order-of-operations", "evaluating-exponents", ]
      },
      "IM.6.6.15": {
        "description": "Equivalent Exponential Expressions",
        "lessons": ["order-of-operations", "evaluating-exponents", ]
      },
      "IM.6.6.16": {
        "description": "Two Related Quantities, Part 1",
        "lessons": ["contracts", ]
      },
      "IM.6.6.17": {
        "description": "Two Related Quantities, Part 2",
        "lessons": ["contracts", ]
      },
      "IM.6.6.18": {
        "description": "More Relationships",
        "lessons": ["contracts", ]
      },
      "IM 6.7.2": {
        "description": "Points on the Number Line",
        "lessons": ["absolute-value-and-opposites", "absolute-value-and-opposites-2", ]
      },
      "IM 6.7.7": {
        "description": "Comparing Numbers and Distance from Zero",
        "lessons": ["absolute-value-and-opposites", "absolute-value-and-opposites-2", ]
      },
      "IM 6.7.8": {
        "description": "Writing and Graphing Inequalities",
        "lessons": ["inequalities1-simple", "simple-data-types", ]
      },
      "IM.6.7.9": {
        "description": "Solutions of Inequalities",
        "lessons": ["inequalities1-simple", "simple-data-types", ]
      },
      "IM.6.7.10": {
        "description": "Interpreting Inequalities",
        "lessons": ["inequalities3-sam", "inequalities1-simple", "simple-data-types", ]
      },
      "IM.6.7.11": {
        "description": "Points on the Coordinate Plane",
        "lessons": ["numbers-inside-video games", ]
      },
      "IM.6.7.12": {
        "description": "Constructing the Coordinate Plane",
        "lessons": ["numbers-inside-video games", ]
      },
      "IM.6.7.13": {
        "description": "Interpreting Points on a Coordinate Plane",
        "lessons": []
      },
      "IM.6.7.14": {
        "description": "Distances on the Coordinate Plane",
        "lessons": ["flags", ]
      },
      "IM.6.7.15": {
        "description": "Shapes on the Coordinate Plane",
        "lessons": ["flags", ]
      },
      "IM.6.8.1": {
        "description": "Got Data?",
        "lessons": ["ds-intro", ]
      },
      "IM.6.8.2": {
        "description": "Statistical Questions",
        "lessons": ["ds-intro", ]
      },
      "IM.6.8.6": {
        "description": "Histograms",
        "lessons": ["histograms2", "histograms", ]
      },
      "IM.6.8.7": {
        "description": "Using Histograms to Answer Statistical Questions",
        "lessons": ["histograms2", "histograms", ]
      },
      "IM.6.8.8": {
        "description": "Describing Distributions on Histograms",
        "lessons": ["histograms2", "histograms", ]
      },
      "IM.6.8.9": {
        "description": "Interpreting the Mean as Fair Share",
        "lessons": ["measures-of-center", ]
      },
      "IM.6.8.10": {
        "description": "Interpreting the Mean as the Balance Point",
        "lessons": ["measures-of-center", ]
      },
      "IM.6.8.13": {
        "description": "The Median of a Data Set",
        "lessons": ["measures-of-center", ]
      },
      "IM.6.8.14": {
        "description": "Comparing Mean and Median",
        "lessons": ["measures-of-center", ]
      },
      "IM.6.8.15": {
        "description": "Quartiles and Interquartile Range",
        "lessons": ["box-plots", ]
      },
      "IM.6.8.16": {
        "description": "Box Plots",
        "lessons": ["box-plots", ]
      },
      "IM.6.8.17": {
        "description": "Using Box Plots",
        "lessons": ["box-plots", ]
      },
    },
    "IM.7": {
      "IM.7.1.1": {
        "description": "What are Scaled Copies?",
        "lessons": ["making-game-images", "flags", ]
      },
      "IM.7.1.5": {
        "description": "The Size of the Scale Factor",
        "lessons": ["making-game-images", "flags", ]
      },
      "IM.7.2.3": {
        "description": "More about Constant of Proportionality",
        "lessons": ["solving-word-problems", ]
      },
      "IM.7.2.4": {
        "description": "Proportional Relationships and Equations",
        "lessons": ["contracts", ]
      },
      "IM.7.2.5": {
        "description": "Two Equations for Each Relationship",
        "lessons": ["contracts", ]
      },
      "IM.7.2.6": {
        "description": "Using Equations to Solve Problems",
        "lessons": ["contracts", ]
      },
      "IM.7.4.1": {
        "description": "Lots of Flags",
        "lessons": ["flags", ]
      },
      "IM.7.5.13": {
        "description": "Expressions with Rational Numbers",
        "lessons": ["order-of-operations", "absolute-value-and-opposites", "absolute-value-and-opposites-2", ]
      },
      "IM.7.5.14": {
        "description": "Solving Problems with Rational Numbers",
        "lessons": ["order-of-operations", ]
      },
      "IM.7.6.11": {
        "description": "Using Equations to Solve Problems",
        "lessons": ["defining-values", ]
      },
      "IM.7.6.13": {
        "description": "Reintroducing Inequalities",
        "lessons": ["simple-data-types", ]
      },
      "IM.7.6.14": {
        "description": "Finding Solutions to Inequalities in Context",
        "lessons": []
      },
      "IM.7.6.15": {
        "description": "Efficiently Solving Inequalities",
        "lessons": []
      },
      "IM.7.6.16": {
        "description": "Interpreting Inequalities",
        "lessons": []
      },
      "IM.7.6.17": {
        "description": "Modeling with Inequalities",
        "lessons": ["inequalities3-sam", ]
      },
      "IM.7.7.14": {
        "description": "Surface Area of Right Prisms",
        "lessons": ["surface-area-rect-prism", ]
      },
      "IM.7.8.11": {
        "description": "Comparing Groups",
        "lessons": ["measures-of-center", "grouped-samples", ]
      },
      "IM.7.8.12": {
        "description": "Larger Populations",
        "lessons": ["probability-inference", ]
      },
      "IM.7.8.13": {
        "description": "What Makes a Good Sample?",
        "lessons": ["measures-of-center", ]
      },
      "IM.7.8.14": {
        "description": "Sampling in a Fair Way",
        "lessons": ["threats-to-validity", "probability-inference", ]
      },
      "IM.7.8.15": {
        "description": "Estimating Populations Measures of Center",
        "lessons": ["box-plots", ]
      },
      "IM.7.8.17": {
        "description": "More about Sampling Variability",
        "lessons": ["threats-to-validity", "probability-inference", ]
      },
      "IM.7.8.18": {
        "description": "Comparing Populations Using Samples",
        "lessons": ["grouped-samples", ]
      },
      "IM.7.8.19": {
        "description": "Comparing Populations with Friends",
        "lessons": ["threats-to-validity", ]
      },
    },
    "IM.8": {
      "IM.8.1.1": {
        "description": "Moving in the Plane",
        "lessons": ["numbers-inside-video games", "making-game-images", "flags", "coordinates", ]
      },
      "IM.8.1.2": {
        "description": "Naming the moves",
        "lessons": ["making-game-images", "flags", ]
      },
      "IM.8.1.3": {
        "description": "Grid Moves",
        "lessons": ["making-game-images", "flags", ]
      },
      "IM.8.2.1": {
        "description": "Projecting and Scaling",
        "lessons": ["making-game-images", "flags", ]
      },
      "IM.8.3.11": {
        "description": "Equations of All Kinds of Lines",
        "lessons": ["functions-for-character-animation", ]
      },
      "IM.8.5.1": {
        "description": "Inputs and Outputs",
        "lessons": ["contracts", ]
      },
      "IM.8.5.2": {
        "description": "Introduction to Functions",
        "lessons": ["contracts", ]
      },
      "IM.8.5.3": {
        "description": "Equations for Functions",
        "lessons": ["defining-table-functions", "solving-word-problems", "restating-the-problem", "defining-functions", ]
      },
      "IM.8.5.10": {
        "description": "Piecewise Linear Functions",
        "lessons": ["player-animation", "piecewise-functions", ]
      },
      "IM.8.6.1": {
        "description": "Organizing Data",
        "lessons": ["bar-and-pie-charts", "histograms2", ]
      },
      "IM.8.6.2": {
        "description": "Plotting Data",
        "lessons": ["scatter-plots", "bar-and-pie-charts", "histograms", ]
      },
      "IM.8.6.3": {
        "description": "What a Point in a Scatter Plots Means",
        "lessons": ["scatter-plots", ]
      },
      "IM.8.6.4": {
        "description": "Fitting a Lin to Data",
        "lessons": ["correlations", ]
      },
      "IM.8.6.5": {
        "description": "Describing Trends in Scatter Plots",
        "lessons": ["correlations", ]
      },
      "IM.8.6.6": {
        "description": "The Slope of a Fitted Line",
        "lessons": ["linear-regression", ]
      },
      "IM.8.6.7": {
        "description": "Observing More Patterns in Scatter Plots",
        "lessons": ["linear-regression", ]
      },
      "IM.8.6.8": {
        "description": "Analyzing Bivariate Data",
        "lessons": ["linear-regression", ]
      },
      "IM.8.6.9": {
        "description": "FIXME: Add title",
        "lessons": ["choosing-your-dataset", ]
      },
      "IM.8.7.7": {
        "description": "Practice with Rational Bases",
        "lessons": ["order-of-operations", ]
      },
      "IM.8.8.6": {
        "description": "Finding Side Lengths of Triangles",
        "lessons": ["distance-formula", ]
      },
      "IM.8.8.7": {
        "description": "A Proof of the Pythagorean Theorem",
        "lessons": ["distance-formula", ]
      },
      "IM.8.8.8": {
        "description": "Finding Unknown Side Lengths",
        "lessons": ["distance-formula", ]
      },
      "IM.8.8.10": {
        "description": "Applications of the Pythagorean Theorem",
        "lessons": ["distance-formula", ]
      },
      "IM.8.8.11": {
        "description": "Finding Distances in the Coordinate Plane",
        "lessons": ["inequalities-collision", ]
      },
    },
    "IM.Alg.1": {
      "IM.Alg1.1.1": {
        "description": "Getting to Know You",
        "lessons": ["ds-intro", "numbers-inside-video games", ]
      },
      "IM.Alg1.1.2": {
        "description": "Data Representations",
        "lessons": ["bar-and-pie-charts", "histograms", ]
      },
      "IM.Alg1.1.3": {
        "description": "A Gallery of Data",
        "lessons": ["bar-and-pie-charts", "histograms", ]
      },
      "IM.Alg1.1.4": {
        "description": "The Shape of Distributions",
        "lessons": ["visualizing-the-shape-of-data", ]
      },
      "IM.Alg1.1.5": {
        "description": "Calculating Measures of Center and Variability",
        "lessons": ["measures-of-center", ]
      },
      "IM.Alg1.1.6": {
        "description": "Mystery Computations",
        "lessons": ["simple-data-types", ]
      },
      "IM.Alg1.1.7": {
        "description": "Spreadsheet Computations",
        "lessons": []
      },
      "IM.Alg1.1.8": {
        "description": "Spreadsheet Shortcuts",
        "lessons": []
      },
      "IM.Alg1.1.9": {
        "description": "Technological Graphing",
        "lessons": ["choosing-your-dataset", ]
      },
      "IM.Alg1.1.10": {
        "description": "The Effect of Extremes",
        "lessons": []
      },
      "IM.Alg1.1.11": {
        "description": "Comparing and Contrasting Data Distributions",
        "lessons": ["box-plots", "measures-of-center", ]
      },
      "IM.Alg1.1.12": {
        "description": "Standard Deviation",
        "lessons": []
      },
      "IM.Alg1.1.13": {
        "description": "More Standard Deviation",
        "lessons": []
      },
      "IM.Alg1.1.14": {
        "description": "Outliers",
        "lessons": []
      },
      "IM.Alg1.1.15": {
        "description": "Comparing Data Sets",
        "lessons": ["box-plots", "checking-your-work", ]
      },
      "IM.Alg1.1.16": {
        "description": "Analyzing Data",
        "lessons": []
      },
      "IM.Alg1.2.1": {
        "description": "Planning a Pizza Party",
        "lessons": []
      },
      "IM.Alg1.2.2": {
        "description": "Writing Equations to Model Relationships (Part 1)",
        "lessons": ["surface-area-rect-prism", ]
      },
      "IM.Alg1.2.3": {
        "description": "Writing Equations to Model Relationships (Part 2)",
        "lessons": ["surface-area-rect-prism", ]
      },
      "IM.Alg1.2.4": {
        "description": "Equations and Their Solutions",
        "lessons": []
      },
      "IM.Alg1.2.5": {
        "description": "Equations and Their Graphs",
        "lessons": ["solving-word-problems", ]
      },
      "IM.Alg1.2.6": {
        "description": "Equivalent Equations",
        "lessons": ["problem-decomposition", "order-of-operations", ]
      },
      "IM.Alg1.2.7": {
        "description": "Explaining Steps for Rewriting Equations",
        "lessons": []
      },
      "IM.Alg1.2.8": {
        "description": "Which Variable to Solve for? (Part 1)",
        "lessons": ["problem-decomposition", ]
      },
      "IM.Alg1.2.9": {
        "description": "Which Variable to Solve for? (Part 2)",
        "lessons": ["distance-formula", ]
      },
      "IM.Alg1.2.10": {
        "description": "Connecting Equations to Graphs (Part 1)",
        "lessons": []
      },
      "IM.Alg1.2.11": {
        "description": "Connecting Equations to Graphs (Part 2)",
        "lessons": []
      },
      "IM.Alg1.2.12": {
        "description": "Writing and Graphing Systems of Linear Equations",
        "lessons": []
      },
      "IM.Alg1.2.13": {
        "description": "Solving Systems by Substitution",
        "lessons": []
      },
      "IM.Alg1.2.14": {
        "description": "Solving Systems by Elimination (Part 1)",
        "lessons": []
      },
      "IM.Alg1.2.15": {
        "description": "Solving Systems by Elimination (Part 2)",
        "lessons": []
      },
      "IM.Alg1.2.16": {
        "description": "Solving Systems by Elimination (Part 3)",
        "lessons": []
      },
      "IM.Alg1.2.17": {
        "description": "Systems of Linear Equations and Their Solutions",
        "lessons": []
      },
      "IM.Alg1.2.18": {
        "description": "Representing Situations with Inequalities",
        "lessons": ["inequalities2-compound", "inequalities1-simple", ]
      },
      "IM.Alg1.2.19": {
        "description": "Solutions to Inequalities in One Variable",
        "lessons": []
      },
      "IM.Alg1.2.20": {
        "description": "Writing and Solving Inequalities in One Variable",
        "lessons": ["inequalities3-sam", "inequalities-collision", ]
      },
      "IM.Alg1.2.21": {
        "description": "Graphing Linear Inequalities in Two Variables (Part 1)",
        "lessons": []
      },
      "IM.Alg1.2.22": {
        "description": "Graphing Linear Inequalities in Two Variables (Part 2)",
        "lessons": []
      },
      "IM.Alg1.2.23": {
        "description": "Solving Problems with Inequalities in Two Variables",
        "lessons": []
      },
      "IM.Alg1.2.24": {
        "description": "Solutions to Systems of Linear Inequalities in Two Variables",
        "lessons": []
      },
      "IM.Alg1.2.25": {
        "description": "Solving Problems with Systems of Linear Inequalities in Two Variables",
        "lessons": []
      },
      "IM.Alg1.2.26": {
        "description": "Modeling with Systems of Inequalities in Two Variables",
        "lessons": []
      },
      "IM.Alg1.3.1": {
        "description": "Two-way Tables",
        "lessons": []
      },
      "IM.Alg1.3.2": {
        "description": "Relative Frequency Tables",
        "lessons": []
      },
      "IM.Alg1.3.3": {
        "description": "Associations in Categorical Data",
        "lessons": []
      },
      "IM.Alg1.3.4": {
        "description": "Linear Models",
        "lessons": ["scatter-plots", ]
      },
      "IM.Alg1.3.5": {
        "description": "Fitting Lines",
        "lessons": ["correlations", ]
      },
      "IM.Alg1.3.6": {
        "description": "Residuals",
        "lessons": []
      },
      "IM.Alg1.3.7": {
        "description": "The Correlation Coefficient",
        "lessons": ["linear-regression", "correlations", ]
      },
      "IM.Alg1.3.8": {
        "description": "Using the Correlation Coefficient",
        "lessons": ["linear-regression", "correlations", ]
      },
      "IM.Alg1.3.9": {
        "description": "Causal Relationships",
        "lessons": ["threats-to-validity", "linear-regression", ]
      },
      "IM.Alg1.3.10": {
        "description": "Fossils and Flags",
        "lessons": ["choosing-your-dataset", ]
      },
      "IM.Alg1.4.1": {
        "description": "Describing and Graphing Situations",
        "lessons": ["coordinates", ]
      },
      "IM.Alg1.4.2": {
        "description": "Function Notation",
        "lessons": ["making-game-images", "defining-values", "defining-functions", "contracts", ]
      },
      "IM.Alg1.4.3": {
        "description": "Interpreting & Using Function Notation",
        "lessons": ["composing-table-operations", "flags", "defining-functions", "contracts", ]
      },
      "IM.Alg1.4.4": {
        "description": "Using Function Notation to Describe Rules (Part 1)",
        "lessons": ["restating-the-problem", "defining-functions", ]
      },
      "IM.Alg1.4.5": {
        "description": "Using Function Notation to Describe Rules (Part 2)",
        "lessons": ["restating-the-problem", "defining-functions", ]
      },
      "IM.Alg1.4.6": {
        "description": "Features of Graphs",
        "lessons": ["functions-for-character-animation", ]
      },
      "IM.Alg1.4.7": {
        "description": "Using Graphs to Find Average Rate of Change",
        "lessons": []
      },
      "IM.Alg1.4.8": {
        "description": "Interpreting and Creating Graphs",
        "lessons": []
      },
      "IM.Alg1.4.9": {
        "description": "Comparing Graphs",
        "lessons": []
      },
      "IM.Alg1.4.10": {
        "description": "Domain and Range (Part 1)",
        "lessons": ["if-expressions", "defining-table-functions", "functions-for-character-animation", ]
      },
      "IM.Alg1.4.11": {
        "description": "Domain and Range (Part 2)",
        "lessons": []
      },
      "IM.Alg1.4.12": {
        "description": "Piecewise Functions",
        "lessons": ["player-animation", "piecewise-functions", ]
      },
      "IM.Alg1.4.13": {
        "description": "Absolute Value Functions (Part 1)",
        "lessons": []
      },
      "IM.Alg1.4.14": {
        "description": "Absolute Value Functions (Part 2)",
        "lessons": []
      },
      "IM.Alg1.4.15": {
        "description": "Inverse Functions",
        "lessons": []
      },
      "IM.Alg1.4.16": {
        "description": "Finding and Interpreting Inverse Functions",
        "lessons": []
      },
      "IM.Alg1.4.17": {
        "description": "Writing Inverse Functions to Solve Problems",
        "lessons": []
      },
      "IM.Alg1.4.18": {
        "description": "Using Functions to Model Battery Power",
        "lessons": []
      },
      "IM.Alg1.5.1": {
        "description": "Growing and Growing",
        "lessons": []
      },
      "IM.Alg1.5.2": {
        "description": "Patterns of Growth",
        "lessons": []
      },
      "IM.Alg1.5.3": {
        "description": "Representing Exponential Growth",
        "lessons": []
      },
      "IM.Alg1.5.4": {
        "description": "Understanding Decay",
        "lessons": []
      },
      "IM.Alg1.5.5": {
        "description": "Representing Exponential Decay",
        "lessons": []
      },
      "IM.Alg1.5.6": {
        "description": "Analyzing Graphs",
        "lessons": []
      },
      "IM.Alg1.5.7": {
        "description": "Using Negative Exponents",
        "lessons": []
      },
      "IM.Alg1.5.8": {
        "description": "Exponential Situations as Functions",
        "lessons": []
      },
      "IM.Alg1.5.9": {
        "description": "Interpreting Exponential Functions",
        "lessons": []
      },
      "IM.Alg1.5.10": {
        "description": "Looking at Rates of Change",
        "lessons": []
      },
      "IM.Alg1.5.11": {
        "description": "Modeling Exponential Behavior",
        "lessons": []
      },
      "IM.Alg1.5.12": {
        "description": "Reasoning about Exponential Graphs (Part 1)",
        "lessons": []
      },
      "IM.Alg1.5.13": {
        "description": "Reasoning about Exponential Graphs (Part 2)",
        "lessons": []
      },
      "IM.Alg1.5.14": {
        "description": "Recalling Percent Change",
        "lessons": []
      },
      "IM.Alg1.5.15": {
        "description": "Functions Involving Percent Change",
        "lessons": []
      },
      "IM.Alg1.5.16": {
        "description": "Compound Interest",
        "lessons": []
      },
      "IM.Alg1.5.17": {
        "description": "Different Compounding Intervals",
        "lessons": []
      },
      "IM.Alg1.5.18": {
        "description": "Expressed in Different Ways",
        "lessons": []
      },
      "IM.Alg1.5.19": {
        "description": "Which One Changes Faster?",
        "lessons": []
      },
      "IM.Alg1.5.20": {
        "description": "Changes over Equal Intervals",
        "lessons": []
      },
      "IM.Alg1.5.21": {
        "description": "Predicting Populations",
        "lessons": []
      },
      "IM.Alg1.6.1": {
        "description": "A Different Kind of Change",
        "lessons": []
      },
      "IM.Alg1.6.2": {
        "description": "How Does it Change?",
        "lessons": []
      },
      "IM.Alg1.6.3": {
        "description": "Building Quadratic Functions from Geometric Patterns",
        "lessons": []
      },
      "IM.Alg1.6.4": {
        "description": "Comparing Quadratic and Exponential Functions",
        "lessons": []
      },
      "IM.Alg1.6.5": {
        "description": "Building Quadratic Functions to Describe Situations (Part 1)",
        "lessons": []
      },
      "IM.Alg1.6.6": {
        "description": "Building Quadratic Functions to Describe Situations (Part 2)",
        "lessons": []
      },
      "IM.Alg1.6.7": {
        "description": "Building Quadratic Functions to Describe Situations (Part 3)",
        "lessons": []
      },
      "IM.Alg1.6.8": {
        "description": "Equivalent Quadratic Expressions",
        "lessons": []
      },
      "IM.Alg1.6.9": {
        "description": "Standard Form and Factored Form",
        "lessons": []
      },
      "IM.Alg1.6.10": {
        "description": "Graphs of Functions in Standard and Factored Forms",
        "lessons": []
      },
      "IM.Alg1.6.11": {
        "description": "Graphing from the Factored Form",
        "lessons": []
      },
      "IM.Alg1.6.12": {
        "description": "Graphing the Standard Form (Part 1)",
        "lessons": []
      },
      "IM.Alg1.6.13": {
        "description": "Graphing the Standard Form (Part 2)",
        "lessons": []
      },
      "IM.Alg1.6.14": {
        "description": "Graphs That Represent Situations",
        "lessons": []
      },
      "IM.Alg1.6.15": {
        "description": "Vertex Form",
        "lessons": []
      },
      "IM.Alg1.6.16": {
        "description": "Graphing from the Vertex Form",
        "lessons": []
      },
      "IM.Alg1.6.17": {
        "description": "Changing the Vertex",
        "lessons": []
      },
      "IM.Alg1.7.1": {
        "description": "Finding Unknown Inputs",
        "lessons": []
      },
      "IM.Alg1.7.2": {
        "description": "When and Why do We Write Quadratic Equations?",
        "lessons": []
      },
      "IM.Alg1.7.3": {
        "description": "Solving Quadratic Equations by Reasoning",
        "lessons": []
      },
      "IM.Alg1.7.4": {
        "description": "Solving Quadratic Equations with the Zero Product Property",
        "lessons": []
      },
      "IM.Alg1.7.5": {
        "description": "How Many Solutions?",
        "lessons": []
      },
      "IM.Alg1.7.6": {
        "description": "Rewriting Quadratic Expressions in Factored Form (Part 1)",
        "lessons": []
      },
      "IM.Alg1.7.7": {
        "description": "Rewriting Quadratic Expressions in Factored Form (Part 2)",
        "lessons": []
      },
      "IM.Alg1.7.8": {
        "description": "Rewriting Quadratic Expressions in Factored Form (Part 3)",
        "lessons": []
      },
      "IM.Alg1.7.9": {
        "description": "Solving Quadratic Equations by Using Factored Form",
        "lessons": []
      },
      "IM.Alg1.7.10": {
        "description": "Rewriting Quadratic Expressions in Factored Form (Part 4)",
        "lessons": []
      },
      "IM.Alg1.7.11": {
        "description": "What are Perfect Squares?",
        "lessons": []
      },
      "IM.Alg1.7.12": {
        "description": "Completing the Square (Part 1)",
        "lessons": []
      },
      "IM.Alg1.7.13": {
        "description": "Completing the Square (Part 2)",
        "lessons": []
      },
      "IM.Alg1.7.14": {
        "description": "Completing the Square (Part 3)",
        "lessons": []
      },
      "IM.Alg1.7.15": {
        "description": "Quadratic Equations with Irrational Solutions",
        "lessons": []
      },
      "IM.Alg1.7.16": {
        "description": "The Quadratic Formula",
        "lessons": []
      },
      "IM.Alg1.7.17": {
        "description": "Applying the Quadratic Formula (Part 1)",
        "lessons": []
      },
      "IM.Alg1.7.18": {
        "description": "Applying the Quadratic Formula (Part 2)",
        "lessons": []
      },
      "IM.Alg1.7.19": {
        "description": "Deriving the Quadratic Formula",
        "lessons": []
      },
      "IM.Alg1.7.20": {
        "description": "Rational and Irrational Solutions",
        "lessons": []
      },
      "IM.Alg1.7.21": {
        "description": "Sums and Products of Rational and Irrational Numbers",
        "lessons": []
      },
      "IM.Alg1.7.22": {
        "description": "Rewriting Quadratic Expressions in Vertex Form",
        "lessons": []
      },
      "IM.Alg1.7.23": {
        "description": "Using Quadratic Expressions in Vertex Form to Solve Problems",
        "lessons": []
      },
      "IM.Alg1.7.24": {
        "description": "Using Quadratic Equations to Model Situations and Solve Problems",
        "lessons": []
      },
    },
  },
  "practices": {
    "SJ": {
      "SJ.1": {
        "description": "Students will develop positive social identities based on their membership in multiple groups in society",
        "lessons": ["computing-needs-all-voices", ]
      },
      "SJ.2": {
        "description": "Students will develop language and historical and cultural knowledge that affirm and accurately describe their membership in multiple identity groups",
        "lessons": ["bar-and-pie-charts", "computing-needs-all-voices", ]
      },
      "SJ.3": {
        "description": "Students will recognize that people’s multiple identities interact and create unique and complex individuals",
        "lessons": []
      },
      "SJ.4": {
        "description": "Students will express pride, confidence and healthy self-esteem without denying the value and dignity of other people.",
        "lessons": ["bar-and-pie-charts", "computing-needs-all-voices", ]
      },
      "SJ.5": {
        "description": "Students will recognize traits of the dominant culture, their home culture and other cultures and understand how they negotiate their own identity in multiple spaces.",
        "lessons": []
      },
      "SJ.6": {
        "description": "Students will express comfort with people who are both similar to and different from them and engage respectfully with all people.",
        "lessons": []
      },
      "SJ.7": {
        "description": "Students will develop language and knowledge to accurately and respectfully describe how people (including themselves) are both similar to and different from each other and others in their identity groups.",
        "lessons": ["project-research-paper", "project-exploration-paper", "bar-and-pie-charts", "computing-needs-all-voices", ]
      },
      "SJ.8": {
        "description": "Students will respectfully express curiosity about the history and lived experiences of others and will exchange ideas and beliefs in an open-minded way",
        "lessons": ["computing-needs-all-voices", ]
      },
      "SJ.9": {
        "description": "Students will respond to diversity by building empathy, respect, understanding and connection.",
        "lessons": []
      },
      "SJ.10": {
        "description": "Students will examine diversity in social, cultural, political and historical contexts rather than in ways that are superficial or oversimplified.",
        "lessons": ["computing-needs-all-voices", ]
      },
      "SJ.11": {
        "description": "Students will recognize stereotypes and relate to people as individuals rather than representatives of groups.",
        "lessons": []
      },
      "SJ.12": {
        "description": "Students will recognize unfairness on the individual level (e.g., biased speech) and injustice at the institutional or systemic level (e.g., discrimination).",
        "lessons": ["project-research-paper", "ethics-privacy-and-bias", "checking-your-work", ]
      },
      "SJ.13": {
        "description": "Students will analyze the harmful impact of bias and injustice on the world, historically and today",
        "lessons": ["project-research-paper", "project-exploration-paper", "probability-inference", "ethics-privacy-and-bias", "checking-your-work", ]
      },
      "SJ.14": {
        "description": "Students will recognize that power and privilege influence relationships on interpersonal, intergroup and institutional levels and consider how they have been affected by those dynamics.",
        "lessons": ["project-research-paper", "project-exploration-paper", "data-collection", "checking-your-work", ]
      },
      "SJ.15": {
        "description": "Students will identify figures, groups, events and a variety of strategies and philosophies relevant to the history of social justice around the world.",
        "lessons": ["checking-your-work", ]
      },
      "SJ.16": {
        "description": "Students will express empathy when people are excluded or mistreated because of their identities and concern when they themselves experience bias.",
        "lessons": []
      },
      "SJ.17": {
        "description": "Students will recognize their own responsibility to stand up to exclusion, prejudice and injustice.",
        "lessons": []
      },
      "SJ.18": {
        "description": "Students will speak up with courage and respect when they or someone else has been hurt or wronged by bias.",
        "lessons": []
      },
      "SJ.19": {
        "description": "Students will make principled decisions about when and how to take a stand against bias and injustice in their everyday lives and will do so despite negative peer or group pressure.",
        "lessons": []
      },
      "SJ.20": {
        "description": "Students will plan and carry out collective action against bias and injustice in the world and will evaluate what strategies are most effective.",
        "lessons": []
      },
    },
    "NGSS": {
      "SEP.1": {
        "description": "Asking Questions and Defining Problems",
        "lessons": []
      },
      "SEP.2": {
        "description": "Developing and Using Models",
        "lessons": ["order-of-operations", ]
      },
      "SEP.3": {
        "description": "Planning and Carrying Out Investigations",
        "lessons": ["threats-to-validity", "scatter-plots", "probability-inference", "box-plots", "measures-of-center", "linear-regression", "histograms2", "histograms", "grouped-samples", "bar-and-pie-charts", "correlations", "choosing-your-dataset", "checking-your-work", ]
      },
      "SEP.4": {
        "description": "Analyzing and Interpreting Data",
        "lessons": ["data-cycle", ]
      },
      "SEP.5": {
        "description": "Using Mathematics and Computational Thinking",
        "lessons": ["function-composition", "flags", "distance-formula", "combinatorics-combination", "combinatorics-permutation", ]
      },
      "SEP.6": {
        "description": "Constructing Explanations and Designing Solutions",
        "lessons": []
      },
      "SEP.7": {
        "description": "Engaging in Argument from Evidence",
        "lessons": ["data-cycle", "defining-values", ]
      },
      "SEP.8": {
        "description": "Obtaining, Evaluating, and Communicating Information",
        "lessons": ["data-cycle", "data-collection", "contracts", ]
      },
    },
    "CC": {
      "MP.1": {
        "description": "Make sense of problems and persevere in solving them",
        "lessons": ["problem-decomposition", "order-of-operations", "inequalities2-compound", "inequalities1-simple", "function-composition", "functions-dr", "function-definition-linear", "functions-can-be-linear", "flags", "functions-dr", ]
      },
      "MP.2": {
        "description": "Reason abstractly and quantitatively",
        "lessons": ["scatter-plots", "probability-inference", "grouped-samples", "choosing-your-dataset", "order-of-operations", "numbers-inside-video-games", "functions-for-character-animation", "function-definition-linear", "functions-can-be-linear", "functions-vertical-line-test", "flags", "error-analysis", "distance-formula", "defining-values", "coordinates", ]
      },
      "MP.3": {
        "description": "Construct viable arguments and critique the reasoning of others",
        "lessons": ["threats-to-validity", "standard-deviation", "box-plots", "measures-of-center", "grouped-samples", "ethics-privacy-and-bias", "ds-intro", "data-collection", "correlations", "checking-your-work", "problem-decomposition", "player-animation", "order-of-operations", "inequalities-collision", "function-definition-linear", "distance-formula", "functions-dr", ]
      },
      "MP.4": {
        "description": "Model with mathematics",
        "lessons": ["table-methods", "standard-deviation", "box-plots", "linear-regression", "histograms2", "histograms", "correlations", "surface-area-rect-prism", "problem-decomposition", "player-animation", "order-of-operations", "numbers-inside-video-games", "inequalities3-sam", "inequalities1-simple", "functions-for-character-animation", "function-notation", "functions-vertical-line-test", "flags", "combinatorics-combination", "combinatorics-permutation", "functions-dr", "codap-transformers", ]
      },
      "MP.5": {
        "description": "Use appropriate tools strategically",
        "lessons": ["bar-and-pie-charts", "data-cycle", "data-collection", "choosing-your-dataset", "function-composition", "function-definition-linear", "functions-can-be-linear", ]
      },
      "MP.6": {
        "description": "Attend to precision",
        "lessons": ["composing-table-operations", "bar-and-pie-charts", "defining-table-functions", "data-cycle", "problem-decomposition", "player-animation", "making-game-images", "inequalities1-simple", "function-notation", "flags", "simple-data-types", "functions-examples-definitions", "functions-make-life-easier", "debugging", ]
      },
      "MP.7": {
        "description": "Look for and make use of structure",
        "lessons": ["lookups", "advanced-displays", "functions-dr", "function-definition-linear", "functions-can-be-linear", "function-notation", "flags", "defining-values", "combinatorics-combination", "combinatorics-permutation", "functions-dr", "functions-examples-definitions", "functions-make-life-easier", ]
      },
      "MP.8": {
        "description": "Look for and express regularity in repeated reasoning",
        "lessons": ["piecewise-functions-conditionals", "defining-table-functions", "functions-vertical-line-test", "flags", "defining-values", "functions-examples-definitions", "functions-make-life-easier", ]
      },
    },
    "K12CS": {
      "P1": {
        "description": "Fostering an Inclusive Computing Culture",
        "lessons": ["project-research-paper", "project-exploration-paper", "threats-to-validity", "ethics-privacy-and-bias", "computing-needs-all-voices", ]
      },
      "P2": {
        "description": "Collaborating Around Computing",
        "lessons": ["project-research-paper", "project-exploration-paper", "data-collection", "project-video-game", "debugging", ]
      },
      "P3": {
        "description": "Recognizing and Defining Computational Problems",
        "lessons": ["re-timers", "re-nested-structures", "re-making-pong", "re-adding-levels", "re-adding-collisions", "re-build-your-own-animation", "re-refactoring", "composing-table-operations", "grouped-samples", "data-cycle", ]
      },
      "P4": {
        "description": "Developing and Using Abstractions",
        "lessons": ["re-timers", "re-nested-structures", "re-making-pong", "re-scoring", "re-adding-collisions", "re-build-your-own-animation", "re-refactoring", "defining-table-functions", "functions-make-life-easier", ]
      },
      "P5": {
        "description": "Creating Computational Artifacts",
        "lessons": ["project-research-paper", "project-exploration-paper", "standard-deviation", "project-video-game", ]
      },
      "P6": {
        "description": "Testing and Refining Computational Artifacts",
        "lessons": ["re-adding-levels", "re-scoring", "project-research-paper", "project-exploration-paper", "data-collection", "checking-your-work", "project-video-game", "debugging", ]
      },
      "P7": {
        "description": "Communicating About Computing",
        "lessons": ["ds-intro", "choosing-your-dataset", ]
      },
    },
  }
};
