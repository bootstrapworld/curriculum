@slidebreak
{layout="Math Title Slide"}
# Defining Linear Functions

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

@slidebreak
{layout="Launch"}
# Defining Linear Functions

A *function definition* is a way of summarizing a relationship. You've seen how a linear relationship can be expressed as a table or graph. But what do these kinds of relationships look like as a definition?

Linear functions are defined by their slope and y-intercept.

@slidebreak
{layout="LaunchC"}
# Defining Linear Functions

Here we see a function definition written using pyret notation and using function notation.{style="font-size:15pt"}

The *slope-intercept form of the line* includes the slope as the coefficient of x and the y-intercept as the numerical term.  You will hear people describe this form as @math{y = mx + b}, where @math{m} stands for slope and @math{b} stands for the y-intercept.{style="font-size:15pt"}

@image{images/slope-and-y.png}{style="font-size:15pt"}

@slidebreak
{layout="Launch"}
# Defining Linear Functions

@table{2}
| Function Notation        | @ifproglang{pyret}{Pyret} @ifproglang{wescheme}{WeScheme} Code
| @math{f(x) = 6x - 10}    | @show{(code '(define (f x) (- (* 6 x) 10)))}
| @math{f(x) = -10 + 6x}   | @show{(code '(define (f x) (+ -10 (* 6 x))))}

While it is common to write the x-term first and the y-intercept second, they can be written in any order!

@slidebreak
{layout="Launch"}
# Defining Linear Functions

@table{2}
| "Visible" Slope            | "Invisible" Slope
|@math{f(x) = 0x + 22}       | @math{f(x) = 22}

When the slope is zero (and the line is horizontal)... we may choose whether or not to write the slope term.

@slidebreak
{layout="Launch"}
# Defining Linear Functions

@table{2}
| "Visible" y-intercept   | "Invisible" y-intercept
|@math{f(x) = 3.2x + 0}   | @math{f(x) = 3.2x}

When the y-intercept is @math{0} (and the line crosses the y-axis at the origin)... we may choose whether or not to write the slope term.

@slidebreak
{layout="Launch"}
# Defining Linear Functions

To check our work, we can apply the function to the x-value from any @vocab{coordinate pair} on our table or graph, and it should produce the y-value!

As with tables and graphs, a function definition can also reveal whether or not the function is linear. Functions that are not linear will follow other forms, for example they may include exponents or absolute values.

@slidebreak
{layout="Investigate"}
# Defining Linear Functions

Let's start by identifying the slope and y-intercept from function definitions.

- @printable-exercise{slope-and-y-def.adoc}

For more practice: 
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc263844666f00d51454b58, Identifying y-intercepts in Tables, Graphs & Definitions of Linear Functions}
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc264d34666f00d51454b87, Identifying slope in Tables, Graphs & Definitions of Linear Functions}

<!--
@ifproglang{pyret}{
_Students can identify slope and y-intercept from functions in Pyret as well, using @opt-starter-file{exploring-linearity-in-definitions}._
}
-->

@slidebreak
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

@slidebreak
{layout="Investigate"}
# Defining Linear Functions

Let's write our own definitions from tables and graphs!

- @printable-exercise{definitions-from-tables.adoc}
- @printable-exercise{definitions-from-graphs.adoc}

What strategies did you use?

<!--
@ifproglang{pyret}{
_Students can also practice defining linear functions when given tables and graphs using the @opt-starter-file{exploring-linearity-in-tables} and @opt-starter-file{exploring-linearity-in-graphs}._
}
-->

@slidebreak
{layout="Investigate"}
# Defining Linear Functions

Let's connect all three function representations!

- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbe74ac877d890d3e1a49cc?collections=5fbe7484d81cab0ca7a8bcfb, Matching Function Definitions, Tables and Graphs}
- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbe782a6dcb980d4c87b78d?collections=5fbecc2b40d7aa0d844956f0, Matching Function Definitions, Tables and Graphs 2}

What strategies did you use?

<!--
Common misconception: It is common to think of the graph as the "output" of the function, rather than the function itself. Most math textbooks will use language like "matching the graph to the function", suggesting that the graph is somehow not the function! Since this language is pervasive, it's important to actively push against it.
-->

@slidebreak
{layout="Synthesize"}
# Defining Linear Functions

Function definitions are a way of talking about relationships between quantities: 

* milk costs $0.59/gallon
* a stone falls at @math{9.8m/s^2}
* there are 30 students for every teacher at a certain school

@slidebreak
{layout="Synthesize"}
# Defining Linear Functions

If we can figure out the relationship between a small sample of data, we can __make predictions__ about what happens next. We can see these relationships as tables, graphs, or symbols in a definition. We can even think about them as a mapping between Domain and Range!

When we talk about functions, it's helpful to be able to switch between representations, and see the connections between them.

