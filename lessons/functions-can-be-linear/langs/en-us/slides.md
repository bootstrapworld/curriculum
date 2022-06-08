---

{layout="Math Title Slide"}

# Functions Can Be Linear

---
{layout="Launch"}
# Simple Sequences and Straight Lines

What do you Notice? What do you Wonder?

@image{images/notice-wonder.png, "table and line graph"}{width="700"}

<!--
Students can record their responses on  @printable-exercise{notice-wonder-linearity.adoc}.
-->

---
{layout="LaunchR"}
# Simple Sequences and Straight Lines

What do you Notice? What do you Wonder? 

Can you figure out what the next (x,y) pair should be for each of them? 

Can you guess what the y-value for each table would be when x is 0?

@image{images/sideways-tables-pair.png, "a"}

<!--
	Students can record their responses on @printable-exercise{notice-wonder-linearity.adoc}.
-->

---
{layout="Launch"}
# Simple Sequences and Straight Lines

We can think of the "x" column as counting the __order in which the y-values appear__ (1st value, 2nd value, etc). When we notice that x-values change at a _constant rate_ and the y-values also change at a _constant rate_, we know that if we were to plot those values on a graph, all of the points would fall on a straight line.

*Linear Relationships* are sequences that change at a constant rate, or points forming a straight line on a graph.


---
{layout="Investigate"}
# Simple Sequences and Straight Lines

Complete @printable-exercise{pages/match-tables-graphs.adoc} and/or @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc25d458dcfcf0b92021b13, Matching Tables to Graphs}.

If you're ready for a challenge, try @opt-printable-exercise{pages/match-tables-graphs2.adoc}.


---
{layout="Investigate"}
# Simple Sequences and Straight Lines

Axes on a graph need an order. Rows in a table don't!

The points in a table are _discrete_. While ordering the rows in a table can make it easier for us to find the function,
they preserve their meaning if the rows are shuffled into a different order.

On a graph, the points on the x-axis _cannot_ be shuffled, because the x-axis must always be ordered. We can stretch the _scale_ of the axes to making the lines _look_ different, but the points will always be in the same order.


---
{layout="Synthesize"}
# Simple Sequences and Straight Lines

We've seen that linear relationships can be represented as tables and graphs. Tables only show us _some points_ on a line, whereas a line itself is made up of an _infinite_ number of points. While a table represents a _sample_ of some larger trend, the graph is a way of seeing the trend itself.

---
{layout="LaunchC"}
# Linear, Non-Linear, or Bust!

What do you Notice? What do you Wonder? If all linear relationships can be shown as points on a graph, does that mean all graphs are linear?{style="font-size:15pt"}

@image{images/set-of-6-graphs.png, "series of six graphs showing different relationships"}{width="700"}

<!---
	Students can record their responses on  @printable-exercise{graphs-all-linear.adoc}.
	--->


---
{layout="Launch"}
# Linear, Non-Linear, or Bust!

Linear relationships in a graph always appear as straight lines.

Three of the graphs on the previous slide represent @vocab{linear} relationships, and three show other, non-linear relationships. The linear graphs can go in lots of directions and non-linear relationships can follow patterns that aren't linear!


---
{layout="LaunchC"}
# Linear, Non-Linear, or Bust!

What do you Notice? What do you Wonder? If all linear relationships can be shown as tables, does that mean all tables are linear?

@image{images/set-of-6-tables.png, "series of six tables showing different relationships"}

<!--
	Students can record their reflections on  @printable-exercise{tables-all-linear.adoc}.
-->

---
{layout="Launch"}
# Linear, Non-Linear, or Bust!

Linear relationships in a table show up as sequences that change at a constant rate. The y-value when x is zero is also the value where the line will cross the y-axis.

Three of the tables on the previous slide show linear relationships, and three show other, non-linear relationships. The linear tables can have y-values that change by zero (no change), by a positive number (constant increase), or a negative number (constant decrease) as the x-values increase. While the other tables may show patterns, they aren’t linear!


---
{layout="LaunchC"}
# Linear, Non-Linear, or Bust!

Sometimes there is no function that will give us a particular table or graph! Take a look at the table and points below. Can you predict the next two rows? Where will the next point be?


@image{images/table-and-dot-plot.png, "table and corresponding dot plot"}


---
{layout="Investigate"}
# Linear, Non-Linear, or Bust!


* Can you tell when a relationship is a linear function? A non-linear one? Not a function at all?
* Can someone remind us how to tell whether or not a graph represents a function? 

Complete:
- @printable-exercise{linear-nonlinear-bust.adoc} 
- Optional: @opt-printable-exercise{linear-nonlinear-bust-graphs.adoc}
- Optional: @opt-printable-exercise{linear-nonlinear-bust-graphs-2.adoc}

---
{layout="Synthesize"}
# Linear, Non-Linear, or Bust!

Data has a "shape", and this shape can emerge when we look for patterns in that data. A @vocab{linear} function is one kind of pattern, and we can see it when viewing data as a table or a graph.

---
{layout="Launch"}
# Slope and y-Intercept from Tables

Every linear relationship has two properties:

