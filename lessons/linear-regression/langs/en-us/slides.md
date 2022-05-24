---

{layout="DS Title Slide"}

# Linear Regression
<!--

-->
---
{layout="Launch"}
# Intro to Linear Regression 

Make two scatterplots from the `animals-table`, using `age` as the explanatory variable in one plot and `pounds` as the @vocab{explanatory variable} in the other. In both plots, use `weeks` as your @vocab{response variable} and `name` for the `labels`. We will refer to the explanatory column as “xs” and the response column as “ys.”


<!--

-->
---
{layout="LaunchR"}
# Intro to Linear Regression 

@image{images/pounds-v-weeks.gif,"weeks-v-pounds scatterplot with a cluster of points on the lower left and some points in the upper right", 300}

*“Can we _predict_ an animal's adoption time based on its size? Its age?”*

We are asking if we can use an animal’s size or age to predict how long it will take to be adopted. A scatter plot of adoption time versus size _does_ suggest that smaller animals get adopted faster than larger animals. Similarly, younger animals tend to be adopted faster than older ones. 

Can we be more precise about this, and actually _predict_ how long it will take an animal to be adopted, based on these factors? And which one would give us a better prediction?

<!--

-->
---
{layout="Launch"}
# Intro to Linear Regression 

The mean, median, and mode are three different ways to measure the “center” of a dataset in one dimension. Each represents a different way to collapse a bunch of points on a number line into a single, summary value. If the “center” of points on a _one dimensional_ number line is a single point, what is the “center” of points in a _two-dimensional_ cloud, which cluster around a line?


<!--

-->
---
{layout="Launch"}
# Intro to Linear Regression 

What we need to do is find a _line_ -- called a @vocab{line of best fit}, or a @vocab{regression line} -- that is at the center of this cloud. Each point in our scatter plot “pulls” on the line, with points above the line yanking it up and points below the line dragging it down. Points that are really far away -- especially influential observations that are far out in the x direction —- pull on the line with more force. This line can be graphed on top of the scatter plot as a function, called the @vocab{predictor function}.

<!--

-->
---
{layout="Launch"}
# Intro to Linear Regression 

Given a value on the x-axis, this line allows us to predict what the corresponding value on the y-axis might be. This allows us to make predictions based on our data.

Is there only one “best line”? Based on methods of calculus, data scientists know the answer to this question is yes! That justifies us talking about a single “line of best fit.”

---
{layout="Launch"}
# Intro to Linear Regression 

Data scientists use a statistical method called @vocab{linear regression} to pinpoint linear relationships in a dataset. When we draw our @vocab{regression line} on a scatter plot, we can imagine a rubber bands stretching vertically between the line itself and each point in the plot -- every point pulls the line a little “up” or “down”. Linear regression is the math behind the line of best fit.

<!--
The straight line that best fits the points on a scatter plot has several names, depending on the context, subject, or grade level. All of the following terms refer to the same concept:

* Regression Line
* Line of Best Fit
* Least Squares Line
* Predictor
* Trendline

The line itself is computed through a process called _linear regression_, which also goes by the name _least squares regression_.

If you want to teach students how to compute this line, now is the time! However, this algorithm is _not_ a required portion of Bootstrap:Data Science.
-->
---
{layout="Investigate"}
# Intro to Linear Regression 

