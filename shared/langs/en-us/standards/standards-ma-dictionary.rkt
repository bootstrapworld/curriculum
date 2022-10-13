#lang racket

(provide *ma-standards-list*)

(define *ma-standards-list*
  '(

    ; Massachusetts State Math Standards
    ("PK.CC.A.1"
     "Listen to and say the names of numbers in meaningful contexts."
     )
    ("PK.CC.A.2"
     "Recognize and name written numerals 0–10."
     )
    ("PK.CC.B.3"
     "Understand the relationships between numerals and quantities up to 10."
     )
    ("PK.CC.C.4"
     "Count many kinds of concrete objects and actions up to ten, using one-to-one correspondence, and accurately count as many as seven things in a scattered configuration. Recognize the “one more,” “one less” patterns."
     )
    ("PK.CC.C.5"
     "Use comparative language, such as more/less than, equal to, to compare and describe collections of objects."
     )
    ("PK.OA.A.1"
     "Use concrete objects to model real-world addition (putting together) and subtraction (taking away) problems up through five."
     )
    ("PK.MD.A.1"
     "Recognize the attributes of length, area, weight, and capacity of everyday objects using appropriate vocabulary (e.g., long, short, tall, heavy, light, big, small, wide, narrow)."
     )
    ("PK.MD.A.2"
     "Compare the attributes of length and weight for two objects, including longer/shorter, same length; heavier/lighter, same weight; holds more/less, holds the same amount."
     )
    ("PK.MD.B.3"
     "Sort, categorize, and classify objects by more than one attribute."
     )
    ("PK.MD.C.4"
     "Recognize that certain objects are coins and that dollars and coins represent money."
     )
    ("PK.G.A.1"
     "Identify relative positions of objects in space, and use appropriate language (e.g., beside, inside, next to, close to, above, below, apart)."
     )
    ("PK.G.A.2"
     "Identify various two-dimensional shapes using appropriate language."
     )
    ("PK.G.B.3"
     "Create and represent three-dimensional shapes (ball/sphere, square box/cube, tube/cylinder) using various manipulative materials (such as Popsicle sticks, blocks, pipe cleaners, pattern blocks)."
     )
    ("K.CC.A.1"
     "Count to 100 by ones and by tens."
     )
    ("K.CC.A.2"
     "Count forward beginning from a given number within the known sequence (instead of having to begin at one)."
     )
    ("K.CC.A.3"
     "Write numbers from 0 to 20. Represent a number of objects with a written numeral 0–20 (with 0 representing a count of no objects)."
     )
    ("K.CC.B.4"
     "Understand the relationship between numbers and quantities; connect counting to cardinality."
     )
    ("K.CC.B.4.a"
     "When counting objects, say the number names in the standard order, pairing each object with one and only one number name and each number name with one and only one object."
     )
    ("K.CC.B.4.b"
     "Understand that the last number name said tells the number of objects counted. The number of objects is the same regardless of their arrangement or the order in which they were counted."
     )
    ("K.CC.B.4.c"
     "Understand that each successive number name refers to a quantity that is one larger.  Recognize the one more pattern of counting using objects."
     )
    ("K.CC.B.5"
     "Count to answer 'how many?' questions about as many as 20 things arranged in a line, a rectangular array, or a circle, or as many as 10 things in a scattered configuration; given a number from 1-20, count out that many objects."
     )
    ("K.CC.C.6"
     "Identify whether the number of objects in one group is greater than, less than, or equal to the number of objects in another group for groups with up to 10 objects, e.g., by using matching and counting strategies."
     )
    ("K.CC.C.7"
     "Compare two numbers between 1 and 10 presented as written numerals."
     )
    ("K.OA.A.1"
     "Represent addition and subtraction with objects, fingers, mental images, drawings , sounds (e.g., claps), acting out situations, verbal explanations, expressions, or equations. [Note: Drawings need not show details, but should show the mathematics in the problem. (This applies wherever drawings are mentioned in the standards.)]"
     )
    ("K.OA.A.2"
     "Solve addition and subtraction word problems, and add and subtract within 10, e.g., by using objects or drawings to represent the problem."
     )
    ("K.OA.A.3"
     "Decompose numbers less than or equal to 10 into pairs in more than one way, e.g., by using objects or drawings, and record each decomposition by a drawing or equation (e.g., 5 = 2 + 3 and 5 = 4 + 1)."
     )
    ("K.OA.A.4"
     "For any number from 1 to 9, find the number that makes 10 when added to the given number, e.g., by using objects or drawings, and record the answer with a drawing or equation."
     )
    ("K.OA.A.5"
     "Fluently add and subtract within 5, including zero"
     )
    ("K.NBT.A.1"
     "Compose and decompose numbers from 11 to 19 into ten ones and some further ones, e.g., by using objects or drawings, and record each composition or decomposition by a drawing or equation (e.g., 18 = 10 + 8); understand that these numbers are composed of ten ones and one, two, three, four, five, six, seven, eight, or nine ones"
     )
    ("K.MD.A.1"
     "Describe measurable attributes of objects, such as length or weight. Describe several measurable attributes of a single object."
     )
    ("K.MD.A.2"
     "Directly compare two objects with a measurable attribute in common, to see which object has 'more of'/'less of' the attribute, and describe the difference. For example, directly compare the heights of two children and describe one child as taller/shorter."
     )
    ("K.MD.B.3"
     "Classify objects into given categories; count the numbers of objects in each category (up to and including 10) and sort the categories by count."
     )
    ("K.G.A.1"
     "Describe objects in the environment using names of shapes, and describe the relative positions of these objects using terms such as above, below, beside, in front of, behind, and next to."
     )
    ("K.G.A.2"
     "Correctly name shapes regardless of their orientations or overall size."
     )
    ("K.G.A.3"
     "Identify shapes as two-dimensional (lying in a plane, 'flat') or three-dimensional ('solid')."
     )
    ("K.G.B.4"
     "Analyze and compare two- and three-dimensional shapes, in different sizes and orientations, using informal language to describe their similarities, differences, parts (e.g., number of sides and vertices/"corners"
     ) and other attributes (e.g., having sides of equal length)."
     )
    ("K.G.B.5"
     "Model shapes in the world by building shapes from components (e.g., sticks and clay balls) and drawing shapes."
     )
    ("K.G.B.6"
     "Compose simple shapes to form larger shapes. For example, 'Can you join these two triangles with full sides touching to make a rectangle?'"
     )
    ("1.OA.A.1"
     "Use addition and subtraction within 20 to solve word problems involving situations of adding to, taking from, putting together, taking apart, and comparing, with unknowns in all positions, e.g., by using objects, drawings, and equations (number sentences) with a symbol for the unknown number to represent the problem. See Glossary, Table 1"
     )
    ("1.OA.A.2"
     "Solve word problems that call for addition of three whole numbers whose sum is less than or equal to 20, e.g., by using objects, drawings, and equations with a symbol for the unknown number to represent the problem."
     )
    ("1.OA.B.3"
     "Apply properties of operations to add. For example, when adding numbers order does not matter. If 8 + 3 = 11 is known, then 3 + 8 = 11 is also known (Commutative property of addition). To add 2 + 6 + 4, the second two numbers can be added to make a ten, so 2 + 6 + 4 = 2 + 10 = 12 (Associative property of addition). When adding zero to a number, the result is the same number (Identity property of zero for addition). [Note: Students need not use formal terms for these properties]"
     )
    ("1.OA.B.4"
     "Understand subtraction as an unknown-addend problem. For example, subtract 10 – 8 by finding the number that makes 10 when added to 8. "
     )
    ("1.OA.C.5"
     "Relate counting to addition and subtraction (e.g., by counting on 2 to add 2)."
     )
    ("1.OA.C.6"
     "Add and subtract within 20, demonstrating fluency for addition and subtraction within 10. Use mental strategies such as counting on; making 10 (e.g., 8 + 6 = 8 + 2 + 4 = 10 + 4 = 14); decomposing a number leading to a 10 (e.g., 13 – 4 = 13 – 3 – 1 = 10 – 1 = 9); using the relationship between addition and subtraction (e.g., knowing that 8 + 4 = 12, one knows 12 – 8 = 4); and creating equivalent but easier or known sums (e.g., adding 6 + 7 by creating the known equivalent 6 + 6 + 1 = 12 + 1 = 13)."
     )
    ("1.OA.D.7"
     "Understand the meaning of the equal sign, and determine if equations involving addition and subtraction are true or false."
     )
    (" For example"
     " which of the following equations are true and which are false? 6 = 6, 7 = 8 – 1, 5 + 2 = 2 + 5, 4 + 1 = 5 + 2."
     )
    ("1.OA.D.8"
     "Determine the unknown whole number in an addition or subtraction equation relating three whole numbers. "
     )
    ("1.NBT.A.1"
     "Count to 120, starting at any number less than 120. In this range, read and write numerals and represent a number of objects with a written numeral."
     )
    ("1.NBT.B.2"
     "Understand that the two digits of a two-digit number represent amounts of tens and ones. Understand the following as special cases:"
     )
    ("1.NBT.B.2.a"
     "10 can be thought of as a bundle of ten ones—called a 'ten.'"
     )
    ("1.NBT.B.2.b"
     "The numbers from 11 to 19 are composed of a ten and one, two, three, four, five, six, seven, eight, or nine ones."
     )
    ("1.NBT.B.2.c"
     "The numbers 10, 20, 30, 40, 50, 60, 70, 80, 90 refer to one, two, three, four, five, six, seven, eight, or nine tens (and 0 ones)."
     )
    ("1.NBT.B.3"
     "Compare two two-digit numbers based on meanings of the tens and ones digits, recording the results of comparisons with the symbols >, =, and <."
     )
    ("1.NBT.C.4"
     "Add within 100, including adding a two-digit number and a one-digit number, and adding a two-digit number and a multiple of 10, using concrete models or drawings and strategies based on place value, properties of operations, and/or the relationship between addition and subtraction; relate the strategy to a written method and explain the reasoning used. Understand that in adding two-digit numbers, one adds tens and tens, ones and ones; and sometimes it is necessary to compose a ten."
     )
    ("1.NBT.C.5"
     "Given a two-digit number, mentally find 10 more or 10 less than the number, without having to count; explain the reasoning used. Identify arithmetic patterns of 10 more and 10 less than using strategies based on place value."
     )
    ("1.NBT.C.6"
     "Subtract multiples of 10 in the range 10–90 from multiples of 10 in the range 10–90 (positive or zero differences), using concrete models or drawings and strategies based on place value, properties of operations, and/or the relationship between addition and subtraction; relate the strategy to a written method and explain the reasoning used."
     )
    ("1.MD.A.1"
     "Order three objects by length; compare the lengths of two objects indirectly by using a third object."
     )
    ("1.MD.A.2"
     "Express the length of an object as a whole number of length units, by laying multiple copies of a shorter object (the length unit) end to end; understand that the length measurement of an object is the number of same-size length units that span it with no gaps or overlaps. Limit to contexts where the object being measured is spanned by a whole number of length units with no gaps or overlaps."
     )
    ("1.MD.B.3"
     "Tell and write time in hours and half-hours using analog and digital clocks."
     )
    ("1.MD.C.4"
     "Organize, represent, and interpret data with up to three categories; ask and answer questions about the total number of data points, how many in each category, and how many more or less are in one category than in another."
     )
    ("1.MD.D.5"
     "Identify the values of all U.S. coins and know their comparative values (e.g., a dime is of greater value than a nickel). Find equivalent values (e.g., a nickel is equivalent to five pennies). Use appropriate notation (e.g., 69¢).  Use the values of coins in the solutions of problems (up to 100¢)."
     )
    ("1.G.A.1"
     "Distinguish between defining attributes (e.g., triangles are closed and three-sided) versus non-defining attributes (e.g., color, orientation, overall size); build and draw shapes that possess defining attributes."
     )
    ("1.G.A.2"
     "Compose two-dimensional shapes (rectangles, squares, trapezoids, triangles, half-circles, and quarter-circles) or three-dimensional shapes (cubes, right rectangular prisms, right circular cones, and right circular cylinders) to create a composite shape, and compose new shapes from the composite shape. [Note: Students do not need to learn formal names such as "right rectangular prism"]"
     )
    ("1.G.A.3"
     "Partition circles and rectangles into two and four equal shares, describe the shares using the words halves, fourths, and quarters, and use the phrases half of, fourth of, and quarter of. Describe the whole as two of, or four of the shares. Understand for these examples that decomposing into more equal shares creates smaller shares."
     )
    ("2.OA.A.1"
     "Use addition and subtraction within 100 to solve one- and two-step word problems involving situations of adding to, taking from, putting together, taking apart, and comparing, with unknowns in all positions, e.g., by using drawings and equations with a symbol for the unknown number to represent the problem. See Glossary, Table 1"
     )
    ("2.OA.B.2"
     "Fluently add and subtract within 20 using mental strategies.  By end of grade 2, know from memory all sums of two single-digit numbers and related differences. For example, the sum 6 + 5 = 11 has related differences of 11 – 5 = 6 and 11 – 6 = 5. [Note: Strategies such as counting on; making tens; decomposing a number; using the relationship between addition and subtraction; and creating equivalent but easier or known sums]"
     )
    ("2.OA.C.3"
     "Determine whether a group of objects (up to 20) has an odd or even number of members, e.g., by pairing objects or counting them by 2s; write an equation to express an even number as a sum of two equal addends."
     )
    ("2.OA.C.4"
     "Use addition to find the total number of objects arranged in rectangular arrays with up to five rows and up to five columns; write an equation to express the total as a sum of equal addends."
     )
    ("2.NBT.A.1"
     "Understand that the three digits of a three-digit number represent amounts of hundreds, tens, and ones; e.g., 706 equals 7 hundreds, 0 tens, and 6 ones. Understand the following as special cases:"
     )
    ("2.NBT.A.1.a"
     "100 can be thought of as a bundle of ten tens—called a 'hundred.'"
     )
    ("2.NBT.A.1.b"
     "The numbers 100, 200, 300, 400, 500, 600, 700, 800, 900 refer to one, two, three, four, five, six, seven, eight, or nine hundreds (and 0 tens and 0 ones)."
     )
    ("2.NBT.A.2"
     "Count within 1,000; skip-count by 5s, 10s, and 100s. Identify patterns in skip counting starting at any number."
     )
    ("2.NBT.A.3"
     "Read and write numbers to 1,000 using base-ten numerals, number names, and expanded form."
     )
    ("2.NBT.A.4"
     "Compare two three-digit numbers based on meanings of the hundreds, tens, and ones digits, using >, =, and < symbols to record the results of comparisons."
     )
    ("2.NBT.B.5"
     "Fluently add and subtract within 100 using strategies based on place value, properties of operations, and/or the relationship between addition and subtraction."
     )
    ("2.NBT.B.6"
     "Add up to four two-digit numbers using strategies based on place value and properties of operations."
     )
    ("2.NBT.B.7"
     "Add and subtract within 1,000, using concrete models or drawings and strategies based on place value, properties of operations, and/or the relationship between addition and subtraction; relate the strategy to a written method. Understand that in adding or subtracting three-digit numbers, one adds or subtracts hundreds and hundreds, tens and tens, ones and ones; and sometimes it is necessary to compose or decompose tens or hundreds."
     )
    ("2.NBT.B.8"
     "Mentally add 10 or 100 to a given number 100–900, and mentally subtract 10 or 100 from a given number 100–900."
     )
    ("2.NBT.B.9"
     "Explain why addition and subtraction strategies work, using place value and the properties of operations. [Note: Explanations may be supported by drawings or objects.]"
     )
    ("2.MD.A.1"
     "Measure the length of an object by selecting and using appropriate tools such as rulers, yardsticks, meter sticks, and measuring tapes."
     )
    ("2.MD.A.2"
     "Measure the length of an object twice, using length units of different lengths for the two measurements; describe how the two measurements relate to the size of the unit chosen."
     )
    ("2.MD.A.3"
     "Estimate lengths using units of inches, feet, centimeters, and meters."
     )
    ("2.MD.A.4"
     "Measure to determine how much longer one object is than another, expressing the length difference in terms of a standard length unit."
     )
    ("2.MD.B.5"
     "Use addition and subtraction within 100 to solve word problems involving lengths that are given in the same units, e.g., by using drawings (such as drawings of rulers) and equations with a symbol for the unknown number to represent the problem."
     )
    ("2.MD.B.6"
     "Represent whole numbers as lengths from 0 on a number line diagram with equally spaced points corresponding to the numbers 0, 1, 2, …, and represent whole-number sums and differences within 100 on a number line diagram."
     )
    ("2.MD.C.7"
     "Tell and write time from analog and digital clocks to the nearest five minutes, using a.m. and p.m."
     )
    ("2.MD.C.7.a"
     "Know the relationships of time, including seconds in a minute, minutes in an hour, hours in a day, days in a week; days in a month and a year and approximate number of weeks in a month and weeks in a year."
     )
    ("2.MD.C.8"
     "Solve word problems involving dollar bills, quarters, dimes, nickels, and pennies (up to $10), using $ and ¢ symbols appropriately and whole dollar amounts. "
     )
    ("2.MD.D.9"
     "Generate measurement data by measuring lengths of several objects to the nearest whole unit, or by making repeated measurements of the same object. Organize and record the data on a line plot (dot plot) where the horizontal scale is marked off in whole-number units."
     )
    ("2.MD.D.10"
     "Draw a picture graph and a bar graph (with single-unit scale) to represent a data set with up to four categories. Solve simple put-together, take-apart, and compare problems  using information presented in a bar graph. See Glossary, Table 1"
     )
    ("2.G.A.1"
     "Recognize and draw shapes having specified attributes, such as a given number of angles or a given number of equal faces.  Identify triangles, squares, rectangles, rhombuses, trapezoids, pentagons, hexagons, and cubes. [Note: Sizes are compared directly or visually, not compared by measuring]"
     )
    ("2.G.A.2"
     "Partition a rectangle into rows and columns of same-size squares and count to find the total number of them."
     )
    ("2.G.A.3"
     "Partition circles and rectangles into two, three, or four equal shares, describe the shares using the words halves, thirds, half of, a third of, etc., and describe the whole as two halves, three thirds, four fourths. Recognize that equal shares of identical wholes need not have the same shape."
     )
    ("3.OA.A.1"
     "Interpret products of whole numbers, e.g., interpret 5 x 7 as the total number of objects in five groups of seven objects each. For example, describe a context in which a total number of objects can be expressed as 5 x 7."
     )
    ("3.OA.A.2"
     "Interpret whole-number quotients of whole numbers, e.g., interpret 56÷8 as the number of objects in each share when 56 objects are partitioned equally into 8 shares, or as a number of shares when 56 objects are partitioned into equal shares of 8 objects each. For example, describe a context in which a number of shares or a number of groups can be expressed as 56÷ 8."
     )
    ("3.OA.A.3"
     "Use multiplication and division within 100 to solve word problems in situations involving equal groups, arrays, and measurement quantities, e.g., by using drawings and equations with a symbol for the unknown number to represent the problem. See Glossary, Table 2"
     )
    ("3.OA.A.4"
     "Determine the unknown whole number in a multiplication or division equation relating three whole numbers. For example, determine the unknown number that makes the equation true in each of the equations 8 x? = 48, 5 =? ÷ 3, 6 x 6 = ?. "
     )
    ("3.OA.B.5"
     "Apply properties of operations to multiply. For example: When multiplying numbers order does not matter. If 6 x 4 = 24 is known, then 4 x 6 = 24 is also known (Commutative property of multiplication); The product 3 x 5 x 2 can be found by 3 x 5 = 15 then 15 x 2 = 30, or by 5 x 2 = 10 then 3 x 10 = 30 (Associative property of multiplication); When multiplying two numbers either number can be decomposed and multiplied; one can find 8 x 7 by knowing that 7 = 5 + 2 and that 8 x 5 = 40 and 8 x 2 = 16, resulting in 8 x (5 + 2) = (8 x 5) + (8 x 2) = 40 + 16 = 56 (Distributive property); When a number is multiplied by 1 the result is the same number (Identity property of 1 for multiplication). [Note: Students need not use formal terms for these properties. Students are not expected to use distributive notation]"
     )
    ("3.OA.B.6"
     "Understand division as an unknown-factor problem. For example, find 32÷ 8 by finding the number that makes 32 when multiplied by 8."
     )
    ("3.OA.C.7"
     "Fluently multiply and divide within 100, using strategies such as the relationship between multiplication and division (e.g., knowing that 8 x 5 = 40, one knows 40 ÷ 5 = 8) or properties of operations. By the end of grade 3, know from memory all products of two single-digit numbers and related division facts. For example, the product 4 x 7 = 28 has related division facts 28 ÷ 7 = 4 and 28 ÷ 4 = 7."
     )
    ("3.OA.D.8"
     "Solve two-step word problems using the four operations for problems posed with whole numbers and having whole number answers. Represent these problems using equations with a letter standing for the unknown quantity. Assess the reasonableness of answers using mental computation and estimation strategies, including rounding. [Note: Students should know how to perform operations in the conventional order when there are no parentheses to specify a particular order (Order of Operations)]"
     )
    ("3.OA.D.9"
     "Identify arithmetic patterns (including patterns in the addition table or multiplication table), and explain them using properties of operations. For example, observe that 4 times a number is always even, and explain why 4 times a number can be decomposed into two equal addends."
     )
    ("3.NBT.A.1"
     "Use place value understanding to round whole numbers to the nearest 10 or 100. [Note: A range of algorithms may be used.]"
     )
    ("3.NBT.A.2"
     "Fluently add and subtract within 1,000 using strategies and algorithms based on place value, properties of operations, and/or the relationship between addition and subtraction. [Note: A range of algorithms may be used.]"
     )
    ("3.NBT.A.3"
     "Multiply one-digit whole numbers by multiples of 10 in the range 10–90 (e.g., 9 x 80, 5 x 60) using strategies based on place value and properties of operations. [Note: A range of algorithms may be used.]"
     )
    ("3.NF.A.1"
     "Understand a fraction 1/b as the quantity formed by 1 part when a whole (a single unit) is partitioned into b equal parts; understand a fraction a/b as the quantity formed by a parts of size 1/b."
     )
    ("3.NF.A.2"
     "Understand a fraction as a number on the number line; represent fractions on a number line diagram."
     )
    ("3.NF.A.2.a"
     "Represent a unit fraction, 1/b, on a number line diagram by defining the interval from 0 to 1 as the whole and partitioning it into b equal parts. Recognize that each part has size 1/b and that the fraction 1/b is located 1/b of a whole unit from 0 on the number line."
     )
    ("3.NF.A.2.b"
     "Represent a fraction a/b on a number line diagram by marking off a lengths 1/b from 0. Recognize that the resulting interval has size a/b and that its endpoint locates the number a/b on the number line."
     )
    ("3.NF.A.3"
     "Explain equivalence of fractions in special cases, and compare fractions by reasoning about their size. [Note: Grade 3 expectations in this domain are limited to fractions with denominators 2, 3, 4, 6, and 8.]"
     )
    ("3.NF.A.3.a"
     "Understand two fractions as equivalent (equal) if they are the same size, or the same point on a number line."
     )
    ("3.NF.A.3.b"
     "Recognize and generate simple equivalent fractions, e.g., 1/2 = 2/4, 4/6 = 2/3. Explain why the fractions are equivalent, e.g., by using a visual fraction model."
     )
    ("3.NF.A.3.c"
     "Express whole numbers as fractions, and recognize fractions that are equivalent to whole numbers. For example, express 3 in the form 3 = 3/1; recognize that 6/1 = 6; locate 4/4 and 1 at the same point of a number line diagram."
     )
    ("3.NF.A.3.d"
     "Compare two fractions with the same numerator or the same denominator by reasoning about their size. Recognize that comparisons are valid only when the two fractions refer to the same whole. Record the results of comparisons with the symbols >, =, or <, and justify the conclusions, e.g., by using a visual fraction model."
     )
    ("3.MD.A.1"
     "Tell and write time to the nearest minute and measure time intervals in minutes. Solve word problems involving addition and subtraction of time intervals in minutes, e.g., by representing the problem on a number line diagram."
     )
    ("3.MD.A.2"
     "Measure and estimate liquid volumes and masses of objects using standard metric units of grams (g), kilograms (kg), and liters (l).  Add, subtract, multiply, or divide to solve one-step word problems involving masses or volumes that are given in the same metric units, e.g., by using drawings (such as a beaker with a measurement scale) to represent the problem. [Note: Excludes compound units such as cm3 and finding the geometric volume of a container. Excludes multiplicative comparison problems (problems involving notions of “times as much”; Glossary, Table 2).]"
     )
    ("3.MD.B.3"
     "Draw a scaled picture graph and a scaled bar graph to represent a data set with several categories. Solve one- and two-step 'how many more' and 'how many less' problems using information presented in scaled bar graphs. For example, draw a bar graph in which each square in the bar graph might represent 5 pets."
     )
    ("3.MD.B.4"
     "Generate measurement data by measuring lengths of objects using rulers marked with halves and fourths of an inch. Record and show the data by making a line plot (dot plot), where the horizontal scale is marked off in appropriate units—whole numbers, halves, or fourths. (See Glossary for example.)"
     )
    ("3.MD.C.5"
     "Recognize area as an attribute of plane figures and understand concepts of area measurement."
     )
    ("3.MD.C.5.a"
     "A square with side length one unit, called 'a unit square,'' is said to have 'one square unit' of area, and can be used to measure area."
     )
    ("3.MD.C.5.b"
     "A plane figure which can be covered without gaps or overlaps by n unit squares is said to have an area of n square units."
     )
    ("3.MD.C.6"
     "Measure areas by counting unit squares (square cm, square m, square in., square ft., and non-standard units)."
     )
    ("3.MD.C.7"
     "Relate area to the operations of multiplication and addition."
     )
    ("3.MD.C.7.a"
     "Find the area of a rectangle with whole-number side lengths by tiling it, and show that the area is the same as would be found by multiplying the side lengths."
     )
    ("3.MD.C.7.b"
     "Multiply side lengths to find areas of rectangles with whole-number side lengths in the context of solving real world and mathematical problems, and represent whole-number products as rectangular areas in mathematical reasoning."
     )
    ("3.MD.C.7.c"
     "Use tiling to show in a concrete case that the area of a rectangle with whole-number side lengths a and b + c is the sum of ax b and ax c. Use area models to represent the distributive property in mathematical reasoning."
     )
    ("3.MD.C.7.d"
     "Recognize area as additive. Find areas of rectilinear figures by decomposing them into non-overlapping rectangles and adding the areas of the non-overlapping parts, applying this technique to solve real-world problems."
     )
    ("3.MD.D.8"
     "Solve real-world and mathematical problems involving perimeters of polygons, including finding the perimeter given the side lengths, finding an unknown side length, and exhibiting rectangles with the same perimeter and different areas or with the same area and different perimeters."
     )
    ("3.G.A.1"
     "Understand that shapes in different categories (e.g., rhombuses, rectangles, and others) may share attributes (e.g., having four sides), and that the shared attributes can define a larger category (e.g., quadrilaterals). Compare and classify shapes by their sides and angles (right angle/non-right angle). Recognize rhombuses, rectangles, squares, and trapezoids as examples of quadrilaterals, and draw examples of quadrilaterals that do not belong to any of these subcategories."
     )
    ("3.G.A.2"
     "Partition shapes into parts with equal areas. Express the area of each part as a unit fraction of the whole. For example, partition a shape into 4 parts with equal areas, and describe the area of each part as 1/4 of the area of the shape."
     )
    ("4.OA.A.1"
     "Interpret a multiplication equation as a comparison, e.g., interpret 35 = 5 x 7 as a statement that 35 is 5 times as many as 7 and 7 times as many as 5. Represent verbal statements of multiplicative comparisons as multiplication equations."
     )
    ("4.OA.A.2"
     "Multiply or divide to solve word problems involving multiplicative comparison, e.g., by using drawings and equations with a symbol for the unknown number to represent the problem, distinguishing multiplicative comparison from additive comparison. [Note: See Glossary, Table 2.]"
     )
    ("4.OA.A.3"
     "Solve multistep word problems posed with whole numbers and having whole-number answers using the four operations, including problems in which remainders must be interpreted. Represent these problems using equations with a letter standing for the unknown quantity. Assess the reasonableness of answers using mental computation and estimation strategies including rounding."
     )
    ("4.OA.A.3.a"
     "Know multiplication facts and related division facts through 12 x 12"
     )
    ("4.OA.B.4"
     "Find all factor pairs for a whole number in the range 1–100. Recognize that a whole number is a multiple of each of its factors. Determine whether a given whole number in the range 1–100 is a multiple of a given one-digit number. Determine whether a given whole number in the range 1–100 is prime or composite."
     )
    ("4.OA.C.5"
     "Generate a number or shape pattern that follows a given rule. Identify apparent features of the pattern that were not explicit in the rule itself. For example, given the rule “Add 3” and the starting number 1, generate terms in the resulting sequence and observe that the terms appear to alternate between odd and even numbers. Explain informally why the numbers will continue to alternate in this way."
     )
    ("4.NBT.A.1"
     "Recognize that in a multi-digit whole number, a digit in any place represents 10 times as much as it represents in the place to its right. "
     )
    ("4.NBT.A.2"
     "Read and write multi-digit whole numbers using base-ten numerals, number names, and expanded form. Compare two multi-digit numbers based on meanings of the digits in each place, using >, =, and < symbols to record the results of comparisons.[Note: Grade 4 expectations in this domain are limited to whole numbers less than or equal to 1,000,000.]"
     )
    ("4.NBT.A.3"
     "Use place value understanding to round multi-digit whole numbers to any place."
     )
    ("4.NBT.B.4"
     "Fluently add and subtract multi-digit whole numbers using the standard algorithm."
     )
    ("4.NBT.B.5"
     "Multiply a whole number of up to four digits by a one-digit whole number, and multiply two two-digit numbers, using strategies based on place value and the properties of operations. Illustrate and explain the calculation by using equations, rectangular arrays, and/or area models."
     )
    ("4.NBT.B.6"
     "Find whole-number quotients and remainders with up to four-digit dividends and one-digit divisors, using strategies based on place value, the properties of operations, and/or the relationship between multiplication and division. Illustrate and explain the calculation by using equations, rectangular arrays, and/or area models."
     )
    ("4.NF.A.1"
     "Explain why a fraction a/b is equivalent to a fraction (n x a)/(n x b) by using visual fraction models, with attention to how the numbers and sizes of the parts differ even though the two fractions themselves are the same size. Use this principle to recognize and generate equivalent fractions, including fractions greater than 1."
     )
    ("4.NF.A.2"
     "Compare two fractions with different numerators and different denominators, e.g., by creating common denominators or numerators, or by comparing to a benchmark fraction such as 1/2. Recognize that comparisons are valid only when the two fractions refer to the same whole. Record the results of comparisons with symbols >, =, or <, and justify the conclusions, e.g., by using a visual fraction model."
     )
    ("4.NF.B.3"
     "Understand a fraction a/b with a > 1 as a sum of fractions 1/b.[Note: Grade 4 expectations in this domain are limited to fractions with denominators 2,3,4,5,6,8,10, 12, and 100.]"
     )
    ("4.NF.B.3.a"
     "a. Understand addition and subtraction of fractions as joining and separating parts referring to the same whole. (The whole can be a set of objects.)"
     )
    ("4.NF.B.3.b"
     "Decompose a fraction into a sum of fractions with the same denominator in more than one way, recording each decomposition by an equation. Justify decompositions, e.g., by using drawings or visual fraction models. Examples: 3/8 = 1/8 + 1/8 + 1/8 ; 3/8 = 1/8 + 2/8 ; 2 1/8 = 1 + 1 + 1/8 = 8/8 + 8/8 + 1/8."
     )
    ("4.NF.B.3.c"
     "Add and subtract mixed numbers with like denominators, e.g., by replacing each mixed number with an equivalent fraction, and/or by using properties of operations and the relationship between addition and subtraction."
     )
    ("4.NF.B.3.d"
     "Solve word problems involving addition and subtraction of fractions referring to the same whole and having like denominators, e.g., by using drawings or visual fraction models and equations to represent the problem."
     )
    ("4.NF.B.4"
     "Apply and extend previous understandings of multiplication to multiply a fraction by a whole number."
     )
    ("4.NF.B.4.a"
     "Understand a fraction a/b as a multiple of 1/b. For example, use a visual fraction model to represent 5/4 as the product 5 x (1/4), recording the conclusion by the equation 5/4 = 5 x (1/4)."
     )
    ("4.NF.B.4.b"
     "Understand a multiple of a/b as a multiple of 1/b, and use this understanding to multiply a fraction by a whole number. For example, use a visual fraction model to express 3 x (2/5) as 6 x (1/5), recognizing this product as 6/5. (In general, n x (a/b) = (n x a)/b.)"
     )
    ("4.NF.B.4.c"
     "Solve word problems involving multiplication of a fraction by a whole number, e.g., by using visual fraction models and equations to represent the problem. For example, if each person at a party will eat 3/8 of a pound of roast beef, and there will be 5 people at the party, how many pounds of roast beef will be needed? Between what two whole numbers does your answer lie?"
     )
    ("4.NF.C.5"
     "Express a fraction with denominator 10 as an equivalent fraction with denominator 100, and use this technique to add two fractions with respective denominators 10 and 100. For example, express 3/10 as 30/100, and add 3/10 + 4/100 = 34/100."
     )
    ("4.NF.C.6"
     "Use decimal notation to represent fractions with denominators 10 or 100. "
     )
    ("4.NF.C.7"
     "Compare two decimals to hundredths by reasoning about their size. Recognize that comparisons are valid only when the two decimals refer to the same whole. Record the results of comparisons with the symbols >, =, or <, and justify the conclusions, e.g., by using a visual model."
     )
    ("4.MD.A.1"
     "Know relative sizes of measurement units within one system of units including km, m, cm; kg, g; lb, oz.; l, ml; hr, min, sec. Within a single system of measurement, express measurements in a larger unit in terms of a smaller unit. Record measurement equivalents in a two-column table. For example, know that 1 ft is 12 times as long as 1 in. Express the length of a 4 ft snake as 48 in. Generate a conversion table for feet and inches listing the number pairs (1, 12), (2, 24), (3, 36), …"
     )
    ("4.MD.A.2"
     "Use the four operations to solve word problems involving distances, intervals of time, liquid volumes, masses of objects, and money, including problems involving simple fractions or decimals, and problems that require expressing measurements given in a larger unit in terms of a smaller unit. Represent measurement quantities using diagrams such as number line diagrams that feature a measurement scale."
     )
    ("4.MD.A.3"
     "Apply the area and perimeter formulas for rectangles in real-world and mathematical problems."
     )
    ("4.MD.B.4"
     "Make a line plot (dot plot) representation to display a data set of measurements in fractions of a unit (1/2, 1/4, 1/8). Solve problems involving addition and subtraction of fractions by using information presented in line plots (dot plots)."
     )
    ("4.MD.C.5"
     "Recognize angles as geometric shapes that are formed wherever two rays share a common endpoint, and understand concepts of angle measurement:"
     )
    ("4.MD.C.5.a"
     "An angle is measured with reference to a circle with its center at the common endpoint of the rays, by considering the fraction of the circular arc between the points where the two rays intersect the circle. An angle that turns through 1/360 of a circle is called a “one-degree angle,” and can be used to measure angles."
     )
    ("4.MD.C.5.b"
     "An angle that turns through n one-degree angles is said to have an angle measure of n degrees."
     )
    ("4.MD.C.6"
     "Measure angles in whole-number degrees using a protractor. Sketch angles of specified measure."
     )
    ("4.MD.C.7"
     "Recognize angle measure as additive. When an angle is decomposed into non-overlapping parts, the angle measure of the whole is the sum of the angle measures of the parts. Solve addition and subtraction problems to find unknown angles on a diagram in real world and mathematical problems, e.g., by using an equation with a symbol for the unknown angle measure."
     )
    ("4.G.A.1"
     "Draw points, lines, line segments, rays, angles (right, acute, obtuse), and perpendicular and parallel lines. Identify these in two-dimensional figures."
     )
    ("4.G.A.2"
     "Classify two-dimensional figures based on the presence or absence of parallel or perpendicular lines, or the presence or absence of angles of a specified size. Recognize right triangles as a category, and identify right triangles."
     )
    ("4.G.A.3"
     "Recognize a line of symmetry for a two-dimensional figure as a line across the figure such that the figure can be folded along the line into matching parts. Identify line-symmetric figures and draw lines of symmetry."
     )
    ("5.OA.A.1"
     "Use parentheses, brackets, or braces in numerical expressions, and evaluate expressions with these symbols, e.g.,(6 x 30) + (6 x 1/2)."
     )
    ("5.OA.A.2"
     "Write simple expressions that record calculations with numbers, and interpret numerical expressions without evaluating them. For example, express the calculation “add 8 and 7, then multiply by 2” as 2x (8 + 7). Recognize that 3x (18932 + 921) is three times as large as 18932 + 921, without having to calculate the indicated sum or product."
     )
    ("5.OA.B.3"
     "Generate two numerical patterns using two given rules. Identify apparent relationships between corresponding terms. Form ordered pairs consisting of corresponding terms from the two patterns, and graph the ordered pairs on a coordinate plane. For example, given the rule “Add 3” and the starting number 0, and given the rule “Add 6” and the starting number 0, generate terms in the resulting sequences, and observe that the terms in one sequence are twice the corresponding terms in the other sequence. Explain informally why this is so."
     )
    ("5.NBT.A.1"
     "Recognize that in a multi-digit number, including decimals, a digit in any place represents 10 times as much as it represents in the place to its right and 1/10 of what it represents in the place to its left."
     )
    ("5.NBT.A.2"
     "Explain patterns in the number of zeros of the product when multiplying a number by powers of 10, and explain patterns in the placement of the decimal point when a decimal is multiplied or divided by a power of 10. Use whole-number exponents to denote powers of 10."
     )
    ("5.NBT.A.3"
     "Read, write, and compare decimals to thousandths."
     )
    ("5.NBT.A.3.a"
     "Read and write decimals to thousandths using base-ten numerals, number names, and expanded form, e.g., 347.392 = 3 x 100 + 4 x 10 + 7 x 1 + 3 x (1/10) + 9 x (1/100) + 2 x (1/1000)."
     )
    ("5.NBT.A.3.b"
     "Compare two decimals to thousandths based on meanings of the digits in each place, using >, =, and < symbols to record the results of comparisons."
     )
    ("5.NBT.A.4"
     "Use place value understanding to round decimals to any place."
     )
    ("5.NBT.B.5"
     "Fluently multiply multi-digit whole numbers. (Include two-digit x four-digit numbers and, three-digit x three-digit numbers) using the standard algorithm."
     )
    ("5.NBT.B.6"
     "Find whole-number quotients of whole numbers with up to four-digit dividends and two-digit divisors, using strategies based on place value, the properties of operations, and/or the relationship between multiplication and division. Illustrate and explain the calculation by using equations, rectangular arrays, and/or area models."
     )
    ("5.NBT.B.7"
     "Add, subtract, multiply, and divide decimals to hundredths, using concrete models or drawings and strategies based on place value, properties of operations, and/or the relationship between addition and subtraction and between multiplication and division; relate the strategy to a written method and explain the reasoning used."
     )
    ("5.NF.A.1"
     "Add and subtract fractions with unlike denominators (including mixed numbers) by replacing given fractions with equivalent fractions in such a way as to produce an equivalent sum or difference of fractions with like denominators. For example, 2/3 + 5/4 = 8/12 + 15/12 = 23/12. (In general, a/b + c/d = (ad + bc)/bd.)"
     )
    ("5.NF.A.2"
     "Solve word problems involving addition and subtraction of fractions referring to the same whole (the whole can be a set of objects), including cases of unlike denominators, e.g., by using visual fraction models or equations to represent the problem. Use benchmark fractions and number sense of fractions to estimate mentally and assess the reasonableness of answers."
     )
    ("5.NF.B.3"
     "Interpret a fraction as division of the numerator by the denominator (a/b = a÷ b). Solve word problems involving division of whole numbers leading to answers in the form of fractions or mixed numbers, e.g., by using visual fraction models or equations to represent the problem. For example, interpret 3/4 as the result of dividing 3 by 4, noting that 3/4 multiplied by 4 equals 3, and that when 3 wholes are shared equally among 4 people each person has a share of size 3/4. If 9 people want to share a 50-pound sack of rice equally by weight, how many pounds of rice should each person get? Between what two whole numbers does your answer lie?"
     )
    ("5.NF.B.4"
     "Apply and extend previous understandings of multiplication to multiply a fraction or whole number by a fraction."
     )
    ("5.NF.B.4.a"
     "Interpret the product (a/b) × q as a parts of a partition of q into b equal parts; equivalently, as the result of a sequence of operations a × q ÷ b. "
     )
    ("5.NF.B.4.b"
     "Find the area of a rectangle with fractional side lengths by tiling it with unit squares of the appropriate unit fraction side lengths, and show that the area is the same as would be found by multiplying the side lengths. Multiply fractional side lengths to find areas of rectangles, and represent fraction products as rectangular areas."
     )
    ("5.NF.B.5"
     "Interpret multiplication as scaling (resizing), by:"
     )
    ("5.NF.B.5.a"
     "Comparing the size of a product to the size of one factor on the basis of the size of the other factor, without performing the indicated multiplication. For example, without multiplying tell which number is greater: 225 or ¾ x 225; 11/50 or 3/2 x 11/50?"
     )
    ("5.NF.B.5.b"
     "Explaining why multiplying a given number by a fraction greater than 1 results in a product greater than the given number (recognizing multiplication by whole numbers greater than 1 as a familiar case); explaining why multiplying a given number by a fraction less than 1 results in a product smaller than the given number; and relating the principle of fraction equivalence a/b = (n x a)/(n x b) to the effect of multiplying a/b by 1."
     )
    ("5.NF.B.6"
     "Solve real-world problems involving multiplication of fractions and mixed numbers, e.g., by using visual fraction models or equations to represent the problem."
     )
    ("5.NF.B.7"
     "Apply and extend previous understandings of division to divide unit fractions by whole numbers and whole numbers by unit fractions. [Note: Students able to multiply fractions in general can develop strategies to divide fractions in general, by reasoning about the relationship between multiplication and division. But division of a fraction by a fraction is not a requirement at this grade.]"
     )
    ("5.NF.B.7.a"
     "Interpret division of a unit fraction by a non-zero whole number, and compute such quotients. For example, create a story context for (1/3) ÷ 4, and use a visual fraction model to show the quotient. Use the relationship between multiplication and division to explain that (1/3) ÷ 4 = 1/12 because (1/12)x 4 = 1/3."
     )
    ("5.NF.B.7.b"
     "Interpret division of a whole number by a unit fraction, and compute such quotients. For example, create a story context for 4 ÷ (1/5), and use a visual fraction model to show the quotient. Use the relationship between multiplication and division to explain that 4 ÷ (1/5) = 20 because 20 x (1/5) = 4."
     )
    ("5.NF.B.7.c"
     "Solve real-world problems involving division of unit fractions by non-zero whole numbers and division of whole numbers by unit fractions, e.g., by using visual fraction models and equations to represent the problem. For example, how much chocolate will each person get if 3 people share 1/2 lb of chocolate equally? How many 1/3-cup servings are in 2 cups of raisins?"
     )
    ("5.MD.A.1"
     "Convert among different-sized standard measurement units within a given measurement system (e.g., convert 5 cm to 0.05 m), and use these conversions in solving multi-step, real world problems."
     )
    ("5.MD.B.2"
     "Make a line plot (dot plot) to display a data set of measurements in fractions of a unit. Use operations on fractions for this grade to solve problems involving information presented in line plot (dot plot). "
     )
    ("5.MD.C.3"
     "Recognize volume as an attribute of solid figures and understand concepts of volume measurement."
     )
    ("5.MD.C.3.a"
     "A cube with side length 1 unit, called a 'unit cube,' is said to have 'one cubic unit' of volume, and can be used to measure volume."
     )
    ("5.MD.C.3.b"
     "A solid figure which can be packed without gaps or overlaps using n unit cubes is said to have a volume of n cubic units."
     )
    ("5.MD.C.4"
     "Measure volumes by counting unit cubes, using cubic cm, cubic in., cubic ft., and non-standard units."
     )
    ("5.MD.C.5"
     "Relate volume to the operations of multiplication and addition and solve real-world and mathematical problems involving volume."
     )
    ("5.MD.C.5.a"
     "Find the volume of a right rectangular prism with whole-number edge lengths by packing it with unit cubes, and show that the volume is the same as would be found by multiplying the edge lengths, equivalently by multiplying the height by the area of the base. Represent threefold whole-number products as volumes, e.g., to represent the associative property of multiplication."
     )
    ("5.MD.C.5.b"
     "Apply the formula V = l × w × h and V = B × h (where B stands for the area of the base) for rectangular prisms to find volumes of right rectangular prisms with whole-number edge lengths in the context of solving real-world and mathematical problems."
     )
    ("5.MD.C.5.c"
     "Recognize volume as additive. Find volumes of solid figures composed of two non-overlapping right rectangular prisms by adding the volumes of the non-overlapping parts, applying this technique to solve real-world problems."
     )
    ("5.G.A.1"
     "Use a pair of perpendicular number lines, called axes, to define a coordinate system, with the intersection of the lines (the origin) arranged to coincide with the 0 on each line and a given point in the plane located by using an ordered pair of numbers, called its coordinates. Understand that the first number indicates how far to travel from the origin in the direction of one axis, and the second number indicates how far to travel in the direction of the second axis, with the convention that the names of the two axes and the coordinates correspond (e.g., x-axis and x-coordinate, y-axis and y-coordinate)."
     )
    ("5.G.A.2"
     "Represent real world and mathematical problems by graphing points in the first quadrant of the coordinate plane, and interpret coordinate values of points in the context of the situation."
     )
    ("5.G.B.3"
     "Understand that attributes belonging to a category of two-dimensional figures also belong to all subcategories of that category. For example, all rectangles have four right angles and squares are rectangles, so all squares have four right angles."
     )
    ("5.G.B.4"
     "Classify two-dimensional figures in a hierarchy based on properties. "
     )
    ("6.RP.A.1"
     "Understand the concept of a ratio including the distinctions between part:part and part:whole and the value of a ratio; part/part and part/whole. Use ratio language to describe a ratio relationship between two quantities. "
     )
    ("6.RP.A.2"
     "Understand the concept of a unit rate a/b associated with a ratio a:b with b ≠ 0, and use rate language in the context of a ratio relationship, including the use of units. "
     )
    ("6.RP.A.3"
     "Use ratio and rate reasoning to solve real-world and mathematical problems, e.g., by reasoning about tables of equivalent ratios, tape diagrams, double number line diagrams, or equations."
     )
    ("6.RP.A.3.a"
     "Make tables of equivalent ratios relating quantities with whole-number measurements, find missing values in the tables, and plot the pairs of values on the coordinate plane. Use tables to compare ratios."
     )
    ("6.RP.A.3.b"
     "Solve unit rate problems including those involving unit pricing and constant speed. For example, if it took 7 hours to mow 4 lawns, then at that rate, how many lawns could be mowed in 35 hours? At what rate were lawns being mowed."
     )
    ("6.RP.A.3.c"
     "Find a percent of a quantity as a rate per 100 (e.g., 30% of a quantity means 30/100 times the quantity); solve problems involving finding the whole, given a part and the percent."
     )
    ("6.RP.A.3.d"
     "Use ratio reasoning to convert measurement units within and between measurement systems; manipulate and transform units appropriately when multiplying or dividing quantities. "
     )
    ("6.RP.A.3.e"
     "Solve problems that relate the mass of an object to its volume."
     )
    ("6.NS.A.1"
     "Interpret and compute quotients of fractions, and solve word problems involving division of fractions by fractions, e.g., by using visual fraction models and equations to represent the problem. For example, create a story context for (2/3) ÷ (3/4) and use a visual fraction model to show the quotient; use the relationship between multiplication and division to explain that (2/3) ÷ (3/4) = 8/9 because 3/4 of 8/9 is 2/3. (In general, (a/b) ÷ (c/d) = ad/bc.) How much chocolate will each person get if 3 people share 1/2 lb of chocolate equally? How many 3/4-cup servings are in 2/3 of a cup of yogurt? How wide is a rectangular strip of land with length 3/4 mi and area 1/2 square mi?"
     )
    ("6.NS.B.2"
     "Fluently divide multi-digit numbers using the standard algorithm."
     )
    ("6.NS.B.3"
     "Fluently add, subtract, multiply, and divide multi-digit decimals using the standard algorithm for each operation."
     )
    ("6.NS.B.4"
     "Use prime factorization to find the greatest common factor of two whole numbers less than or equal to 100 and the least common multiple of two whole numbers less than or equal to 12. Use the distributive property to express a sum of two whole numbers 1–100 with a common factor as a multiple of a sum of two relatively prime numbers. "
     )
    ("6.NS.C.5"
     "Understand that positive and negative numbers are used together to describe quantities having opposite directions or values (e.g., temperature above/below zero, elevation above/below sea level, credits/debits, and positive/negative electric charge). Use positive and negative numbers (whole numbers, fractions, and decimals) to represent quantities in real-world contexts, explaining the meaning of zero in each situation."
     )
    ("6.NS.C.6"
     "Understand a rational number as a point on the number line. Extend number line diagrams and coordinate axes familiar from previous grades to represent points on the line and in the plane with negative number coordinates."
     )
    ("6.NS.C.6.a"
     "Recognize opposite signs of numbers as indicating locations on opposite sides of 0 on the number line; recognize that the opposite of the opposite of a number is the number itself, e.g., –(–3) = 3, and that 0 is its own opposite."
     )
    ("6.NS.C.6.b"
     "Understand signs of numbers in ordered pairs as indicating locations in quadrants of the coordinate plane; recognize that when two ordered pairs differ only by signs, the locations of the points are related by reflections across one or both axes."
     )
    ("6.NS.C.6.c"
     "Find and position integers and other rational numbers on a horizontal or vertical number line diagram; find and position pairs of integers and other rational numbers on a coordinate plane."
     )
    ("6.NS.C.7"
     "Understand ordering and absolute value of rational numbers."
     )
    ("6.NS.C.7.a"
     "Interpret statements of inequality as statements about the relative position of two numbers on a number line diagram. For example, interpret –3 > –7 as a statement that –3 is located to the right of –7 on a number line oriented from left to right."
     )
    ("6.NS.C.7.b"
     "Write, interpret, and explain statements of order for rational numbers in real-world contexts. For example, write –3 °C > –7 °C to express the fact that –3 °C is warmer than –7°C."
     )
    ("6.NS.C.7.c"
     "Understand the absolute value of a rational number as its distance from 0 on the number line; interpret absolute value as magnitude for a positive or negative quantity in a real-world situation. For example, for an account balance of –30 dollars, write |–30| = 30 to describe the size of the debt in dollars."
     )
    ("6.NS.C.7.d"
     "Distinguish comparisons of absolute value from statements about order. For example, recognize that an account balance less than –30 dollars represents a debt greater than 30 dollars."
     )
    ("6.NS.C.8"
     "Solve real-world and mathematical problems by graphing points in all four quadrants of the coordinate plane. Include use of coordinates and absolute value to find distances between points with the same first coordinate or the same second coordinate."
     )
    ("6.EE.A.1"
     "Write and evaluate numerical expressions involving whole-number exponents."
     )
    ("6.EE.A.2"
     "Write, read, and evaluate expressions in which letters stand for numbers."
     )
    ("6.EE.A.2.a"
     "Write expressions that record operations with numbers and with letters standing for numbers. For example, express the calculation "Subtract y from 5" as 5 – y."
     )
    ("6.EE.A.2.b"
     "Identify parts of an expression using mathematical terms (sum, term, product, factor, quotient, coefficient); view one or more parts of an expression as a single entity. For example, describe the expression 2(8 + 7) as a product of two factors; view (8 + 7) as both a single entity and a sum of two terms."
     )
    ("6.EE.A.2.c"
     "Evaluate expressions at specific values of their variables. Include expressions that arise from formulas used in real-world problems. Perform arithmetic operations, including those involving whole-number exponents, in the conventional order when there are no parentheses to specify a particular order (Order of Operations). For example, use the formulas V = s³ and A = 6 s² to find the volume and surface area of a cube with sides of length s = 1/2."
     )
    ("6.EE.A.3"
     "Apply the properties of operations to generate equivalent expressions. For example, apply the distributive property to the expression 3(2 + x) to produce the equivalent expression 6 + 3x; apply the distributive property to the expression 24x + 18y to produce the equivalent expression 6(4x + 3y); apply properties of operations to y + y + y to produce the equivalent expression 3y."
     )
    ("6.EE.A.4"
     "Identify when two expressions are equivalent (i.e., when the two expressions name the same number regardless of which value is substituted into them). For example, the expressions y + y + y and 3y are equivalent because they name the same number regardless of which number y stands for."
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
     "Write an inequality of the form x > c or x < c to represent a constraint or condition in a real-world or mathematical prob-lem. Recognize that inequalities of the form x > c or x < c have infinitely many solutions; represent solutions of such in-equalities on number line diagrams."
     )
    ("6.EE.C.9"
     "Use variables to represent two quantities in a real-world problem that change in relationship to one another; write an equation to express one quantity, thought of as the dependent variable, in terms of the other quantity, thought of as the independent variable. Analyze the relationship between the dependent and independent variables using graphs and tables, and relate these to the equation. For example, in a problem involving motion at constant speed, list and graph ordered pairs of distances and times, and write the equation d = 65t to represent the relationship between distance and time."
     )
    ("6.G.A.1"
     "Find the area of right triangles, other triangles, special quadrilaterals, and polygons by composing into rectangles or decomposing into triangles and other shapes; apply these techniques in the context of solving real-world and mathematical problems."
     )
    ("6.G.A.2"
     "Find the volume of a right rectangular prism with fractional edge lengths by packing it with unit cubes of the appropriate unit fraction edge lengths, and show that the volume is the same as would be found by multiplying the edge lengths of the prism. Apply the formulas V = lwh and V = Bh to find volumes of right rectangular prisms with fractional edge lengths in the context of solving real-world and mathematical problems."
     )
    ("6.G.A.3"
     "Draw polygons in the coordinate plane given coordinates for the vertices; use coordinates to find the length of a side joining points with the same first coordinate or the same second coordinate. Apply these techniques in the context of solving real-world and mathematical problems."
     )
    ("6.G.A.4"
     "Represent three-dimensional figures using nets made up of rectangles and triangles, and use the nets to find the surface area of these figures. Apply these techniques in the context of solving real-world and mathematical problems."
     )
    ("6.SP.A.1"
     "Recognize a statistical question as one that anticipates variability in the data related to the question and accounts for it in the answers. For example, "How old am I?" is not a statistical question, but "How old are the students in my school?" is a statistical question because one anticipates variability in students’ ages."
     )
    ("6.SP.A.2"
     "Understand that a set of data collected to answer a statistical question has a distribution, which can be described by its center (median, mean, and/or mode), spread (range, interquartile range), and overall shape."
     )
    ("6.SP.A.3"
     "Recognize that a measure of center for a numerical data set summarizes all of its values with a single number, while a measure of variation describes how its values vary with a single number."
     )
    ("6.SP.B.4"
     "Display numerical data in plots on a number line, including dot plots, histograms, and box plots."
     )
    ("6.SP.B.4.a"
     "Read and interpret circle graphs."
     )
    ("6.SP.B.5"
     "Summarize numerical data sets in relation to their context, such as by."
     )
    ("6.SP.B.5.a"
     "Reporting the number of observations."
     )
    ("6.SP.B.5.b"
     "Describing the nature of the attribute under investigation, including how it was measured and its units of measurement."
     )
    ("6.SP.B.5.c"
     "Giving quantitative measures of center (median, and/or mean) and variability (range and/or interquartile range), as well as describing any overall pattern and any striking deviations from the overall pattern with reference to the context in which the data were gathered."
     )
    ("6.SP.B.5.d"
     "Relating the choice of measures of center and variability to the shape of the data distribution and the context in which the data were gathered."
     )
    ("7.RP.A.1"
     "Compute unit rates associated with ratios of fractions, including ratios of lengths, areas and other quantities measured in like or different units. For example, if a person walks ½ mile in each ¼ hour, compute the unit rate as the complex fraction ½/¼ miles per hour, equivalently 2 miles per hour."
     )
    ("7.RP.A.2"
     "Recognize and represent proportional relationships between quantities."
     )
    ("7.RP.A.2.a"
     "Decide whether two quantities are in a proportional relationship, e.g., by testing for equivalent ratios in a table or graphing on a coordinate plane and observing whether the graph is a straight line through the origin."
     )
    ("7.RP.A.2.b"
     "Identify the constant of proportionality (unit rate) in tables, graphs, equations, diagrams, and verbal descriptions of proportional relationships."
     )
    ("7.RP.A.2.c"
     "Represent proportional relationships by equations. For example, if total cost t is proportional to the number n of items purchased at a constant price p, the relationship between the total cost and the number of items can be expressed as t = pn."
     )
    ("7.RP.A.2.d"
     "Explain what a point (x, y) on the graph of a proportional relationship means in terms of the situation, with special attention to the points (0, 0) and (1, r) where r is the unit rate."
     )
    ("7.RP.A.3"
     "Use proportional relationships to solve multi-step ratio, rate, and percent problems. "
     )
    ("7.NS.A.1"
     "Apply and extend previous understandings of addition and subtraction to add and subtract integers and other rational numbers; represent addition and subtraction on a horizontal or vertical number line diagram."
     )
    ("7.NS.A.1.a"
     "Describe situations in which opposite quantities combine to make zero. "
     )
    ("7.NS.A.1.b"
     "Understand p + q as the number located a distance |q| from p, in the positive or negative direction depending on whether q is positive or negative. Show that a number and its opposite have a sum of 0 (are additive inverses). Interpret sums of rational numbers by describing real-world contexts."
     )
    ("7.NS.A.1.c"
     "Understand subtraction of rational numbers as adding the additive inverse, p – q = p + (–q). Show that the distance between two rational numbers on the number line is the absolute value of their difference, and apply this principle in real-world contexts."
     )
    ("7.NS.A.1.d"
     "Apply properties of operations as strategies to add and subtract rational numbers."
     )
    ("7.NS.A.2"
     "Apply and extend previous understandings of multiplication and division and of fractions to multiply and divide integers and other rational numbers."
     )
    ("7.NS.A.2.a"
     "Understand that multiplication is extended from fractions to rational numbers by requiring that operations continue to satisfy the properties of operations, particularly the distributive property, leading to products such as (–1)(–1) = 1 and the rules for multiplying signed numbers. Interpret products of rational numbers by describing real-world contexts."
     )
    ("7.NS.A.2.b"
     "Understand that integers can be divided, provided that the divisor is not zero, and every quotient of integers (with non-zero divisor) is a rational number. If p and q are integers, then –(p/q) = (–p)/q = p/(–q). Interpret quotients of rational numbers by describing real-world contexts."
     )
    ("7.NS.A.2.c"
     "Apply properties of operations as strategies to multiply and divide rational numbers."
     )
    ("7.NS.A.2.d"
     "Convert a rational number to a decimal using long division; know that the decimal form of a rational number terminates in 0s or eventually repeats."
     )
    ("7.NS.A.3"
     "Solve real-world and mathematical problems involving the four operations with integers and other rational numbers."
     )
    ("7.EE.A.1"
     "Apply properties of operations to add, subtract, factor, and expand linear expressions with rational coefficients. "
     )
    ("7.EE.A.2"
     "Understand that rewriting an expression in different forms in a problem context can shed light on the problem and how the quantities in it are related. "
     )
    ("7.EE.B.3"
     "Solve multi-step real-life and mathematical problems posed with positive and negative rational numbers in any form (whole numbers, fractions, and decimals), using tools strategically. Apply properties of operations to calculate with numbers in any form; convert between forms as appropriate; and assess the reasonableness of answers using mental computation and estimation strategies. For example: If a woman making $25 an hour gets a 10% raise, she will make an additional 1/10 of her salary an hour, or $2.50, for a new salary of $27.50. If you want to place a towel bar 9 3/4 inches long in the center of a door that is 27 1/2 inches wide, you will need to place the bar about 9 inches from each edge; this estimate can be used as a check on the exact computation."
     )
    ("7.EE.B.4"
     "Use variables to represent quantities in a real-world or mathematical problem, and construct simple equations and inequalities to solve problems by reasoning about the quantities."
     )
    ("7.EE.B.4.a"
     "Solve word problems leading to equations of the form px + q = r and p(x + q) = r, where p, q, and r are specific rational numbers. Solve equations of these forms fluently. Compare an algebraic solution to an arithmetic solution, identifying the sequence of the operations used in each approach. For example, the perimeter of a rectangle is 54 cm. Its length is 6 cm. What is its width?"
     )
    ("7.EE.B.4.b"
     "Solve word problems leading to inequalities of the form px + q > r or px + q < r, where p, q, and r are specific rational numbers. Graph the solution set of the inequality and interpret it in the context of the problem. For example: As a sales-person, you are paid $50 per week plus $3 per sale. This week you want your pay to be at least $100. Write an inequality for the number of sales you need to make, and describe the solutions.."
     )
    ("7.EE.B.4.c"
     "Extend analysis of patterns to include analyzing, extending, and determining an expression for simple arithmetic and geometric sequences (e.g., compounding, increasing area), using tables, graphs, words, and expressions."
     )
    ("7.G.A.1"
     "Solve problems involving scale drawings of geometric figures, such as computing actual lengths and areas from a scale drawing and reproducing a scale drawing at a different scale."
     )
    ("7.G.A.2"
     "Draw (freehand, with ruler and protractor, and with technology) two-dimensional geometric shapes with given conditions. Focus on constructing triangles from three measures of angles or sides, noticing when the conditions determine a unique triangle, more than one triangle, or no triangle."
     )
    ("7.G.A.3"
     "Describe the shape of the two-dimensional face of the figure that results from slicing three-dimensional figures, as in plane sections of right rectangular prisms and right rectangular pyramids."
     )
    ("7.G.B.4"
     "Circles and measurement"
     )
    ("7.G.B.4.a"
     "Know that a circle is a two-dimensional shape created by connecting all of the points equidistant from a fixed point called the center of the circle."
     )
    ("7.G.B.4.b"
     "Understand and describe the relationships among the radius, diameter, circumference and circumference of a circle."
     )
    ("7.G.B.4.c"
     "Understand and describe the relationship among the radius, diameter, and area of a circle."
     )
    ("7.G.B.4.d"
     "Know the formulas for the area and circumference of a circle and use them to solve problems."
     )
    ("7.G.B.4.e"
     "Give an informal derivation of the relationship between the circumference and area of a circle."
     )
    ("7.G.B.5"
     "Use facts about supplementary, complementary, vertical, and adjacent angles in a multi-step problem to write simple equations and use them to solve for an unknown angle in a figure."
     )
    ("7.G.B.6"
     "Solve real-world and mathematical problems involving area, volume and surface area of two- and three-dimensional objects composed of triangles, quadrilaterals, polygons, cubes, and right prisms."
     )
    ("7.SP.A.1"
     "Understand that statistics can be used to gain information about a population by examining a sample of the population; generalizations about a population from a sample are valid only if the sample is representative of that population. Understand that random sampling tends to produce representative samples and support valid inferences."
     )
    ("7.SP.A.2"
     "Use data from a random sample to draw inferences about a population with an unknown characteristic of interest. Generate multiple samples (or simulated samples) of the same size to gauge the variation in estimates or predictions. For example, estimate the mean word length in a book by randomly sampling words from the book; predict the winner of a school election based on randomly sampled survey data. Gauge how far off the estimate or prediction might be."
     )
    ("7.SP.B.3"
     "Informally assess the degree of visual overlap of two numerical data distributions with similar variabilities, measuring the difference between the centers by expressing it as a multiple of a measure of variability. "
     )
    ("7.SP.B.4"
     "Use measures of center and measures of variability for numerical data from random samples to draw informal comparative inferences about two populations. For example, decide whether the words in a chapter of a seventh-grade science book are generally longer than the words in a chapter of a fourth-grade science book."
     )
    ("7.SP.C.5"
     "Understand that the probability of a chance event is a number between 0 and 1 that expresses the likelihood of the event occurring. Larger numbers indicate greater likelihood. A probability near 0 indicates an unlikely event, a probability around ½ indicates an event that is neither unlikely nor likely, and a probability near 1 indicates a likely event."
     )
    ("7.SP.C.6"
     "Approximate the probability of a chance event by collecting data on the chance process that produces it and observing its long-run relative frequency, and predict the approximate relative frequency given the probability. For example, when rolling a number cube 600 times, predict that a 3 or 6 would be rolled roughly 200 times, but probably not exactly 200 times."
     )
    ("7.SP.C.7"
     "Develop a probability model and use it to find probabilities of events. Compare probabilities from a model to observed frequencies; if the agreement is not good, explain possible sources of the discrepancy."
     )
    ("7.SP.C.7.a"
     "Develop a uniform probability model by assigning equal probability to all outcomes, and use the model to determine probabilities of events. For example, if a student is selected at random from a class, find the probability that Jane will be selected and the probability that a girl will be selected."
     )
    ("7.SP.C.7.b"
     "Develop a probability model (which may not be uniform) by observing frequencies in data generated from a chance process. For example, find the approximate probability that a spinning penny will land heads up or that a tossed paper cup will land open-end down. Do the outcomes for the spinning penny appear to be equally likely based on the observed frequencies."
     )
    ("7.SP.C.8"
     "Find probabilities of compound events using organized lists, tables, tree diagrams, and simulation."
     )
    ("7.SP.C.8.a"
     "Understand that, just as with simple events, the probability of a compound event is the fraction of outcomes in the sample space for which the compound event occurs."
     )
    ("7.SP.C.8.b"
     "Represent sample spaces for compound events using methods such as organized lists, tables and tree diagrams. For an event described in everyday language (e.g., “rolling double sixes”), identify the outcomes in the sample space which compose the event."
     )
    ("7.SP.C.8.c"
     "Design and use a simulation to generate frequencies for compound events. For example, use random digits as a simulation tool to approximate the answer to the question: If 40% of donors have type A blood, what is the probability that it will take at least 4 donors to find one with type A blood."
     )
    ("8.NS.A.1"
     "Know that numbers that are not rational are called irrational. Understand informally that every number has a decimal expansion; for rational numbers show that the decimal expansion repeats eventually, and convert a decimal expansion which repeats eventually into a rational number."
     )
    ("8.NS.A.2"
     "Use rational approximations of irrational numbers to compare the size of irrational numbers, locate them approximately on a number line diagram, and estimate the value of expressions (e.g.,π2). For example, by truncating the decimal expansion of √2 show that√2 is between 1 and 2, then between 1.4 and 1.5, and explain how to continue on to get better approximations."
     )
    ("8.EE.A.1"
     "Know and apply the properties of integer exponents to generate equivalent numerical expressions. For example, 3² x 3-5 = 3-3 = 1/33 = 1/27."
     )
    ("8.EE.A.2"
     "Use square root and cube root symbols to represent solutions to equations of the form x2 = p and x3 = p, where p is a positive rational number. Evaluate square roots of small perfect squares and cube roots of small perfect cubes. Know that √2 is irrational."
     )
    ("8.EE.A.3"
     "Use numbers expressed in the form of a single digit times an integer power of 10 to estimate very large or very small quantities, and to express how many times as much one is than the other. For example, estimate the population of the United States as 3 x 108 and the population of the world as 7 x 109, and determine that the world population is more than 20 times larger."
     )
    ("8.EE.A.4"
     "Perform operations with numbers expressed in scientific notation, including problems where both decimal and scientific notation are used. Use scientific notation and choose units of appropriate size for measurements of very large or very small quantities (e.g., use millimeters per year for seafloor spreading). Interpret scientific notation that has been generated by technology."
     )
    ("8.EE.B.5"
     "Graph proportional relationships, interpreting the unit rate as the slope of the graph. Compare two different proportional relationships represented in different ways. For example, compare a distance-time graph to a distance-time equation to determine which of two moving objects has greater speed."
     )
    ("8.EE.B.6"
     "Use similar triangles to explain why the slope m is the same between any two distinct points on a non-vertical line in the coordinate plane; derive the equation y = mx for a line through the origin and the equation y = mx + b for a line intercepting the vertical axis at b."
     )
    ("8.EE.C.7"
     "Solve linear equations in one variable."
     )
    ("8.EE.C.7.a"
     "Give examples of linear equations in one variable with one solution, infinitely many solutions, or no solutions. Show which of these possibilities is the case by successively transforming the given equation into simpler forms, until an equivalent equation of the form x = a, a = a, or a = b results (where a and b are different numbers)."
     )
    ("8.EE.C.7.b"
     "Solve linear equations with rational number coefficients, including equations whose solutions require expanding expressions using the distributive property and collecting like terms."
     )
    ("8.EE.C.8"
     "Analyze and solve pairs of simultaneous linear equations."
     )
    ("8.EE.C.8.a"
     "Understand that solutions to a system of two linear equations in two variables correspond to points of intersection of their graphs, because points of intersection satisfy both equations simultaneously."
     )
    ("8.EE.C.8.b"
     "Solve systems of two linear equations in two variables algebraically (using substitution and elimination strategies), and estimate solutions by graphing the equations. Solve simple cases by inspection. "
     )
    ("8.EE.C.8.c"
     "Solve real-world and mathematical problems leading to two linear equations in two variables. For example, given coordinates for two pairs of points, determine whether the line through the first pair of points intersects the line through the second pair."
     )
    ("8.F.A.1"
     "Understand that a function is a rule that assigns to each input exactly one output. The graph of a function is the set of ordered pairs consisting of an input and the corresponding output. [Note: Function notation is not required in grade 8.]"
     )
    ("8.F.A.2"
     "Compare properties of two functions each represented in a different way (algebraically, graphically, numerically in tables, or by verbal descriptions). For example, given a linear function represented by a table of values and a linear function represented by an algebraic expression, determine which function has the greater rate of change."
     )
    ("8.F.A.3"
     "Interpret the equation y = mx + b as defining a linear function, whose graph is a straight line; give examples of functions that are not linear. For example, the function A = s² giving the area of a square as a function of its side length is not linear because its graph contains the points (1,1), (2,4) and (3,9), which are not on a straight line."
     )
    ("8.F.B.4"
     "Construct a function to model a linear relationship between two quantities. Determine the rate of change and initial value of the function from a description of a relationship or from two (x, y) values, including reading these from a table or from a graph. Interpret the rate of change and initial value of a linear function in terms of the situation it models, and in terms of its graph or a table of values."
     )
    ("8.F.B.5"
     "Describe qualitatively the functional relationship between two quantities by analyzing a graph (e.g., where the function is increasing or decreasing, linear or nonlinear). Sketch a graph that exhibits the qualitative features of a function that has been described verbally."
     )
    ("8.G.A.1"
     "Verify experimentally the properties of rotations, reflections, and translations."
     )
    ("8.G.A.1.a"
     "Lines are transformed to lines, and line segments to line segments of the same length."
     )
    ("8.G.A.1.b"
     "Angles are transformed to angles of the same measure."
     )
    ("8.G.A.1.c"
     "Parallel lines are transformed to parallel lines."
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
     "Use informal arguments to establish facts about the angle sum and exterior angle of triangles, about the angles created when parallel lines are cut by a transversal, and the angle-angle criterion for similarity of triangles. For example, arrange three copies of the same triangle so that the sum of the three angles appears to form a line, and give an argument in terms of transversals why this is so."
     )
    ("8.G.B.6"
     "[See 8.G.B.6.a and 8.G.B.6.b.]"
     )
    ("8.G.B.6.a"
     "Understand the relationship among the sides of a right triangle."
     )
    ("8.G.B.6.b"
     "Analyze and justify the Pythagorean Theorem and its converse using pictures, diagrams, narratives, or models."
     )
    ("8.G.B.7"
     "Apply the Pythagorean Theorem to determine unknown side lengths in right triangles in real-world and mathematical problems in two and three dimensions."
     )
    ("8.G.B.8"
     "Apply the Pythagorean Theorem to find the distance between two points in a coordinate system."
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
     "Use the equation of a linear model to solve problems in the context of bivariate measurement data, interpreting the slope and intercept. For example, in a linear model for a biology experiment, interpret a slope of 1.5 cm/hr as meaning that an additional hour of sunlight each day is associated with an additional 1.5 cm in mature plant height."
     )
    ("8.SP.A.4"
     "Understand that patterns of association can also be seen in bivariate categorical data by displaying frequencies and relative frequencies in a two-way table. Construct and interpret a two-way table summarizing data on two categorical variables collected from the same subjects. Use relative frequencies calculated for rows or columns to describe possible association between the two variables. For example, collect data from students in your class on whether or not they have a curfew on school nights and whether or not they have assigned chores at home. Is there evidence that those who have a curfew also tend to have chores?"
     )
    ("AI.N-RN.A.1"
     "Explain how the definition of the meaning of rational exponents follows from extending the properties of integer exponents to those values, allowing for a notation for radicals in terms of rational exponents. For example, we define 51/3 to be the cube root of 5 because we want (51/3)3 = 5(1/3)3 to hold, so (51/3)3 must equal 5."
     )
    ("AI.N-RN.A.2"
     "Rewrite expressions involving radicals and rational exponents using the properties of exponents."
     )
    ("AI.N-RN.B.3"
     "Explain why the sum or product of two rational numbers is rational; that the sum of a rational number and an irrational number is irrational; and that the product of a nonzero rational number and an irrational number is irrational."
     )
    ("AI.N-Q.A.1"
     "Use units as a way to understand problems and to guide the solution of multi-step problems; choose and interpret units consistently in formulas; choose and interpret the scale and the origin in graphs and data displays."
     )
    ("AI.N-Q.A.2"
     "Define appropriate quantities for the purpose of descriptive modeling."
     )
    ("AI.N-Q.A.3"
     "Choose a level of accuracy appropriate to limitations on measurement when reporting quantities."
     )
    ("AI.A-SSE.A.1"
     "Interpret expressions that represent a quantity in terms of its context."
     )
    ("AI.A-SSE.A.1.a"
     "Interpret parts of an expression, such as terms, factors, and coefficients."
     )
    ("AI.A-SSE.A.1.b"
     "Interpret complicated expressions by viewing one or more of their parts as a single entity. For example, interpret P(1 + r)t as the product of P and a factor not depending on P."
     )
    ("AI.A-SSE.A.2"
     "Use the structure of an expression to identify ways to rewrite it. For example, see (x + 2)2 – 9 as a difference of squares that can be factored as ((x + 2) + 3)((x + 2 ) – 3)."
     )
    ("AI.A-SSE.B.3"
     "Choose and produce an equivalent form of an expression to reveal and explain properties of the quantity represented by the expression."
     )
    ("AI.A-SSE.B.3.a"
     "Factor a quadratic expression to reveal the zeros of the function it defines."
     )
    ("AI.A-SSE.B.3.b"
     "Complete the square in a quadratic expression to reveal the maximum or minimum value of the function it defines."
     )
    ("AI.A-SSE.B.3.c"
     "Use the properties of exponents to transform expressions for exponential functions. For example, the expression 1.15t can be rewritten as (1.151/12)12t ≈ 1.01212t to reveal the approximate equivalent monthly interest rate if the annual rate is 15%."
     )
    ("AI.A-APR.A.1"
     "Understand that polynomials form a system analogous to the integers, namely, they are closed under certain operations."
     )
    ("AI.A-APR.A.1.a"
     "Perform operations on polynomial expressions (addition, subtraction, multiplication), and compare the system of polynomials to the system of integers when performing operations."
     )
    ("AI.A-APR.A.1.b"
     "Factor and/or expand polynomial expressions, identify and combine like terms, and apply the Distributive property."
     )
    ("AI.A-CED.A.1"
     "Create equations and inequalities in one variable and use them to solve problems. (Include equations arising from linear, quadratic, and exponential functions with integer exponents.)"
     )
    ("AI.A-CED.A.2"
     "Create equations in two or more variables to represent relationships between quantities; graph equations on coordinate axes with labels and scales."
     )
    ("AI.A-CED.A.3"
     "Represent constraints by linear equations or inequalities, and by systems of linear equations and/or inequalities, and interpret solutions as viable or non-viable options in a modeling context.* For example, represent inequalities describing nutritional and cost constraints on combinations of different foods."
     )
    ("AI.A-CED.A.4"
     "Rearrange formulas to highlight a quantity of interest using the same reasoning as in solving equations (Properties of equality).* For example, rearrange Ohm’s law R=V2/P to solve for voltage, V. Manipulate variables in formulas used in financial contexts such as for simple interest, I=Prt."
     )
    ("AI.A-REI.A.1"
     "Explain each step in solving a simple equation as following from the equality of numbers asserted at the previous step, starting from the assumption that the original equation has a solution. Construct a viable argument to justify or refute a solution method."
     )
    ("AI.A-REI.B.3"
     "Solve linear equations and inequalities in one variable, including equations with coefficients represented by letters."
     )
    ("AI.A-REI.B.3.a"
     "Solve linear equations and inequalities in one variable involving absolute value."
     )
    ("AI.A-REI.B.4"
     "Solve quadratic equations in one variable."
     )
    ("AI.A-REI.B.4.a"
     "Use the method of completing the square to transform any quadratic equation in x into an equation of the form (x – p)2 = q that has the same solutions. Derive the quadratic formula from this form."
     )
    ("AI.A-REI.B.4.b"
     "Solve quadratic equations by inspection (e.g., for x2 = 49), taking square roots, completing the square, the quadratic formula, and factoring, as appropriate to the initial form of the equation. Recognize when the solutions of a quadratic equation results in non-real solutions and write them as a ± bi for real numbers a and b."
     )
    ("AI.A-REI.C.5"
     "Prove that, given a system of two equations in two variables, replacing one equation by the sum of that equation and a multiple of the other produces a system with the same solutions."
     )
    ("AI.A-REI.C.6"
     "Solve systems of linear equations exactly and approximately (e.g., with graphs), focusing on pairs of linear equations in two variables."
     )
    ("AI.A-REI.C.7"
     "Solve a simple system consisting of a linear equation and a quadratic equation in two variables algebraically and graphically. For example, find the points of intersection between the line y = –3x and the circle x2 + y2 = 3."
     )
    ("AI.A-REI.D.10"
     "Understand that the graph of an equation in two variables is the set of all its solutions plotted in the coordinate plane, often forming a curve (which could be a line). Show that any point on the graph of an equation in two variables is a solution to the equation."
     )
    ("AI.A-REI.D.11"
     "Explain why the x-coordinates of the points where the graphs of the equations y = f(x) and y = g(x) intersect are the solutions of the equation f(x) = g(x); find the solutions approximately, e.g., using technology to graph the functions and make tables of values. Include cases where f(x) and/or g(x) are linear and exponential functions."
     )
    ("AI.A-REI.D.12"
     "Graph the solutions of a linear inequality in two variables as a half-plane (excluding the boundary in the case of a strict inequality), and graph the solution set of a system of linear inequalities in two variables as the intersection of the corresponding half-planes."
     )
    ("AI.F-IF.A.1"
     "Understand that a function from one set (called the domain) to another set (called the range) assigns to each element of the domain exactly one element of the range. If f is a function and x is an element of its domain, then f(x) denotes the output (range) of f corresponding to the input x. The graph of f is the graph of the equation y = f(x)."
     )
    ("AI.F-IF.A.2"
     "Use function notation, evaluate functions for inputs in their domains, and interpret statements that use function notation in terms of a context. For example, given a function representing a car loan, determine the balance of the loan at different points in time."
     )
    ("AI.F-IF.A.3"
     "Recognize that sequences are functions, sometimes defined recursively, whose domain is a subset of the integers. For example, the Fibonacci sequence is defined recursively by f(0) = f(1) = 1, f(n + 1) = f(n) + f(n - 1) for n = 1."
     )
    ("AI.F-IF.B.4"
     "For a function that models a relationship between two quantities, interpret key features of graphs and tables in terms of the quantities, and sketch graphs showing key features given a verbal description of the relationship. Key features include: intercepts; intervals where the function is increasing, decreasing, positive, or negative; relative maximums and minimums; symmetries; and end behavior."
     )
    ("AI.F-IF.B.5"
     "Relate the domain of a function to its graph and, where applicable, to the quantitative relationship it describes.* For example, if the function h(n) gives the number of person-hours it takes to assemble n engines in a factory, then the positive integers would be an appropriate domain for the function."
     )
    ("AI.F-IF.B.6"
     "Calculate and interpret the average rate of change of a function (presented symbolically or as a table) over a specified interval. Estimate the rate of change from a graph."
     )
    ("AI.F-IF.C.7"
     "Graph functions expressed symbolically and show key features of the graph, by hand in simple cases and using technology for more complicated cases."
     )
    ("AI.F-IF.C.7.a"
     "Graph linear and quadratic functions and show intercepts, maxima, and minima."
     )
    ("AI.F-IF.C.7.b"
     "Graph piecewise-defined functions, including step functions and absolute value functions."
     )
    ("AI.F-IF.C.7.e"
     "Graph exponential functions showing intercepts and end behavior."
     )
    ("AI.F-IF.C.8"
     "Write a function defined by an expression in different but equivalent forms to reveal and explain different properties of the function."
     )
    ("AI.F-IF.C.8.a"
     "Use the process of factoring and completing the square in a quadratic function to show zeros, maximum/minimum values, and symmetry of the graph, and interpret these in terms of a context."
     )
    ("AI.F-IF.C.8.b"
     "Use the properties of exponents to interpret expressions for exponential functions. Apply to financial situations such as identifying appreciation and depreciation rate for the value of a house or car some time after its initial purchase: Vn=P(1+r)n. For example, identify percent rate of change in functions such as y = (1.02)t, y = (0.97)t, y = (1.01)12t, and y = (1.2)t /10, and classify them as representing exponential growth or decay."
     )
    ("AI.F-IF.C.9"
     "Translate among different representations of functions (algebraically, graphically, numerically in tables, or by verbal descriptions). Compare properties of two functions each represented in a different way. For example, given a graph of one quadratic function and an algebraic expression for another, say which has the larger maximum."
     )
    ("AI.F-BF.A.1"
     "Write linear, quadratic, and exponential functions that describe a relationship between two quantities."
     )
    ("AI.F-BF.A.1.a"
     "Determine an explicit expression, a recursive process, or steps for calculation from a contex."
     )
    ("AI.F-BF.A.1.b"
     "Combine standard function types using arithmetic operations.* For example, build a function that models the temperature of a cooling body by adding a constant function to a decaying exponential, and relate these functions to the model."
     )
    ("AI.F-BF.A.2"
     "Write arithmetic and geometric sequences both recursively and with an explicit formula them to model situations, and translate between the two forms."
     )
    ("AI.F-BF.B.3"
     "Identify the effect on the graph of replacing f(x) by f(x) + k, kf(x), f(kx), and f(x + k) for specific values of k (both positive and negative); find the value of k given the graphs. Include linear, quadratic, exponential, and absolute value functions. Utilize technology to experiment with cases and illustrate an explanation of the effects on the graph."
     )
    ("AI.F-BF.B.4"
     "Find inverse functions algebraically and graphically."
     )
    ("AI.F-BF.B.4.a"
     "Solve an equation of the form f(x) = c for a linear function f that has an inverse and write an expression for the inverse."
     )
    ("AI.F-LE.A.1"
     "Distinguish between situations that can be modeled with linear functions and with exponential functions."
     )
    ("AI.F-LE.A.1.a"
     "Prove that linear functions grow by equal differences over equal intervals, and that exponential functions grow by equal factors over equal intervals."
     )
    ("AI.F-LE.A.1.b"
     "Recognize situations in which one quantity changes at a constant rate per unit interval relative to another."
     )
    ("AI.F-LE.A.1.c"
     "Recognize situations in which a quantity grows or decays by a constant percent rate per unit interval relative to another."
     )
    ("AI.F-LE.A.2"
     "Construct linear and exponential functions, including arithmetic and geometric sequences, given a graph, a description of a relationship, or two input-output pairs (including reading these from a table)."
     )
    ("AI.F-LE.A.3"
     "Observe, using graphs and tables, that a quantity increasing exponentially eventually exceeds a quantity increasing linearly, quadratically, or (more generally) as a polynomial function."
     )
    ("AI.F-LE.B.5"
     "Interpret the parameters in a linear or exponential function (of the form f(x) = bx + k) in terms of a context."
     )
    ("AI.S-ID.A.1"
     "Represent data with plots on the real number line (dot plots, histograms, and box plots)."
     )
    ("AI.S-ID.A.2"
     "Use statistics appropriate to the shape of the data distribution to compare center (median, mean) and spread (interquartile range, standard deviation) of two or more different data sets."
     )
    ("AI.S-ID.A.3"
     "Interpret differences in shape, center, and spread in the context of the data sets, accounting for possible effects of extreme data points (outliers)."
     )
    ("AI.S-ID.B.5"
     "Summarize categorical data for two categories in two-way frequency tables. Interpret relative frequencies in the context of the data (including joint, marginal, and conditional relative frequencies). Recognize possible associations and trends in the data."
     )
    ("AI.S-ID.B.6"
     "Represent data on two quantitative variables on a scatter plot, and describe how the variables are related."
     )
    ("AI.S-ID.B.6.a"
     "Fit a linear function to the data and use the fitted function to solve problems in the context of the data. Use functions fitted to data or choose a function suggested by the context (emphasize linear and exponential models)."
     )
    ("AI.S-ID.B.6.b"
     "Informally assess the fit of a function by plotting and analyzing residuals."
     )
    ("AI.S-ID.B.6.c"
     "Fit a linear function for a scatter plot that suggests a linear association."
     )
    ("AI.S-ID.C.7"
     "Interpret the slope (rate of change) and the intercept (constant term) of a linear model in the context of the data."
     )
    ("AI.S-ID.C.8"
     "Compute (using technology) and interpret the correlation coefficient of a linear fit."
     )
    ("AI.S-ID.C.9"
     "Distinguish between correlation and causation."
     )
    ("GEO.N-Q.A.3"
     "Choose a level of accuracy appropriate to limitations on measurement when reporting quantities."
     )
    ("GEO.N-Q.A.3.a"
     "Describe the effects of approximate error in measurement and rounding on measurements and on computed values from measurements. Identify significant figures in recorded measures and computed values based on the context given and the precision of the tools used to measure."
     )
    ("GEO.G-CO.A.1"
     "Know precise definitions of angle, circle, perpendicular line, parallel line, and line segment, based on the undefined notions of point, line, distance along a line, and distance around a circular arc."
     )
    ("GEO.G-CO.A.2"
     "Represent transformations in the plane using, e.g., transparencies and geometry software; describe transformations as functions that take points in the plane as inputs and give other points as outputs. Compare transformations that preserve distance and angle to those that do not (e.g., translation versus horizontal stretch)."
     )
    ("GEO.G-CO.A.3"
     "Given a rectangle, parallelogram, trapezoid, or regular polygon, describe the rotations and reflections that carry it onto itself."
     )
    ("GEO.G-CO.A.4"
     "Develop definitions of rotations, reflections, and translations in terms of angles, circles, perpendicular lines, parallel lines, and line segments."
     )
    ("GEO.G-CO.A.5"
     "Given a geometric figure and a rotation, reflection, or translation, draw the transformed figure using graph paper, tracing paper, or geometry software. Specify a sequence of transformations that will carry a given figure onto another."
     )
    ("GEO.G-CO.B.6"
     "Use geometric descriptions of rigid motions to transform figures and to predict the effect of a given rigid motion on a given figure; given two figures, use the definition of congruence in terms of rigid motions to decide if they are congruent."
     )
    ("GEO.G-CO.B.7"
     "Use the definition of congruence in terms of rigid motions to show that two triangles are congruent if and only if corresponding pairs of sides and corresponding pairs of angles are congruent."
     )
    ("GEO.G-CO.B.8"
     "Explain how the criteria for triangle congruence (ASA, SAS, and SSS) follow from the definition of congruence in terms of rigid motions."
     )
    ("GEO.G-CO.C.9"
     "Prove theorems about lines and angles. Theorems include: vertical angles are congruent; when a transversal crosses parallel lines, alternate interior angles are congruent and corresponding angles are congruent, and conversely prove lines are parallel; points on a perpendicular bisector of a line segment are exactly those equidistant from the segment’s endpoints."
     )
    ("GEO.G-CO.C.10"
     "Prove theorems about triangles. Theorems include: measures of interior angles of a triangle sum to 180°; base angles of isosceles triangles are congruent, and conversely prove a triangle is isosceles; the segment joining midpoints of two sides of a triangle is parallel to the third side and half the length; the medians of a triangle meet at a point."
     )
    ("GEO.G-CO.C.11"
     "Prove theorems about parallelograms. Theorems include: opposite sides are congruent, opposite angles are congruent, the diagonals of a parallelogram bisect each other, and conversely, rectangles are parallelograms with congruent diagonals."
     )
    ("GEO.G-CO.C.11.a"
     "Prove theorems about polygons. Theorems include the measures of interior and exterior angles. Apply properties of polygons to the solutions of mathematical and contextual problems."
     )
    ("GEO.G-CO.D.12"
     "Make formal geometric constructions with a variety of tools and methods (compass and straightedge, string, reflective devices, paper folding, dynamic geometric software, etc.). Constructions include: copying a segment; copying an angle; bisecting a segment; bisecting an angle; constructing perpendicular lines, including the perpendicular bisector of a line segment; and constructing a line parallel to a given line through a point not on the line."
     )
    ("GEO.G-CO.D.13"
     "Construct an equilateral triangle, a square, and a regular hexagon inscribed in a circle."
     )
    ("GEO.G-SRT.A.1"
     "Verify experimentally the properties of dilations given by a center and a scale factor:"
     )
    ("GEO.G-SRT.A.1.a"
     "A dilation takes a line not passing through the center of the dilation to a parallel line, and leaves a line passing through the center unchanged."
     )
    ("GEO.G-SRT.A.1.b"
     "The dilation of a line segment is longer or shorter in the ratio given by the scale factor."
     )
    ("GEO.G-SRT.A.2"
     "Given two figures, use the definition of similarity in terms of similarity transformations to decide if they are similar; explain using similarity transformations the meaning of similarity for triangles as the equality of all corresponding pairs of angles and the proportionality of all corresponding pairs of sides."
     )
    ("GEO.G-SRT.A.3"
     "Use the properties of similarity transformations to establish the Angle-Angle (AA) criterion for two triangles to be similar."
     )
    ("GEO.G-SRT.B.4"
     "Prove theorems about triangles. Theorems include: a line parallel to one side of a triangle divides the other two proportionally, and conversely; the Pythagorean Theorem proved using triangle similarity."
     )
    ("GEO.G-SRT.B.5"
     "Use congruence and similarity criteria for triangles to solve problems and to prove relationships in geometric figures."
     )
    ("GEO.G-SRT.C.6"
     "Understand that by similarity, side ratios in right triangles are properties of the angles in the triangle, leading to definitions of trigonometric ratios for acute angles."
     )
    ("GEO.G-SRT.C.7"
     "Explain and use the relationship between the sine and cosine of complementary angles."
     )
    ("GEO.G-SRT.C.8"
     "Use trigonometric ratios and the Pythagorean Theorem to solve right triangles in applied problems."
     )
    ("GEO.G-SRT.D.9"
     "Derive the formula A = ½ absin(C) for the area of a triangle by drawing an auxiliary line from a vertex perpendicular to the opposite side."
     )
    ("GEO.G-SRT.D.10"
     "Prove the Laws of Sines and Cosines and use them to solve problems."
     )
    ("GEO.G-SRT.D.11"
     "Understand and apply the Law of Sines and the Law of Cosines to find unknown measurements in right and non-right triangles (e.g., surveying problems, resultant forces)."
     )
    ("GEO.G-C.A.1"
     "Prove that all circles are similar."
     )
    ("GEO.G-C.A.2"
     "Identify and describe relationships among inscribed angles, radii, and chords. Include the relationship between central, inscribed, and circumscribed angles; inscribed angles on a diameter are right angles; the radius of a circle is perpendicular to the tangent where the radius intersects the circle."
     )
    ("GEO.G-C.A.3"
     "Construct the inscribed and circumscribed circles of a triangle, and prove properties of angles for a quadrilateral and other polygons inscribed in a circle."
     )
    ("GEO.G-C.A.4"
     "Construct a tangent line from a point outside a given circle to the circle."
     )
    ("GEO.G-C.B.5"
     "Derive, using similarity, the fact that the length of the arc intercepted by an angle is proportional to the radius, and define the radian measure of the angle as the constant of proportionality; derive the formula for the area of a sector."
     )
    ("GEO.G-GPE.A.1"
     "Derive the equation of a circle of given center and radius using the Pythagorean Theorem; complete the square to find the center and radius of a circle given by an equation."
     )
    ("GEO.G-GPE.A.2"
     "Derive the equation of a parabola given a focus and directrix."
     )
    ("GEO.G-GPE.B.4"
     "Use coordinates to prove simple geometric theorems algebraically, including the distance formula and its relationship to the Pythagorean Theorem. For example, prove or disprove that a figure defined by four given points in the coordinate plane is a rectangle; prove or disprove that the point (1, √3) lies on the circle centered at the origin and containing the point (0, 2)."
     )
    ("GEO.G-GPE.B.5"
     "Prove the slope criteria for parallel and perpendicular lines and use them to solve geometric problems (e.g., find the equation of a line parallel or perpendicular to a given line that passes through a given point)."
     )
    ("GEO.G-GPE.B.6"
     "Find the point on a directed line segment between two given points that partitions the segment in a given ratio."
     )
    ("GEO.G-GPE.B.7"
     "Use coordinates to compute perimeters of polygons and areas of triangles and rectangles (e.g., using the distance formula)."
     )
    ("GEO.G-GMD.A.1"
     "Give an informal argument for the formulas for the circumference of a circle, area of a circle, volume of a cylinder, pyramid, and cone. Use dissection arguments, Cavalieri’s principle, and informal limit arguments."
     )
    ("GEO.G-GMD.A.2"
     "Give an informal argument using Cavalieri’s principle for the formulas for the volume of a sphere and other solid figures."
     )
    ("GEO.G-GMD.A.3"
     "Use volume formulas for cylinders, pyramids, cones, and spheres to solve problems."
     )
    ("GEO.G-GMD.B.4"
     "Identify the shapes of two-dimensional cross-sections of three-dimensional objects, and identify three-dimensional objects generated by rotations of two-dimensional objects."
     )
    ("GEO.G-MG.A.1"
     "Use geometric shapes, their measures, and their properties to describe objects (e.g., modeling a tree trunk or a human torso as a cylinder)."
     )
    ("GEO.G-MG.A.2"
     "Apply concepts of density based on area and volume in modeling situations (e.g., persons per square mile, BTUs per cubic foot)."
     )
    ("GEO.G-MG.A.3"
     "Apply geometric methods to solve design problems (e.g., designing an object or structure to satisfy physical constraints or minimize cost; working with typographic grid systems based on ratios)."
     )
    ("GEO.G-MG.A.4"
     "Use dimensional analysis for unit conversions to confirm that expressions and equations make sense."
     )
    ("GEO.S-CP.A.1"
     "Describe events as subsets of a sample space (the set of outcomes) using characteristics (or categories) of the outcomes, or as unions, intersections, or complements of other events (“or,” “and,” “not”)."
     )
    ("GEO.S-CP.A.2"
     "Understand that two events A and B are independent if the probability of A and B occurring together is the product of their probabilities, and use this characterization to determine if they are independent."
     )
    ("GEO.S-CP.A.3"
     "Understand the conditional probability of A given B as P(A and B)/P(B), and interpret independence of A and B as saying that the conditional probability of A given B is the same as the probability of A, and the conditional probability of B given A is the same as the probability of B."
     )
    ("GEO.S-CP.A.4"
     "Construct and interpret two-way frequency tables of data when two categories are associated with each object being classified. Use the two-way table as a sample space to decide if events are independent and to approximate conditional probabilities.* For example, collect data from a random sample of students in your school on their favorite subject among math, science, and English. Estimate the probability that a randomly selected student from your school will favor science given that the student is in tenth grade. Do the same for other subjects and compare the results."
     )
    ("GEO.S-CP.A.5"
     "Recognize and explain the concepts of conditional probability and independence in everyday language and everyday situations.* For example, compare the chance of having lung cancer if you are a smoker with the chance of being a smoker if you have lung cancer."
     )
    ("GEO.S-CP.B.6"
     "Find the conditional probability of A given B as the fraction of B’s outcomes that also belong to A, and interpret the answer in terms of the model."
     )
    ("GEO.S-CP.B.7"
     "Apply the Addition Rule, P(A or B) = P(A) + P(B) – P(A and B), and interpret the answer in terms of the model."
     )
    ("GEO.S-CP.B.8"
     "Apply the general Multiplication Rule in a uniform probability model, P(A and B) = P(A)P(B|A) = P(B)P(A|B), and interpret the answer in terms of the model."
     )
    ("GEO.S-CP.B.9"
     "Use permutations and combinations to compute probabilities of compound events and solve problems."
     )
    ("AII.N-CN.A.1"
     "Know there is a complex number i such that i2 = −1, and every complex number has the form a + bi with x-a and b real."
     )
    ("AII.N-CN.A.2"
     "Use the relation i2 = –1 and the Commutative, Associative, and Distributive properties to add, subtract, and multiply complex numbers."
     )
    ("AII.N-CN.C.7"
     "Solve quadratic equations with real coefficients that have complex solutions."
     )
    ("AII.N-CN.C.8"
     "Extend polynomial identities to the complex numbers. For example, rewrite x2 + 4 as (x + 2i)(x – 2i)."
     )
    ("AII.N-CN.C.9"
     "Know the Fundamental Theorem of Algebra; show that it is true for quadratic polynomials."
     )
    ("AII.N-VM.A.1"
     "Recognize vector quantities as having both magnitude and direction. Represent vector quantities by directed line segments, and use appropriate symbols for vectors and their magnitudes (e.g., v, |v|, ||v||, v)."
     )
    ("AII.N-VM.A.3"
     "Solve problems involving velocity and other quantities that can be represented by vectors."
     )
    ("AII.N-VM.C.6"
     "Use matrices to represent and manipulate data, e.g., to represent payoffs or incidence relationships in a network."
     )
    ("AII.N-VM.C.8"
     "Add, subtract, and multiply matrices of appropriate dimensions."
     )
    ("AII.N-VM.C.12"
     "Work with 2 × 2 matrices as transformations of the plane, and interpret the absolute value of the determinant in terms of area."
     )
    ("AII.A-SSE.A.1"
     "Interpret expressions that represent a quantity in terms of its context."
     )
    ("AII.A-SSE.A.1.a"
     "Interpret parts of an expression, such as terms, factors, and coefficients."
     )
    ("AII.A-SSE.A.1.b"
     "Interpret complicated expressions by viewing one or more of their parts as a single entity. For example, interpret P(1 + r)n as the product of P and a factor not depending on P."
     )
    ("AII.A-SSE.A.2"
     "Use the structure of an expression to identify ways to rewrite it. For example, see x4 – y4 as (x2)2 – (y2)2, thus recognizing it as a difference of squares that can be factored as (x2 – y2)(x2 + y2)and further factored (x-y)(x+y)(x-yi)(x+yi)."
     )
    ("AII.A-SSE.B.4"
     "Derive the formula for the sum of a finite geometric series (when the common ratio is not 1), and use the formula to solve problems.* For example, calculate mortgage payments."
     )
    ("AII.A-APR.A.1"
     "Understand that polynomials form a system analogous to the integers, namely, they are closed under certain operations."
     )
    ("AII.A-APR.A.1.a"
     "Perform operations on polynomial expressions (addition, subtraction, multiplication, and division), and compare the system of polynomials to the system of integers when performing operations."
     )
    ("AII.A-APR.B.2"
     "Know and apply the Remainder Theorem: For a polynomial p(x) and a number a, the remainder on division by x – a is p(a), so p(a) = 0 if and only if (x – a) is a factor of p(x)."
     )
    ("AII.A-APR.B.3"
     "Identify zeros of polynomials when suitable factorizations are available, and use the zeros to construct a rough graph of the function defined by the polynomial."
     )
    ("AII.A-APR.C.4"
     "Prove polynomial identities and use them to describe numerical relationships. For example, the polynomial identity (x2 + y2)2 = (x2 – y2)2 + (2xy)2 can be used to generate Pythagorean triples."
     )
    ("AII.A-APR.C.5"
     "Know and apply the Binomial Theorem for the expansion of (x + y)n in powers of x and y for a positive integer n, where x and y are any numbers, with coefficients determined for example by Pascal’s Triangle."
     )
    ("AII.A-APR.D.6"
     "Rewrite simple rational expressions in different forms; write a(x)/b(x) in the form q(x) + r(x)/b(x), where a(x), b(x), q(x), and r(x) are polynomials with the degree of r(x) less than the degree of b(x), using inspection, long division, or, for the more complicated examples, a computer algebra system."
     )
    ("AII.A-APR.D.7"
     "Understand that rational expressions form a system analogous to the rational numbers, closed under addition, subtraction, multiplication, and division by a nonzero rational expression; add, subtract, multiply, and divide rational expressions."
     )
    ("AII.A-CED.A.1"
     "Create equations and inequalities in one variable and use them to solve problems. Include equations arising from simple root and rational functions and exponential functions."
     )
    ("AII.A-CED.A.2"
     "Create equations in two or more variables to represent relationships between quantities; graph equations on coordinate axes with labels and scales."
     )
    ("AII.A-CED.A.3"
     "Represent constraints by equations or inequalities, and by systems of equations and/or inequalities, and interpret solutions as viable or non-viable options in a modeling context. For example, represent equations describing satellites orbiting Earth and constraints on Earth’s size and atmosphere."
     )
    ("AII.A-REI.A.2"
     "Solve simple rational and radical equations in one variable, and give examples showing how extraneous solutions may arise."
     )
    ("AII.A-REI.D.11"
     "Explain why the x-coordinates of the points where the graphs of the equations y = f(x) and y = g(x) intersect are the solutions of the equation f(x) = g(x); find the solutions approximately, e.g., using technology to graph the functions, make tables of values, or find successive approximations. Include cases where f(x) and/or g(x) are polynomial, rational, and logarithmic functions."
     )
    ("AII.F-IF.B.4"
     "For a function that models a relationship between two quantities, interpret key features of graphs and tables in terms of the quantities, and sketch graphs showing key features given a verbal description of the relationship. Key features include: intercepts; intervals where the function is increasing, decreasing, positive, or negative; relative maximums and minimums; symmetries; end behavior; and periodicity."
     )
    ("AII.F-IF.B.5"
     "Relate the domain of a function to its graph and, where applicable, to the quantitative relationship it describes.* For example, if the function h(n) gives the number of person-hours it takes to assemble n engines in a factory, then the positive integers would be an appropriate domain for the function."
     )
    ("AII.F-IF.B.6"
     "Calculate and interpret the average rate of change of a function (presented symbolically or as a table) over a specified interval. Estimate the rate of change from a graph."
     )
    ("AII.F-IF.C.7"
     "Graph functions expressed symbolically and show key features of the graph; by hand in simple cases and using technology for more complicated cases."
     )
    ("AII.F-IF.C.7.b"
     "Graph square root and cube root functions."
     )
    ("AII.F-IF.C.7.c"
     "Graph polynomial functions, identifying zeros when suitable factorizations are available, and showing end behavior."
     )
    ("AII.F-IF.C.7.e"
     "Graph exponential and logarithmic functions, showing intercepts and end behavior; and trigonometric functions, showing period, midline, and amplitude."
     )
    ("AII.F-IF.C.8"
     "Write a function defined by an expression in different but equivalent forms to reveal and explain different properties of the function."
     )
    ("AII.F-IF.C.8.a"
     "Use the process of factoring in a polynomial function to show zeros, extreme values, and symmetry of the graph and interpret these in terms of a context."
     )
    ("AII.F-IF.C.9"
     "Translate among different representations of functions (algebraically, graphically, numerically in tables, or by verbal descriptions). Compare properties of two functions each represented in a different way."
     )
    ("AII.F-IF.C.10"
     "Given algebraic, numeric and/or graphical representations of functions, recognize the function as polynomial, rational, logarithmic, exponential, or trigonometric."
     )
    ("AII.F-BF.A.1"
     "Write a function (simple rational, radical, logarithmic, and trigonometric functions) that describes a relationship between two quantities."
     )
    ("AII.F-BF.A.1.b"
     "Combine standard function types using arithmetic operations.* For example, build a function that models the temperature of a cooling body by adding a constant function to a decaying exponential, and relate these functions to the model."
     )
    ("AII.F-BF.B.3"
     "Identify the effect on the graph of replacing f(x) by f(x) + k, kf(x), f(kx), and f(x + k) for specific values of k (both positive and negative); find the value of k given the graphs. Include simple rational, radical, logarithmic, and trigonometric functions. Utilize technology to experiment with cases and illustrate an explanation of the effects on the graph using technolog"
     )
    ("AII.F-BF.B.4"
     "Find inverse functions algebraically and graphically."
     )
    ("AII.F-BF.B.4.a"
     "Solve an equation of the form f(x) = c for a simple function f that has an inverse and write an expression for the inverse. For example, f(x) =2x3 or f(x)= (x + 1)/(x - 1) for x ≠ 1."
     )
    ("AII.F-LE.A.4"
     "For exponential models, express as a logarithm the solution to abct = d where a, c, and d are numbers and the base b is 2, 10, or e; evaluate the logarithm using technology."
     )
    ("AII.F-TF.A.1"
     "Understand radian measure of an angle as the length of the arc on the unit circle subtended by the angle."
     )
    ("AII.F-TF.A.2"
     "Explain how the unit circle in the coordinate plane enables the extension of trigonometric functions to all real numbers, interpreted as radian measures of angles traversed counterclockwise around the unit circle."
     )
    ("AII.F-TF.B.5"
     "Choose trigonometric functions to model periodic phenomena with specified amplitude, frequency, and midline."
     )
    ("AII.F-TF.C.8"
     "Prove the Pythagorean identity sin2(θ) + cos2(θ) = 1 and use it to find sin(θ), cos(θ), or tan(θ) given sin(θ), cos(θ), or tan(θ) and the quadrant."
     )
    ("AII.S-ID.A.4"
     "Use the mean and standard deviation of a data set to fit it to a normal distribution and to estimate population percentages. Recognize that there are data sets for which such a procedure is not appropriate. Use calculators, spreadsheets, and tables to estimate areas under the normal curve."
     )
    ("AII.S-IC.A.1"
     "Understand statistics as a process for making inferences to be made about population parameters based on a random sample from that population."
     )
    ("AII.S-IC.A.2"
     "Decide if a specified model is consistent with results from a given data-generating process, e.g., using simulation. For example, a model says a spinning coin falls heads up with probability 0.5. Would a result of five tails in a row cause you to question the model?"
     )
    ("AII.S-IC.B.3"
     "Recognize the purposes of and differences among sample surveys, experiments, and observational studies; explain how randomization relates to each."
     )
    ("AII.S-IC.B.4"
     "Use data from a sample survey to estimate a population mean or proportion; develop a margin of error through the use of simulation models for random sampling."
     )
    ("AII.S-IC.B.5"
     "Use data from a randomized experiment to compare two treatments; use simulations to decide if differences between parameters are significant."
     )
    ("AII.S-IC.B.6"
     "Evaluate reports based on data."
     )
    ("AII.S-MD.B.6"
     "Use probabilities to make fair decisions (e.g., drawing by lots, using a random number generator)."
     )
    ("AII.S-MD.B.7"
     "Analyze decisions and strategies using probability concepts (e.g., product testing, medical testing, pulling a hockey goalie at the end of a game and replacing the goalie with an extra skater)."
     )
    ("MI.N-Q.A.1"
     "Use units as a way to understand problems; and to guide the solution of multi-step problems; choose and interpret units consistently in formulas; choose and interpret the scale and the origin in graphs and data displays."
     )
    ("MI.N-Q.A.2"
     "Define appropriate quantities for the purpose of descriptive modeling."
     )
    ("MI.N-Q.A.3"
     "Choose a level of accuracy appropriate to limitations on measurement when reporting quantities."
     )
    ("MI.A-SSE.A.1"
     "Interpret expressions that represent a quantity in terms of its context."
     )
    ("MI.A-SSE.A.1.a"
     "Interpret parts of an expression, such as terms, factors, and coefficients."
     )
    ("MI.A-SSE.A.1.b"
     "Interpret complicated expressions by viewing one or more of their parts as a single entity. For example, interpret P(1 + r)n as the product of P and a factor not depending on P."
     )
    ("MI.A-CED.A.1"
     "Create equations and inequalities in one variable and use them to solve problems. Include equations arising from linear and exponential functions with integer exponents."
     )
    ("MI.A-CED.A.2"
     "Create equations in two or more variables to represent relationships between quantities; graph equations on coordinate axes with labels and scales."
     )
    ("MI.A-CED.A.3"
     "Represent constraints by linear equations or inequalities, and by systems of linear equations and/or inequalities, and interpret solutions as viable or non-viable options in a modeling context.* For example, represent inequalities describing nutritional and cost constraints on combinations of different foods."
     )
    ("MI.A-CED.A.4"
     "Rearrange formulas to highlight a quantity of interest, using the same reasoning (Properties of equality) as in solving equations.* For example, rearrange Ohm’s law, V = IR, to solve for resistance, R. Manipulate variables in formulas used in financial contexts such as for simple interest, I=Prt ."
     )
    ("MI.A-REI.A.1"
     "Explain each step in solving a simple linear equation as following from the equality of numbers asserted at the previous step, starting from the assumption that the original equation has a solution. Construct a viable argument to justify or refute a solution method."
     )
    ("MI.A-REI.B.3"
     "Solve linear equations and inequalities in one variable, including equations with coefficients represented by letters."
     )
    ("MI.A-REI.B.3.a"
     "Solve linear equations and inequalities in one variable involving absolute value."
     )
    ("MI.A-REI.C.5"
     "Prove that, given a system of two equations in two variables, replacing one equation by the sum of that equation and a multiple of the other produces a system with the same solutions."
     )
    ("MI.A-REI.C.6"
     "Solve systems of linear equations exactly and approximately (e.g., with graphs), focusing on pairs of linear equations in two variables."
     )
    ("MI.A-REI.D.10"
     "Understand that the graph of an equation in two variables is the set of all its solutions plotted in the coordinate plane, often forming a curve (which could be a line). Show that any point on the graph of an equation in two variables is a solution to the equation."
     )
    ("MI.A-REI.D.11"
     "Explain why the x-coordinates of the points where the graphs of the equations y = f(x) and y = g(x) intersect are the solutions of the equation f(x) = g(x); find the solutions approximately, e.g., using technology to graph the functions and/or make tables of values. Include cases where f(x) and/or g(x) are linear and exponential functions."
     )
    ("MI.A-REI.D.12"
     "Graph the solutions of a linear inequality in two variables as a half-plane (excluding the boundary in the case of a strict inequality), and graph the solution set of a system of linear inequalities in two variables as the intersection of the corresponding half-planes."
     )
    ("MI.F-IF.A.1"
     "Understand that a function from one set (called the domain) to another set (called the range) assigns to each element of the domain exactly one element of the range. If f is a function and x is an element of its domain, then f(x) denotes the output of f corresponding to the input x. The graph of f is the graph of the equation y = f(x)."
     )
    ("MI.F-IF.A.2"
     "Use function notation, evaluate functions for inputs in their domains, and interpret statements that use function notation in terms of a context. For example, given a function representing a car loan, determine the balance of the loan at different points in time."
     )
    ("MI.F-IF.A.3"
     "Recognize that sequences are functions, sometimes defined recursively, whose domain is a subset of the integers. For example, the Fibonacci sequence is defined recursively by f(0) = f(1) = 1, f(n + 1) = f(n) + f(n - 1) for n = 1."
     )
    ("MI.F-IF.B.4"
     "For a function that models a relationship between two quantities, interpret key features of graphs and tables in terms of the quantities, and sketch graphs showing key features given a verbal description of the relationship. Key features include: intercepts; intervals where the function is increasing, decreasing, positive, or negative; relative maximums and minimums; symmetries; and end behavior."
     )
    ("MI.F-IF.B.5"
     "Relate the domain of a function to its graph and, where applicable, to the quantitative relationship it describes.* For example, if the function h(n) gives the number of person-hours it takes to assemble n engines in a factory, then the positive integers would be an appropriate domain for the function."
     )
    ("MI.F-IF.B.6"
     "Calculate and interpret the average rate of change of a function (presented symbolically or as a table) over a specified interval. Estimate the rate of change from a graph."
     )
    ("MI.F-IF.C.7"
     "Graph functions expressed symbolically and show key features of the graph, by hand in simple cases and using technology for more complicated cases."
     )
    ("MI.F-IF.C.7.a"
     "Graph linear functions and show intercepts."
     )
    ("MI.F-IF.C.7.e"
     "Graph exponential functions, showing intercepts and end behavior."
     )
    ("MI.F-IF.C.9"
     "Translate among different representations of functions: (algebraically, graphically, numerically in tables, or by verbal descriptions). Compare properties of two functions each represented in a different way. For example, given a graph of one exponential function and an algebraic expression for another, say which has the larger y-intercept."
     )
    ("MI.F-BF.A.1"
     "Write linear and exponential functions that describe a relationship between two quantities."
     )
    ("MI.F-BF.A.1.a"
     "Determine an explicit expression, a recursive process, or steps for calculation from a context."
     )
    ("MI.F-BF.A.1.b"
     "Combine standard function types using arithmetic operations.* For example, build a function that models the temperature of a cooling body by adding a constant function to a decaying exponential, and relate these functions to the model."
     )
    ("MI.F-BF.A.2"
     "Write arithmetic and geometric sequences both recursively and with an explicit formula, use them to model situations, and translate between the two forms."
     )
    ("MI.F-BF.B.3"
     "Identify the effect on the graph of replacing f(x) by f(x) + k, kf(x), f(kx), and f(x + k) for specific values of k (both positive and negative); find the value of k given the graphs. Include linear and exponential models. (Focus on vertical translations for exponential functions). Utilize technology to experiment with cases and illustrate an explanation of the effects on the graph."
     )
    ("MI.F-LE.A.1"
     "Distinguish between situations that can be modeled with linear functions and with exponential functions."
     )
    ("MI.F-LE.A.1.a"
     "Prove that linear functions grow by equal differences over equal intervals, and that exponential functions grow by equal factors over equal intervals."
     )
    ("MI.F-LE.A.1.b"
     "Recognize situations in which one quantity changes at a constant rate per unit interval relative to another."
     )
    ("MI.F-LE.A.1.c"
     "Recognize situations in which a quantity grows or decays by a constant percent rate per unit interval relative to another."
     )
    ("MI.F-LE.A.2"
     "Construct linear and exponential functions, including arithmetic and geometric sequences, given a graph, a description of a relationship, or two input-output pairs (including reading these from a table)."
     )
    ("MI.F-LE.A.3"
     "Observe using graphs and tables that a quantity increasing exponentially eventually exceeds a quantity increasing linearly."
     )
    ("MI.F-LE.B.5"
     "Interpret the parameters in a linear function or exponential function (of the form f(x) = bx + k) in terms of a context."
     )
    ("MI.G-CO.A.1"
     "Know precise definitions of angle, circle, perpendicular line, parallel line, and line segment, based on the undefined notions of point, line, distance along a line, and distance around a circular arc."
     )
    ("MI.G-CO.A.2"
     "Represent transformations in the plane using, e.g., transparencies and geometry software; describe transformations as functions that take points in the plane as inputs and give other points as outputs. Compare transformations that preserve distance and angle to those that do not (e.g., translation versus horizontal stretch)."
     )
    ("MI.G-CO.A.3"
     "Given a rectangle, parallelogram, trapezoid, or regular polygon, describe the rotations and reflections that carry it onto itself."
     )
    ("MI.G-CO.A.4"
     "Develop definitions of rotations, reflections, and translations in terms of angles, circles, perpendicular lines, parallel lines, and line segments."
     )
    ("MI.G-CO.A.5"
     "Given a geometric figure and a rotation, reflection, or translation, draw the transformed figure using, e.g., graph paper, tracing paper, or geometry software. Specify a sequence of transformations that will carry a given figure onto another."
     )
    ("MI.G-CO.B.6"
     "Use geometric descriptions of rigid motions to transform figures and to predict the effect of a given rigid motion on a given figure; given two figures, use the definition of congruence in terms of rigid motions to decide if they are congruent."
     )
    ("MI.G-CO.B.7"
     "Use the definition of congruence in terms of rigid motions to show that two triangles are congruent if and only if corresponding pairs of sides and corresponding pairs of angles are congruent."
     )
    ("MI.G-CO.B.8"
     "Explain how the criteria for triangle congruence (ASA, SAS, and SSS) follow from the definition of congruence in terms of rigid motions."
     )
    ("MI.G-CO.D.12"
     "Make formal geometric constructions with a variety of tools and methods (compass and straightedge, string, reflective devices, paper folding, dynamic geometric software, etc.). Copying a segment; copying an angle; bisecting a segment; bisecting an angle; constructing perpendicular lines, including the perpendicular bisector of a line segment; and constructing a line parallel to a given line through a point not on the line."
     )
    ("MI.G-CO.D.13"
     "Construct an equilateral triangle, a square, and a regular hexagon inscribed in a circle."
     )
    ("MI.G-GPE.B.5"
     "Prove the slope criteria for parallel and perpendicular lines and use them to solve geometric problems (e.g., find the equation of a line parallel or perpendicular to a given line that passes through a given point)."
     )
    ("MI.G-GPE.B.7"
     "Use coordinates to compute perimeters of polygons and areas of triangles and rectangles (e.g., using the distance formula)."
     )
    ("MI.S-ID.A.1"
     "Represent data with plots on the real number line (dot plots, histograms, and box plots)."
     )
    ("MI.S-ID.A.2"
     "Use statistics appropriate to the shape of the data distribution to compare center (median, mean) and spread (interquartile range, standard deviation) of two or more different data sets."
     )
    ("MI.S-ID.A.3"
     "Interpret differences in shape, center, and spread in the context of the data sets, accounting for possible effects of extreme data points (outliers)."
     )
    ("MI.S-ID.B.5"
     "Summarize categorical data for two categories in two-way frequency tables. Interpret relative frequencies in the context of the data (including joint, marginal, and conditional relative frequencies). Recognize possible associations and trends in the data."
     )
    ("MI.S-ID.B.6"
     "Represent data on two quantitative variables on a scatter plot, and describe how the variables are related."
     )
    ("MI.S-ID.B.6.a"
     "Fit a linear function to the data and use the fitted function to solve problems in the context of the data. Use given functions fitted to data or choose a function suggested by the context. Emphasize linear and exponential models."
     )
    ("MI.S-ID.B.6.b"
     "Informally assess the fit of a function by plotting and analyzing residuals."
     )
    ("MI.S-ID.B.6.c"
     "Fit a linear function for a scatter plot that suggests a linear association."
     )
    ("MI.S-ID.C.7"
     "Interpret the slope (rate of change) and the intercept (constant term) of a linear model in the context of the data."
     )
    ("MI.S-ID.C.8"
     "Compute (using technology) and interpret the correlation coefficient of a linear fit."
     )
    ("MI.S-ID.C.9"
     "Distinguish between correlation and causation."
     )
    ("MII.N-RN.A.1"
     "Explain how the definition of the meaning of rational exponents follows from extending the properties of integer exponents to those values, allowing for a notation for radicals in terms of rational exponents. For example, we define 51/3 to be the cube root of 5 because we want (51/3)3 = 5(1/3)3 to hold, so (51/3)3 must equal 5."
     )
    ("MII.N-RN.A.2"
     "Rewrite expressions involving radicals and rational exponents using the properties of exponents."
     )
    ("MII.N-RN.B.3"
     "Explain why the sum or product of two rational numbers is rational; that the sum of a rational number and an irrational number is irrational; and that the product of a nonzero rational number and an irrational number is irrational."
     )
    ("MII.N-Q.A.3"
     "Choose a level of accuracy appropriate to limitations on measurement when reporting quantities."
     )
    ("MII.N-Q.A.3.a"
     "Describe the effects of approximate error in measurement and rounding on measurements and on computed values from measurements. Identify significant figures in recorded measures and computed values based on the context given and the precision of the tools used to measure"
     )
    ("MII.N-CN.A.1"
     "Know there is a complex number i such that i2 = −1, and every complex number has the form a + bi with a and b real."
     )
    ("MII.N-CN.A.2"
     "Use the relation i2 = –1 and the Commutative, Associative, and Distributive properties to add, subtract, and multiply complex numbers."
     )
    ("MII.N-CN.C.7"
     "Solve quadratic equations with real coefficients that have complex solutions."
     )
    ("MII.A-SSE.A.1"
     "Interpret expressions that represent a quantity in terms of its context."
     )
    ("MII.A-SSE.A.1.a"
     "Interpret parts of an expression, such as terms, factors, and coefficients."
     )
    ("MII.A-SSE.A.1.b"
     "Interpret complicated expressions by viewing one or more of their parts as a single entity. For example, interpret P(1 + r)t as the product of P and a factor not depending on P."
     )
    ("MII.A-SSE.A.2"
     "Use the structure of an expression to identify ways to rewrite it. For example, see (x + 2)2 – 9 as a difference of squares that can be factored as ((x + 2) + 3)((x + 2) – 3)."
     )
    ("MII.A-SSE.B.3"
     "Choose and produce an equivalent form of an expression to reveal and explain properties of the quantity represented by the expression."
     )
    ("MII.A-SSE.B.3.a"
     "Factor a quadratic expression to reveal the zeros of the function it defines."
     )
    ("MII.A-SSE.B.3.b"
     "Complete the square in a quadratic expression to reveal the maximum or minimum value of the function it defines."
     )
    ("MII.A-SSE.B.3.c"
     "Use the properties of exponents to transform expressions for exponential functions. For example, the expression 1.15t can be rewritten as (1.151/12)12t ≈ 1.01212t to reveal the approximate equivalent monthly interest rate if the annual rate is 15%."
     )
    ("MII.A-APR.A.1"
     "Understand that polynomials form a system analogous to the integers, namely, they are closed under certain operations."
     )
    ("MII.A-APR.A.1.a"
     "Perform operations on polynomial expressions (addition, subtraction, multiplication), and compare the system of polynomials to the system of integers when performing operations."
     )
    ("MII.A-APR.A.1.b"
     "Factor and/or expand polynomial expressions; identify and combine like terms; and apply the Distributive property."
     )
    ("MII.A-CED.A.1"
     "Create equations and inequalities in one variable and use them to solve problems. Include equations arising from quadratic and exponential functions."
     )
    ("MII.A-CED.A.2"
     "Create equations in two or more variables to represent relationships between quantities; graph equations on coordinate axes with labels and scales."
     )
    ("MII.A-CED.A.4"
     "Rearrange formulas, including formulas with quadratic terms, to highlight a quantity of interest using the same reasoning as in solving equations (Properties of equality). For example, rearrange Ohm’s law R=V2/P to solve for voltage, V."
     )
    ("MII.A-REI.B.4"
     "Solve quadratic equations in one variable."
     )
    ("MII.A-REI.B.4.a"
     "Use the method of completing the square to transform any quadratic equation in x into an equation of the form (x – p)2 = q that has the same solutions. Derive the quadratic formula from this form."
     )
    ("MII.A-REI.B.4.b"
     "Solve quadratic equations by inspection (e.g., for x2 = 49), taking square roots, completing the square, the quadratic formula, and factoring, as appropriate to the initial form of the equation. Recognize when the quadratic formula gives complex solutions and write them as a ± bi for real numbers a and b."
     )
    ("MII.A-REI.C.7"
     "Solve a simple system consisting of a linear equation and a quadratic equation in two variables algebraically and graphically. For example, find the points of intersection between the line y = –3x and the circle x2 + y2 = 3."
     )
    ("MII.F-IF.B.4"
     "For a function that models a relationship between two quantities, interpret key features of graphs and tables in terms of the quantities, and sketch graphs showing key features given a verbal description of the relationship. Key features include: intercepts; intervals where the function is increasing, decreasing, positive, or negative; relative maximums and minimums; symmetries; and end behavior."
     )
    ("MII.F-IF.B.5"
     "Relate the domain of a function to its graph and, where applicable, to the quantitative relationship it describes.* For example, if the function h(n) gives the number of person-hours it takes to assemble n engines in a factory, then the positive integers would be an appropriate domain for the function."
     )
    ("MII.F-IF.B.6"
     "Calculate and interpret the average rate of change of a function (presented symbolically or as a table) over a specified interval. Estimate the rate of change from a graph."
     )
    ("MII.F-IF.C.7"
     "Graph functions expressed symbolically and show key features of the graph, by hand in simple cases and using technology for more complicated cases."
     )
    ("MII.F-IF.C.7.a"
     "Graph quadratic functions and show intercepts, maxima, and minima."
     )
    ("MII.F-IF.C.7.b"
     "Graph piecewise-defined functions, including step functions and absolute value functions."
     )
    ("MII.F-IF.C.8"
     "Write a function defined by an expression in different but equivalent forms to reveal and explain different properties of the function."
     )
    ("MII.F-IF.C.8.a"
     "Use the process of factoring and completing the square in a quadratic function to show zeros, minimum/maximum values, and symmetry of the graph and interpret these in terms of a context."
     )
    ("MII.F-IF.C.8.b"
     "Use the properties of exponents to interpret expressions for exponential functions. Apply to financial situations such as Identifying appreciation/depreciation rate for the value of a house or car some time after its initial purchase: Vn=P(1+r)n. For example, identify percent rate of change in functions such as y = (1.02)t, y = (0.97)t, y = (1.01)12t, and y = (1.2) t /10, and classify them as representing exponential growth or decay."
     )
    ("MII.F-IF.C.9"
     "Translate among different representations of functions (algebraically, graphically, numerically in tables, or by verbal descriptions). Compare properties of two functions each represented in a different way. For example, given a graph of one quadratic function and an algebraic expression for another, say which has the larger maximum."
     )
    ("MII.F-BF.A.1"
     "Write linear, quadratic, and exponential functions that describe relationships between two quantities."
     )
    ("MII.F-BF.A.1.a"
     "Determine an explicit expression, a recursive process, or steps for calculation from a context."
     )
    ("MII.F-BF.A.1.b"
     "Combine standard function types using arithmetic operations.* For example, build a function that models the temperature of a cooling body by adding a constant function to a decaying exponential, and relate these functions to the model."
     )
    ("MII.F-BF.B.3"
     "Identify the effect on the graph of replacing f(x) by f(x) + k, kf(x), f(kx), and f(x + k) for specific values of k (both positive and negative); find the value of k given the graphs. Include exponential, quadratic, and absolute value functions. Utilize technology to experiment with cases and illustrate an explanation of the effects on the graph."
     )
    ("MII.F-BF.B.4"
     "Find inverse functions algebraically and graphically."
     )
    ("MII.F-BF.B.4.a"
     "Solve an equation of the form f(x) = c for a linear function f that has an inverse and write an expression for the inverse."
     )
    ("MII.F-LE.A.3"
     "Observe using graphs and tables that a quantity increasing exponentially eventually exceeds a quantity increasing linearly, quadratically, or (more generally) as a polynomial function."
     )
    ("MII.G-CO.C.9"
     "Prove theorems about lines and angles. Theorems include: vertical angles are congruent; when a transversal crosses parallel lines, alternate interior angles are congruent and corresponding angles are congruent, and conversely prove lines are parallel; points on a perpendicular bisector of a line segment are exactly those equidistant from the segment’s endpoints."
     )
    ("MII.G-CO.C.10"
     "Prove theorems about triangles. Theorems include: measures of interior angles of a triangle sum to 180°; base angles of isosceles triangles are congruent, and conversely prove a triangle is isosceles; the segment joining midpoints of two sides of a triangle is parallel to the third side and half the length; the medians of a triangle meet at a point."
     )
    ("MII.G-CO.C.11"
     "Prove theorems about parallelograms. Theorems include: opposite sides are congruent, opposite angles are congruent, the diagonals of a parallelogram bisect each other, and conversely, rectangles are parallelograms with congruent diagonals."
     )
    ("MII.G-CO.C.11.a"
     "Prove theorems about polygons. Theorems include the measures of interior and exterior angles. Apply properties of polygons to the solutions of mathematical and contextual problems."
     )
    ("MII.G-SRT.A.1"
     "Verify experimentally the properties of dilations given by a center and a scale factor:"
     )
    ("MII.G-SRT.A.1.a"
     "A dilation takes a line not passing through the center of the dilation to a parallel line, and leaves a line passing through the center unchanged."
     )
    ("MII.G-SRT.A.1.b"
     "The dilation of a line segment is longer or shorter in the ratio given by the scale factor."
     )
    ("MII.G-SRT.A.2"
     "Given two figures, use the definition of similarity in terms of similarity transformations to decide if they are similar; explain using similarity transformations the meaning of similarity for triangles as the equality of all corresponding pairs of angles and the proportionality of all corresponding pairs of sides."
     )
    ("MII.G-SRT.A.3"
     "Use the properties of similarity transformations to establish the Angle-Angle (AA) criterion for two triangles to be similar."
     )
    ("MII.G-SRT.B.4"
     "Prove theorems about triangles. Theorems include: a line parallel to one side of a triangle divides the other two proportionally, and conversely; the Pythagorean Theorem proved using triangle similarity."
     )
    ("MII.G-SRT.B.5"
     "Use congruence and similarity criteria for triangles to solve problems and to prove relationships in geometric figures."
     )
    ("MII.G-SRT.C.6"
     "Understand that by similarity, side ratios in right triangles are properties of the angles in the triangle, leading to definitions of trigonometric ratios for acute angles."
     )
    ("MII.G-SRT.C.7"
     "Explain and use the relationship between the sine and cosine of complementary angles."
     )
    ("MII.G-SRT.C.8"
     "Use trigonometric ratios and the Pythagorean Theorem to solve right triangles in applied problems."
     )
    ("MII.G-C.A.1"
     "Prove that all circles are similar."
     )
    ("MII.G-C.A.2"
     "Identify and describe relationships among inscribed angles, radii, and chords. Include the relationship between central, inscribed, and circumscribed angles; inscribed angles on a diameter are right angles; the radius of a circle is perpendicular to the tangent where the radius intersects the circle."
     )
    ("MII.G-C.A.3"
     "Construct the inscribed and circumscribed circles of a triangle, and prove properties of angles for a quadrilateral and other polygons inscribed in a circle."
     )
    ("MII.G-C.A.4"
     "Construct a tangent line from a point outside a given circle to the circle."
     )
    ("MII.G-C.B.5"
     "Derive, using similarity, the fact that the length of the arc intercepted by an angle is proportional to the radius, and define the radian measure of the angle as the constant of proportionality; derive the formula for the area of a sector."
     )
    ("MII.G-GPE.A.1"
     "Derive the equation of a circle of given center and radius using the Pythagorean Theorem; complete the square to find the center and radius of a circle given by an equation."
     )
    ("MII.G-GPE.A.2"
     "Derive the equation of a parabola given a focus and directrix."
     )
    ("MII.G-GPE.B.4"
     "Use coordinates to prove simple geometric theorems algebraically including the distance formula and its relationship to the Pythagorean Theorem. For example, prove or disprove that a figure defined by four given points in the coordinate plane is a rectangle; prove or disprove that the point (1, √3) lies on the circle centered at the origin and containing the point (0, 2)."
     )
    ("MII.G-GPE.B.6"
     "Find the point on a directed line segment between two given points that partitions the segment in a given ratio."
     )
    ("MII.G-GMD.A.1"
     "Give an informal argument for the formulas for the circumference of a circle, area of a circle, volume of a cylinder, pyramid, and cone. Use dissection arguments, Cavalieri’s principle, and informal limit arguments."
     )
    ("MII.G-GMD.A.2"
     "Give an informal argument using Cavalieri’s principle for the formulas for the volume of a sphere and other solid figures."
     )
    ("MII.G-GMD.A.3"
     "Use volume formulas for cylinders, pyramids, cones, and spheres to solve problems."
     )
    ("MII.S-CP.A.1"
     "Describe events as subsets of a sample space (the set of outcomes) using characteristics (or categories) of the outcomes, or as unions, intersections, or complements of other events (“or,” “and,” “not”)."
     )
    ("MII.S-CP.A.2"
     "Understand that two events A and B are independent if the probability of A and B occurring together is the product of their probabilities, and use this characterization to determine if they are independent."
     )
    ("MII.S-CP.A.3"
     "Understand the conditional probability of A given B as P(A and B)/P(B), and interpret independence of A and B as saying that the conditional probability of A given B is the same as the probability of A, and the conditional probability of B given A is the same as the probability of B."
     )
    ("MII.S-CP.A.4"
     "Construct and interpret two-way frequency tables of data when two categories are associated with each object being classified. Use the two-way table as a sample space to decide if events are independent and to approximate conditional probabilities.* For example, collect data from a random sample of students in your school on their favorite subject among math, science, and English. Estimate the probability that a randomly selected student from your school will favor science given that the student is in tenth grade. Do the same for other subjects and compare the results."
     )
    ("MII.S-CP.A.5"
     "Recognize and explain the concepts of conditional probability and independence in everyday language and everyday situations.* For example, compare the chance of having lung cancer if you are a smoker with the chance of being a smoker if you have lung cancer."
     )
    ("MII.S-CP.B.6"
     "Find the conditional probability of A given B as the fraction of B’s outcomes that also belong to A, and interpret the answer in terms of the model."
     )
    ("MII.S-CP.B.7"
     "Apply the Addition Rule, P(A or B) = P(A) + P(B) – P(A and B), and interpret the answer in terms of the model."
     )
    ("MII.S-CP.B.8"
     "Apply the general Multiplication Rule in a uniform probability model, P(A and B) = P(A)P(B|A) = P(B)P(A|B), and interpret the answer in terms of the model."
     )
    ("MII.S-CP.B.9"
     "Use permutations and combinations to compute probabilities of compound events and solve problems."
     )
    ("MIII.N-CN.C.8"
     "Extend polynomial identities to the complex numbers. For example, rewrite x2 + 4 as (x + 2i)(x – 2i)."
     )
    ("MIII.N-CN.C.9"
     "Know the Fundamental Theorem of Algebra; show that it is true for quadratic polynomials."
     )
    ("MIII.N-VM.A.1"
     "Recognize vector quantities as having both magnitude and direction. Represent vector quantities by directed line segments, and use appropriate symbols for vectors and their magnitudes (e.g., v, |v|, ||v||, v)."
     )
    ("MIII.N-VM.A.3"
     "Solve problems involving velocity and other quantities that can be represented by vectors."
     )
    ("MIII.N-VM.C.6"
     "Use matrices to represent and manipulate data, e.g., to represent payoffs or incidence relationships in a network."
     )
    ("MIII.N-VM.C.8"
     "Add, subtract, and multiply matrices of appropriate dimensions."
     )
    ("MIII.N-VM.C.12"
     "Work with 2 × 2 matrices as transformations of the plane, and interpret the absolute value of the determinant in terms of area."
     )
    ("MIII.A-SSE.A.1"
     "Interpret expressions that represent a quantity in terms of its context."
     )
    ("MIII.A-SSE.A.1.a"
     "Interpret parts of an expression, such as terms, factors, and coefficients."
     )
    ("MIII.A-SSE.A.1.b"
     "Interpret complicated expressions by viewing one or more of their parts as a single entity. For example, interpret P(1 + r)n as the product of P and a factor not depending on P."
     )
    ("MIII.A-SSE.A.2"
     "Use the structure of an expression to identify ways to rewrite it. For example, see x4 – y4 as (x2)2 – (y2)2, thus recognizing it as a difference of squares that can be factored as (x2 – y2)(x2 + y2) and as (x-y)(x+y)(x-yi)(x+yi)."
     )
    ("MIII.A-SSE.B.4"
     "Derive the formula for the sum of a finite geometric series (when the common ratio is not 1), and use the formula to solve problems.* For example, calculate mortgage payments."
     )
    ("MIII.A-APR.A.1"
     "Understand that polynomials form a system analogous to the integers, namely, they are closed under certain operations."
     )
    ("MIII.A-APR.A.1.a"
     "Perform operations on polynomial expressions (addition, subtraction, multiplication, and division), and compare the system of polynomials to the system of integers when performing operations."
     )
    ("MIII.A-APR.B.2"
     "Know and apply the Remainder Theorem: For a polynomial p(x) and a number a, the remainder on division by x – a is p(a), so p(a) = 0 if and only if (x – a) is a factor of p(x)."
     )
    ("MIII.A-APR.B.3"
     "Identify zeros of polynomials when suitable factorizations are available, and use the zeros to construct a rough graph of the function defined by the polynomial."
     )
    ("MIII.A-APR.C.4"
     "Provide polynomial identities and use them to describe numerical relationships. For example, the polynomial identity (x2 + y2)2 = (x2 – y2)2 + (2xy)2 can be used to generate Pythagorean triples."
     )
    ("MIII.A-APR.C.5"
     "Know and apply the Binomial Theorem for the expansion of (x + y)n in powers of x and y for a positive integer n, where x and y are any numbers, with coefficients determined for example by Pascal’s Triangle."
     )
    ("MIII.A-APR.D.6"
     "Rewrite simple rational expressions in different forms; write a(x)/b(x) in the form q(x) + r(x)/b(x), where a(x), b(x), q(x), and r(x) are polynomials with the degree of r(x) less than the degree of b(x), using inspection, long division, or, for the more complicated examples, a computer algebra system."
     )
    ("MIII.A-APR.D.7"
     "Understand that rational expressions form a system analogous to the rational numbers, closed under addition, subtraction, multiplication, and division by a nonzero rational expression; add, subtract, multiply, and divide rational expressions."
     )
    ("MIII.A-CED.A.1"
     "Create equations and inequalities in one variable and use them to solve problems. (Include equations arising from simple root and rational functions.)"
     )
    ("MIII.A-CED.A.2"
     "Create equations in two or more variables to represent relationships between quantities; graph equations on coordinate axes with labels and scales."
     )
    ("MIII.A-CED.A.3"
     "Represent constraints by equations or inequalities and by systems of equations and/or inequalities, and interpret solutions as viable or non-viable options in a modeling context.* For example, represent equations describing satellites orbiting earth and constraints on earth’s size and atmosphere."
     )
    ("MIII.A-REI.A.2"
     "Solve simple rational and radical equations in one variable, and give examples showing how extraneous solutions may arise."
     )
    ("MIII.A-REI.D.11"
     "Explain why the x-coordinates of the points where the graphs of the equations y = f(x) and y = g(x) intersect are the solutions of the equation f(x) = g(x); find the solutions approximately, e.g., using technology to graph the functions, make tables of values, or find successive approximations. Include cases where f(x) and/or g(x) are polynomial, rational, and logarithmic functions."
     )
    ("MIII.F-IF.B.4"
     "For a function that models a relationship between two quantities, interpret key features of graphs and tables in terms of the quantities, and sketch graphs showing key features given a verbal description of the relationship. Key features include: intercepts; intervals where the function is increasing, decreasing, positive, or negative; relative maximums and minimums; symmetries; end behavior; and periodicity."
     )
    ("MIII.F-IF.B.5"
     "Relate the domain of a function to its graph and, where applicable, to the quantitative relationship it describes.* For example, if the function h(n) gives the number of person-hours it takes to assemble n engines in a factory, then the positive integers would be an appropriate domain for the function."
     )
    ("MIII.F-IF.B.6"
     "Calculate and interpret the average rate of change of a function (presented symbolically or as a table) over a specified interval. Estimate the rate of change from a graph."
     )
    ("MIII.F-IF.C.7"
     "Graph functions expressed symbolically and show key features of the graph, by hand in simple cases and using technology for more complicated cases."
     )
    ("MIII.F-IF.C.7.b"
     "Graph square root and cube root functions."
     )
    ("MIII.F-IF.C.7.c"
     "Graph polynomial functions, identifying zeros when suitable factorizations are available, and showing end behavior."
     )
    ("MIII.F-IF.C.7.e"
     "Graph exponential and logarithmic functions, showing intercepts and end behavior, and trigonometric functions, showing period, midline, and amplitude."
     )
    ("MIII.F-IF.C.8"
     "Write a function defined by an expression in different but equivalent forms to reveal and explain different properties of the function."
     )
    ("MIII.F-IF.C.8.a"
     "Use the process of factoring in a polynomial function to show zeros, extreme values, and symmetry of the graph, and interpret these in terms of a context."
     )
    ("MIII.F-IF.C.9"
     "Translate among different representations of functions: (algebraically, graphically, numerically in tables, or by verbal descriptions). Compare properties of two functions each represented in a different way. For example, given a graph of one polynomial function and an algebraic expression for another, say which has the larger relative maximum and/or smaller relative minimum."
     )
    ("MIII.F-IF.C.10"
     "Given algebraic, numeric and/or graphical representations of functions, recognize the function as polynomial, rational, logarithmic, exponential, or trigonometric."
     )
    ("MIII.F-BF.A.1"
     "Write simple rational and radical functions, logarithmic, and trigonometric functions that describes a relationship between two quantities."
     )
    ("MIII.F-BF.A.1.b"
     "Combine standard function types using arithmetic operations.* For example, build a function that models the temperature of a cooling body by adding a constant function to a decaying exponential, and relate these functions to the model (include simple rational and radical functions, logarithmic, and trigonometric functions)."
     )
    ("MIII.F-BF.B.3"
     "Identify the effect on the graph of replacing f(x) by f(x) + k, kf(x), f(kx), and f(x + k) for specific values of k (both positive and negative); find the value of k given the graphs. Include simple rational, radical, logarithmic, and trigonometric functions. Experiment with cases and illustrate an explanation of the effects on the graph using technology. Include recognizing even and odd functions from their graphs and algebraic expressions for them."
     )
    ("MIII.F-BF.B.4"
     "Find inverse functions algebraically and graphically."
     )
    ("MIII.F-BF.B.4.a"
     "Solve an equation of the form f(x) = c for a simple function f that has an inverse and write an expression for the inverse. For example, f(x) =2x3 or f(x) = (x + 1)/(x - 1) for x ≠ 1."
     )
    ("MIII.F-LE.A.4"
     "For exponential models, express as a logarithm the solution to abct = d where a, c, and d are numbers and the base b is 2, 10, or e; evaluate the logarithm using technology."
     )
    ("MIII.F-TF.A.1"
     "Understand radian measure of an angle as the length of the arc on the unit circle subtended by the angle."
     )
    ("MIII.F-TF.A.2"
     "Explain how the unit circle in the coordinate plane enables the extension of trigonometric functions to all real numbers, interpreted as radian measures of angles traversed counterclockwise around the unit circle."
     )
    ("MIII.F-TF.B.5"
     "Choose trigonometric functions to model periodic phenomena with specified amplitude, frequency, and midline."
     )
    ("MIII.F-TF.C.8"
     "Prove the Pythagorean identity sin2(θ) + cos2(θ) = 1 and use it to find sin(θ), cos(θ), or tan(θ) given sin(θ), cos(θ), or tan(θ) and the quadrant."
     )
    ("MIII.G-SRT.D.9"
     "Derive the formula A = ½ ab sin(C) for the area of a triangle by drawing an auxiliary line from a vertex perpendicular to the opposite side."
     )
    ("MIII.G-SRT.D.10"
     "Prove the Laws of Sines and Cosines and use them to solve problems."
     )
    ("MIII.G-SRT.D.11"
     "Understand and apply the Law of Sines and the Law of Cosines to find unknown measurements in right and non-right triangles (e.g., surveying problems, resultant forces)."
     )
    ("MIII.G-GMD.B.4"
     "Identify the shapes of two-dimensional cross-sections of three-dimensional objects, and identify three-dimensional objects generated by rotations of two-dimensional objects."
     )
    ("MIII.G-MG.A.1"
     "Use geometric shapes, their measures, and their properties to describe objects (e.g., modeling a tree trunk or a human torso as a cylinder)."
     )
    ("MIII.G-MG.A.2"
     "Apply concepts of density based on area and volume in modeling situations (e.g., persons per square mile, BTUs per cubic foot)."
     )
    ("MIII.G-MG.A.3"
     "Apply geometric methods to solve design problems (e.g., designing an object or structure to satisfy physical constraints or minimize cost; working with typographic grid systems based on ratios)."
     )
    ("MIII.G-MG.A.4"
     "Use dimensional analysis for unit conversions to confirm that expressions and equations make sense."
     )
    ("MIII.S-ID.A.4"
     "Use the mean and standard deviation of a data set to fit it to a normal distribution and to estimate population percentages. Recognize that there are data sets for which such a procedure is not appropriate. Use calculators, spreadsheets, and tables to estimate areas under the normal curve."
     )
    ("MIII.S-IC.A.1"
     "Understand statistics as a process for making inferences to be made about population parameters based on a random sample from that population."
     )
    ("MIII.S-IC.A.2"
     "Decide if a specified model is consistent with results from a given data-generating process, e.g., using simulation.* For example, a model says a spinning coin falls heads up with probability 0.5. Would a result of five tails in a row cause you to question the model?"
     )
    ("MIII.S-IC.B.3"
     "Recognize the purposes of and differences among sample surveys, experiments, and observational studies; explain how randomization relates to each."
     )
    ("MIII.S-IC.B.4"
     "Use data from a sample survey to estimate a population mean or proportion; develop a margin of error through the use of simulation models for random sampling."
     )
    ("MIII.S-IC.B.5"
     "Use data from a randomized experiment to compare two treatments; use simulations to decide if differences between parameters are significant."
     )
    ("MIII.S-IC.B.6"
     "Evaluate reports based on data."
     )
    ("MIII.S-MD.B.6"
     "Use probabilities to make fair decisions (e.g., drawing by lots, using a random number generator)."
     )
    ("MIII.S-MD.B.7"
     "Analyze decisions and strategies using probability concepts (e.g., product testing, medical testing, pulling a hockey goalie at the end of a game and replacing the goalie with an extra skater)."
     )
    ("PC.N-CN.A.3"
     "Find the conjugate of a complex number; use conjugates to find moduli and quotients of complex numbers."
     )
    ("PC.N-CN.B.4"
     "Represent complex numbers on the complex plane in rectangular and polar form (including real and imaginary numbers), and explain why the rectangular and polar forms of a given complex number represent the same number."
     )
    ("PC.N-CN.B.5"
     "Represent addition, subtraction, multiplication, and conjugation of complex numbers geometrically on the complex plane; use properties of this representation for computation. For example: (-1+√3i)3=8 because (-1+ √3i) has modulus 2 and argument 120°."
     )
    ("PC.N-CN.B.6"
     "Calculate the distance between numbers in the complex plane as the modulus of the difference, and the midpoint of a segment as the average of the numbers at its endpoints."
     )
    ("PC.N-CN.C.8"
     "Extend polynomial identities to the complex numbers. For example, rewrite x2 + 4 as (x + 2i)(x – 2i)."
     )
    ("PC.N-CN.C.9"
     "Know the Fundamental Theorem of Algebra; show that it is true for quadratic polynomials."
     )
    ("PC.N-VM.A.1"
     "Recognize vector quantities as having both magnitude and direction. Represent vector quantities by directed line segments, and use appropriate symbols for vectors and their magnitudes (e.g., v, |v|, ||v||, v)."
     )
    ("PC.N-VM.A.2"
     "Find the components of a vector by subtracting the coordinates of an initial point from the coordinates of a terminal point."
     )
    ("PC.N-VM.A.3"
     "Solve problems involving velocity and other quantities that can be represented by vectors."
     )
    ("PC.N-VM.B.4"
     "Add and subtract vectors."
     )
    ("PC.N-VM.B.4.a"
     "Add vectors end-to-end, component-wise, and by the parallelogram rule. Understand that the magnitude of a sum of two vectors is typically not the sum of the magnitudes."
     )
    ("PC.N-VM.B.4.b"
     "Given two vectors in magnitude and direction form, determine the magnitude and direction of their sum."
     )
    ("PC.N-VM.B.4.c"
     "Understand vector subtraction v – w as v + (–w), where –w is the additive inverse of w, with the same magnitude as w and pointing in the opposite direction. Represent vector subtraction graphically by connecting the tips in the appropriate order, and perform vector subtraction component-wise."
     )
    ("PC.N-VM.B.5"
     "Multiply a vector by a scalar."
     )
    ("PC.N-VM.B.5.a"
     "Represent scalar multiplication graphically by scaling vectors and possibly reversing their direction; perform scalar multiplication component-wise, e.g., as c(vx, vy) = (cvx, cvy)."
     )
    ("PC.N-VM.B.5.b"
     "Compute the magnitude of a scalar multiple cv using ||cv|| = |c|v. Compute the direction of cv knowing that when |c|v ? 0, the direction of cv is either along v (for c > 0) or against v (for c < 0)."
     )
    ("PC.N-VM.C.6"
     "Use matrices to represent and manipulate data, e.g., to represent payoffs or incidence relationships in a network."
     )
    ("PC.N-VM.C.7"
     "Multiply matrices by scalars to produce new matrices, e.g., as when all of the payoffs in a game are doubled."
     )
    ("PC.N-VM.C.8"
     "Add, subtract, and multiply matrices of appropriate dimensions."
     )
    ("PC.N-VM.C.9"
     "Understand that, unlike multiplication of numbers, matrix multiplication for square matrices is not a Commutative operation, but still satisfies the Associative and Distributive properties."
     )
    ("PC.N-VM.C.10"
     "Understand that the zero and identity matrices play a role in matrix addition and multiplication similar to the role of 0 and 1 in the real numbers. The determinant of a square matrix is nonzero if and only if the matrix has a multiplicative inverse."
     )
    ("PC.N-VM.C.11"
     "Multiply a vector (regarded as a matrix with one column) by a matrix of suitable dimensions to produce another vector. Work with matrices as transformations of vectors."
     )
    ("PC.N-VM.C.12"
     "Work with 2 × 2 matrices as transformations of the plane, and interpret the absolute value of the determinant in terms of area."
     )
    ("PC.A-APR.C.5"
     "Know and apply the Binomial Theorem for the expansion of (x + y)n in powers of x and y for a positive integer n, where x and y are any numbers, with coefficients determined for example by Pascal’s Triangle."
     )
    ("PC.A-APR.D.7"
     "Understand that rational expressions form a system analogous to the rational numbers, closed under addition, subtraction, multiplication, and division by a nonzero rational expression; add, subtract, multiply, and divide rational expressions."
     )
    ("PC.A-REI.C.8"
     "Represent a system of linear equations as a single matrix equation in a vector variable."
     )
    ("PC.A-REI.C.9"
     "Find the inverse of a matrix if it exists and use it to solve systems of linear equations (using technology for matrices of dimension 3 × 3 or greater)."
     )
    ("PC.F-IF.C.7"
     "Graph functions expressed symbolically and show key features of the graph, by hand in simple cases and using technology for more complicated cases."
     )
    ("PC.F-IF.C.7.d"
     "Graph rational functions, identifying zeros and asymptotes when suitable factorizations are available, and showing end behavior."
     )
    ("PC.F-BF.A.1"
     "Write a function that describes a relationship between two quatities."
     )
    ("PC.F-BF.A.1.c"
     "Compose functions.* For example, if T(y) is the temperature in the atmosphere as a function of height, and h(t) is the height of a weather balloon as a function of time, then T(h(t)) is the temperature at the location of the weather balloon as a function of time."
     )
    ("PC.F-BF.B.4"
     "Find inverse functions."
     )
    ("PC.F-BF.B.4.b"
     "Verify by composition that one function is the inverse of another."
     )
    ("PC.F-BF.B.4.c"
     "Read values of an inverse function from a graph or a table, given that the function has an inverse."
     )
    ("PC.F-BF.B.4.d"
     "Produce an invertible function from a non-invertible function by restricting the domain."
     )
    ("PC.F-BF.B.5"
     "Understand the inverse relationship between exponents and logarithms and use this relationship to solve problems involving logarithms and exponents."
     )
    ("PC.F-TF.A.3"
     "Use special triangles to determine geometrically the values of sine, cosine, tangent for π/3, π/4 and π/6, and use the unit circle to express the values of sine, cosine, and tangent for π-x, π + x, and 2π - x in terms of their values for x, where x is any real number."
     )
    ("PC.F-TF.A.4"
     "Use the unit circle to explain symmetry (odd and even) and periodicity of trigonometric functions."
     )
    ("PC.F-TF.B.6"
     "Understand that restricting a trigonometric function to a domain on which it is always increasing or always decreasing allows its inverse to be constructed."
     )
    ("PC.F-TF.B.7"
     "Use inverse functions to solve trigonometric equations that arise in modeling contexts; evaluate the solutions using technology, and interpret them in terms of the context."
     )
    ("PC.F-TF.C.9"
     "Prove the addition and subtraction formulas for sine, cosine, and tangent and use them to solve problems."
     )
    ("PC.G-SRT.D.9"
     "Derive the formula A = ½ ab sin(C) for the area of a triangle by drawing an auxiliary line from a vertex perpendicular to the opposite side."
     )
    ("PC.G-SRT.D.10"
     "Prove the Laws of Sines and Cosines and use them to solve problems."
     )
    ("PC.G-SRT.D.11"
     "Understand and apply the Law of Sines and the Law of Cosines to find unknown measurements in right and non-right triangles (e.g., surveying problems, resultant forces)."
     )
    ("PC.G-C.A.4"
     "Construct a tangent line from a point outside a given circle to the circle."
     )
    ("PC.G-GPE.A.3"
     "Derive the equations of ellipses and hyperbolas given the foci, using the fact that the sum or difference of distances from the foci is constant."
     )
    ("PC.G-GPE.A.3.a"
     "Use equations and graphs of conic sections to model real-world problems."
     )
    ("PC.G-GMD.A.2"
     "Give an informal argument using Cavalieri’s principle for the formulas for the volume of a sphere and other solid figures."
     )
    ("AQR.N-VM.A.1"
     "Recognize vector quantities as having both magnitude and direction. Represent vector quantities by directed line segments, and use appropriate symbols for vectors and their magnitudes (e.g., v, |v|, ||v||, v)."
     )
    ("AQR.N-VM.A.2"
     "Find the components of a vector by subtracting the coordinates of an initial point from the coordinates of a terminal point."
     )
    ("AQR.N-VM.A.3"
     "Solve problems involving velocity and other quantities that can be represented by vectors."
     )
    ("AQR.N-VM.C.6"
     "Use matrices to represent and manipulate data, e.g., to represent payoffs or incidence relationships in a network."
     )
    ("AQR.N-VM.C.7"
     "Multiply matrices by scalars to produce new matrices, e.g., as when all of the payoffs in a game are doubled."
     )
    ("AQR.N-VM.C.8"
     "Add, subtract, and multiply matrices of appropriate dimensions."
     )
    ("AQR.N-VM.C.9"
     "Understand that, unlike multiplication of numbers, matrix multiplication for square matrices is not a Commutative operation, but still satisfies the Associative and Distributive properties."
     )
    ("AQR.N-VM.C.10"
     "Understand that the zero and identity matrices play a role in matrix addition and multiplication similar to the role of 0 and 1 in the real numbers. The determinant of a square matrix is nonzero if and only if the matrix has a multiplicative inverse."
     )
    ("AQR.N-VM.C.11"
     "Multiply a vector (regarded as a matrix with one column) by a matrix of suitable dimensions to produce another vector. Work with matrices as transformations of vectors."
     )
    ("AQR.N-VM.C.12"
     "Work with 2 ×2 matrices as transformations of the plane, and interpret the absolute value of the determinant in terms of area."
     )
    ("AQR.A-APR.C.5"
     "Know and apply the Binomial Theorem for the expansion of (x + y)n in powers of x and y for a positive integer n, where x and y are any numbers, with coefficients determined for example by Pascal’s Triangle."
     )
    ("AQR.A-REI.C.8"
     "Represent a system of linear equations as a single matrix equation in a vector variable."
     )
    ("AQR.A-REI.C.9"
     "Find the inverse of a matrix if it exists and use it to solve systems of linear equations (using technology for matrices of dimension 3 × 3 or greater)."
     )
    ("AQR.F-TF.A.3"
     "Use special triangles to determine geometrically the values of sine, cosine, tangent for π/3, π/4 and π/6, and use the unit circle to express the values of sine, cosine, and tangent for π-x, π + x, and 2π - x in terms of their values for x, where x is any real number."
     )
    ("AQR.F-TF.A.4"
     "Use the unit circle to explain symmetry (odd and even) and periodicity of trigonometric functions."
     )
    ("AQR.F-TF.B.7"
     "Use inverse functions to solve trigonometric equations that arise in modeling contexts; evaluate the solutions using technology, and interpret them in terms of the context."
     )
    ("AQR.F-TF.C.9"
     "Prove the addition and subtraction formulas for sine, cosine, and tangent and use them to solve problems."
     )
    ("AQR.G-SRT.D.11"
     "Understand and apply the Law of Sines and the Law of Cosines to find unknown measurements in right and non-right triangles (e.g., surveying problems, resultant forces)."
     )
    ("AQR.G-C.A.4"
     "Construct a tangent line from a point outside a given circle to the circle."
     )
    ("AQR.G-GPE.A.3"
     "Derive the equations of ellipses and hyperbolas given the foci, using the fact that the sum or difference of distances from the foci is constant."
     )
    ("AQR.G-GPE.A.3.a"
     "Use equations and graphs of conic sections to model real-world problems."
     )
    ("AQR.G-GMD.A.2"
     "Give an informal argument using Cavalieri’s principle for the formulas for the volume of a sphere and other solid figures."
     )
    ("AQR.S-CP.B.8"
     "Apply the general Multiplication Rule in a uniform probability model, P(A and B) = P(A)P(B|A) = P(B)P(A|B), and interpret the answer in terms of the model."
     )
    ("AQR.S-CP.B.9"
     "Use permutations and combinations to compute probabilities of compound events and solve problems."
     )
    ("AQR.S-MD.A.1"
     "Define a random variable for a quantity of interest by assigning a numerical value to each event in a sample space; graph the corresponding probability distribution using the same graphical displays as for data distributions."
     )
    ("AQR.S-MD.A.2"
     "Calculate the expected value of a random variable; interpret it as the mean of the probability distribution."
     )
    ("AQR.S-MD.A.3"
     "Develop a probability distribution for a random variable defined for a sample space in which theoretical probabilities can be calculated; find the expected value.* For example, find the theoretical probability distribution for the number of correct answers obtained by guessing on all five questions of a multiple-choice test where each question has four choices, and find the expected grade under various grading schemes."
     )
    ("AQR.S-MD.A.4"
     "Develop a probability distribution for a random variable defined for a sample space in which probabilities are assigned empirically; find the expected value.* For example, find a current data distribution on the number of TV sets per household in the United States, and calculate the expected number of sets per household. How many TV sets would you expect to find in 100 randomly selected households?"
     )
    ("AQR.S-MD.B.5"
     "Weigh the possible outcomes of a decision by assigning probabilities to payoff values and finding expected values."
     )
    ("AQR.S-MD.B.5.a"
     "Find the expected payoff for a game of chance.* For example, find the expected winnings from a state lottery ticket or a game at a fast-food restaurant."
     )
    ("AQR.S-MD.B.5.b"
     "Evaluate and compare strategies on the basis of expected values.* For example, compare a high-deductible versus a low-deductible automobile insurance policy using various, but reasonable, chances of having a minor or a major accident."
     )
    ("AQR.S-MD.B.6"
     "Use probabilities to make fair decisions (e.g., drawing by lots, using a random number generator"
     )
    ("AQR.S-MD.B.7"
     "Use probabilities to make fair decisions (e.g., drawing by lots, using a random number generator"
     )
))

