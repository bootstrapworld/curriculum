---
{layout="DS Title Slide"}
# Linear Regression

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Intro to Linear Regression 

Make two scatterplots from the `animals-table`, using `age` as the explanatory variable in one plot and `pounds` as the @vocab{explanatory variable} in the other. 

In both plots, use `weeks` as your @vocab{response variable} and `name` for the `labels`. We will refer to the explanatory column as “xs” and the response column as “ys.”


<!--

-->
---
{layout="Launch"}
# Intro to Linear Regression 

*“Can we _predict_ an animal's adoption time based on its size? Its age?”*

We are asking if we can use an animal’s **size** or **age** to predict how long it will take to be adopted. A scatter plot of adoption time versus size _does_ suggest that smaller animals get adopted faster than larger animals. Similarly, younger animals tend to be adopted faster than older ones.{style="font-size:16pt"}

**Can we be more precise about this, and actually _predict_ how long it will take an animal to be adopted?** And which one would give us a better prediction?{style="font-size:16pt"}

<!--

-->
---
{layout="LaunchR"}
# Intro to Linear Regression 

@image{images/pounds-v-weeks.gif, 400}

The mean, median, and mode are three different ways to measure the “center” of a dataset in one dimension. 

Each represents a different way to collapse a bunch of points on a number line into a single, summary value. 

If the “center” of points on a _one dimensional_ number line is a single point, **what is the “center” of points in a _two-dimensional_ cloud**?


<!--

-->
---
{layout="Launch"}
# Intro to Linear Regression 

What we need to do is find a _line_ -- called a @vocab{line of best fit}, or a @vocab{regression line} -- that is at the center of this cloud. 

Each point in our scatter plot “pulls” on the line, with points above the line yanking it up and points below the line dragging it down. Points that are really far away -- especially influential observations that are far out in the x direction —- pull on the line with more force. 

This line can be graphed on top of the scatter plot as a function, called the @vocab{predictor function}.

<!--

-->
---
{layout="LaunchC"}
# Intro to Linear Regression 

@image{images/lr-pounds-v-weeks.png, 300}

Given a value on the x-axis, this line allows us to predict what the corresponding value on the y-axis might be. **This allows us to make predictions based on our data!**{style="font-size:16pt"}

---
{layout="Launch"}
# Intro to Linear Regression 

Data scientists use a statistical method called @vocab{linear regression} to pinpoint linear relationships in a dataset. 

When we draw our @vocab{regression line} on a scatter plot, we can imagine a rubber bands stretching vertically between the line itself and each point in the plot -- every point pulls the line a little “up” or “down”. 

Linear regression is the math behind the line of best fit.

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

- Move the blue point “P”, and see what effect it has on the red line.{style="font-size:16pt"}
- Find the number called @math{r}. What does this number tell us?{style="font-size:16pt"}
- What’s the largest @math{r}-value you can get? What do you think that number means?{style="font-size:16pt"}
- Move P so that it is as _far from the other points_ as possible.{style="font-size:16pt"}
- Move P so that it is _most_ aligned with the other points.{style="font-size:16pt"}
- Could the @vocab{regression line} ever be above or below _all_ the points? Why or why not?{style="font-size:16pt"}

---
{layout="Investigate2"}
# Intro to Linear Regression 

Let's explore scatter plots for weeks-v-pounds and weeks-v-age.

@image{images/age-v-weeks.gif, 400}
@image{images/pounds-v-weeks.gif, 400}

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
* *Don't forget to look at sample size!* A linear regression plot with an @math{r}-value of 0.999 is strong...but that's useless if it's a sample of just three data points!

-->
---
{layout="Synthesize"}
# Intro to Linear Regression 

* Would it be possible to have a line that is _below_ all the points?
* Would it be possible to have a line that is _above_ all the points?
* Would it be possible to have a line with more points on one side than the other?

<!--
Give students some time to experiment, then share back observations. 

**Answers**
1. No
2. No
3. Yes
-->
---
{layout="Launch"}
# Linear Regression in Pyret

Pyret includes a powerful display, which (1) draws a scatter plot, (2) draws the line of best fit, and (3) even displays the equation for that line:

```{style="font-size:16pt"}
# lr-plot :: Table, String, String, String -> Image
# consumes a table, and 3 column names: labels, xs and ys
# produces a scatter plot, and draws the line of best fit
lr-plot(animals-table, "name", "age", "weeks")
```
<!--

-->
---
{layout="LaunchR"}
# Linear Regression in Pyret

```{style="font-size:14pt"}
# lr-plot :: Table,String,String,String -> Image
lr-plot(animals-table, "name", "age", "weeks")
```

@image{images/lr-explained.png,  400}
`lr-plot` is a function that takes a Table & the names of *3 columns*:{style="font-size:13pt"}

- `ls` -- the name of the column to use for _labels_ (e.g. “names of pets”){style="font-size:13pt"}
- `xs` -- the name of the column to use for _x-coordinates_ (e.g. “age of each pet”){style="font-size:13pt"}
- `ys` -- the name of the column to use for _y-coordinates_ (e.g. “weeks for each pet to be adopted”){style="font-size:13pt"}

Our goal is to use values of the variable on our x-axis to _predict_ values of the variable on our y-axis.{style="font-size:13pt"}

---
{layout="Launch-DN"}
# Linear Regression in Pyret

- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
- Create an `lr-plot` for the `animals-table`, using `"names"` for the labels, `"age"` for the x-axis and `"weeks"` for the y-axis.

---
{layout="LaunchR"}
# Linear Regression in Pyret

