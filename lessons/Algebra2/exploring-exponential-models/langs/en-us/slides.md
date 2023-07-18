---
{layout="DS Title Slide"}
# Exploring Exponential Models

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Filtering & Simpson's Paradox

- Open the @online-exercise{https://code.pyret.org/editor#share=1ueyf5-0ByVYmeJKQ03i9msb9u1C5y50o, Covid Spread Starter File}
- From the File menu, select "Save a Copy", and click "Run"
- Working in pairs or small groups, complete questions 1-10 of @printable-exercise{exploring-covid.adoc}

<!--
Review student answers to confirm that students have made a number of observations:

* There is _more than one_ relationship in this dataset!
* Every relationship seems extremely strong
* Every relationship appears non-linear
-->
---
{layout="InvestigateC"}
# Filtering & Simpson's Paradox

@image{images/multiple-models.png}
With all these clear, tight lines, we might think this would be a dataset with a very strong correlation. Unfortunately, that's not true at all.


<!--
Datasets like these are impossible to model all at once, because there will always be lots of points that are far from any single function. But it's not that there's _no correlation_. Instead, we have several sub-groups each with their own _very strong correlations!_
-->

---
{layout="Investigate"}
# Filtering & Simpson's Paradox

**Simpson's Paradox: visible trends in sub-groups _disappear_ or even _reverse_ when the groups are combined.**

Normally we think that "more data means more power!", and that the more data we include in our sample the more clearly we'll see any potential correlations. But in certain circumstances - like in our Covid dataset! - the correlations in our sub-groups cancel each other out when we put the groups together! This is called Simpson's Paradox, and you can learn more at @link{https://en.wikipedia.org/wiki/Simpson%27s_paradox, Wikipedia}.

---
{layout="Investigate"}
# Filtering & Simpson's Paradox

**For Example:** School A and B both have basketball teams. The 6 foot kids on School A's team are better than the 6 foot kids on School B's team. The 5' 10" kids from School A are also better than 5' 10" kids from School B. In fact, at every height, the kids from School A are better than the kids from School B. __But School B's team is better than School A.__ How is this possible? School B has __more tall kids__ than School A!


---
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@image{images/multiple-models.png}
- We need to break this dataset up into _grouped samples_, so that all of the data for Rhode Island is in one table, all of the data for Maine is in another, etc.
- Working in pairs or small groups, complete the rest of of @printable-exercise{exploring-covid.adoc}.

<!--
The term "Grouped Samples" is used instead of "Random Samples". Grouped samples are non-random by design!
-->
---
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@image{images/multiple-models.png}
How does the `filter` function work?

_The `filter` function consumes a Table and **a helper function!** The helper function is used on every Row of the Table, producing true or false. The `filter` function takes all the Rows for which the helper produced true, and combines them all into a new table._

---
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@image{images/multiple-models.png}
We can use `filter` to split our dataset into multiple sub-groups, and then fit models to each sample.

Create helper functions to filter at least three other states, then use them to define the Covid tables for each state.

<!--
It's extremely common for students to think that filtering a table *changes the original table*. This is NOT how it works in Pyret! Instead, the `filter` function always produces a _new_ table, containing only the Rows for which the supplied function evaluates to `true`
-->
---
{layout="Synthesize"}
# Filtering & Simpson's Paradox

- In what other situations would it be useful to filter a dataset?
- Can you think of other examples where Simpson's Paradox might arise?

---
{layout="Launch"}
# Looking for Patterns

Make a scatter-plot showing the Covid infection rate for Massachusetts. What kind of model do you think would fit this best?

---
{layout="Investigate"}
# Looking for Patterns

- Open @printable-exercise{graphing-models.adoc} and @online-exercise{https://www.desmos.com/calculator/vqdynw0j2s, MA Covid Spread - Linear, MA Covid Spread - Linear}.
- Complete the *first* section on @printable-exercise{graphing-models.adoc}.

---
{layout="Investigate"}
# Looking for Patterns

Linear models capture _straight-line relationships_, where one quantity varies proportionally based on another. In linear models, we expect the response variable to grow by equal amounts over equal intervals in the explanatory variable.

- Using `lr-plot` in Pyret, come up with the best possible linear model, and write your answer at the bottom of @printable-exercise{exploring-covid.adoc}.
- Class discussion: Are linear models a good fit for this data? Why or why not?

<!--
-->
---
{layout="InvestigateR"}
# Looking for Patterns

@image{images/MA-covid-linear.png, 300}
If we make the line go from the start to the peak, almost all of the points bulge out below out line of best fit. If we make the line fit the bulge, all the points fall above it! We always have either too many points _below_ the line in the middle or _above_ the line at the end. **It's growing too fast to be fit with a linear model that grows at a constant rate!**{style="font-size:17pt"}

- Take a few minutes to explore @online-exercise{https://www.desmos.com/calculator/pqmmoa6ose, MA Covid Spread - Quadratic}.
- Complete the *second* section on @printable-exercise{graphing-models.adoc}.

<!--
-->

---
{layout="Investigate"}
# Looking for Patterns

Quadratic models capture _parabolic relationships_, where one quantity varies based on the square of another. In quadratic models, we expect the response variable to grow by differing amounts over equal intervals in the explanatory variable.

- Write the best quadratic model you can find at the bottom of @printable-exercise{exploring-covid.adoc}.
- Class discussion: Are quadratic models a good fit for this data? Why or why not?

<!--
Have students share their resulting models. Which one fits best?

-->

---
{layout="InvestigateR"}
# Looking for Patterns

@right{@image{images/MA-covid-quadratic.png, 300}} Quadratic models change their rate of growth over time, which definitely made them a better fit than linear ones. But they still don't have the explosive growth we need to model this data, which starts out incredibly slow and then suddenly takes off like a rocket!

---
{layout="Synthesize"}
# Looking for Patterns

- Do you think the data for MA shows a linear relationship? Why or why not?
- Do you think this data shows a quadratic relationship? Why or why not?
- Do you think this data shows some other kind of relationship? Why or why not?

---
{layout="Launch"}
# Fitting Exponential Models

There is, however, a class of functions that grow even faster than quadratics: *exponential functions*.

Linear functions grow by equal **amounts** over equal intervals (adding *n* each time). Exponential functions grow by equal **factors** over equal intervals (multiplying by *n* each time).

<!--

-->

---
{layout="Launch"}
# Fitting Exponential Models

Exponential relationships show up all the time!

- Cells that constantly divide, doubling the total number of cells each time
- A tree that's on fire will likely catch neighboring trees on fire, so that the fire spreads to 2 or more trees each time
- Money in a savings account grows by a certain percentage each year, meaning every year there's that much more money to grow

<!--
Can you think of other real-world examples where a relationship is likely exponential?
-->
---
{layout="Launch"}
# Fitting Exponential Models

Exponential models have the form @math{y = ab^x + k}

- @math{k} is the vertical shift, which is the amount the graph is shifted up or down the y-axis. @math{k} contributes the same amount to the value of the function for all values of @math{x}
- @math{a} is the initial value, which is the contribution of the exponential term when @math{x} is zero. Another way to think of it is "the value of the function _above k_ when @math{x} is zero"
- @math{b} is a growth factor, which is the rate at which the exponential term grows (@math{b > 1}) or decays (@math{b < 1}) as @math{x} increases.
<!--

-->
---
{layout="Investigate"}
# Fitting Exponential Models

Now we need to figure out the values of @math{a}, @math{b} and @math{k}!

- Open @online-exercise{https://www.desmos.com/calculator/sqrgiujcsq, MA Covid Spread - Exponential}.
- Complete the *last* section on @printable-exercise{graphing-models.adoc}.
- Class discussion: Are exponential models a good fit for this data? Why or why not?

<!--
@star Optional: have students build models for other states. How do the coefficients differ from state to state? What differences between states could explain the different values of the coefficients?
-->
---
{layout="Synthesize"}
# Fitting Exponential Models

- What makes exponential models different?
- How would you describe the shape of the three models you've seen so far (Linear, Quadratic, and Exponential)?
