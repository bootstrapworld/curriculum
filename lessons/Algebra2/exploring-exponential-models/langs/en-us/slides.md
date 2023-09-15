---
{layout="DS Title Slide"}
# Exploring Exponential Models

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Filtering & Simpson's Paradox

Starting in 2019, covid spread across the globe. Most of us heard terms like "flatten the curve" and "infection rate" more than we ever thought possible. Even in 2020, very few people could have predicted the impact it would have on the world.

But Data Scientists who were looking at the data knew differently. Let's take a look at some of that data!

---
{layout="Launch"}
# Filtering & Simpson's Paradox

- Open the @starter-file{alg2-covid}. This data looks at the Covid infection rates for New England states from summer 2020 until the end of the year.
- From the File menu, select "Save a Copy", and click "Run"
- Working in pairs or small groups, complete questions 1-10 of @printable-exercise{exploring-covid.adoc}

@teacher{This dataset is @link{docs.google.com/spreadsheets/d/1T73KS2IUU1kkG1SY4Ac7EU9Lj-ev1U9vzM_txSYcUhE/, available for all 50 states (and Washington, D.C!)}, but for pedagogical purposes we've written the starter file to pull only data from New England.
}

---
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@image{images/multiple-models.png}

The scatterplot we just produced doesn't look much like a scatterplot all! It looks like someone took a blue marker and drew in five different curvy lines.{style="font-size: 16pt"} 

While it's clear that there are strong patterns in the data, these patterns are so distinct from one another that there isn't really one, single model that fits them all.{style="font-size: 16pt"}

Each relationship appears very strong, almost as if there is _more than one model_ here.{style="font-size: 16pt"}

@teacher{Review student answers to confirm that students have made a number of observations:

* There is _more than one_ relationship in this dataset
* Every relationship seems extremely strong
* Most/all relationships appear nonlinear}


---
{layout="Investigate"}
# Filtering & Simpson's Paradox

Discuss in groups or pairs, and prepare to share out to the class:

- Based on the look of this scatter plot, do you think there's a strong correlation here?
- If we fit a model to this data, would it have a high @math{r}-value?

---
{layout="Investigate"}
# Filtering & Simpson's Paradox

With all these clear, tight lines, we might think this would be a dataset with a very strong correlation. Unfortunately, that's not true at all.

Datasets like these are impossible to model all at once, because there will always be lots of points that are far from any single function. But it's not that there's _no correlation_. Instead, we have several sub-groups each with their own _very strong correlations._

---
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@right{@image{../images/Simpsons_animation.gif, 300}}

**Simpson's Paradox: visible trends in sub-groups _disappear_ or even _reverse_ when the groups are combined.**{style="font-size: 16pt"}

