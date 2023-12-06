@slidebreak
{layout="DS Title Slide"}
# Linear Regression

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch"}
# Intro to Linear Regression 

Make two scatterplots from the `animals-table`, using `age` as the explanatory variable in one plot and `pounds` as the @vocab{explanatory variable} in the other. 

In both plots, use `weeks` as your @vocab{response variable} and `name` for the `labels`. We will refer to the explanatory column as “xs” and the response column as “ys.”


@slidebreak
{layout="Launch"}
# Intro to Linear Regression 

*“Can we _predict_ an animal's adoption time based on its size? Its age?”*{style="font-size:16pt"}

We are asking if we can use an animal’s **size** or **age** to predict how long it will take to be adopted. A scatter plot of adoption time versus size _does_ suggest that smaller animals get adopted faster than larger animals. Similarly, younger animals tend to be adopted faster than older ones.{style="font-size:15pt"}

@image{images/pounds-v-weeks.gif, 400}
@image{images/age-v-weeks.gif, 400}

@teacher{
Quickly survey the class about whether they think we can use an animal’s size or age to predict how long it will take to be adopted.

- _A scatter plot of adoption time versus size does suggest that smaller animals get adopted faster than larger animals._
- _Similarly, younger animals tend to be adopted faster than older ones._
}

@slidebreak
{layout="Launch"}
# Intro to Linear Regression 

Can we be more precise about this, and actually _predict_ how long it will take an animal to be adopted, based on these factors? And which one would give us a better prediction?

@image{images/pounds-v-weeks.gif, 400}
@image{images/age-v-weeks.gif, 400}

@slidebreak
{layout="Launch"}
# Intro to Linear Regression 

Just as the mean, median, and mode can summarize data from a _single quantitative variable_, the “center” of points in a _two-dimensional_ cloud can be described by a @vocab{line of best fit}. Given a value for the @vocab{explanatory variable}, this line allows us to predict what the corresponding value for the @vocab{response variable} might be.

