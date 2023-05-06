---
{layout="DS Title Slide"}
# Exploring Logarithmic Relationships

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchR"}
# Looking for Patterns

@image{images/questions.png, 250}

- Do people who make more money generally live longer?
- Open the @online-exercise{https://code.pyret.org/editor#share=1SGzPWywGy63-DaqOVTy39-497lcWaF4B, Countries of the World Starter File}
- From the File menu, select "Save a Copy", and click "Run".
- Working in pairs or small groups, complete questions 1-4 on @printable-exercise{exploring-countries.adoc}.
- Be ready to discuss!

<!--
Discuss students' findings. Pay special attention to the @vocab{form} that students use to describe the pattern in the scatter plot. Is it linear, or something else? Is it strong or weak? If there's some disagreement among the students, that's a good thing!

-->
---
{layout="Launch"}
# Looking for Patterns

**Working in pairs or small groups, complete the rest of @printable-exercise{exploring-countries.adoc}.**

- Use @opt-online-exercise{https://www.desmos.com/calculator/9izutrnkas, Wealth-v-Health - Linear} to try fitting linear models for this dataset
- Use @opt-online-exercise{https://www.desmos.com/calculator/tpngoafcv8, Wealth-v-Health - Quadratic} to try fitting quadratic models for this dataset
- Use @opt-online-exercise{https://www.desmos.com/calculator/ktxtecldt9, Wealth-v-Health - Exponential} to try fitting exponential models for this dataset

<!--
Note: This worksheet involves lots of trial and error, as students try to come up with a good linear model. The goal is to __discover that a non-linear model is necessary__.

-->
---
{layout="Synthesize"}
# Looking for Patterns

- What's the best model you came up with?
- What sketches did you draw. What kinds of lines or curves did you use?

<!--

-->
---
{layout="LaunchC"}
# Fitting Logarithmic Models

@image{images/wealth-v-life-linear.png} There definitely appears to be a relationship here, but it's not linear. Using `lr-plot` only shows a moderate correlation, because the straight line doesn't really fit the curve. The shape of this starts out rising fast on the left, before tapering off as `pc-gdp` increases to the right.{style="font-size:15pt"}

<!--

-->

---
{layout="LaunchC"}
# Fitting Logarithmic Models

@image{images/wealth-v-life-linear.png} What functions behave like this? Could we approximate this with a quadratic model? An exponential one?


<!--

-->
---
{layout="Investigate"}
# Fitting Logarithmic Models

The shape of this relationship is _logarithmic_, meaning it can be modeled using a logarithmic function:

@center{@math{f(x) = b \times log(x) + c}  }

We need to find @math{b} and @math{c}, such that the model fits the data as closely as possible.

<!--

-->
---
{layout="Investigate"}
# Fitting Logarithmic Models

Pyret has a few functions that may come in handy here:

@show{(contract "num-log" '("Number") "Number" "Consumes a number, and produces its natural log")}
@show{(contract "num-log-base" '("Number" "Number") "Number" "Consumes a number and a base, and produces the log of that number with the base")}
@show{(contract "num-expt" '("Number" "Number") "Number" "Consumes a number and a power, and produces that number raised to the power")}

---
{layout="Investigate"}
# Fitting Logarithmic Models

- Experiment with logarithmic models using @online-exercise{https://www.desmos.com/calculator/zfb5aaczt6, Wealth-v-Health - Logarithmic}
- Complete @printable-exercise{model-wealth-v-lifespan.adoc}

<!--
Note: This process involves a lot of trial and error, as students build up an intuition for how the terms in a logarithmic graph affect the graph of the function. This mirrors the process students went through in earlier exploring-models lessons.

-->
---
{layout="Investigate"}
# Fitting Logarithmic Models

- @math{c} represents the vertical shift in our model, which slides the curve up or down the y-axis
- @math{b} represents the growth factor, which determines how quicky the curve "flattens out" as @math{x} increases

---
{layout="Synthesize"}
# Fitting Logarithmic Models

- What was the best @math{R^2} value you found?
- What points did you use?
- What, if any, other strategies did you use to come up with your model?

<!--

-->
---
{layout="Launch"}
# Using Log Transformations

Deriving a logarithmic model from only two points is problematic. How do we know that those two points really represent the shape of the curve? 

If we picked a wealthy country that is at war, we'd find an artificially low life expectancy. 

A model based on that point is unlikely to fit the rest of the points very well!


<!--

-->

---
{layout="Launch"}
# Using Log Transformations

This is the same problem we ran into with linear models in our state demographics data, where a model built from any two points would only be as good as those points were representative.

Trial-and-error only gets us so far, and it's not clear that we would ever stumble upon the optimal model. We need something like Pyret's `lr-plot` function, which uses computational methods to find the best possible model. Unfortunately, `lr-plot` only finds linear models. We need to find a transformation that will make this data appear linear in order to use `lr-plot`.

<!--

-->
---
{layout="Launch"}
# Using Log Transformations

Imagine that the scatter plot is printed on a sheet of rubber, and can be stretched or squashed in any way we want. 

Data Scientists often use *transformations* to stretch their data into shapes that are easier to use, and then reverse the transformation when they are done.

<!--

-->

---
{layout="Launch"}
# Using Log Transformations

- Complete questions 1-6 in @printable-exercise{transforming-wealth.adoc}.
- What does the `build-column` function do?
- How is `albania["pc-gdp"] / 2` similar to `transform-pc-gdp(albania)`? How are they different?

<!--

-->
---
{layout="Launch"}
# Using Log Transformations

Given a table, a string and a function, `build-column` creates a new table with an extra column. 
The given string determines the header of the column, and the given function computes the values in that column based on each row of the old table. 
In this worksheet, `build-column` is used to add a column called `pc-gdp / 2` to the `countries-table`, by applying `transform-pc-gdp` to each Row.


<!--

-->
---
{layout="Launch"}
# Using Log Transformations

Now we can look for a relationship between `pc-gdp / 2` and `median-lifespan`.

Our goal in transforming this dataset is to find a transformation that lets us use the power of linear regression to compute the best-possible model. Once we've done that, we'll __transform the model itself__ and use the transformed model with our original dataset.

<!--

-->
---
{layout="Investigate"}
# Using Log Transformations

Since the values on the y-axis (`median-lifespan`) appear to grow logarithmically, we could _transform_ the x-axis (`pc-gdp`) to grow logarithmically as well. 

With both x- and y-values growing logarithmically, they would appear grow at a constant rate relative to one another. A constant rate will appear linear, which allows us to use `lr-plot` to find the optimal model!

<!--

-->

---
{layout="Investigate"}
# Using Log Transformations

How can we transform this plot so that the `pc-gdp` column is placed on a logarithmic scale?

Complete questions 7-9 on @printable-exercise{transforming-wealth.adoc}.


<!--

-->
---
{layout="InvestigateR"}
# Using Log Transformations

@right{@image{images/wealth-v-life-transformed-linear.png, 550}}

Success! After transforming the `pc-gdp` column to `log-pc-gdp`, a scatter plot shows a more linear pattern in the data! 

Pyret's `lr-plot` tool computes the best possible linear model for our transformed data, determining it to have a slope of `5.169` and a y-intercept of `24.264`. 

Our @math{R^2} has jumped to 0.663, showing a vastly better correlation than before.

<!--

-->
---
{layout="Investigate"}
# Using Log Transformations

With the transformation applied, our linear model (in both function and Pyret notation) is:

- @math{f(x) = 5.169x + 24.264}
- @show{(code '(define (f x) (+ (* 5.169 x) 24.264)))}

At each point in our linear model, @math{f} is the _predicted median lifespan_, and @math{x} is the _log of per-capita gdp_. But we want @math{x} to represent the **original, un-transformed** value, simply using _per-capita gdp_ as-is.

<!--

-->
---
{layout="Investigate"}
# Using Log Transformations

Instead of transforming our dataset and then fitting a linear model, we want to transform _the model itself_ and then fit it to the original dataset. We already know the translation requires taking the log of `per-capita-gdp`, so we can simply compose our linear function with a log function:

- @math{g(x) = f(log(x))}
- @show{(code '(define (g x) (f (log x))))}

<!--

-->
---
{layout="Investigate"}
# Using Log Transformations

Of course, we could also just define a new function which composes the log transformation with our linear function, by replacing @math{x} in our linear model with @math{log(x)}:

- @math{h(x) = 5.169 \times log(x) + 24.264}
- @show{(code '(define (h x) (+ (* 5.169 (log x)) 24.264)))}

<!--

-->
---
{layout="InvestigateR"}
# Using Log Transformations

Complete the remainder of @printable-exercise{transforming-wealth.adoc}.

The resulting logarithmic model can be fit to our original scatter plot, showing a much better fit than our 2-point-derived estimates.

@center{@image{images/wealth-v-life-log.png}}
<!--

-->
---
{layout="SynthesizeR"}
# Using Log Transformations

- Why is the @math{R^2} value for our logarithmic model the same as the value for our linear model after transforming?
- How do you interpret this model?
- Why do you think the relationship between wealth is logarithmic?
- Are there other relationships you can think of, which might be logarithmic?

<!--

-->
---
{layout="Supplemental"}
# Additional Exercises

Is the relationship between wealth and lifespan different in countries that have universal healthcare? Students can explore this in @opt-printable-exercise{transforming-wealth-practice.adoc}.

<!--

-->