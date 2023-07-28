---
{layout="DS Title Slide"}
# Exploring Linear Models

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Looking for Patterns

- Today we'll be looking at data from each state in the US, and searching for possible relationships within the data!
- Open the @online-exercise{https://code.pyret.org/editor#share=10bWYM4rOq_ZshtX6_M-xf-bPbfz61rd1, State Demographics Starter File}
- From the File menu, select "Save a Copy", and click "Run".
- Working in pairs or small groups, complete questions 1 and 2 in @printable-exercise{exploring-states.adoc}.

<!--
Have students share back what they Notice and Wonder about the dataset.
-->
---
{layout="Launch"}
# Looking for Patterns

The code on lines 13 and 14 show us how Pyret defines values:

```
alabama = row-n(states-table, 0)
alaska  = row-n(states-table, 1)
```

The variables `alabama` and `alaska` are _rows_ from the table.

<!--
In math, `x = 4` will define a variable `x` to be the value `4`. Any time we use `x` after that, we can substitute in the value of `4`. This works in Pyret too! But in Pyret, values can be more than just numbers!
-->

---
{layout="Investigate"}
# Looking for Patterns

- Working in pairs or small groups, complete questions 3 and 4 (making displays and suggesting possible relationships) in @printable-exercise{exploring-states.adoc}.
- **Do not go on to question 5!** We'll be returning to that later in the lesson.

<!--
Note: During this activity, don't let students just make scatter plot for random pairs of columns. Instead, encourage them to first _think about which columns might be related_, and then create the scatter plot to search for this relationship. The dataset is designed so that students will quickly begin searching for relationships between varying levels of education and income, and there are linear relationships in each of these.
-->
---
{layout="Synthesize"}
# Looking for Patterns

- Share your scatter-plots with one another! What possible relationships did you find in question 3?
- Did you and your classmates commonly use any words to describe the relationships you observed?

<!--
Teacher note: the next section of the lesson is all about identifying form, direction, and strength. Students will acquire the formal vocabulary that data scientists use to assess relationships.
-->
---
{layout="Launch"}
# Describing Patterns

Scatter plots let us visualize the relationship between two columns. If no relationship exists, the points in the scatter plot just appear as a shapeless cloud. 

But if there _is_ a relationship, the points will form some kind of pattern. When we build scatter plots, we are searching for patterns - or @vocab{correlations} between two quantitative variables.

These patterns can be described using three qualities: **form**, **direction**, and **strength**.

<!--

-->

---
{layout="Launch"}
# Describing Patterns

@vocab{Form} refers to the shape of the pattern. Sometimes a pattern looks like a straight line, or a curve, or a hockey stick. And sometime, there's no clear shape at all!

Form indicates whether a relationship is linear, non-linear or undefined.

@table{3}
| @image{images/1b1.gif, 250} | @image{images/2NL.gif, 250} | @image{images/B.gif, 250}
| Some patterns are **linear**, and cluster around a straight line sloping up or down. | Some patterns are **non-linear**, and may look like a curve or an arc. | And sometimes there is **no relationship** or pattern at all!

<!--

-->
---
{layout="LaunchR"}
# Describing Patterns

Linear relationships have direction

For straight-line relationships, we can talk about **direction**.

@image{images/C.gif, 200 }
**Positive**: The line slopes up as we look from left-to-right. Positive relationships are by far the most common because of natural tendencies for variables to increase in tandem. For example, “the older the animal, the more it tends to weigh”. This is usually true for human animals, too!

<!--

-->

---
{layout="LaunchR"}
# Describing Patterns

@image{images/A.gif, 200}
**Negative**: The line slopes _down_ as we look from left-to-right. For example, “the older a child gets, the fewer new words he or she learns each day.”

Note: Not every shape has a direction! For example, a curve can start out sloping upwards, but then peak and slope downwards.

<!--

-->
---
{layout="Launch"}
# Describing Patterns

**Strength** indicates how closely the two variables are correlated.

How well does knowing the x-value allow us to predict what the y-value will be?


<!--

-->
---
{layout="LaunchR"}
# Describing Patterns

@image{images/A.gif, 200}
**A relationship is strong if knowing the x-value of a data point gives us a very good idea of what its y-value will be** 

For example: a knowing a student's age gives us a very good idea of what grade they're in. 

A strong linear relationship means that the points in the scatter plot are all clustered _tightly_ around an invisible line.

<!--

-->
---
{layout="LaunchR"}
# Describing Patterns

@image{images/1a.gif, 200}
**A relationship is weak if x tells us little about y**

For example: a student's age doesn't tell us much about their number of siblings!

A weak linear relationship means that the cloud of points is scattered very _loosely_ around the line.

<!--

-->
---
{layout="Investigate"}
# Describing Patterns

In pairs or small groups, complete @printable-exercise{pages/identifying-form-matching.adoc}.

<!--
Review student answers, and have students _explain their thinking_ for this activity. For students who are struggling, hearing what their peers are looking for is especially helpful at this stage.
-->
---
{layout="SynthesizeR"}
# Describing Patterns

In pairs or small groups, complete @printable-exercise{pages/identifying-form.adoc}


<!--
Review student answers. Some of the answers are not so clear-cut, and students may disagree about what constitutes a "strong" vs. "weak" correlation. We've tried to choose scatter plots that clearly fall into one category or the other, but without diving into the algorithm for linear regression students may find this exercise somewhat subjective.
-->
---
{layout="Launch"}
# Describing Patterns

Return to @printable-exercise{exploring-states.adoc}, and complete the rest of the page.

<!--

-->

---
{layout="Synthesize"}
# Describing Patterns

- What relationships did you find in the states dataset?
- What was their form, direction, and strength?
- Were any of these relationships a surprise? Why or why not?

<!--
- Students often conflate strength and direction, thinking that a strong correlation _must_ be positive and a weak one _must_ be negative.
- Students may also falsely believe that there is ALWAYS a correlation between any two variables in their dataset.
- Students often believe that strength and sample size are interchangeable, leading to mistaken assumptions like "any correlation found in a million data points _must_ be strong!"
-->
---
{layout="Launch"}
# Fitting Linear Models

In Pyret, make a scatter plot showing the the relationship between `college-or-higher` and `median-income`.


<!--

-->
---
{layout="LaunchC"}
# Fitting Linear Models

@image{images/college-v-income.png}
This scatter plot appears to show a positive, linear relationship: states with higher percentages of college graduates tend to have higher median household incomes.

<!--

-->
---
{layout="LaunchC"}
# Fitting Linear Models

@image{images/college-v-income.png}

Suppose the United States were to add a new state. **Based on the data for the existing 50 states, what median household income would you predict, if exactly 50% of the new state's citizens had attended college?** What about 90%? 10%

<!--
Let students discuss, and explain their thinking. If possible, mark off a single point for each of the hypothetical percentages, then connect those points to show a straight line. Note that some of these new points would require changing the x- and y-axes of our display!
-->
---
{layout="Launch"}
# Fitting Linear Models

When we see patterns in data, we can use those patterns to __make predictions__ based on that data. We can even draw a line to show all the possible predictions at once! These predictions represent our "best guess" at the underlying relationship in the data, as we try to model that relationship using math.

<!--
These models are just functions being graphed on top of the scatter plot, with the goal of minimizing the distance between the line and all the points on the plot. For straight-line relationships, these are _linear functions_ or "linear models". The straight-line graph of these models is sometimes called the "regression line" or the "predictor function", but you may have heard it called the @vocab{line of best fit}.
-->
---
{layout="Launch"}
# Fitting Linear Models

When we make a model, we want it to be the closest possible approximation of all the points. A "good fit" has most of the points very close to the line, and a "bad fit" has the points very far away.

---
{layout="Launch"}
# Fitting Linear Models

Depending on what part of the model we care about most, we might choose to use one display over another.

@table{3}
| Standard Form | Point-Slope Form | Slope-Intercept Form
| @math{Ax+By = C}|@math{y-y_1 = m(x-x_1)}|@math{y = mx+b}

<!--
- Standard Form makes it easy to find the x- and y-intercepts of the line
- Point-Slope Form makes it easy to find the equation of the line given a single point and slope
- Slope-Intercept Form makes it really easy to read off the slope and y-intercept

Since we're looking for both the slope and the y-intercept for this model, it makes sense to use Slope-Intercept form.
-->
---
{layout="Investigate"}
# Fitting Linear Models

- Complete the first section ("Build a Model from Samples") in @printable-exercise{model-college-v-income.adoc}.
- How well did your model work for Alabama and Alaska? Why didn't it work as well for other states?
- How can we measure "how well a model fits"?

<!--
Before students complete the remainder of the workbook page, confirm that they were able to successfully compute slope and y-intercept, define and test `f(x)` in Pyret, and evaluate the predictive value of `f(x)`.
-->
---
{layout="Investigate"}
# Fitting Linear Models

Pyret includes a function called `fit-model`. @pathway-only{Find this contract in your @pathway-link{resources/pages/contracts.pdf, Contracts pages}!} Like `scatter-plot`, it consumes columns for our labels, our @math{x}s and ours @math{y}s. However, it __also consumes a function!__ It produces a scatter plot, with the function graphed on top of it.

- Complete the second section ("Fit the Model") in @printable-exercise{model-college-v-income.adoc}.
- What does @math{R^2} mean?

<!--

-->
---
{layout="Investigate"}
# Fitting Linear Models

@math{R^2} describes the _percentage of the variation in the y-variable that is explained by the x variable_ in our model. 

In other words, an @math{R^2} value of 0.20 could mean that “20% of the variation in median household income is explained by the percentage of college degrees in a state, according to our linear model”. 

Better models will explain a higher percentage of that variation!

<!--
If the model is perfect, the @math{R^2} value will be 1.00, meaning 100% of the @math{y}-values can be explained by the @math{x}-values. Of course in the real world, no model is perfect! The @math{R^2} value for no correlation at all is *zero*. If we just drew a horizontal predictor line _in the middle of the data_, it would mean that we expect a median income somewhere in that range but with no connection whatsoever to the percentage of people who finish college.
-->
---
{layout="Investigate"}
# Fitting Linear Models

But sometimes models make predictions that are _even worse than useless_ - they trend in the wrong direction altogether! Did you see any models with a negative @math{R^2} value?

- Complete the third section ("Build a Model through Trial and Error") in @printable-exercise{model-college-v-income.adoc}.
- Optional: For each of your trials, graph the resulting linear model on @opt-printable-exercise{graphing-models.adoc}.
- What was the best model you could come up with?

<!--
Have students share their "best" models
-->
---
{layout="Investigate"}
# Fitting Linear Models

But how do we find the __best__ model? In Statistics, an algorithm called linear regression is used to derive the slope and y-intercept of the best possible model by taking every datapoint into account. Pyret has a function that will do just that, called `lr-plot`.

- Complete the last section ("Build a Model Computationally") in @printable-exercise{model-college-v-income.adoc}.

<!--
How close did you come to the optimal model? Did anything about the model surprise you?
-->
---
{layout="Investigate"}
# Fitting Linear Models

When we interpret a model, we try to make sense of the slope, the axes, the @math{R^2} value, and the real data behind them. 

In this example, **a model built from Alaska and Alabama predicts that a 1 percent increase in college degrees is associated with a **$5613** increase in median household income.**

But based on the @math{R^2} value of **-15.63**, this is a pretty terrible model and shouldn't be trusted!

<!--

-->
---
{layout="Investigate"}
# Fitting Linear Models

These models are useless if we can't make sense of them!

- For practice building other relationships in the data, complete @printable-exercise{interpreting-linear-models.adoc}.
- Optional: For more practice, build linear models for **other** relationships in the data! You can use @opt-printable-exercise{model-your-own.adoc}, and write up your findings in the extra space on @printable-exercise{interpreting-linear-models.adoc}.


<!--

-->
---
{layout="Synthesize"}
# Fitting Linear Models

- How could we use scatter plots and linear models to find out if taller NBA players tend to make more three-pointers?
- How could we use them to find out if wealthier people live longer?
- How could we use them to find answers to _other_ questions?

<!--

-->
---
{layout="Supplemental"}
# Additional Exercises

Practice switching between linear forms using @opt-printable-exercise{other-forms-linear-models.adoc}.

---