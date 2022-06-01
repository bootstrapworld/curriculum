---
{layout="Math Title Slide"}
# Defining Linear Functions

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Defining Linear Functions

A *function definition* is a way of summarizing a relationship. You've seen how a linear relationship can be expressed as a table or graph. But what do these kinds of relationships look like as a definition?

Linear functions are defined by their slope and y-intercept.

---
{layout="LaunchC"}
# Defining Linear Functions

Here we see a function definition written using pyret notation and using function notation.{style="font-size:15pt"}

The *slope-intercept form of the line* includes the slope as the coefficient of x and the y-intercept as the numerical term.  You will hear people describe this form as @math{y = mx + b}, where @math{m} stands for slope and @math{b} stands for the y-intercept.{style="font-size:15pt"}

@image{images/slope-and-y.png, "f(x) = 2x + 10. Slope = 2. Y-intercept = 10."}{style="font-size:15pt"}

---
{layout="Launch"}
# Defining Linear Functions

@table{2}
| Function Notation        | @ifproglang{pyret}{Pyret} @ifproglang{wescheme}{WeScheme} Code
| @math{f(x) = 6x - 10}    | @show{(code '(define (f x) (- (* 6 x) 10)))}
| @math{f(x) = -10 + 6x}   | @show{(code '(define (f x) (+ -10 (* 6 x))))}

While it is common to write the x-term first and the y-intercept second, they can be written in any order!

---
{layout="Launch"}
# Defining Linear Functions

@table{2}
| "Visible" Slope            | "Invisible" Slope
|@math{f(x) = 0x + 22}       | @math{f(x) = 22}

When the slope is zero (and the line is horizontal)... we may choose whether or not to write the slope term.

---
{layout="Launch"}
# Defining Linear Functions

@table{2}
| "Visible" y-intercept   | "Invisible" y-intercept
|@math{f(x) = 3.2x + 0}   | @math{f(x) = 3.2x}

When the y-intercept is @math{0} (and the line crosses the y-axis at the origin)... we may choose whether or not to write the slope term.

---
{layout="Launch"}
# Defining Linear Functions

To check our work, we can apply the function to the x-value in each Row in the table, it produces the y-value! Instead of writing endless rows repeating the rule or drawing an entire graph, we can just declare the rule itself by defining the function.

As with tables and graphs, a function definition can also reveal whether or not the function is linear. Functions that are not linear will follow other forms, for example they may include exponents or absolute values.

---
{layout="Investigate"}
# Defining Linear Functions

Let's start by identifying the slope and y-intercept from function definitions.

- @printable-exercise{slope-and-y-def.adoc}

For more practice: 
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc263844666f00d51454b58, Identifying y-intercepts in Tables, Graphs & Definitions of Linear Functions}
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc264d34666f00d51454b87, Identifying slope in Tables, Graphs & Definitions of Linear Functions}

---
{layout="Investigate"}
# Defining Linear Functions

Let's connect definitions to tables and graphs. Writing down the slope and y-intercept beneath each representation will help!

- @printable-exercise{match-definitions-tables.adoc}
- @printable-exercise{match-definitions-graphs.adoc}

For more practice:
- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc24d7d7768970b95efa813, Matching Tables and Definitions}
- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbe72167f5cee0d57130b96, Matching Graphs and Definitions of Linear Functions}
- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbe7b4cf278460cdbd34bc8, Matching Graphs and Definitions of Linear Functions 2}

What strategies did you use?

---
{layout="Investigate"}
# Defining Linear Functions

Let's write our own definitions from tables and graphs!

- @printable-exercise{definitions-from-tables.adoc}
- @printable-exercise{definitions-from-graphs.adoc}

What strategies did you use?

---
{layout="Investigate"}
# Defining Linear Functions

Let's connect all three function representations!

- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbe74ac877d890d3e1a49cc?collections=5fbe7484d81cab0ca7a8bcfb, Matching Function Definitions, Tables and Graphs}
- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbe782a6dcb980d4c87b78d?collections=5fbecc2b40d7aa0d844956f0, Matching Function Definitions, Tables and Graphs 2}

What strategies did you use?

<!--
	Common misconception: It is common to think of the graph as the "output" of the function, rather than the function itself. Most math textbooks will use language like "matching the graph to the function", suggesting that the graph is somehow not the function! Since this language is pervasive, it's important to actively push against it.
-->

---
{layout="Synthesize"}
# Defining Linear Functions

Function definitions are a way of talking about relationships between quantities: milk costs $0.59/gallon, a stone falls at @math{9.8m/s^2}, or there are 30 students for every teacher at a school. 

If we can figure out the relationship between a small sample of data, we can __make predictions__ about what happens next. We can see these relationships as tables, graphs, or symbols in a definition. We can even think about them as a mapping between Domain and Range!

When we talk about functions, it's helpful to be able to switch between representations, and see the connections between them.

---
{layout="Supplemental"}
# Defining Linear Functions

Additional Exercises
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbecf6ee47d820d0a06ef09, Matching Graphs & Definitions of Functions (not just linear!)}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fe38c56f875180d2adb6674, Identifying y-intercepts in Tables, Graphs & Definitions of Linear Functions (challenge)}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc26797b575200bae86929c, Identifying Linearity in Tables, Graphs & Definitions of Linear Functions}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc261b2b575200bae8691fd, Matching Tables, Graphs, and Definitions of Functions (challenge!)}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbe7ce016ed10402e547aa7, Matching Tables, Graphs, and Definitions of Functions (challenge!)}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fe38c56f875180d2adb6674?collections=5fbe7484d81cab0ca7a8bcfb, Identifying y-intercepts in Tables, Graphs & Definitions of Linear Functions (challenge!)}