1) The sequence of y-values always changes at a constant rate - called @vocab{slope} - increasing or decreasing by the same amount for each change in the x-value.

2) The y-value when @math{x = 0} is called the @vocab{y-intercept}.

---
{layout="Launch"}
# Slope and y-Intercept from Tables

@table{7}
| x | -1 | 0 | 1 | 2 | 3 | 4
| y | -1 | 1 | 3 | 5 | 7 | 9

Turn to @printable-exercise{slope-int-tables-intro.adoc}

- In the table below: How much does y increase as x increases by 1? 
- What is the y-intercept? (Figure this out by finding the y-value when @math{x = 0}.)

---
{layout="Launch"}
# Slope and y-Intercept from Tables

@table{7}
| x | -1 | 0 | 1 | 2 | 3 | 4
| y | -1 | 1 | 3 | 5 | 7 | 9

Life isn't always so simple!

- What if the table didn't include x = 0?
- What if the x-values didn't increase by 1?
- What if the other rows were __out of order__?
- What if we only had a few random rows, for @math{x = 3} and @math{x = 1}?


---
{layout="Launch"}
# Slope and y-Intercept from Tables


Try extending the second table (below) and filling in the missing rows to find the slope and y-intercept.

@table{5}
| x |  2 | 5 | 8  | 11
| y |  3 | 9 | 15 | 21

What strategies did you use to extend the table?

---
{layout="Launch"}
# Slope and y-Intercept from Tables

You can find the y-intercept by expanding the table and following the pattern to figure out the value of @math{y} when @math{x = 0}, but sometimes that's a lot of work! How might we compute the slope and y-intercept, using only two rows in the table?

---
{layout="Launch"}
# Slope and y-Intercept from Tables

TO FIND THE SLOPE: Find any two pairs of values in the table, and divide the difference in y's by the difference in x's.

This is an easy way to see the change in y __as a proportion__ of the change in x, which gives you the @vocab{slope} of the function.

This is often described as  @math{\frac{change.in.y}{change.in.x}} or @math{\frac{rise}{run}}.


---
{layout="Launch"}
# Slope and y-Intercept from Tables

@table{6}
| x | 3 | 20 | 5  |  9 | 1
| y | 5 | 56 | 11 | 23 | -1

Taking the first two pairs of values gives us @math{\frac{56 - 5}{20 - 3}}, which simplifies to @math{\frac{51}{17}}, for a slope of @math{3}.

* Pick two other pairs of values from the third table and compute the @vocab{slope}. Did you get the same answer?
* Are there other strategies we could have used to find the slope?

---
{layout="Launch"}
# Slope and y-Intercept from Tables

TO FIND THE Y-INTERCEPT: Multiply any x in the table by the slope, and subtract the result from the corresponding y.

Let's use the the pair (20, 56) from the table to demonstrate this shortcut:

Starting with the @math{x} value of 20, multiplying by the slope (@math{20 \times 3}) gives us @math{60}.

Looking at the table... when @math{x} is 20, @math{y} is 56.

The y-intercept is @math{56 - 60 = -4}.

---
{layout="Investigate"}
# Slope and y-Intercept from Tables

Let's get some practice identifying the slope and y-intercept of a linear function in a table by completing @printable-exercise{slope-and-y-tables.adoc}

---
{layout="Synthesize"}
# Slope and y-Intercept from Tables

@vocab{Slope} and @vocab{y-intercept} form the essence of linear functions. If we can find them in a sample of data, we can make predictions that go outside that sample. 

For example: If we know a car is moving at a consistent speed, all we need to know is __where it is located at two points in time__ in order to figure out the speed, and to predict where it will be at any other point in time!

---
{layout="LaunchC"}
# Slope and Y-Intercept from Graphs

On a graph, the y-intercept is the value where the line "intercepts" the y-axis.

@image{images/y-intercept-graphs.png, "two linear graphs"}

---
{layout="LaunchC"}
# Slope and Y-Intercept from Graphs

On a graph, the slope refers to both the "steepness" and "direction" of the line.

@image{images/slope-graphs.png, "graphs demonstrating slopes"}


---
{layout="LaunchC"}
# Slope and Y-Intercept from Graphs

We can compute the slope from a graph the same way we would with a table, by picking two points and using those as our two sample rows.

@image{images/slope-2-points.png, "lines from two points"}

---
{layout="Investigate"}
# Slope and Y-Intercept from Graphs

Complete @printable-exercise{slope-and-y-graphs.adoc}

@ifproglang{pyret}{
If you have time, check out:
- @opt-starter-file{exploring-linearity-in-tables} to make predictions about linearity, slope, and y-intercepts from tables before their graphs are revealed
- @opt-starter-file{exploring-linearity-in-graphs} to think about linearity, positive/negative/zero slopes and y-intercepts from interactive graphs
}

---
{layout="Synthesize"}
# Slope and Y-Intercept from Graphs

Slope and y-intercept form the essence of linear functions. If we can find them in a sample of data, we can make predictions that go outside that sample.

For example: If we know a car is moving at a consistent speed, all we need to know is where it is located at two points in time in order to figure out the speed, and to predict where it will be at any other point in time!

