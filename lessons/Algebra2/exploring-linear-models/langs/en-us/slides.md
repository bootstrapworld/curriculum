---
{layout="DS Title Slide"}
# Exploring Linear Models

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Looking for Patterns

We're going to search for relationships within a dataset about each of the states in the US. But first, let's take a moment to (1) develop confidence in our ability to use functions for working with tables and making displays, and (2) build familiarity with a new dataset that we are going to spend a lot of time with.

---
{layout="Launch"}
# Looking for Patterns

- Open the @starter-file{alg2-states}.
- From the File menu, select "Save a Copy", and click "Run".
- Working in pairs or small groups, complete @printable-exercise{exploring-states.adoc}.
- What did you Notice and Wonder?
- What did you learn about defining rows in Pyret?

---
{layout="Launch"}
# Looking for Patterns

In math, x = 4 will define a variable x to be the value 4. Any time we use x after that, we can substitute in the value of 4. This works in Pyret, too. But in Pyret, values can be more than just numbers! In this file, the variables `alabama` and `alaska` are defined as rows from the table.

@teacher{
- Allow students to share what they discovered when completing Q8-Q10._
- In math, x = 4 will define a variable x to be the value 4. Any time we use x after that, we can substitute in the value of 4. This works in Pyret, too. But in Pyret, values can be more than just numbers! In this file, the variables `alabama` and `alaska` are defined as rows from the table.


Debrief the rest of the page with students. Then, initiate a conversation about the various column names, ensuring that students understand all of the terminology. Later in the lesson, students will examine relationships between income and education. We recommend posing the questions below to ensure that they are ready to do so.
}

---
{layout="Launch"}
# Looking for Patterns

* What columns in this dataset have to do with wealth?
* What columns might be related to education?


@teacher{
* What columns in this dataset have to do with wealth?
    - _Examples:_ `pct-in-poverty`, `poverty-rate`, `median-income`, `per-capita-income`
* What columns might be related to education?
    - _Examples:_ `college-or-higher`, `hs-or-higher`
}
---
{layout="Investigate"}
# Looking for Patterns

Before we dig deeper into @starter-file{alg2-states}, let's think back to the animals at the shelter in order to introduce some new data science concepts.

- Think back to the dataset we explored about animals at the shelter. Would you imagine that younger animals get adopted faster than older animals? Why or why not?
- What kind of data is `age` at adoption? What kind of data is `weeks` to adoption?
- What kind of display would help us analyze the relationship between age and adoption time?