Normally we think that "more data means more power!", and that the more data we include in our sample the more clearly we'll see any potential correlations. But in certain circumstances - like in our Covid dataset! - the correlations in our sub-groups cancel each other out when we put the groups together! This is called Simpson's Paradox, and you can learn more at @link{https://en.wikipedia.org/wiki/Simpson%27s_paradox, Wikipedia}.{style="font-size: 16pt"}

---
{layout="Investigate"}
# Filtering & Simpson's Paradox

**For Example:** School A and B both have basketball teams. The 6 foot kids on School A's team are better than the 6 foot kids on School B's team. The 5' 10" kids from School A are also better than 5' 10" kids from School B. 

In fact, at every height, the kids from School A are better than the kids from School B. __But School B's team is better than School A.__ 

---
{layout="Investigate"}
# Filtering & Simpson's Paradox

How is this possible? School B has __more tall kids__ than School A!

---
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@image{images/multiple-models.png}
- We need to break this dataset up into _grouped samples_, so that all of the data for Rhode Island is in one table, all of the data for Maine is in another, etc.
- Working in pairs or small groups, complete the rest of of @printable-exercise{exploring-covid.adoc}.

@teacher{
The term "Grouped Samples" is used instead of "Random Samples". Grouped samples are non-random by design!
}

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

@teacher{
It's extremely common for students to think that filtering a table *changes the original table*. This is NOT how it works in Pyret! Instead, the `filter` function always produces a _new_ table, containing only the Rows for which the supplied function evaluates to `true`.}

---
{layout="Synthesize"}
# Filtering & Simpson's Paradox

- In what other situations would it be useful to filter a dataset?
- Can you think of other examples where Simpson's Paradox might arise?

@teacher{
- When comparing one country's schools to another's, a researcher finds that poor students in country A outperform poor students in country B. They also find that the _rich_ students in A outperform their wealthy peers in B. In fact, for every income level, A outperforms B! But if B has _less child poverty overall_, it will still outperform A.
- Another example can be found @link{https://towardsdatascience.com/simpsons-paradox-and-interpreting-data-6a0443516765, on this web page}.
}

---
{layout="Launch"}
# Looking for Patterns

Make a scatter-plot showing the Covid infection rate for Massachusetts. What kind of model do you think would fit this best?

---
{layout="Investigate"}
# Looking for Patterns

- Complete @printable-exercise{linear-models.adoc}, using @starter-file{alg2-covid-desmos-l}.

Linear models capture _straight-line relationships_, where one quantity varies proportionally based on another. In linear models, we expect the response variable to grow by equal amounts over equal intervals in the explanatory variable.

---
{layout="Investigate"}
# Looking for Patterns

Class discussion: Are linear models a good fit for this data? Why or why not?

@teacher{Have students share their resulting models. Which one fits best?}

---
{layout="InvestigateR"}
# Looking for Patterns

@right{@image{images/MA-covid-linear.png, 300}} If we make the line go from the start to the peak, almost all of the points bulge out below out line of best fit. If we make the line fit the bulge, all the points fall above it. We always have either too many points _below_ the line in the middle or _above_ the line at the end. **It's growing too fast to be fit with a linear model that grows at a constant rate!**

---
{layout="Investigate"}
# Looking for Patterns

- Complete @printable-exercise{quadratic-models.adoc}, using @starter-file{alg2-covid-desmos-q}.

Quadratic models capture _parabolic relationships_, where one quantity varies based on the square of another. In quadratic models, we expect the response variable to grow by differing amounts over equal intervals in the explanatory variable.

---
{layout="Investigate"}
# Looking for Patterns

Class discussion: Are quadratic models a good fit for this data? Why or why not?

@teacher{Have students share their resulting models. Which one fits best?}

---
{layout="InvestigateR"}
# Looking for Patterns

@right{@image{images/MA-covid-quadratic.png, 300}} Quadratic models change their rate of growth over time, which definitely makes them a better fit for this data than linear ones. But they still don't have the explosive growth we need to model this data, which starts out incredibly slow and then suddenly takes off like a rocket.

---
{layout="Synthesize"}
# Looking for Patterns

- Do you think the data for MA shows a linear relationship? Why or why not?
- Do you think this data shows a quadratic relationship? Why or why not?
- Do you think this data shows some other kind of relationship? Why or why not?

---
{layout="Launch"}
# Fitting Exponential Models

There is, however, a class of functions that grow even faster than quadratics: **exponential functions**.

Exponential functions grow by equal *factors* over equal intervals (multiplying by _n_ each time).

Linear functions grow by *fixed intervals*.

Quadratic relationships grow by intervals that increase by fixed amounts.

---
{layout="Launch"}
# Fitting Exponential Models

Exponential relationships show up all the time!

- Cells that constantly divide, doubling the total number of cells each time
- A tree that's on fire will likely catch neighboring trees on fire, so that the fire spreads to 2 or more trees each time
- Money in a savings account grows by a certain percentage each year, meaning every year there's that much more money to grow

@teacher{Can you think of other real-world examples where a relationship is likely exponential?}

---
{layout="Launch"}
# Fitting Exponential Models

Exponential models have the form @math{y = ab^x + k}

- Complete the first section of @printable-exercise{exponential-models.adoc}, using @starter-file{alg2-covid-desmos-e}.

---
{layout="Launch"}
# Fitting Exponential Models

- From what you've seen in other models, what do you think the @math{k} term is telling us?
- Any guesses as to what @math{a} and @math{b} might describe in the model?
- @optional for more practice modeling relationships using exponentials, complete @opt-printable-exercise{grading-models.adoc}
- @optional For practice differentiating between linear, quadratic and exponential relationships, optional exercises are available for @opt-printable-exercise{classifying-tables.adoc, Tables}, @opt-printable-exercise{classifying-plots.adoc, Graphs} and @opt-printable-exercise{classifying-defs.adoc, Definitions}.

@teacher{
- From what you've seen in other models, what do you think the @math{k} term is telling us?
** @math{k} is the vertical shift, which is the amount the graph is shifted up or down the y-axis. @math{k} contributes the same amount to the value of the function for all values of @math{x}. Note that, unlike in linear functions, the vertical shift in exponential functions is not usually the same value as the y-intercept.
- Any guesses as to what @math{a} and @math{b} might describe in the model?
** @math{a} is the initial value, which is the contribution of the exponential term when @math{x} is zero. Another way to think of it is "the value of the function _above k_ when @math{x} is zero"
** @math{b} is a @vocab{growth factor}, which is the rate at which the exponential term grows (@math{b > 1}) or decays (@math{b < 1}) as @math{x} increases.
- @optional for more practice modeling relationships using exponentials, complete @opt-printable-exercise{grading-models.adoc}
- @optional For practice differentiating between linear, quadratic and exponential relationships, optional exercises are available for @opt-printable-exercise{classifying-tables.adoc, Tables}, @opt-printable-exercise{classifying-plots.adoc, Graphs} and @opt-printable-exercise{classifying-defs.adoc, Definitions}.
}

---
{layout="Investigate"}
# Fitting Exponential Models

Now we need to figure out the values of @math{a}, @math{b} and @math{k} for _this_ data.

- Complete the rest of @printable-exercise{exponential-models.adoc}.
- Class discussion: Are exponential models a good fit for this data? Why or why not?

@star @optional build models for _other states_. How do the coefficients differ from state to state? What differences between states could explain the different values of the coefficients?
---
{layout="Investigate"}
# Precision v. Efficiency in Computation

On @printable-exercise{exponential-models.adoc} you'll see a note about the use of `~1` to tell Pyret to prioritize speed over precision. Unlike most calculators that students will engage with, Pyret usually prioiritizes precision.

In data processing, opting to round for speed over preserving precision can have ethical or technical consequences.

---
{layout="Synthesize"}
# Fitting Exponential Models

- What makes exponential models different from the linear and quadratic models you've seen before?
- How would you describe the shape of the three models you've seen so far (Linear, Quadratic, and Exponential)?
- Is it always ok for Data Scientists to round off their numbers to speed up computation? Why or why not?

---
{layout="Supplemental"}
# Additional Exercises

- @opt-printable-exercise{classifying-tables.adoc}
- @opt-printable-exercise{classifying-plots.adoc}
- @opt-printable-exercise{classifying-defs.adoc}
- @opt-printable-exercise{grading-models.adoc}
