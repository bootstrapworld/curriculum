---
{layout="DS Title Slide"}
# Exploring Logarithmic Models

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchR"}
# Looking for Patterns

@image{images/questions.png, 250}

- Do people who make more money generally live longer?
- Open the @starter-file{alg2-countries}
- From the File menu, select "Save a Copy", and click "Run".
- Working in pairs or small groups, complete questions 1-6 on @printable-exercise{exploring-countries.adoc}.
- Be ready to discuss!

@teacher{
Discuss students' findings. Pay special attention to the @vocab{form} that students use to describe the pattern in the scatter plot. Is it linear, or something else? Is it strong or weak? If there's some disagreement among the students, that's a good thing!

Be attentive to sense-making: If a wealthy country is suffering heavy causalties in a war, where would we expect to see the datapoint? Why? What other conditions would cause a point to shift up, down, left or right?
}

---
{layout="Launch"}
# Looking for Patterns

Working in pairs or small groups, complete the rest of @printable-exercise{exploring-countries.adoc} using @online-exercise{https://teacher.desmos.com/activitybuilder/custom/646f99970cc6898a9d87ef95, Fitting Wealth-v-Health} to try fitting linear, quadratics, and exponential models for this dataset

@teacher{
Note: This worksheet involves lots of trial and error, as students try to come up with a good linear, quadratic, or exponential model. The goal is to __discover that a new kind of  model is necessary__.
}


---
{layout="Synthesize"}
# Looking for Patterns

- What's the best model you came up with?
- What sketches did you draw. What kinds of lines or curves did you use?

---
{layout="LaunchC"}
# Transforming the x-Axis 

@image{images/wealth-v-life-linear.png} There definitely appears to be a relationship here, but it's not one we've seen before. Using `lr-plot` only shows a moderate correlation, because the straight line doesn't really fit the curve. The shape of this starts out rising fast on the left, before tapering off as `pc-gdp` increases to the right.{style="font-size:15pt"}


---
{layout="LaunchC"}
# Fitting Logarithmic Models

@image{images/wealth-v-life-linear.png} How well did our linear, quadratic, and exponential models fit this data? Is there another kind of function that starts off rising fast, but then levels off quickly?


---
{layout="Investigate"}
# Fitting Logarithmic Models

The shape of this relationship is _logarithmic_, meaning it can be modeled using a logarithmic function:

@center{@math{f(x) = b \times log(x) + c}  }

---
{layout="Investigate"}
# Fitting Logarithmic Models

@center{@math{f(x) = b \times log(x) + c}  }

Logarithmic relationships grow very quickly at first, but then level out as @math{x} increases until they approach a horizontal line, called an _asymptote_.

Optional: For practice differentiating between quadratic, exponential, and logarithmic relationships, optional exercises are available for @opt-printable-exercise{classifying-tables.adoc, Tables}, @opt-printable-exercise{classifying-graphs.adoc, Graphs} and @opt-printable-exercise{classifying-defs.adoc, Definitions}.

---
{layout="Investigate"}
# Fitting Logarithmic Models

We need to find @math{b} and @math{c}, such that the model fits the data as closely as possible.

Complete the first section of @printable-exercise{transforming-axis.adoc}, using @online-exercise{https://www.desmos.com/calculator/xectdnnqdy, Wealth-v-Health - Logarithmic}.

@teacher{Crowdsource the values students came up with for @math{b} and @math{c} in their best-guess logarithmic model. Were they very similar or very different? What were the @math{R^2} values?}

---
{layout="Investigate"}
# Fitting Logarithmic Models

Trial-and-error only gets us so far, and it's not clear that we would ever stumble upon the optimal model. **We need something like Pyret's `lr-plot` function, which uses computational methods to find the best possible model.** 

Unfortunately, `lr-plot` only finds linear models. If only we could _transform_ this data to make it appear linear. Then we could use `lr-plot` to fit the optimal model, and then reverse the transformation to get the optimal logarithmic model!

---
{layout="Investigate"}
# Fitting Logarithmic Models

Imagine that the scatter plot is printed on a sheet of rubber, and can be stretched or squashed in any way we want. 

---
{layout="Investigate"}
# Fitting Logarithmic Models

Data Scientists often use *transformations* to stretch their data into shapes that are easier to use, and then reverse the transformation when they are done.

* A person running on a treadmill is still standing in the same place. Why?
* If they run faster and faster, what needs to happen to the treadmill to keep them in the same place?

@teacher{
* A person running on a treadmill is still standing in the same place. Why?
** Their forward movement is balanced by the backwards movement of the treadmill.
* If they run faster and faster, what needs to happen to the treadmill to keep them in the same place?
** The treadmill needs to go faster as well - by the same amount.	
}

---
{layout="Investigate"}
# Fitting Logarithmic Models

As long as the treadmill speed increases at the same rate as the runner, they will _balance one another's growth_. That's the same thing that's happening in our transformed graph.

---
{layout="Investigate"}
# Fitting Logarithmic Models

By __transforming the x-axis__ to grow exponentially, we are "squashing" the coordinate plane so that each interval of  represents 10x the growth in `pc-gdp` as the one before it. This balances  the logarithmic growth in `median-lifespan`, makes the curved relationship appear linear, and warps our logarithmic model so it looks like a straight line-of-best-fit.

---
{layout="Synthesize"}
# Fitting Logarithmic Models

- How does seeing the point cloud as linear help us think about logarithmic growth?
- What if we wanted to change the axis to show a quadratic scale? Or something more complicated?

---
{layout="Synthesize"}
# Fitting Logarithmic Models

Even our best-guess logarithmic model looks like a straight line. But transforming the axes only makes things _look_ linear - the actual points haven't changed at all, and we still can't use linear regression to find the best model.

- Can you think of a way we could we transform the _data_, instead of the axes?

---
{layout="Synthesize"}
# Additional Exercises

- @opt-printable-exercise{classifying-tables.adoc, Tables}
- @opt-printable-exercise{classifying-graphs.adoc, Graphs}
- @opt-printable-exercise{classifying-defs.adoc, Definitions}