Open the @online-exercise{https://www.geogebra.org/m/ZcVIxKtF, Interactive Regression Line}, and use it to complete @printable-exercise{lr-plot-intro.adoc}.

@teacher{
Have students talk about their answers to the first section.
* Why do x-values that are far to the left or right of the point cloud have a larger impact on R?
** Think of their distance from the "anchor" of the data as the length of a wrench. The longer the handle, the more "force" P applies on the regression line.
* Why can't we have a regression line with all points above or below the line?
** Because the points exert a _balanced_ force on the line. If all the points were on one side, there would be nothing to balance them out on the other side.
}


@slidebreak
{layout="Launch"}
# Intro to Linear Regression 

Data scientists use a statistical method called @vocab{linear regression} to pinpoint linear relationships in a dataset. Linear regression is the math behind the @vocab{line of best fit}, which allows us to make predictions based on our data.

Each point in our scatter plot “pulls” on the line, with points above the line yanking it up and points below the line dragging it down. Points that are really far away -- especially influential observations that are far to the left or right of the point cloud —- pull on the line with more force.

This line can be graphed on top of the scatter plot as a function, called the @vocab{predictor function}.

@teacher{
We prefer the words “explanatory” and “response” in our curriculum, because in other contexts the words “dependent” and “independent” refer to whether or not the variables are related at all, as opposed to what role each plays in the relationship.

The straight line that best fits the points on a scatter plot has several names, depending on the context, subject, or grade level. All of the following terms refer to the same concept:

_Regression Line - Line of Best Fit - Least Squares Line - Predictor - Trendline_

The line itself is computed through a process called _linear regression_, which also goes by the name _least squares regression_.	
}

@slidebreak
{layout="Investigate"}
# Intro to Linear Regression 

* Turn to @printable-exercise{pages/drawing-predictors.adoc}.
* In the first column, draw a @vocab{line of best fit} through each of the scatter plots.
* In the second column, circle whether the slope of the line (which is the same as the _direction_ of the correlation) is positive or negative.

<!--
*Common Misconceptions*
* *Don't forget to look at sample size!* A linear regression plot with an @math{r}-value of 0.999 is strong...but that's useless if it's a sample of just three data points!

-->
@slidebreak
{layout="Synthesize"}
# Intro to Linear Regression 

* Would it be possible to have a line with more points on one side than the other?

@teacher{Yes - as long as the forces are balanced}

@slidebreak
{layout="Launch"}
# Performing Linear Regression

@proglang includes a powerful display called @ifproglang{pyret}{`lr-plot`}@ifproglang{codap}{Least Squares Line}, which (1) draws a scatter plot, (2) draws the line of best fit, and (3) even displays the equation for that line.

@ifproglang{pyret}{
```{style="font-size:16pt"}
# lr-plot :: Table, String, String, String -> Image
# consumes a table, and 3 column names: labels, xs and ys
# produces a scatter plot, and draws the line of best fit
lr-plot(animals-table, "name", "age", "weeks")
```
}

<!--

-->
@slidebreak
{layout="LaunchR"}
# Performing Linear Regression

@ifproglang{pyret}{
```{style="font-size:14pt"}
# lr-plot :: Table,String,String,String -> Image
lr-plot(animals-table, "name", "age", "weeks")
```
}


@ifproglang{pyret}{@image{images/lr-explained.png, 400}}
@ifproglang{codap}{@image{images/codap-lr-explained.png, 400}}

@ifproglang{codap}{
To perform linear regression in CODAP, simply create a scatter plot and select Least Squares Line from the `Measure` menu.

Our goal is to use values of the variable on our x-axis to _predict_ values of the variable on our y-axis.}

@ifproglang{pyret}{
`lr-plot` is a function that takes a Table & the names of *3 columns*:{style="font-size:13pt"}

- `ls` -- the name of the column to use for _labels_ (e.g. “names of pets”){style="font-size:13pt"}
- `xs` -- the name of the column to use for _x-coordinates_ (e.g. “age of each pet”){style="font-size:13pt"}
- `ys` -- the name of the column to use for _y-coordinates_ (e.g. “weeks for each pet to be adopted”){style="font-size:13pt"}

Our goal is to use values of the variable on our x-axis to _predict_ values of the variable on our y-axis.{style="font-size:13pt"}}

@slidebreak
{layout="Launch"}
# Performing Linear Regression

- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
- Create @ifproglang{pyret}{an `lr-plot`}@ifproglang{codap}{a Least Squares Line} for the Animals Table.

** Use `"name"` for the labels.
** Use `"age"` for the x-axis.
** Use `"weeks"` for the y-axis.


@slidebreak
{layout="LaunchR"}
# Performing Linear Regression

@ifproglang{pyret}{@image{images/lr-explained.png, 400}}
@ifproglang{codap}{@image{images/codap-lr-explained.png, 400}}

The resulting scatter plot looks like those we’ve seen before, but it has a few important additions.{style="font-size:12pt"}

First, we can see the @vocab{line of best fit} drawn onto the plot. We can also see the equation for that line.{style="font-size:12pt"}

In this plot, we can see that **the slope of the line is 0.789**, which means that on average, **each extra year of age results in an extra 0.789 weeks of waiting to be adopted** (about 5 or 6 extra days).{style="font-size:12pt"}

@slidebreak
{layout="LaunchR"}
# Performing Linear Regression

@ifproglang{pyret}{@image{images/lr-explained.png, 400}}
@ifproglang{codap}{@image{images/codap-lr-explained.png, 400}}

By plugging in an animal’s age for _x_ in the predictor function @math{y = 0.789x + 2.309}, we can make a _prediction_ about how many weeks it will take to be adopted.{style="font-size:16pt"}

For example, **we predict a 5-year-old animal to be adopted in @math{0.789(5) + 2.309 = 6.254} weeks.** That’s the y-value exactly on the line at x=5.{style="font-size:16pt"}

@slidebreak
{layout="LaunchR"}
# Performing Linear Regression

@ifproglang{pyret}{@image{images/lr-explained.png, 400}}
@ifproglang{codap}{@image{images/codap-lr-explained.png, 400}}

**The intercept is @ifproglang{pyret}{`2.2309`}@ifproglang{codap}{`2.3`}.** This is where the best-fitting line crosses the y-axis. We want to be careful not to interpret this _too_ literally, and say that a newborn animal would be adopted in  @ifproglang{pyret}{2.309}@ifproglang{codap}{2.3} weeks, because none of the animals in our dataset was that young.{style="font-size:16pt"} 

Still, the @vocab{regression line} (or @vocab{line of best fit}) suggests that a baby animal, whose age is close to 0, would take only about 3 weeks to be adopted.{style="font-size:16pt"}

@slidebreak
{layout="LaunchR"}
# Performing Linear Regression

@ifproglang{pyret}{@image{images/lr-explained.png, 400}}
@ifproglang{codap}{@image{images/codap-lr-explained.png, 400}}

@ifproglang{pyret}{We also see the @math{r}-value is `+0.448`.}@ifproglang{codap}{We also see that the @math{R^2} value is `0.201`. When we know @math{R^2}, we can find @math{r} by taking the square root of @math{R^2}. The @math{r}-value is `+0.448`.}

The fact that **the @math{r}-value is close to 0.5** tells us that the strength is **moderate**.{style="font-size:16pt"}

This makes sense: the points on the scatter plot are somewhere between being really tightly clustered and really loosely scattered.{style="font-size:16pt"}

@slidebreak
{layout="InvestigateR"}
# Performing Linear Regression

@ifproglang{pyret}{@image{images/lr-explained.png, 400}}
@ifproglang{codap}{@image{images/codap-lr-explained.png, 400}}

Complete @printable-exercise{lr-plot-explore.adoc}!

@slidebreak
{layout="Investigate"}
# Performing Linear Regression

- Make another lr-plot, comparing the `age` v. `weeks` columns for **only the cats**.
- Complete @printable-exercise{which-questions-make-sense.adoc}
@ifproglang{pyret}{
- @optional Open @opt-starter-file{height} to explore the same student dataset broken down by gender identity using @opt-printable-exercise{age-v-height-explore.adoc}.}


@slidebreak
{layout="Synthesize"}
# Performing Linear Regression

**A predictor only makes sense within the range of the data that was used to generate it.**

- Which ages made sense to calculate the heights for using the linear regression? Why?
- How tall did the equation expect a ninety-year-old human to be?! _about 301 inches!_
- Did anyone figure out how tall would that be in feet? _over 25 feet!_

<!--

-->

@slidebreak
{layout="Launch"}
# Interpreting LR Plots


How well can you interpret the results of a linear regression analysis?{style="font-size:26pt"}

How would you explain it to someone else?{style="font-size:26pt"}

@slidebreak
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
@slidebreak
{layout="Launch"}
# Interpreting LR Plots

Read @printable-exercise{pages/regression-analysis-example.adoc}.

At the bottom of the page we have the _Data Story_ for this question, which includes the results of the analysis and a responsible way to write about them. 

When looking at a regression for adoption time v. age for just the cats, we saw that the slope of the predictor function was +0.23, meaning that for **every year older, we expect a cat to take +0.23-weeks longer to be adopted** The @math{r}-value was +0.566, confirming that the correlation is positive and indicating moderate strength.

<!--
Have students explain the connection between the Ask Questions and Consider Data step. Do they match? Why or why not?
-->
@slidebreak
{layout="Investigate"}
# Interpreting LR Plots

- Turn to @printable-exercise{pages/describing-relationships-1.adoc}
- Using the language you saw on @printable-exercise{pages/regression-analysis-example.adoc}, how would you write up the findings on this page?
- @optional For more practice, you can complete @opt-printable-exercise{pages/describing-relationships-2.adoc}

<!--
*Common Misconceptions*
* *Don't call it "accuracy"!* One of the most common misconceptions about Linear Regression is that the @math{r} or @math{r}-squared value is a _measure of accuracy._ For example, a student who sees a very high @math{r}-value when plotting age vs. weeks might say "this prediction is 95% accurate." But these values only speak to _how much variation in the y-axis can be explained by variation in the x-axis_, so the statement should be "95% of the variation in weeks can be explained by variation in the age."
* *X and Y matter!* The correlation coefficient will be the same, even if you swap the x- and y-axes. However, the _interpretation_ of the display is different! The column used for the x-axis will always be interpreted as "the explanation" for the "result" seen in the y-axis. It's fine to say that being older tends to make an animal take longer to be adopted, but it is *not true* that taking longer to be adopted makes an animal older!
-->
@slidebreak
{layout="Launch"}
# Exploration Project (Linear Regression)

Let’s review what we have learned about linear regression.

Linear Regression is a way to calculate the line-of-best-fit (or "predictor function") for the relationship between two quantitative columns.

- Will @ifproglang{pyret}{`lr-plot`}@ifproglang{codap}{Least Squares Line} still find a line of best fit, even if there's no correlation?
- What does the slope of the line-of-best-fit tell us about a correlation?
- If the @math{r}-value is close to 1, does this mean the predictor function will always give us a good prediction of the y-value, based on _any_ x-value? Why or why not?

@teacher{
- Will @ifproglang{pyret}{`lr-plot`}@ifproglang{codap}{a Least Squares Line} still find a line of best fit, even if there's no correlation?
** _Yes! Linear regression will always find a line of best fit -- it just might not fit very well!_
- What does the slope of the line-of-best-fit tell us about a correlation?
** If the slope is positive, the correlation is positive. If it's negative, so is the correlation._
- If the @math{r}-value is close to 1, does this mean the predictor function will always give us a good prediction of the y-value, based on _any_ x-value? Why or why not?
** No! Even with an exremely high @math{r}-value, the predictor function should not be used to make predictions far outside the range of the dataset.	
}

@slidebreak
{layout="Investigate"}
# Exploration Project (Linear Regression)

Let’s connect what we know about linear regression to your chosen dataset.

- Open your chosen dataset starter file @ifproglang{pyret}{in Pyret}@ifproglang{codap}{in CODAP}.
- Choose one correlation you were investigating, and use the Data Cycle to ask the question about the relationship between those two columns. Tell the story on @printable-exercise{regression-analysis-1.adoc}.
- You can explore another question in the same way, using @opt-printable-exercise{regression-analysis-2.adoc}.

@teacher{Confirm that all students have created and understand how to interpret their LR plots. Once you are confident that all students have made adequate progress, invite them to access their @starter-file{exploration-project} from Google Drive.}

@slidebreak
{layout="Investigate"}
# Exploration Project (Linear Regression)

- *It’s time to add to your @starter-file{exploration-project}.*
- Find the "Correlations I want to look into" section of the slide deck.
- Choose one correlation you explored, and duplicate the slide.
- On the new slide, replace your scatter plot with the linear regression plot and add your interpretation of that plot.

@slidebreak
{layout="Synthesize"}
# Exploration Project (Linear Regression)

@teacher{Have students share their findings.}

Did you discover anything surprising or interesting about their dataset?

Did the results from @ifproglang{pyret}{`lr-plot`}@ifproglang{codap}{your Least Squares Line} confirm your suspicions about the correlation? Were any of them surprising?

@slidebreak
{layout="Supplemental"}
# Your Analysis

- An extra, @opt-printable-exercise{regression-analysis-2.adoc, blank regression analysis pages} is available
@ifproglang{pyret}{
- @opt-project{olympics-project.adoc, olympics-project-rubric.adoc}}