@teacher{
- Think back to the dataset we explored about animals at the shelter. Would you imagine that younger animals get adopted faster than older animals? Why or why not?
** _The goal here is to have an open discussion and draw students in. Allow students to share their opinions freely. (For example: Yes, baby animals get adopted quickly because they're so cute! No, animals require too much work when they are young.)_
- What kind of data is `age` at adoption? What kind of data is `weeks` to adoption?
** _Both `age` and `weeks` are quantitative._
- What kind of display would help us analyze the relationship between age and adoption time?
** _Again, solicit students ideas and discuss why each display type would or would not work._	
}

---
{layout="Investigate"}
# Looking for Patterns

Pie and Bar charts help us see the _frequency_ of values in a single _categorical_ column. There are other displays, like histograms and box plots, that help us explore the _distribution_ of values in a single _quantitative_ column.

But what we really want is a display that will help us search for _a relationship between two quantitative columns_, and that's exactly what scatter plots do.

---
{layout="Investigate"}
# Looking for Patterns

**Scatter plots reveal the relationship between two columns by plotting one on the x-axis and the other on the y-axis.**

Before we can draw a @vocab{scatter plot}, we have to make an important decision: which variable is the _cause_ - called the @vocab{explanatory} variable - and which is the _effect_ (@vocab{response variable})? 

Which do we suspect is the cause and which is the effect: age or time-to-adoption?

We suspect that age affects the adoption time, so we'll use `age` as our @vocab{explanatory variable} and `weeks` as our @vocab{response variable}.  

---
{layout="Investigate"}
# Looking for Patterns

It's customary to use the horizontal axis for our explanatory variable and the vertical axis for the response variable. Each row in the dataset will be represented by a point on the scatter plot with `age` for @math{x} and `weeks` for @math{y}.


---
{layout="Investigate"}
# Looking for Patterns

- It's time to return to the @starter-file{alg2-states}!
- We are going to be focusing some of our thinking on our state and its neighbors. Which states should we focus on?
** _Come to a consensus about which states your students will explore to produce richer full-class dialogue._
- Working in pairs or small groups, complete Part 1 of @printable-exercise{looking-for-patterns.adoc}.
- Do not go on to Part 2! We'll return to that later in the lesson.

@teacher{Encourage students to first _think about which columns might be related_, and then create the scatter plot to search for this relationship, rather than making scatter plots for random pairs of columns. The dataset is designed so that students will quickly begin searching for relationships between varying levels of education and income, and there are linear relationships in each of these.}

---
{layout="Synthesize"}
# Looking for Patterns

- Share your scatter plots with one another (copying and pasting `scatter-plot` displays into a shared document, for example, and then labeling those displays). 
- What possible relationships did you find?
- Did you and your classmates commonly use any words to describe the relationships you observed?

@teacher{_Note: Students will acquire the formal vocabulary that data scientists use to assess relationships in the next section of this lesson, which is all about identifying form, direction, and strength._}


---
{layout="Launch"}
# Describing Patterns

Scatter plots let us visualize the relationship between two columns. If no relationship exists, the points in the scatter plot just appear as a shapeless cloud. But if there _is_ a relationship, the points will form some kind of pattern. When we build scatter plots, we are searching for patterns - or @vocab{correlations} between two quantitative variables.

These patterns can be described using three qualities: **form**, **direction**, and **strength**.

---
{layout="Launch"}
# Describing Patterns

@vocab{Form} refers to the shape of the pattern. Sometimes a pattern looks like a straight line, or a curve, or a hockey stick. And sometime, there's no clear shape at all!

Form indicates whether a relationship is linear, nonlinear or undefined.

@table{3}
| @image{images/1b1.gif, 250} | @image{images/2NL.gif, 250} | @image{images/B.gif, 250}
| Some patterns are **linear**, and cluster around a straight line sloping up or down. | Some patterns are **nonlinear**, and may look like a curve or an arc. | And sometimes there is **no relationship** or pattern at all!

@teacher{@optional Have students turn to @opt-printable-exercise{linear-nonlinear-bust.adoc} and decide whether each of the scatter plots could be modeled by a linear relationship, a non-linear relationship, or that there doesn't appear to be a pattern.}

---
{layout="LaunchR"}
# Describing Patterns

If the relationship clusters around a straight line, we can talk about _direction._

@right{@image{images/C.gif, 200 }}**Positive**: The line slopes up as we look from left-to-right. Positive relationships are by far the most common because of natural tendencies for variables to increase in tandem. For example, “the older the animal, the more it tends to weigh”.


---
{layout="LaunchR"}
# Describing Patterns

@right{@image{images/A.gif, 200}}**Negative**: The line slopes _down_ as we look from left-to-right. For example, “the older a child gets, the fewer new words he or she learns each day.”

**Only @vocab{linear} relationships have @vocab{direction}.**

Not every shape has a direction! For example, a curve can start out sloping upwards, but then peak and slope downwards.

---
{layout="LaunchR"}
# Describing Patterns

How well does knowing the x-value allow us to predict what the y-value will be?

@right{@image{images/A.gif, 200}}**A relationship is strong if knowing the x-value of a data point gives us a very good idea of what its y-value will be** (knowing a student's age gives us a very good idea of what grade they're in). A strong linear relationship means that the points in the scatter plot are all clustered _tightly_ around an invisible line.

---
{layout="LaunchR"}
# Describing Patterns

@right{@image{images/1a.gif, 200}}**A relationship is weak if x tells us little about y** (a student's age doesn't tell us much about their number of siblings). A weak linear relationship means that the cloud of points is scattered very _loosely_ around the line.

@vocab{Strength} indicates how closely the two variables are @vocab{correlated}.

---
{layout="Investigate"}
# Describing Patterns

Now that you've dug into the role that form, direction and strength play in quantifying a correlation, it's time to put those concepts to work!

- We are going to learn how to compute correlations using Pyret, but before we can trust the computer, we need to train our eyes to look for form so that we know what kind of correlations to run. Sometimes there's a bug in a program, so we want to be able to recognize whether the results we get from Pyret for form, direction, and strength make sense!
- Let's start by practicing matching the scatterplots to their descriptions on @printable-exercise{pages/identifying-form-matching.adoc}.

@teacher{Review student answers, and have students _explain their thinking_ for this activity. For students who are struggling, hearing what their peers are looking for is especially helpful at this stage.}

---
{layout="Investigate"}
# Describing Patterns

In pairs or small groups, complete @printable-exercise{pages/identifying-form.adoc}

@teacher{Review student answers. Some of the answers are not so clear-cut, and students may disagree about what constitutes a "strong" vs. "weak" correlation. We've tried to choose scatter plots that clearly fall into one category or the other, but without diving into the algorithm for linear regression students may find this exercise somewhat subjective... and that's ok!}

---
{layout="Investigate"}
# Describing Patterns

Return to @printable-exercise{looking-for-patterns.adoc}, and complete Part 2.


---
{layout="Synthesize"}
# Describing Patterns

- What relationships did you explore in the states dataset?
- Which appeared to have strong correlations? Were they positive or negative?
- Were any of these relationships a surprise? Why or why not?


@teacher{
- Students often conflate strength and direction, thinking that a strong correlation _must_ be positive and a weak one _must_ be negative.
- Students may also falsely believe that there is ALWAYS a correlation between any two variables in their dataset.
- Students often believe that strength and sample size are interchangeable, leading to mistaken assumptions like "any correlation found in a million data points _must_ be strong!"
}

---
{layout="Launch"}
# Fitting Linear Models

Before we learn to fit linear models to scatter plots, let's review. *What do you remember about linear functions?*

@teacher{
We'd expect students to be able to surface much of the following:

- Linear functions look like straight lines.
- Vertical lines are not functions, because their slope is undefined as a result of their horizontal change being zero.
- The steepness of a line can be described by its @vocab{slope} (or _constant_ @vocab{rate of change}).
- The @vocab{slope} can be calculated from any two points.
- Students may remember the @vocab{slope} as @math{\frac{change \; in \; y}{change \; in \; x}} or @math{\frac{rise}{run}} or @math{\frac{y_2 - y_1}{x_2 - x_1}}. 
- The point where the line crosses the y-axis is called the @vocab{y-intercept}.
- The x-coordinate of the @vocab{y-intercept} always starts with zero, e.g. @math{(0, y)}.
- Diagonal lines have both a @vocab{y-intercept} and an @vocab{x-intercept}.
- Horizontal lines have a constant rate of change of zero.
}

---
{layout="LaunchR"}
# Fitting Linear Models

@right{@image{images/difference-table-linear.png, 200}} Linear relationships grow by fixed amounts, meaning that the difference between two y-values will always be the same over identical intervals. In the table shown to the right, you can see arrows pointing out the "jumps" between y-values for intervals of 1. Each jump is the same size.

* Try comparing intervals of 2, instead of intervals of 1. Is the difference between x=1 and x=3 the same as the difference between x=2 and x=4?{style="font-size: 14pt"}

@teacher{
* Try comparing intervals of 2, instead of intervals of 1. Is the difference between x=1 and x=3 the same as the difference between x=2 and x=4?
** _Yes._

}

---
{layout="Investigate"}
# Fitting Linear Models

Return to Pyret and the @starter-file{alg2-states}.
Make a scatter plot showing the the relationship between `pct-college-or-higher` and `median-income`, using `state` for the labels.

---
{layout="InvestigateC"}
# Fitting Linear Models

@center{@image{images/college-v-income.png}}

This scatter plot appears to show a positive, linear relationship: states with higher percentages of college graduates tend to have higher median household incomes.

---
{layout="InvestigateR"}
# Fitting Linear Models

@right{@image{images/college-v-income.png}}

Suppose the United States were to add a new state. 

__Based on the data for the existing 50 states (plus DC!)...__

- What median household income would you predict, if exactly 50% of the new state's citizens had attended college?{style="font-size: 14pt"}
- What would you predict if 20% had attended college?{style="font-size: 14pt"}
- If 60% had attended college?{style="font-size: 14pt"}


@teacher{
@right{@image{images/pyret-window.png, 150}} Let students discuss, and explain their thinking. If possible, mark off a single point for each of the hypothetical percentages, then connect those points to show a straight line. Note that some of these new points would require changing the x-min, x-max, y-min and/or y-max of our display, which we can do by typing in the cells on the right side of the scatterplot and clicking "Redraw".
}

---
{layout="Investigate"}
# Fitting Linear Models

When we see patterns in data, we can use those patterns to __make predictions__ based on that data. We can even draw a line to show all the possible predictions at once! These predictions represent our "best guess" at the underlying relationship in the data, as we try to model that relationship using math.


---
{layout="Investigate"}
# Fitting Linear Models

These models are just functions being graphed on top of the scatter plot, with the goal of minimizing the distance between the line and all the points on the plot. For straight-line relationships, the "predictor functions" are _linear functions_ or "linear models". The straight-line graph of these models is also sometimes called the "regression line" or @vocab{line of best fit}.

---
{layout="Investigate"}
# Fitting Linear Models

When we make a model, we want it to be the closest possible approximation of all the points. A "good fit" has most of the points very close to the line, and a "bad fit" has the points very far away.


---
{layout="Investigate"}
# Fitting Linear Models

Let's find the best fit we can make for this dataset!

- Complete @printable-exercise{model-college-v-income-1.adoc}.

@teacher{
@optional If your students could use more support for finding the equation of the line between two points, direct them to the scaffolded version of @opt-printable-exercise{model-college-v-income-1-scaffolded.adoc} instead.
}

---
{layout="Investigate"}
# Fitting Linear Models

- How well did your model work for Alabama and Alaska? Why didn't it work as well for other states?
- How can we measure "how well a model fits"?

@teacher{Confirm that students were able to successfully compute slope and y-intercept, define and test `f(x)` in Pyret, and evaluate the predictive value of `f(x)`.}


---
{layout="Investigate"}
# Fitting Linear Models

Pyret includes a function called `fit-model`. Find its Contract on the @dist-link{Contracts.shtml, Contracts Page}. Like `scatter-plot`, it consumes columns for our _labels_, our @math{x}s and our @math{y}s. However, it __also consumes a function!__ It produces a scatter plot, with the function graphed on top of it.


---
{layout="Investigate"}
# Fitting Linear Models

- Complete @printable-exercise{model-college-v-income-2.adoc}.
- Based on the @vocab{R&sup2;} values of the plots you created on this page, what do you think @vocab{R&sup2;} means?

---
{layout="Investigate"}
# Fitting Linear Models

@vocab{R&sup2;} describes the _percentage of the variation in the y-variable that is explained by the x-variable_ in our model. In other words, an @vocab{R&sup2;} value of 0.20 could mean that “20% of the variation in median household income is explained by the percentage of college degrees in a state, according to our linear model”. Better models will explain a higher percentage of that variation.


---
{layout="Investigate"}
# Fitting Linear Models

If the model is perfect, the @vocab{R&sup2;} value will be 1.00, meaning the @math{y}-values can be perfectly predicted by the @math{x}-values. Of course in the real world, no model is perfect! The @vocab{R&sup2;} value for no correlation at all is *zero*. If we just drew a horizontal predictor line _in the middle of the data_, it would mean that we expect a median income somewhere in that range but with no connection whatsoever to the percentage of people who finish college.

---
{layout="Investigate"}
# Fitting Linear Models

But sometimes models make predictions that are _even worse than useless_ - they trend in the wrong direction altogether. Did you see any models with a negative @vocab{R&sup2;} value?

- Complete the first section ("Build a Model through Trial and Error") on @printable-exercise{model-college-v-income-3.adoc}.
- What was the best model you could come up with?


---
{layout="Investigate"}
# Fitting Linear Models

But how do we find the __best__ model? In Statistics, an algorithm called linear regression is used to derive the slope and y-intercept of the best possible model by taking every datapoint into account. Pyret has a function that will do just that, called `lr-plot`.



---
{layout="Investigate"}
# Fitting Linear Models

- Complete the last section ("Build a Model Computationally") in @printable-exercise{model-college-v-income-3.adoc}.
- How close did you come to the optimal model? Did anything about the model surprise you?
- @optional Turn to @opt-printable-exercise{graphing-models.adoc} and sketch graphs for three of the models you wrote on @printable-exercise{model-college-v-income-1.adoc} and @printable-exercise{model-college-v-income-2.adoc}.

@teacher{Sometimes the slope or y-intercept of a linear model have too many digits to be displayed clearly. When this happens, Pyret will convert them to scientific notation. While students have encountered scientific notation before, they may not recognize @math{8.23e5} as @math{8.23 \times 10^5}. You should make sure they understand how to translate this notation into numbers before proceeding.}


---
{layout="Investigate"}
# Fitting Linear Models

When we interpret a model, we try to make sense of the slope, the axes, the @math{R^2} value, and the real data behind them. In this example, __a model built from Alaska and Alabama predicts that a 1 percent increase in college degrees is associated with a **$5613** increase in median household income. Based on the @math{R^2} value of **-15.63**, this is a pretty terrible model and shouldn't be trusted.__


---
{layout="Investigate"}
# Fitting Linear Models

These models are useless if we can't make sense of them!

- For practice building other relationships in the data, complete @printable-exercise{interpreting-linear-models.adoc}.
- @optional For more practice, build linear models for **other** relationships in the data. You can use @opt-printable-exercise{building-more-linear-models.adoc}, and write up your findings in the extra space on @printable-exercise{interpreting-linear-models.adoc}. 


---
{layout="Synthesize"}
# Fitting Linear Models

- How could we use scatter plots and linear models to find out if taller NBA players tend to make more three-pointers?
- How could we use scatter plots and linear models to find out if wealthier people live longer?
- How could we use scatter plots and linear models to find answers to _other_ questions?


---
{layout="Launch"}
# (Optional) Other Forms of Linear Models

When trying to fit a piece into a puzzle, sometimes we rotate the piece to see it from a different angle. When fitting a model to a dataset, we might prefer to look at the linear relationship from different angles as well! 


---
{layout="Launch"}
# (Optional) Other Forms of Linear Models

So far, we've focused on models using the *Slope-Intercept* form of the line. That's because it's the form that is defined in terms of the response variable, making it most compatible with the programming environment. Depending on who we're communicating with and what information we have available to us, we might opt to use other forms of linear models, but we can always translate any model into another!


---
{layout="Launch"}
# (Optional) Other Forms of Linear Models

You may already be familiar with the different forms of linear models available to us:

@table{3}
| Slope-Intercept		| Point-Slope				| Standard
| @math{y = mx+b}		| @math{y-y_1 = m(x-x_1)}	| @math{Ax+By = C}
|  - m: slope - b: y-intercept | - m: slope - @math{y_1}: y-coordinate of a point - @math{x_1}: x-coordinate of the same point | - x-int: @math{\frac{C}{A}} - y-int: @math{\frac{C}{B}} - slope: @math{-\frac{A}{B}}

---
{layout="Launch"}
# (Optional) Other Forms of Linear Models

Why we might choose to use one form over another?

- *Slope-Intercept Form* makes it really easy to read the slope and y-intercept.
- *Point-Slope Form* makes it easy to find the equation of the line given a single point and slope.
- *Standard Form* makes it easy to find the x- and y-intercepts of the line.



---
{layout="Launch"}
# (Optional) Other Forms of Linear Models

@teacher{Pose these questions below to assess student understanding of when and why we might choose one form over another:}

* Suppose our scatterplot has data for a state with 0% college enrollment, and another with 0% median income. Which linear model form would be easiest to build?
* Suppose we only know the slope of a model, but we know the college graduation rate _and_ median income for Rhode Island. Which form would make it easy to figure out the rest of the model?
* Suppose we want to define our model in Pyret. Which form makes it easiest to do that?

@teacher{
* Suppose our scatterplot has data for a state with 0% college enrollment, and another with 0% median income. Which linear model form would be easiest to build?
** _Standard Form_
* Suppose we only know the slope of a model, but we know the college graduation rate _and_ median income for Rhode Island. Which form would make it easy to figure out the rest of the model?
** _Point-Slope Form_
* Suppose we want to define our model in Pyret. Which form makes it easiest to do that?
** _Slope-Intercept Form_
}

---
{layout="Investigate"}
# (Optional) Other Forms of Linear Models

While it's easier to write one linear form or the other based on the information available to us, and might be easier for someone else to extract the information they're looking for based on the model we supply them with, we can easily translate back and forth between linear forms!


---
{layout="Investigate"}
# (Optional) Other Forms of Linear Models

- Let's practice writing linear functions in each of the forms and translating them into Pyret function definitions.
- Turn to @printable-exercise{which-form.adoc}
- When you're done, add your function definitions to your @starter-file{alg2-states} and test them out with `fit-model`.


---
{layout="Synthesize"}
# (Optional) Other Forms of Linear Models


If you needed to draw the graph of a linear model, which form would you like to start from? Why?

