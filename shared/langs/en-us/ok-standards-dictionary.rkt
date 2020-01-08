#lang racket

(provide *ok-standards-list*)

(define *ok-standards-list*
'(

; Oklahoma State Math Standards

 ("OK.PA.N.1"
  "Read, write, compare, classify, and represent real numbers and use them to solve problems in various contexts."
 )
 ("OK.PA.N.1.1"
  "Develop and apply the properties of integer exponents, including the zero exponent rule, to generate equivalent numerical and algebraic expressions."
 )
 ("OK.PA.N.1.2"
  "Express and compare approximations of very large and very small numbers using scientific notation."
 )
 ("OK.PA.N.1.3"
  "Multiply and divide numbers expressed in scientific notation, express the answer in scientific notation."
 )
 ("OK.PA.N.1.4"
  "Classify real numbers as rational or irrational. Explain why the rational number system is closed under addition and multiplication and why the irrational system is not. Explain why the sum of a rational number and an irrational number is irrational; and the product of a non-zero rational number and an irrational number is irrational."
 )
 ("OK.PA.N.1.5"
  "Compare real numbers; locate real numbers on a number line. Identify the square root of a perfect square to 400 or, if it is not a perfect square root, locate it as an irrational number between two consecutive positive integers."
 )
 ("OK.PA.A.1"
  "Understand the concept of function in real-world and mathematical situations, and distinguish between linear and nonlinear functions."
 )
 ("OK.PA.A.1.1"
  "Recognize that a function is a relationship between an independent variable and a dependent variable in which the value of the independent variable determines the value of the dependent variable."
 )
 ("OK.PA.A.1.2"
  "Use linear functions to represent and explain real-world and mathematical situations."
 )
 ("OK.PA.A.1.3"
  "Identify a function as linear if it can be expressed in the form y = mx + b or if its graph is a straight line."
 )
 ("OK.PA.A.2"
  "Recognize linear functions in real-world and mathematical situations; represent linear functions and other functions with tables, verbal descriptions, symbols, and graphs; solve problems involving linear functions and interpret results in the original context."
 )
 ("OK.PA.A.2.1"
  "Represent linear functions with tables, verbal descriptions, symbols, and graphs; translate from one representation to another."
 )
 ("OK.PA.A.2.2"
  "Identify, describe, and analyze linear relationships between two variables."
 )
 ("OK.PA.A.2.3"
  "Identify graphical properties of linear functions including slope and intercepts. Know that the slope equals the rate of change, and that the yintercept is zero when the function represents a proportional relationship."
 )
 ("OK.PA.A.2.4"
  "Predict the effect on the graph of a linear function when the slope or y-intercept changes. Use appropriate tools to examine these effects."
 )
 ("OK.PA.A.2.5"
  "Solve problems involving linear functions and interpret results in the original context."
 )
 ("OK.PA.A.3"
  "Generate equivalent numerical and algebraic expressions and use algebraic properties to evaluate expressions."
 )
 ("OK.PA.A.3.1"
  "Use substitution to simplify and evaluate algebraic expressions."
 )
 ("OK.PA.A.3.2"
  "Justify steps in generating equivalent expressions by identifying the properties used, including the properties of operations (associative, commutative, and distributive laws) and the order of operations, including grouping symbols."
 )
 ("OK.PA.A.4"
  "Represent real-world and mathematical problems using equations and inequalities involving linear expressions. Solve and graph equations and inequalities symbolically and graphically. Interpret solutions in the original context."
 )
 ("OK.PA.A.4.1"
  "Illustrate, write, and solve mathematical and real-world problems using linear equations with one variable with one solution, infinitely many solutions, or no solutions. Interpret solutions in the original context."
 )
 ("OK.PA.A.4.2"
  "Represent, write, solve, and graph problems leading to linear inequalities with one variable in the form px + q > r and px + q < r, where p, q, and r are rational numbers."
 )
 ("OK.PA.A.4.3"
  "Represent real-world situations using equations and inequalities involving one variable."
 )
 ("OK.PA.GM.1"
  "Solve problems involving right triangles using the Pythagorean Theorem."
 )
 ("OK.PA.GM.1.1"
  "Informally justify the Pythagorean Theorem using measurements, diagrams, or dynamic software and use the Pythagorean Theorem to solve problems in two and three dimensions involving right triangles."
 )
 ("OK.PA.GM.1.2"
  "Use the Pythagorean Theorem to find the distance between any two points in a coordinate plane."
 )
 ("OK.PA.GM.2"
  "Calculate surface area and volume of three-dimensional figures."
 )
 ("OK.PA.GM.2.1"
  "Calculate the surface area of a rectangular prism using decomposition or nets. Use appropriate measurements such as cm2."
 )
 ("OK.PA.GM.2.2"
  "Calculate the surface area of a cylinder, in terms of pi and using approximations for pi, using decomposition or nets. Use appropriate measurements such as cm2."
 )
 ("OK.PA.GM.2.3"
  "Develop and use the formulas V = lwh and V = Bh to determine the volume of rectangular prisms. Justify why base area (B) and height (h) are
multiplied to find the volume of a rectangular prism. Use appropriate measurements such as cm3."
 )
 ("OK.PA.GM.2.4"
  "Develop and use the formulas V = pi * r2 * h and V = Bh to determine the volume of right cylinders, in terms of pi and using approximations for pi.
Justify why base area (B) and height (h) are multiplied to find the volume of a right cylinder. Use appropriate measurements such as cm3."
 )
 ("OK.PA.D.1"
  "Display and interpret data in a variety of ways, including using scatterplots and approximate lines of best fit. Use line of best fit and average rate of change to make predictions and draw conclusions about data."
 )
 ("OK.PA.D.1.1"
  "Describe the impact that inserting or deleting a data point has on the mean and the median of a data set. Know how to create data displays using a spreadsheet and use a calculator to examine this impact."
 )
 ("OK.PA.D.1.2"
  "Explain how outliers affect measures of central tendency."
 )
 ("OK.PA.D.1.3"
  "Collect, display and interpret data using scatterplots. Use the shape of the scatterplot to informally estimate a line of best fit, make statements about average rate of change, and make predictions about values not in the original data set. Use appropriate titles, labels and units."
 )
 ("OK.PA.D.2"
  "Calculate experimental probabilities and reason about probabilities to solve real-world and mathematical problems."
 )
 ("OK.PA.D.2.1"
  "Calculate experimental probabilities and represent them as percents, fractions and decimals between 0 and 1 inclusive. Use experimental probabilities to make predictions when actual probabilities are unknown."
 )
 ("OK.PA.D.2.2"
  "Determine how samples are chosen (random, limited, biased) to draw and support conclusions about generalizing a sample to a population."
 )
 ("OK.PA.D.2.3"
  "Compare and contrast dependent and independent events."
 )
 ("OK.MAP.1" 
  "Develop a deep and flexible conceptual understanding."
 )
 ("OK.MAP.2"
  "Develop accurate and appropriate procedural fluency."
 )
 ("OK.MAP.3"
  "Develop strategies for problem solving."
 )
 ("OK.MAP.4"
  "Develop mathematical reasoning."
 )
 ("OK.MAP.5"
  "Develop a productive mathematical disposition."
 )
 ("OK.MAP.6"
  "Develop the ability to make conjectures, model, and generalize."
 )
 ("OK.MAP.7"
  "Develop the ability to communicate mathematically."
 )
 ("OK.A1.N.1"
  "Extend the understanding of number and operations to include square roots and cube roots."
 )
 ("OK.A1.N.1.1"
  "Write square roots and cube roots of monomial algebraic expressions in simplest radical form."
 )
 ("OK.A1.N.1.2"
  "Add, subtract, multiply, and simplify square roots of monomial algebraic expressions and divide square roots of whole numbers, rationalizing
the denominator when necessary."
 )
 ("OK.A1.A.1"
  "Represent and solve mathematical and real-world problems using linear equations, absolute value equations, and systems of equations; interpret solutions in the original context."
 )
 ("OK.A1.A.1.1"
  "Use knowledge of solving equations with rational values to represent and solve mathematical and real-world problems (e.g., angle measures, geometric formulas, science, or statistics) and interpret the solutions in the original context."
 )
 ("OK.A1.A.1.2"
  "Solve absolute value equations and interpret the solutions in the original context."
 )
 ("OK.A1.A.1.3"
  "Analyze and solve real-world and mathematical problems involving systems of linear equations with a maximum of two variables by graphing (may include graphing calculator or other appropriate technology), substitution, and elimination. Interpret the solutions in the original context."
 )
 ("OK.A1.A.2"
  "Represent and solve real-world and mathematical problems using linear inequalities, compound inequalities and systems of linear inequalities; interpret solutions in the original context."
 )
 ("OK.A1.A.2.1"
  "Represent relationships in various contexts with linear inequalities; solve the resulting inequalities, graph on a coordinate plane, and interpret the solutions."
 )
 ("OK.A1.A.2.2"
  "Represent relationships in various contexts with compound and absolute value inequalities and solve the resulting inequalities by graphing and interpreting the solutions on a number line."
 )
 ("OK.A1.A.2.3"
  "Solve systems of linear inequalities with a maximum of two variables; graph and interpret the solutions on a coordinate plane."
 )
 ("OK.A1.A.3"
  "Generate equivalent algebraic expressions and use algebraic properties to evaluate expressions and arithmetic and geometric sequences."
 )
 ("OK.A1.A.3.1"
  "Solve equations involving several variables for one variable in terms of the others."
 )
 ("OK.A1.A.3.2"
  "Simplify polynomial expressions by adding, subtracting, or multiplying."
 )
 ("OK.A1.A.3.3"
  "Factor common monomial factors from polynomial expressions and factor quadratic expressions with a leading coefficient of 1."
 )
 ("OK.A1.A.3.4"
  "Evaluate linear, absolute value, rational, and radical expressions. Include applying a nonstandard operation such as a o b = 2a + b."
 )
 ("OK.A1.A.3.5"
  "Recognize that arithmetic sequences are linear using equations, tables, graphs, and verbal descriptions. Use the pattern, find the next term."
 )
 ("OK.A1.A.3.6"
  "Recognize that geometric sequences are exponential using equations, tables, graphs and verbal descriptions. Given the formula f(x) = a(r)^x, find the next term and define the meaning of a and r within the context of the problem."
 )
 ("OK.A1.A.4"
  "Analyze mathematical change involving linear equations in real-world and mathematical problems."
 )
 ("OK.A1.A.4.1"
  "Calculate and interpret slope and the x- and y-intercepts of a line using a graph, an equation, two points, or a set of data points to solve realworld and mathematical problems."
 )
 ("OK.A1.A.4.2"
  "Solve mathematical and real-world problems involving lines that are parallel, perpendicular, horizontal, or vertical."
 )
 ("OK.A1.A.4.3"
  "Express linear equations in slope-intercept, point-slope, and standard forms and convert between these forms. Given sufficient information (slope and y-intercept, slope and one-point on the line, two points on the line, x- and y-intercept, or a set of data points), write the equation of a line."
 )
 ("OK.A1.A.4.4"
  "Translate between a graph and a situation described qualitatively."
 )
 ("OK.A1.F.1"
  "Understand functions as descriptions of covariation (how related quantities vary together) in real-world and mathematical problems."
 )
 ("OK.A1.F.1.1"
  "Distinguish between relations and functions."
 )
 ("OK.A1.F.1.2"
  "Identify the dependent and independent variables as well as the domain and range given a function, equation, or graph. Identify restrictions on the domain and range in real-world contexts."
 )
 ("OK.A1.F.1.3"
  "Write linear functions, using function notation, to model real-world and mathematical situations."
 )
 ("OK.A1.F.1.4"
  "Given a graph modeling a real-world situation, read and interpret the linear piecewise function (excluding step functions)."
 )
 ("OK.A1.F.2"
  "Recognize functions and understand that families of functions are characterized by their rate of change."
 )
 ("OK.A1.F.2.1"
  "Distinguish between linear and nonlinear (including exponential) functions arising from real-world and mathematical situations that are represented in tables, graphs, and equations. Understand that linear functions grow by equal intervals and that exponential functions grow by equal factors over equal intervals."
 )
 ("OK.A1.F.2.2"
  "Recognize the graph of the functions f(x) = x and f(x) = |x| and predict the effects of transformations [ f(x + c) and f(x) + c, where c is a positive or negative constant] algebraically and graphically using various methods and tools that may include graphing calculators."
 )
 ("OK.A1.F.3"
  "Represent functions in multiple ways and use the representation to interpret real-world and mathematical problems."
 )
 ("OK.A1.F.3.1"
  "Identify and generate equivalent representations of linear equations, graphs, tables, and real-world situations."
 )
 ("OK.A1.F.3.2" 
  "Use function notation; evaluate a function, including nonlinear, at a given point in its domain algebraically and graphically. Interpret the results in terms of real-world and mathematical problems."
 )
 ("OK.A1.F.3.3"
  "Add, subtract, and multiply functions using function notation."
 )
 ("OK.A1.D.1"
  "Display, describe, and compare data. For linear relationships, make predictions and assess the reliability of those predictions."
 )
 ("OK.A1.D.1.1"
  "Describe a data set using data displays, describe and compare data sets using summary statistics, including measures of central tendency, location, and spread. Know how to use calculators, spreadsheets, or other appropriate technology to display data and calculate summary statistics."
 )
 ("OK.A1.D.1.2"
  "Collect data and use scatterplots to analyze patterns and describe linear relationships between two variables. Using graphing technology, determine regression lines and correlation coefficients; use regression lines to make predictions and correlation coefficients to assess the reliability of those predictions."
 )
 ("OK.A1.D.1.3"
  "Interpret graphs as being discrete or continuous."
 )
 ("OK.A1.D.2"
  "Calculate probabilities and apply probability concepts."
 )
 ("OK.A1.D.2.1"
  "Select and apply counting procedures, such as the multiplication and addition principles and tree diagrams, to determine the size of a sample space (the number of possible outcomes) and to calculate probabilities."
 )
 ("OK.A1.D.2.2"
  "Describe the concepts of intersections, unions, and complements using Venn diagrams to evaluate probabilities. Understand the relationships between these concepts and the words AND, OR, and NOT."
 )
 ("OK.A1.D.2.3"
  "Calculate experimental probabilities by performing simulations or experiments involving a probability model and using relative frequencies of outcomes."
 )
 ("OK.A1.D.2.4"
  "Apply probability concepts to real-world situations to make informed decisions."
 )

 ; OK CS Standards

 ("OK.3.CS.HS.01" 
  "Model how information flows through hardware and software to accomplish tasks."
 )
 ("OK.4.CS.HS.01" 
  "Model that information is translated, transmitted, and processed in order to flow through hardware and software."
 )
 ("OK.5.CS.HS.01" 
  "Model that information is translated into bits in order to transmit and process between software to accomplish tasks."
 )
 ("OK.3.CS.T.01" 
  "Identify, using accurate terminology, simple hardware and software problems that may occur during everyday use, discuss problems with peers and adults, and apply strategies for solving these problems."
 )
 ("OK.4.CS.T.01" 
  "Identify, using accurate terminology, simple hardware and software problems that may occur during everyday use, discuss problems with peers and adults, and apply strategies for solving these problems."
 )
 ("OK.5.CS.T.01" 
  "Identify, using accurate terminology, simple hardware and software problems that may occur during everyday use. Discuss problems with peers and adults, apply strategies for solving these problems and explain why the strategy should work."
 )
 ("OK.3.NI.NCO.01" 
  "Recognize that information is sent and received over physical or wireless paths."
 )
 ("OK.4.NI.NCO.01" 
  "Explain how information is sent and received across physical or wireless paths."
 )
 ("OK.5.NI.NCO.01" 
  "Model how information is broken down into packets and transmitted through multiple devices over networks and the Internet, and reassembled at the destination."
 )
 ("OK.3.NI.C.01" 
  "Identify problems that relate to inappropriate use of computing devices and networks."
 )
 ("OK.4.NI.C.01" 
  "Identify and explain issues related to responsible use of technology and information, and describe personal consequences of inappropriate use."
 )
 ("OK.5.NI.C.01" 
  "Discuss real-world cybersecurity problems and identify strategies for how personal information can be protected."
 )
 ("OK.3.DA.S.01" 
  "Recognize that different types of information are stored in different formats that have associated programs and varied storage requirements."
 )
 ("OK.4.DA.S.01"
  "Choose different storage locations based on the type of file, storage requirements, and sharing requirements."
 )
 ("OK.5.DA.S.01" 
  "Evaluate trade-offs, including availability and quality, based on the type of file, storage requirements, and sharing requirements."
 )
 ("OK.3.DA.CVT.01" 
  "Collect and organize data in various visual formats."
 )
 ("OK.4.DA.CVT.01" 
  "Organize and present collected data visually to highlight comparisons."
 )
 ("OK.5.DA.CVT.01" 
  "Organize and present collected data to highlight comparisons and support a claim."
 )
 ("OK.3.DA.IM.01" 
  "With guidance, utilize data to make predictions and discuss whether there is adequate data to make reliable predictions."
 )
 ("OK.4.DA.IM.01" 
  "Determine how the accuracy of conclusions are influenced by the amount of data collected."
 )
 ("OK.5.DA.IM.01" 
  "Use data to highlight or propose cause and effect relationships, predict outcomes, or communicate an idea."
 )
 ("OK.3.AP.A.01" 
  "Compare multiple algorithms for the same task."
 )
 ("OK.4.AP.A.01" 
  "Compare and refine multiple algorithms for the same task."
 )
 ("OK.5.AP.A.01" 
  "Compare and refine multiple algorithms for the same task and determine which is the most efficient."
 )
 ("OK.3.A.V.01" 
  "Create programs that use variables to store and modify grade level appropriate data."
 )
 ("OK.4.AP.V.01" 
  "Create programs that use variables to store and modify grade level appropriate data."
 )
 ("OK.5.AP.V.01" 
  "Create programs that use variables to store and modify grade level appropriate data."
 )
 ("OK.3.AP.C.01" 
  "Create programs using a programming language that utilize sequencing, repetition, conditionals, and variables to solve a problem or express ideas both independently and collaboratively."
 )
 ("OK.4.AP.C.01" 
  "Create programs using a programming language that utilize sequencing, repetition, conditionals and variables using math operations manipulate values to solve a problem or express ideas both independently and collaboratively."
 )
 ("OK.5.AP.C.01" 
  "Create programs using a programming language that utilize sequencing, repetition, conditionals, event handlers and variables using math operations to manipulate values to solve a problem or express ideas both independently and collaboratively."
 )
 ("OK.3.AP.M.01" 
  "Decompose the steps needed to solve a problem into a precise sequence of instructions."
 )
 ("OK.4.AP.M.01"
  "Decompose large problems into smaller, manageable subproblems to facilitate the program development process."
 )
 ("OK.5.AP.M.01" 
  "Decompose large problems into smaller, manageable subproblems and then into a precise sequence of instructions."
 )
 ("OK.3.AP.M.02" 
  "With grade appropriate complexity, modify, remix, or incorporate portions of an existing program into one's own work, to develop something new or add more advanced features."
 )
 ("OK.4.AP.M.02" 
  "With grade appropriate complexity, modify, remix, or incorporate portions of an existing program into one's own work, to develop something new or add more advanced features."
 )
 ("OK.5.AP.M.02" 
  "With grade appropriate complexity, modify, remix, or incorporate portions of an existing program into one's own work, to develop something new or add more advanced features."
 )
 ("OK.3.AP.PD.01" 
  "Use an iterative process to plan the development of a program while solving simple problems."
 )
 ("OK.4.AP.PD.01" 
  "Use an iterative process to plan the development of a program that includes user preferences while solving simple problems."
 )
 ("OK.5.AP.PD.01" 
  "Use an iterative process to plan the development of a program that includes others' perspectives and user preferences while solving simple problems."
 )
 ("OK.3.AP.PD.02" 
  "Observe intellectual property rights and give appropriate credit when creating or remixing programs."
 )
 ("OK.4.AP.PD.02" 
  "Observe intellectual property rights and give appropriate credit when creating or remixing programs."
 )
 ("OK.5.AP.PD.02" 
  "Observe intellectual property rights and give appropriate credit when creating or remixing programs."
 )
 ("OK.3.AP.PD.03" 
  "Analyze and debug a program that includes sequencing, repetition and variables in a programming language."
 )
 ("OK.4.AP.PD.03" 
  "Analyze, create, and debug a program that includes sequencing, repetition, conditionals and variables in a programming language."
 )
 ("OK.5.AP.PD.03" 
  "Analyze, create, and debug a program that includes sequencing, repetition, conditionals and variables in a programming language."
 )
 ("OK.3.AP.PD.04" 
  "Communicate and explain your program development using comments, presentations and demonstrations."
 )
 ("OK.4.AP.PD.04" 
  "Communicate and explain your program development using comments, presentations and demonstrations."
 )
 ("OK.5.AP.PD.04"
  "Communicate and explain your program development using comments, presentations and demonstrations."
 )
 ("OK.3.IC.C.01" 
  "Identify computing technologies that have changed the world, and express how those technologies influence, and are influenced by, cultural practices."
 )
 ("OK.4.IC.C.01" 
  "Give examples of computing technologies that have changed the world, and express how those technologies influence, and are influenced by, cultural practices."
 )
 ("OK.5.IC.C.01" 
  "Give examples and explain how computing technologies have changed the world, and express how computing technologies influence, and are influenced by, cultural practices."
 )
 ("OK.3.IC.C.02" 
  "Identify possible problems and how computing devices have built in features for increasing accessibility to all users."
 )
 ("OK.4.IC.C.02" 
  "Brainstorm problems and ways to improve computing devices to increase accessibility to all users."
 )
 ("OK.5.IC.C.02" 
  "Develop, test and refine digital artifacts to improve accessibility and usability."
 )
 ("OK.3.IC.SI.01" 
  "Develop a code of conduct, explain, and practice grade-level appropriate behavior and responsibilities while participating in an online community. Identify and report inappropriate behavior."
 )
 ("OK.4.IC.SI.01" 
  "Develop a code of conduct, explain, and practice grade-level appropriate behavior and responsibilities while participating in an online community. Identify and report inappropriate behavior."
 )
 ("OK.5.IC.SI.01" 
  "Develop a code of conduct, explain, and practice grade-level appropriate behavior and responsibilities while participating in an online community. Identify and report inappropriate behavior."
 )
 ("OK.3.IC.SI.02" 
  "Identify how computational products may be, or have been, improved to incorporate diverse perspectives."
 )
 ("OK.4.IC.SI.02" 
  "As a team, consider each others perspectives on improving a computational product."
 )
 ("OK.5.IC.SI.02" 
  "As a team, collaborate with outside resources (other grade levels, online collaborative spaces) to include diverse perspectives to improve computational products."
 )
 ("OK.3.IC.SLE.01" 
  "Identify types of digital data that may have intellectual property rights that prevent copying or require attribution."
 )
 ("OK.4.IC.SLE.01" 
  "Discuss the social impact of violating intellectual property rights."
 )
 ("OK.5.IC.SLE.01" 
  "Observe intellectual property rights and give appropriate credit when using resources."
 )
 ("OK.6.CS.D.01" 
  "Evaluate existing computing devices and recommend improvements to design based on analysis of personal interaction with the device."
 )
 ("OK.7.CS.D.01"
  "Evaluate existing computing devices and recommend improvements to design based on analysis of how other users interact with the device."
 )
 ("OK.8.CS.D.01"
  "Develop and implement a process to evaluate existing computing devices and recommend improvements to design based on analysis of how other users interact with the device."
 )
 ("OK.6.CS.HS.01"
  "Identify ways that hardware and software are combined to collect and exchange data."
 )
 ("OK.7.CS.HS.01"
  "Evaluate and recommend improvements to software and hardware combinations used to collect and exchange data."
 )
 ("OK.8.CS.HS.01"
  "Design and refine projects that combine hardware and software components to collect and exchange data."
 )
 ("OK.6.CS.T.01"
  "Identify increasingly complex software and hardware problems with computing devices and their components."
 )
 ("OK.7.CS.T.01"
  "Identify and fix increasingly complex software and hardware problems with computing devices and their components."
 )
 ("OK.8.CS.T.01"
  "Systematically identify, fix, and document increasingly complex software and hardware problems with computing devices and their components."
 )
 ("OK.6.NI.NCO.01"
  "Model a simple protocol for transferring information using packets."
 )
 ("OK.7.NI.NCO.01"
  "Explain how a system responds when a packet is lost and the effect it has on the transferred information."
 )
 ("OK.8.NI.NCO.01"
  "Explain protocols and their importance to data transmission; model how packets are broken down into smaller pieces and how they are delivered."
 )
 ("OK.6.NI.C.01"
  "Identify existing cybersecurity concerns with the Internet and systems it uses."
 )
 ("OK.7.NI.C.01"
  "Explain how to protect electronic information, both physical (e.g. hard drive) and digital, identify cybersecurity concerns and options to address issues with the Internet and the systems it uses."
 )
 ("OK.8.NI.C.01"
  "Evaluate physical and digital procedures that could be implemented to protect electronic data/information; explain the impacts of hacking, ransomware, scams, fake scans, and ethical/legal concerns."
 )
 ("OK.6.NI.C.02"
  "Explain the importance of secured websites and describe how one method of encryption works."
 )
 ("OK.7.NI.C.02"
  "Identify and explain two or more methods of encryption used to ensure and secure the transmission of information."
 )
 ("OK.8.NI.C.02"
  "Compare the advantages and disadvantages of multiple methods of encryption to model the secure transmission of information."
 )
 ("OK.6.DA.S.01"
  "Identify how the same data can be represented in multiple ways."
 )
 ("OK.7.DA.S.01"
  "Create multiple representations of data."
 )
 ("OK.8.DA.S.01"
  "Analyze multiple methods of representing data and choose the most appropriate method for representing data."
 )
 ("OK.6.DA.CVT.01"
  "Collect data using computational tools and transform the data to make it more useful."
 )
 ("OK.7.DA.CVT.01"
  "Collect data using computational tools and transform the data to make it more useful and reliable."
 )
 ("OK.8.DA.CVT.01"
  "Develop, implement, and refine a process that utilizes computational tools to collect and transform data to make it more useful and reliable."
 )
 ("OK.6.DA.IM.01"
  "Use models and simulations to formulate, refine, and test hypotheses."
 )
 ("OK.7.DA.IM.01"
  "Discuss the correctness of a model representing a system by comparing the model’s generated results with observed data from the modeled system."
 )
 ("OK.8.DA.IM.01"
  "Refine computational models based on the data generated by the models."
 )
 ("OK.6.AP.A.01"
  "Use an existing algorithm in natural language or pseudocode to solve complex problems."
 )
 ("OK.7.AP.A.01"
  "Select and modify an existing algorithm in natural language or pseudocode to solve complex problems."
 )
 ("OK.8.AP.A.01"
  "Design algorithms in natural language, flow and control diagrams, comments within code, and/or pseudocode to solve complex problems."
 )
 ("OK.6.AP.C.01"
  "Develop programs that utilize combinations of repetition, conditionals, and the manipulation of variables representing different data types."
 )
 ("OK.7.AP.C.01"
  "Develop programs that utilize combinations of repetition, compound conditionals, and the manipulation of variables representing different data types."
 )
 ("OK.8.AP.C.01"
  "Develop programs that utilize combinations of nested repetition, compound conditionals, procedures without parameters, and the manipulation of variables representing different data types."
 )
 ("OK.6.AP.M.01"
  "Decompose problems into parts to facilitate the design, implementation, and review of programs."
 )
 ("OK.7.AP.M.01"
  "Decompose problems into parts to facilitate the design, implementation, and review of increasingly complex programs."
 )
 ("OK.8.AP.M.01"
  "Decompose problems and subproblems into parts to facilitate the design, implementation, and review of complex programs."
 )
 ("OK.6.AP.PD.01"
  "Seek and incorporate feedback from team members to refine a solution to a problem."
 )
 ("OK.7.AP.PD.01"
  "Seek and incorporate feedback from team members and users to refine a solution to a problem."
 )
 ("OK.8.AP.PD.01"
  "Seek and incorporate feedback from team members and users to refine a solution to a problem that meets the needs of diverse users."
 )
 ("OK.6.AP.PD.02"
  "Incorporate existing code, media, and libraries into original programs and give attribution."
 )
 ("OK.7.AP.PD.02"
  "Incorporate existing code, media, and libraries into original programs of increasing complexity and give attribution."
 )
 ("OK.8.AP.PD.02"
  "Incorporate existing code, media, and libraries into original programs of increasing complexity and give attribution."
 )
 ("OK.6.AP.PD.03"
  "Test and refine programs using teacher provided inputs."
 )
 ("OK.7.AP.PD.03"
  "Test and refine programs using a variety of student created inputs."
 )
 ("OK.8.AP.PD.03"
  "Systematically test and refine programs using a range of student created inputs."
 )
 ("OK.6.AP.PD.04"
  "Break down tasks and follow an individual timeline when developing a computational artifact."
 )
 ("OK.7.AP.PD.04"
  "Distribute tasks and maintain a project timeline when collaboratively developing computational artifacts."
 )
 ("OK.8.AP.PD.04"
  "Explain how effective communication between participants is required for successful collaboration when developing computational artifacts."
 )
 ("OK.6.AP.PD.05"
  "Document text-based programs in order to make them easier to follow, test, and debug."
 )
 ("OK.7.AP.PD.05"
  "Document text-based programs of increasing complexity in order to make them easier to follow, test, and debug."
 )
 ("OK.8.AP.PD.05"
  "Document text-based programs of increasing complexity in order to make them easier to follow, test, and debug."
 )
 ("OK.6.IC.C.01"
  "Explain how computing impacts people's everyday activities."
 )
 ("OK.7.IC.C.01"
  "Explain how computing impacts innovation in other fields."
 )
 ("OK.8.IC.C.01"
  "Describe the trade-offs associated with computing technologies (e.g. automation), explaining their effects on economies and global societies, and explore careers related to the field of computer science."
 )
 ("OK.6.IC.C.02"
  "Identify and discuss the technology proficiencies needed in the classroom and the workplace, and how to meet the needs of diverse users."
 )
 ("OK.7.IC.C.02"
  "Relate the distribution of computing resources in a global society to issues of equity, access, and power."
 )
 ("OK.8.IC.C.02"
  "Evaluate and improve the design of existing technologies to meet the needs of diverse users and increase accessibility and usability. Evaluate how technology can be used to distort, exaggerate, and misrepresent information."
 )
 ("OK.6.IC.SI.01"
  "Individually and collaboratively develop and conduct an online survey that seeks input from a broad audience. Describe and use safe, appropriate, and responsible practices (netiquette) when participating in online communities (e.g., discussion groups, blogs, social networking sites)."
 )
 ("OK.7.IC.SI.01"
  "Individually and collaboratively use advanced tools to design and create online content (e.g., digital portfolio, multimedia, blog, web page). Describe and use safe, appropriate, and responsible practices (netiquette) when participating in online communities (e.g., discussion groups, blogs, social networking sites)."
 )
 ("OK.8.IC.SI.01"
  "Communicate and publish key ideas and details individually or collaboratively in a way that informs, persuades, and/or entertains using a variety of digital tools and media-rich resources. Describe and use safe, appropriate, and responsible practices (netiquette) when participating in online communities (e.g., discussion groups, blogs, social networking sites)."
 )
 ("OK.6.IC.SLE.01"
  "Differentiate between appropriate and inappropriate content on the Internet, and identify unethical and illegal online behavior."
 )
 ("OK.7.IC.SLE.01"
  "Explain the connection between the longevity of data on the Internet, personal online identity, and personal privacy."
 )
 ("OK.8.IC.SLE.01"
  "Discuss the social impacts and ethical considerations associated with cybersecurity, including the positive and malicious purposes of hacking."
 )
))