@slidebreak
{layout="Launch"}
# Finding the y-intercept from the Slope and a Point{style="font-size:20pt"}

Consider the function @math{f(x) = 3x}.

@table{5}
| x |  0 | 1 | 2  | 3
| y |  0 | 3 | 6  | 9

* What is the slope?
* What is the y-intercept?
* What is the y-value when x = 2?

<!-- 
* What is the slope? _3_
* What is the y-intercept? _0_
* What is the y-value when x = 2? _6_
-->

@slidebreak
{layout="Launch"}
# Finding the y-intercept from the Slope and a Point{style="font-size:20pt"}

Anytime the y-intercept is 0, we can multiply any x-value by the slope to get its corresponding y-value.

@table{5}
| x |  0 | 1 | 2  | 3
| y |  0 | 3 | 6  | 9

But if the y-intercept isn't zero... there is another step to finding the y-value.

@slidebreak
{layout="Launch"}
# Finding the y-intercept from the Slope and a Point{style="font-size:20pt"}

Consider the function @math{f(x) = 3x - 2}.

@table{5}
| x |  0  | 1 | 2  | 3
| y |  -2 | 1 | 4  | 7

* What is the slope?
* What is the y-intercept?
* What is the y-value when x = 2?

<!--
* What is the slope? _3. Same as for the previous function._
* What is the y-intercept? _-2_
* What is the y-value when x = 2? _4. Two less than the y-value for @math{x=3} in the previous function, where the y-intercept was 0._
-->

@slidebreak
{layout="Launch"}
# Finding the y-intercept from the Slope and a Point{style="font-size:20pt"}

@table{5}
| x |  0  | 1 | 2  | 3
| y |  -2 | 1 | 4  | 7

The y-intercept always gets added to / subtracted from the product of the slope and the x-value to find the corresponding y-value.

@slidebreak
{layout="Investigate"}
# Finding the y-intercept from the Slope and a Point{style="font-size:20pt"}

The relationship between the x-values and the y-values can be described using 

@math{y = mx + b}, 

where @math{m} stands for @vocab{slope} and @math{b} stands for the @vocab{y-intercept}.

If we solve that for the y-intercept...

@math{b = y - mx}

In other words, _the y-intercept can be calculated by subtracting the product of the slope and any x-value from the corresponding y-value._

@slidebreak
{layout="Investigate"}
# Finding the y-intercept from the Slope and a Point{style="font-size:20pt"}


Let's say the slope is @math{3}. And we know that the line passes through the point (7,9).{style="font-size:14pt"}

* @math{b = y - mx}{style="font-size:14pt"}
* @math{m = 3}{style="font-size:14pt"}
* @math{x = 7}{style="font-size:14pt"} 
* @math{y = 9}{style="font-size:14pt"}

To find the y-intercept, subtract @math{9} (the y-value of the point) minus @math{3 \times 7} (the product of the slope and the x-value of the point).{style="font-size:14pt"}

* @math{b = 9 - 3(7)}{style="font-size:14pt"}
* @math{b = 9 - 21}{style="font-size:14pt"}
* _@math{b = -12} ...We found our y-intercept!_{style="font-size:14pt"}

We can now use the slope and y-intercept to write our function definition:{style="font-size:14pt"}

* @math{f(x) = 3x - 12}{style="font-size:14pt"}

@slidebreak
{layout="Investigate"}
# Finding the y-intercept from the Slope and a Point{style="font-size:20pt"} 

Consider the table below.

@table{5}
| x |  80  | 81  | 82  | 83
| y |  150 | 155 | 160 | 165

* What is the slope?
* Calculate the y-intercept using the first coordinate pair.
* Do you get the same y-intercept if you use another pair?

<!--
* What is the slope? _5_
* Calculate the y-intercept using the first coordinate pair. _@math{b = 150 - 5(80) = -250}
* Do you get the same y-intercept if you use another pair? _Yes._
-->

@slidebreak
{layout="Supplemental"}
# Defining Linear Functions

Additional Exercises
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbecf6ee47d820d0a06ef09, Matching Graphs & Definitions of Functions (not just linear!)}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fe38c56f875180d2adb6674, Identifying y-intercepts in Tables, Graphs & Definitions of Linear Functions (challenge)}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc26797b575200bae86929c, Identifying Linearity in Tables, Graphs & Definitions of Linear Functions}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc261b2b575200bae8691fd, Matching Tables, Graphs, and Definitions of Functions (challenge!)}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fbe7ce016ed10402e547aa7, Matching Tables, Graphs, and Definitions of Functions (challenge!)}
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fe38c56f875180d2adb6674?collections=5fbe7484d81cab0ca7a8bcfb, Identifying y-intercepts in Tables, Graphs & Definitions of Linear Functions (challenge!)}