@image{images/lr-explained.png, 400}

The resulting scatter plot looks like those we’ve seen before, but it has a few important additions.{style="font-size:12pt"}

First, we can see the @vocab{line of best fit} drawn onto the plot. We can also see the equation for that line (in red).{style="font-size:12pt"}

In this plot, we can see that **the slope of the line is 0.789**, which means that on average, **each extra year of age results in an extra 0.789 weeks of waiting to be adopted** (about 5 or 6 extra days).{style="font-size:12pt"}

---
{layout="LaunchR"}
# Linear Regression in Pyret

@image{images/lr-explained.png, 400}

By plugging in an animal’s age for _x_ in the predictor function @math{y = 0.789x + 2.309}, we can make a _prediction_ about how many weeks it will take to be adopted.{style="font-size:16pt"}

For example, **we predict a 5-year-old animal to be adopted in @math{0.789(5) + 2.309 = 6.254} weeks.** That’s the y-value exactly on the line at x=5.{style="font-size:16pt"}

---
{layout="LaunchR"}
# Linear Regression in Pyret

@image{images/lr-explained.png, 400}

**The intercept is `2.309`**. This is where the best-fitting line crosses the y-axis. We want to be careful not to interpret this _too_ literally, and say that a newborn animal would be adopted in 2.309 weeks, because none of the animals in our dataset was that young.{style="font-size:16pt"} 

Still, the @vocab{regression line} (or @vocab{line of best fit}) suggests that a baby animal, whose age is close to 0, would take only about 3 weeks to be adopted.{style="font-size:16pt"}

---
{layout="LaunchR"}
# Linear Regression in Pyret

@image{images/lr-explained.png, 400}

We also see **the @math{r}-value is +0.448**. The sign is positive, consistent with the fact that the scatter plot point cloud and line of best fit, slope upward.{style="font-size:16pt"}

The fact that **the @math{r}-value is close to 0.5** tells us that the strength is **moderate**.{style="font-size:16pt"}

This makes sense: the points on the scatter plot are somewhere between being really tightly clustered and really loosely scattered.{style="font-size:16pt"}

---
{layout="InvestigateR"}
# Linear Regression in Pyret

@image{images/lr-explained.png, 400}

- If an animal is 5 years old, how long would our line of best fit predict they would wait to be adopted? What if they were a newborn, just 0 years old?
- Make another lr-plot, but this time **use the animals' weight as our explanatory variable instead of their age.**
- If an animal weighs 21 pounds, how long would our line of best fit predict they would wait to be adopted? What if they weighed 0.1 pounds?
---
{layout="Investigate"}
# Linear Regression in Pyret

- Make another lr-plot, comparing the `age` v. `weeks` columns for **only the cats**.
- Complete @printable-exercise{which-questions-make-sense.adoc}
- _Optional:_ open @opt-starter-file{height} to explore the same student dataset broken down by gender identity using @opt-printable-exercise{age-v-height-explore.adoc}.

---
{layout="Synthesize"}
# Linear Regression in Pyret

**A predictor only makes sense within the range of the data that was used to generate it.**

- Which ages made sense to calculate the heights for using the linear regression? Why?
- How tall did the equation expect a ninety-year-old human to be?! _about 301 inches!_
- Did anyone figure out how tall would that be in feet? _over 25 feet!_

<!--

-->

---
{layout="Launch"}
# Interpreting LR Plots


How well can you interpret the results of a linear regression analysis?{style="font-size:26pt"}

How would you explain it to someone else?{style="font-size:26pt"}

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

Read @printable-exercise{pages/regression-analysis-example.adoc}.

At the bottom of the page we have the _Data Story_ for this question, which includes the results of the analysis and a responsible way to write about them. 

When looking at a regression for adoption time v. age for just the cats, we saw that the slope of the predictor function was +0.23, meaning that for **every year older, we expect a cat to take +0.23-weeks longer to be adopted** The @math{r}-value was +0.566, confirming that the correlation is positive and indicating moderate strength.

<!--
Have students explain the connection between the Ask Questions and Consider Data step. Do they match? Why or why not?
-->
---
{layout="Investigate"}
# Interpreting LR Plots

- Turn to @printable-exercise{pages/describing-relationships-1.adoc}
- Using the language you saw on @printable-exercise{pages/regression-analysis-example.adoc}, how would you write up the findings on this page?
- Optional: for more practice, you can complete @opt-printable-exercise{pages/describing-relationships-2.adoc}

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
- Fill in the Correlations portion of your @starter-file{research-paper}, using the scatter plots and linear regression plots they've constructed for their dataset and explaining what they show.

---
{layout="SynthesizeR"}
# Your Analysis

@image{images/lin-reg-2.png, 400}

You’ve learned how linear regression can be used to fit a line to a linear cloud, and how to determine the direction and strength of that relationship. The word “linear” is important here. In the image on the right, there’s clearly a pattern, but it doesn’t look like a straight line!{style="font-size:15pt"} 

There are many other kinds of statistical models out there, but all of them work the same way: use a particular kind of mathematical function (linear or otherwise), to figure out how to get the “best fit” for a cloud of data.{style="font-size:15pt"}

<!--
Have students share their findings with the class. Get excited about the connections they are making and the conclusions they are drawing! Encourage students to make suggestions to one another about further analysis.

-->

---
{layout="Supplemental"}
# Your Analysis

- @opt-printable-exercise{pages/describing-relationships-2.adoc}
- @opt-project{olympics-project.adoc, olympics-project-rubric.adoc}
