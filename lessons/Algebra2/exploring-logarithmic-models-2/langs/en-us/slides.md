---
{layout="DS Title Slide"}
# Exploring Logarithmic Models (2)

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchR"}
# Transforming the Data

Instead of transforming the x-axis, another strategy is to _transform the x-coordinates themselves_. Instead of plotting `pc-gdp` on a *logarithmic* x-axis, we could plot `log(gdp)` on a *linear* x-axis.

Complete @printable-exercise{transforming-data.adoc}, using @online-exercise{https://www.desmos.com/calculator/hgp5a9n7it, Wealth-v-Health - Transformed}.

---
{layout="Launch"}
# Transforming the Data

Transforming the points instead of the axis has the same visual effect: the dots appear to fall in a straight line. But now we can plot them on a linear-scale axis, and use linear regression to find the best-possible model!

@teacher{
Crowdsource the coefficients (slope and y-intercept) of the linear models students come up with. How close are they to one another? How close are they to the coefficients from the best-guess logarithmic model?

They will discover that they match the coefficients of the logarithmic model as well.
}

---
{layout="Launch"}
# Transforming the Data

**Why do these coefficients match?**

---
{layout="Investigate"}
# Transforming the Data in Desmos

We transformed the `pc-gdp` column in three steps:

1. We defined a transformation function - @math{g(x)} - which produces the log of whatever it's given (the `pc-gdp` column).
2. We defined a new column to use as our x-values, populating it by applying the transformation to each of our original x-values.
3. We displayed these transformed datapoints as a scatterplot.

---
{layout="Investigate"}
# Transforming the Data

**It's easy to do the same thing in Pyret**

In the @starter-file{alg2-countries}, find the definition of `g(r)`.

* What does this function do?
** `g` produces the log of the `pc-gdp` column, which it gets from the country it's given
* Find the contract for `build-column` on the @dist-link{Contracts, Contracts Page}. @pathway-only{_If you're working with a printed workbook, the contracts pages are included in the back._} What is its Range?
* What is its Domain?

@teacher{
* What does this function do?
** `g` produces the log of the `pc-gdp` column, which it gets from the country it's given
* Find the contract for `build-column` on the @dist-link{Contracts, Contracts Page}. @pathway-only{_If you're working with a printed workbook, the contracts pages are included in the back._} What is its Range?
** Table
* What is its Domain?
** A Table, A String, and a Function	
}

---
{layout="Investigate"}
# Transforming the Data

At the end of the program, you'll find this code:

@show{(code '(define countries-transformed (build-column countries-table "log(pc-gdp)" g)))}

Click "Run", and evaluare `countries-transformed` in the Interactions Area on the right.

* What did you get back?
* What is different about this Table?
* Where did the column on the right come from?
* What does that line of code at the end of the program do?



---
{layout="InvestigateR"}
# Transforming the Data

@right{@image{images/wealth-v-life-transformed-linear.png, 550}}
Just like in Desmos, transforming the `pc-gdp` column with a log function produces a scatter plot showing a linear pattern in the data! Pyret's `lr-plot` tool computes the best possible linear model for our transformed data, determining it to have a slope of `11.9011` and a y-intercept of `24.2636`. Our @math{R^2} has jumped to 0.66311, showing a vastly better correlation than before.

---
{layout="Investigate"}
# Transforming the Data

With the transformation applied, our linear model (in both function and Pyret notation) is:

- @math{f(x) = 11.9011x + 24.2636}
- @show{(code '(define (f x) (+ (* 11.9011 x) 24.2636)))}

At each point in our linear model, @math{f} is the _predicted median lifespan_, and @math{x} is the _log of per-capita gdp_. But we want @math{x} to represent the **original, un-transformed** value, simply using _per-capita gdp_ as-is.

---
{layout="Investigate"}
# Transforming the Data

From @printable-exercise{transforming-data.adoc}, we know that the coefficients used in the transformed, linear model are the same ones used in the logarithmic, un-transformed model:

- @math{h(x) = 11.9011 \times log(x) + 24.2636}
- @show{(code '(define (h x) (+ (* 11.9011 (log x)) 24.2636)))}

---
{layout="InvestigateR"}
# Transforming the Data

The resulting logarithmic model can be fit to our original scatter plot, showing a much better fit than our 2-point-derived estimates.

@center{@image{images/wealth-v-life-log.png}}

@star Optional Exploration: Is the relationship between lifespan and income different for countries with universal healthcare than without it? Have students `filter` this dataset into grouped samples for each, and find out.

---
{layout="Synthesize"}
# Transforming the Data

- Why is the @math{R^2} value for our logarithmic model the same as the value for our linear model after transforming?
- Why were our coefficients for linear and logarithmic models the same, even though they were for different terms?
- How do you interpret this model?
- Why do you think the relationship between wealth is logarithmic?
- Are there other relationships you can think of, which might be logarithmic?

---
{layout="Supplemental"}
# Additional Exercises

- @opt-printable-exercise{grading-models.adoc}