Open this @link{https://www.geogebra.org/m/ZcVIxKtF, Interactive LR Plot}.

- Try moving the blue point “P”, and see what effect it has on the red line.
- Find the number called @math{r}. In your own words, explain what this number tells us.
- What’s the largest @math{r}-value you can get? What do you think that number means?
- Where can you move it so that it is _most_ aligned with the other points?
- Where can you move it so that it is _least_ aligned with the other points?
- Could the @vocab{regression line} ever be above or below _all_ the points? Why or why not?

---
{layout="InvestigateR"}
# Intro to Linear Regression 

Let's explore scatter plots for weeks-v-pounds and weeks-v-age.

@image{images/pounds-v-weeks.gif,"weeks-v-pounds scatterplot with a tight cluster in the lower left and some points toward the right and top right corner", 400}
@image{images/age-v-weeks.gif,"weeks-v-age scatterplot with some points in the lower left and some in the upper right", 400}

<!--
- Do the relationships appear to be linear for one? Both?
- If a relationship is linear, what line in particular are the scatter plot points clustering around?
- What is the @math{r}-value for each relationship?
-->
---
{layout="Investigate"}
# Intro to Linear Regression 

* Turn to @printable-exercise{pages/drawing-predictors.adoc}.
* In the first column, draw a @vocab{line of best fit} through each of the scatter plots.
* In the second column, circle whether the slope of the line (which is the same as the _direction_ of the correlation) is positive or negative.

<!--
*Common Misconceptions*
* *Don't forget to look at sample size!* A linear regression plot with an @math{r}-value of 0.999 is strong...but that's useless if it's a sample of just three datapoints!

-->
---
{layout="Synthesize"}
# Intro to Linear Regression 

* Would it be possible to have a line that is _below_ all the points? (no)
* Would it be possible to have a line that is _above_ all the points? (no)
* Would it be possible to have a line with more points on one side than the other? (yes)

<!--
Give students some time to experiment, then share back observations. 
-->
---
{layout="Launch"}
# Linear Regression in Pyret

Pyret includes a powerful display, which (1) draws a scatterplot, (2) draws the line of best fit, and (3) even displays the equation for that line:

```
# lr-plot :: Table, String, String, String -> Image
# consumes a table, and three column names: labels, x-vals and y-vals
# produces a scatterplot, and draws the line of best fit
lr-plot(animals-table, "name", "age", "weeks")
```
<!--

-->
---
{layout="LaunchR"}
# Linear Regression in Pyret

```
# lr-plot :: Table, String, String, String -> Image
# consumes a table, and three column names: labels, x-vals and y-vals
# produces a scatterplot, and draws the line of best fit
lr-plot(animals-table, "name", "age", "weeks")
```

@image{images/lr-explained.png, LR explained, 400}
`lr-plot` is a function that takes a Table and the names of *3 columns*:

- `ls` -- the name of the column to use for _labels_ (e.g. “names of pets”)
- `xs` -- the name of the column to use for _x-coordinates_ (e.g. “age of each pet”)
- `ys` -- the name of the column to use for _y-coordinates_ (e.g. “weeks for each pet to be adopted”)

Our goal is to use values of the variable on our x-axis to _predict_ values of the variable on our y-axis.

---
{layout="Launch"}
# Linear Regression in Pyret

Create an `lr-plot` for the `animals-table`, using `"names"` for the labels, `"age"` for the x-axis and `"weeks"` for the y-axis.

---
{layout="Launch"}
# Linear Regression in Pyret

The resulting scatterplot looks like those we’ve seen before, but it has a few important additions. 

First, we can see the @vocab{line of best fit} drawn onto the plot. We can also see the equation for that line (in red), in the form @math{f(x) = mx + b}. In this plot, we can see that the slope of the line is 0.792, which means that on average, each extra year of age results in an extra 0.792 weeks of waiting to be adopted (about 5 or 6 extra days). 

By plugging in an animal’s age for _x_, we can make a _prediction_ about how many weeks it will take to be adopted. For example, we predict a 5-year-old animal to be adopted in @math{0.792(5) + 2.285 = 6.245} weeks. That’s the y-value exactly on the line at x=5.{style="font-size:14pt"}

---
{layout="Launch"}
# Linear Regression in Pyret

The intercept is `2.285`. This is where the best-fitting line crosses the y-axis. We want to be careful not to interpret this too literally, and say that a newborn animal would be adopted in 2.285 weeks, because none of the animals in our dataset was that young. Still, the @vocab{regression line} (or @vocab{line of best fit}) suggests that a baby animal, whose age is close to 0, would take only about 3 weeks to be adopted.

---
{layout="Launch"}
# Linear Regression in Pyret

We also see the @math{r}-value is +0.442. The sign is positive, consistent with the fact that the scatter plot point cloud, along with the line of best fit, slopes upward. The fact that the @math{r}-value is close to 0.5 tells us that the strength is moderate. This is consistent with the fact that the scatter plot points are somewhere between being really tightly clustered and really loosely scattered.

---
{layout="Investigate"}
# Linear Regression in Pyret

- If an animal is 5 years old, how long would our line of best fit predict they would wait to be adopted? What if they were a newborn, just 0 years old?
- Make another lr-plot, but this time use the animals' weight as our explanatory variable instead of their age.
- If an animal weighs 21 pounds, how long would our line of best fit predict they would wait to be adopted? What if they weighed 0.1 pounds?
---
{layout="Investigate"}
# Linear Regression in Pyret

- Make another lr-plot, comparing the `age` v. `weeks` columns for _only the cats_.
- Complete @printable-exercise{which-questions-make-sense.adoc}
- _Optional:_ open @opt-starter-file{height} to explore the same student dataset broken down by gender identity using @opt-printable-exercise{age-v-height-explore.adoc}.

---
{layout="Synthesize"}
# Linear Regression in Pyret

A predictor _only makes sense within the range of the data that was used to generate it_. For example, a regression line predicting weight from height based only on adults could predict an infant to have a weight less than zero!

---
{layout="Synthesize"}
# Linear Regression in Pyret

- Which ages made sense to calculate the heights for using the linear regression? Why?
- How tall did the equation expect a ninety-year-old human to be?! _about 301 inches!_
- Did anyone figure out how tall would that be in feet? _over 25 feet!_

<!--

-->

---
{layout="Launch"}
# Interpreting LR Plots


How well can you interpret the results of a linear regression analysis? How would you explain it to someone else?{style="font-size:26pt"}

---
{layout="Launch"}
# Interpreting LR Plots

- What does it mean when a data point is _above_ the line of best fit?
- What does it mean when a data point is _below_ the line of best fit?
- Turn to @printable-exercise{pages/interpreting-regression-lines-n-rvalues.adoc}, and match the write-up on the left with the line of best fit and @math{r}-value on the right.

<!--
- What does it mean when a data point is _above_ the line of best fit?
** It means the y-value is _higher_ than the sample would have predicted for that x-value.
- What does it mean when a data point is _below_ the line of best fit?
** It means the y-value is _lower_ than the sample would have predicted for that x-value.
- Turn to @printable-exercise{pages/interpreting-regression-lines-n-rvalues.adoc}, and match the write-up on the left with the line of best fit and @math{r}-value on the right.
-->
---
{layout="Launch"}
# Interpreting LR Plots

Complete @printable-exercise{pages/regression-analysis-example.adoc}.

At the bottom of the page we have the _Data Story_ for this question, which includes the results of the analysis and a responsible way to write about them. 

When looking at a regression for adoption time v. age for just the cats, we saw that the slope of the predictor function was +0.23, meaning that for every year older a cat is, we expect a +0.23-week increase in the time taken to adopt the cat. The @math{r}-value was +0.566, confirming that the correlation is positive and indicating moderate strength.

<!--
Have students explain the connection between the Ask Questions and Consider Data step. Do they match? Why or why not?
-->
---
{layout="Investigate"}
# Interpreting LR Plots

- Turn to @printable-exercise{pages/describing-relationships-1.adoc}
- Using the language you saw on @printable-exercise{pages/regression-analysis-example.adoc}, how would you write up the findings on this page?
- Optional: for more practice, students can complete @opt-printable-exercise{pages/describing-relationships-2.adoc}

<!--
*Common Misconceptions*
* *Don't call it "accuracy"!* One of the most common misconceptions about Linear Regression is that the @math{r} or @math{r}-squared value is a _measure of accuracy._ For example, a student who sees a very high @math{r}-value when plotting age vs. weeks might say "this prediction is 95% accurate." But these values only speak to _how much variation in the y-axis can be explained by variation in the x-axis_, so the statement should be "95% of the variation in weeks can be explained by variation in the age."
* *X and Y matter!* The correlation coefficient will be the same, even if you swap the x- and y-axes. However, the _interpretation_ of the display is different! The column used for the x-axis will always be interpreted as "the explanation" for the "result" seen in the y-axis. It's fine to say that being older tends to make an animal take longer to be adopted, but it is *not true* that taking longer to be adopted makes an animal older!
-->
---
{layout="Launch"}
# Your Analysis

Now that you've gotten some practice performing linear regression on the Animals Dataset, it's time to apply that knowledge to your own data!

---
{layout="Investigate"}
# Your Analysis

- Ask your questions and tell your story on @printable-exercise{pages/regression-analysis-1.adoc}.
- Students should fill in the Correlations portion of their @starter-file{research-paper}, using the scatter plots and linear regression plots they've constructed for their dataset and explaining what they show.

---
{layout="Synthesize"}
# Your Analysis

@image{images/lin-reg-2.png, lin reg 2, 400}

You’ve learned how linear regression can be used to fit a line to a linear cloud, and how to determine the direction and strength of that relationship. The word “linear” is important here. In the image on the right, there’s clearly a pattern, but it doesn’t look like a straight line! 

There are many other kinds of statistical models out there, but all of them work the same way: use a particular kind of mathematical function (linear or otherwise), to figure out how to get the “best fit” for a cloud of data.

<!--
Have students share their findings with the class. Get excited about the connections they are making and the conclusions they are drawing! Encourage students to make suggestions to one another about further analysis.

-->

---
{layout="Supplemental"}
# Your Analysis

- @opt-printable-exercise{pages/describing-relationships-2.adoc}
