@slidebreak
{layout="DS Title Slide"}
# Exploring Exponential Models

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->


@slidebreak
{layout="Launch"}
# Filtering & Simpson's Paradox

Starting in 2019, Covid spread across the globe. Most of us heard terms like "flatten the curve" and "infection rate" in videos and on the news.

Even in 2020, very few people could have predicted the impact it would have on the world. But Data Scientists who were looking at the data knew differently. Let's take a look at some of that data!

@slidebreak
{layout="Launch"}
# Filtering & Simpson's Paradox

- Open the @starter-file{alg2-covid}. This data looks at the Covid infection rates for New England states from summer 2020 until the end of the year.
- From the File menu, select "Save a Copy", and click "Run"
- Working in pairs or small groups, complete @printable-exercise{exploring-covid.adoc}.

@teacher{This dataset is @link{docs.google.com/spreadsheets/d/1T73KS2IUU1kkG1SY4Ac7EU9Lj-ev1U9vzM_txSYcUhE/, available for all 50 states (and Washington, D.C!)}, but for pedagogical purposes we've written the starter file to pull only data from New England.
}

@slidebreak
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@image{images/multiple-models.png}
Discuss in groups or pairs, and prepare to share out to the class:

- Based on the look of the scatter plot you just made, do you think there's a strong correlation here?
- If we fit a curve or straight line to this data, do you think it would have a high @math{R^2}-value?

@slidebreak
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@image{images/multiple-models.png}

The scatter plot we just produced doesn't look much like a scatter plot all! It looks like someone took a blue marker and drew in five different curvy lines.{style="font-size: 16pt"} 

While it's clear that there are strong patterns in the data, these patterns are so distinct from one another that there isn't really one, single model that fits them all.{style="font-size: 16pt"}

Each relationship appears very strong, almost as if there is _more than one model_ here.{style="font-size: 16pt"}

@teacher{Review student answers to confirm that students have made a number of observations:

* There is _more than one_ relationship in this dataset
* Every relationship seems extremely strong
* Most/all relationships appear nonlinear}


@slidebreak
{layout="Investigate"}
# Filtering & Simpson's Paradox

With all these clear, tight lines, we might think this would be a dataset with a very strong correlation. Unfortunately, that's not true at all.

Datasets like these are impossible to model all at once, because there will always be lots of points that are far from any single function. But it's not that there's _no correlation_. Instead, we have several sub-groups each with their own _very strong correlations._

@slidebreak
{layout="InvestigateR"}
# Filtering & Simpson's Paradox

@right{@image{images/Simpsons_animation.gif, 300}}

**Simpson's Paradox: visible trends in sub-groups _disappear_ or even _reverse_ when the groups are combined.**{style="font-size: 14pt"}

Normally we think that "more data means more power!", and that the more data we include in our sample the more clearly we'll see any potential correlations. But in certain circumstances - like in our Covid dataset! - the correlations in our sub-groups cancel each other out when we put the groups together! This is called Simpson's Paradox.{style="font-size: 14pt"}


@slidebreak
{layout="Investigate"}
# Filtering & Simpson's Paradox


@table{3}
| City  		| % 35 and over	| % Under 35
| Marrakesh		| 30%			|  70%
| Istanbul		| 20%			|  80%
| Punta Cana 	| 25%			|  75%
| Goa			| 46%			|  54%
| Sarasota		| 75%			|  25%

A travel agency wants to know whether they serve more people 35 and over, or travelers under 35. They looked at their booking records, grouped by city.

Which group do you think the agency serves more? Why?

@teacher{If your students need printed copies of this table, you can use @opt-printable-exercise{travel-data.adoc}.

Have students discuss in pairs or small groups. Invite students to share their thoughts. Most likely they will say it's the under-35 crowd, because they are the bigger group in almost every city.
}

@slidebreak
{layout="Investigate"}
# Filtering & Simpson's Paradox

@table{4}
| City  		| # Tourists 	| % 35 and over	| % Under 35
| Marrakesh		| 160			| 30%			|  70%
| Istanbul		| 200			| 20%			|  80%
| Punta Cana 	| 204			| 25%			|  75%
| Goa			| 450			| 46%			|  54%
| Sarasota		| 676			| 75%			|  25%

Most of the agency's clients are 35 and over!
How is this possible? We can see a clear trend when _comparing_ within cities: the under-35 crowd dominates every city except Sarasota. When aggregating all of the data together, _the number of tourists in each city matters_. Sarasota was our outlier, but it also makes up the largest portion of all tourists!{style="font-size: 15pt"}

@slidebreak
{layout="Investigate"}
# Filtering & Simpson's Paradox

- We need to break this dataset up into _grouped samples_, so that all of the data for Rhode Island is in one table, all of the data for Maine is in another, etc.
- How is a grouped sample different from a random sample?
- Working in pairs or small groups, complete the rest of of @printable-exercise{exploring-covid.adoc}.


@teacher{
- How is a grouped sample different from a random sample?
** _A grouped sample is a non-random subset chosen from a larger set. Grouped samples are non-random by design!_

While filtering is introduced in this lesson, the primary goal is for students to explore exponential functions. If your students need more practice with filtering - or wish to filter their own datasets - we recommend checking out the @lesson-link{filtering-and-building} lesson.
}

@slidebreak
{layout="Investigate"}
# Filtering & Simpson's Paradox

You just used the `filter` function. How does the `filter` function work?

_The `filter` function consumes a Table and **a helper function!** The helper function is used on every Row of the Table, producing true or false. The `filter` function takes all the Rows for which the helper produced true, and combines them all into a new table._

@teacher{
It's extremely common for students to think that filtering a table *changes the original table*. This is NOT how it works in Pyret! Instead, the `filter` function always produces a _new_ table, containing only the Rows for which the supplied function evaluates to `true`.}

@slidebreak
{layout="Synthesize"}
# Filtering & Simpson's Paradox

- In what other situations would it be useful to filter a dataset?
- Can you think of other examples where Simpson's Paradox might arise?

@teacher{
- When comparing one country's schools to another's, a researcher finds that poor students in country A outperform poor students in country B. They also find that the _rich_ students in A outperform their wealthy peers in B. In fact, for every income level, A outperforms B! But if B has _less child poverty overall_, it will still outperform A.
- Another example can be found @link{https://towardsdatascience.com/simpsons-paradox-and-interpreting-data-6a0443516765, on this web page}.
}

@slidebreak
{layout="Launch"}
# Looking for Patterns

- Open the @starter-file{alg2-covid}.
- Make a scatter-plot showing the Covid infection rate for Massachusetts.
- What kind of model do you think would fit this best?

@slidebreak
{layout="Investigate"}
# Looking for Patterns

- Complete @printable-exercise{linear-models.adoc}, using the first slide of @starter-file{alg2-covid-desmos}.

Linear models capture _straight-line relationships_, where one quantity varies proportionally based on another. In linear models, we expect the response variable to grow by equal amounts over equal intervals in the explanatory variable.

@slidebreak
{layout="Investigate"}
# Looking for Patterns

Are linear models a good fit for this data? Why or why not?

@teacher{Have students share their resulting models. Which one fits best?}

@slidebreak
{layout="InvestigateR"}
# Looking for Patterns
@image{images/MA-covid-linear.png, 300} 
If we make the line go from the start to the peak, almost all of the points bulge out below out line of best fit. If we make the line fit the bulge, all the points fall above it.Splitting the difference (orange line) is better than both of those options, and we might even get a pretty good @math{R^2}! But ultimately, straight-line, linear models just don't behave like this curve, and we'll never get the _best-possible fit_ with them.{style="font-size: 16pt"}


**It's growing too fast to be fit with a linear model that grows at a constant rate!**{style="font-size: 14pt"}


@slidebreak
{layout="Investigate"}
# Looking for Patterns

- Complete @printable-exercise{quadratic-models.adoc}, using the second slide of @starter-file{alg2-covid-desmos}.

Quadratic models capture _parabolic relationships_, where one quantity varies based on the square of another. In quadratic models, we expect the response variable to grow by differing amounts over equal intervals in the explanatory variable.

@slidebreak
{layout="Investigate"}
# Looking for Patterns

Class discussion: Are quadratic models a good fit for this data? Why or why not?

@teacher{Have students share their resulting models. Which one fits best?}

@slidebreak
{layout="Investigate"}
# Looking for Patterns

Quadratic models capture _parabolic relationships_, where one quantity varies based on the square of another. In quadratic models, we expect the response variable to grow by differing amounts over equal intervals in the explanatory variable.

@slidebreak
{layout="Investigate"}
# Looking for Patterns

Quadratic models change their rate of growth over time, which definitely makes them a better fit for this data than linear ones. It's very likely we could find a quadratic model with a pretty good @math{R^2} value! But this data starts out almost flat and then suddenly takes off like a rocket - quadratic models just don't have that kind of explosive growth, so our model will never be as good as it _could_ be.

@slidebreak
{layout="Synthesize"}
# Looking for Patterns

- Do you think the data for MA shows a linear relationship? Why or why not?
- Do you think this data shows a quadratic relationship? Why or why not?
- Do you think this data shows some other kind of relationship? Why or why not?


@slidebreak
{layout="Launch"}
# Exponential Functions

Let's review what we know about the behavior of the models we've seen so far...

@slidebreak
{layout="LaunchR"}
# Exponential Functions

@image{images/difference-table-linear.png}

Remember that linear functions grow by _fixed intervals,_ so the rate of change is _constant_. In the table shown here, each time the x-value increases by 1, we see that the y-value increases by 2. This is true for any set of equal-sized intervals: a line needs to slope up or down at a constant rate in order to be a straight line! 

**If the "growth" is constant, the relationship is linear.**

@slidebreak
{layout="LaunchR"}
# Exponential Functions

@image{images/difference-table-quadratic.png}
Quadratic functions grow by intervals that _increase by fixed amounts!_ In the table to the right, the blue arrows show a differently-sized jump between identical intervals, meaning _the function is definitely not linear!_ However, if we take a look at the _difference between those differences_(shown in red), we're back to constant growth! 

**If the "growth of the growth" is constant, the relationship is quadratic.**

@slidebreak
{layout="LaunchR"}
# Exponential Functions

@image{images/difference-table-exponential-1.png}

There is, however, a class of functions that grows even faster than quadratics: @vocab{exponential functions}.

If we try to calculate the growth between the y-values, we can immediately tell it's not linear. But then if we try to calculate the "growth of the growth", we see that it's not quadratic either. 

@slidebreak
{layout="LaunchR"}
# Exponential Functions

@image{images/difference-table-exponential-1.png}

Even if we calculate the "growth of the __growth of the growth__" (shown in green)... we still haven't found a constant. In fact, each of these "growths" just repeats the original pattern of y-values! 

Something is making this function grow so fast that our attempt to calculate the rate of change fails to simplify anything.

@slidebreak
{layout="LaunchR"}
# Exponential Functions

@image{images/difference-table-exponential-2.png}

Exponential functions grow so rapidly that looking for "what is _added_ to y?" isn't helpful at all. The only way to talk about their growth is to start noticing "what is y being _multiplied_ by?"

*In this case, we can see that the y-values are doubling each time!*

@slidebreak
{layout="Launch"}
# Exponential Functions

- Complete @printable-exercise{classifying-tables.adoc}
- Be ready to discuss your answers with the class!


@slidebreak
{layout="Investigate"}
# Exponential Functions


We generally write exponential functions like this: @math{f(x)=ab^x + k}. 

Let's explore what each coefficient means!

Use the third slide of @starter-file{alg2-covid-desmos} to complete the first section ("base") of @printable-exercise{graphing-models.adoc}.

@teacher{
Review students answers, and then debrief via class discussion. Invite students to consider what new information they have gained by looking at graphical representations rather than tables.}


@slidebreak
{layout="Investigate"}
# Exponential Functions

*The base of an exponential function (@math{b})* must *always be positive*, because exponential functions grow and decay uniformly. A negative @math{b} would bounce from one side of the y-axis to another. When raised to a fractional power, negative values of @math{b} might also lead to things like @math{\sqrt{-2}}!



@slidebreak
{layout="InvestigateR"}
# Exponential Functions

@image{images/growth.png}

@math{b > 1} : When the base is *larger* than 1, the function starts out flat and then grows by the "percentage greater than 1". A base of 1.25 - or @math{(1 + 0.25)} - will grow by 25% each time @math{x} grows by 1. In this instance, the base is also called the @vocab{growth factor}, since it determines how quickly the function grows.



@slidebreak
{layout="InvestigateR"}
# Exponential Functions

@image{images/flat.png}

@math{b = 1} : When the base is equal to 1, the function stays flat without any growth of all (raising 1 to _any_ power will always produce 1!).


@slidebreak
{layout="InvestigateR"}
# Exponential Functions

@image{images/decay.png}

@math{0 < b < 1} : When the base is *smaller* than 1, the function shrinks by the "amount less than 1". A base of 0.25 - or @math{(1 - 0.75)} - will shrink by 75% each time @math{x} grows by 1. In this instance, the base is also called the @vocab{decay factor}, since it determines how quickly the function shrinks.


@slidebreak
{layout="Investigate"}
# Exponential Functions

Use the third slide of @starter-file{alg2-covid-desmos} to complete the second section ("vertical shift") of @printable-exercise{graphing-models.adoc}.



@slidebreak
{layout="Investigate"}
# Exponential Functions

An exponential function with a @vocab{growth factor} will always start close to a horizontal line, then gradually shoot up to ever-increasing values. An exponential function with a @vocab{decay factor} will drop quickly, then level out close to a horizontal line. 

This horizontal line is called an @vocab{asymptote}, and the equation of the line will always be @math{y = k}. 


*Adjusting @math{k} shifts the asymptote up and down*, along with the rest of the exponential curve that approaches it.


@slidebreak
{layout="Investigate"}
# Exponential Functions

Use the third slide of @starter-file{alg2-covid-desmos} to complete the last section ("initial value") of @printable-exercise{graphing-models.adoc}.

@slidebreak
{layout="Investigate"}
# Exponential Functions


*The y-intercept appears _differently_ in exponential function definitions than in linear and quadratic definitions:*

* In both linear and quadratic functions, we could cross out the linear or quadratic term when @math{x = 0} (because anything multiplied by zero is zero) and the constant term being added or subtracted in the equation was our y-intercept. 
* But, because any value raised to the power of zero is 1, when @math{x = 0} in exponential equations, part of the exponential term _remains_, for example: @math{4(2^0) = 4(1) = 4}. 
* As a result, *the y-intercept of an exponential function is @math{a + k}*.

@slidebreak
{layout="Investigate"}
# Exponential Functions


*The y-intercept appears _differently_ in exponential function definitions than in linear and quadratic definitions:*

* When there is no @math{k}-term being added or subtracted, the coefficient @math{a} is the initial value where @math{x = 0}. 
* And, if @math{a} is "missing", the value of the coefficient is @math{1}. _After all,_ @math{2^x = 1(2^x)} +
That means that if we don't see @math{a} or @math{k} in an exponential equation, the y-intercept of the function is 1.

@slidebreak
{layout="Investigate"}
# Exponential Functions

@vocab{Exponential growth} and @vocab{exponential decay} show up all the time!{style="font-size: 15pt"}


- Most cells (e.g. bacteria, the cells in a growing fetus, etc) divide every few hours, doubling the number of cells each time. A single cell will split into 2, those 2 cells will split to become 4, which will become 8, then 16, and so on.{style="font-size: 15pt"}
- Unstable particles degrade into stable particles over time, emitting radiation as a byproduct. We use the term _half-life_ to refer to the length of time it takes for 50% of the particles in a sample to become stable, leaving behind the other half as radiation-emitting material.{style="font-size: 15pt"}
- Money in a savings account grows by a certain percentage each year. 3% growth on $100 would turn into $103. The next year that would become $106.09. And the next year $109.27. Every year there's a little more money to grow. If you start saving early, the account will grow into quite a lot more money down the road.{style="font-size: 15pt"}



@teacher{In the following two activities, students will decide whether various scenarios and definitions represent quadratic, linear, or exponential functions. They will also have opportunities to think about and apply their knowledge of growth, decay, initial value, and growth factor.}


@slidebreak
{layout="Investigate"}
# Exponential Functions

- Complete @printable-exercise{classifying-descriptions.adoc}.
- What strategies did you use to decide if a function was linear, quadratic, or exponential?
- What new insights did you gain about exponential functions by thinking about them in real-world scenarios?


@teacher{Have students share their answers, asking them to notice and wonder about the sequences for the exponential examples. How are these sequences growing or decaying? How is that growth or decay different from what they've seen before? }


@slidebreak
{layout="Investigate"}
# Exponential Functions

- Complete @printable-exercise{classifying-defs.adoc}.
- What strategies did you use to decide if a function was linear, quadratic, or exponential?
- What new insights did you gain about exponential functions by thinking about their definitions?

@teacher{As students discuss their answers, pay special attention to their use of vocabulary when describing the initial value and the growth factor.}


@slidebreak
{layout="Synthesize"}
# Exponential Functions

- You looked at several different representations of exponential functions: tables, graphs, descriptions, and equations.
- Which representation was the most useful for you? Why?
- Which representation was the least useful for you? Why?


@slidebreak
{layout="Launch"}
# Fitting Exponential Models


Now that you're familiar with exponential functions, let's use them to model this Covid data!

Create a scatter plot showing the change in positive Covid cases for `MA-Table`. Then, make some educated guesses about the values of @math{a}, @math{b}, and @math{k}.

@slidebreak
{layout="Launch"}
# Fitting Exponential Models 

- Does your scatter plot show exponential growth or exponential decay?
- Can we make any conclusions about the value of @math{b}? Explain.
- Can we make any conclusions about the value of @math{k}?
- Can we make any conclusions about the value of @math{a}? Explain.

@teacher{
- Does your scatter plot show exponential growth or exponential decay?
** _The scatter plot shows growth. The "hockey stick" is pointing up, meaning that positive cases are increasing._
- Can we make any conclusions about the value of @math{b}? Explain.
** _Because we see exponential growth, we know that @math{b} must be greater than one._
- Can we make any conclusions about the value of @math{k}?
- Can we make any conclusions about the value of @math{a}? Explain.
** _@math{a} must be positive, because the curve is consistently above @math{k}._}



@slidebreak
{layout="Investigate"}
# Fitting Exponential Models

- Open to the fourth slide of @starter-file{alg2-covid-desmos}, and complete @printable-exercise{exponential-models.adoc}.
- Is an exponential model a good fit for this data? Why or why not?

Build models for _other states_. How do the coefficients differ from state to state? What differences between states could explain the different values of the coefficients?


@slidebreak
{layout="Investigate"}
# Fitting Exponential Models

On @printable-exercise{exponential-models.adoc}, you'll see a note about the use of `~1` to tell Pyret to prioritize speed over precision. Unlike most calculators you've worked with, Pyret usually prioritizes precision.

In a math classroom, this is the difference between @math{\frac {2}{3}} rendering as @math{ 0.\overline{666}} or being rounded to 0.666666667.

@slidebreak
{layout="Investigate"}
# Fitting Exponential Models

In data processing, opting to round for speed over preserving precision can have ethical or technical consequences. For example:

(1) When calculating a path over an extremely long distance, missing decimal places could result in the Mars Rover missing its destination.

(2) For an extremely large population like China, rounding to 10 decimal places might result in discounting an entire subpopulation.


@slidebreak
{layout="Synthesize"}
# Fitting Exponential Models

- What makes exponential models different from the linear and quadratic models you've seen before?
- How would you describe the shape of the three models you've seen so far (Linear, Quadratic, and Exponential)?
- Is it always okay for Data Scientists to round off their numbers to speed up computation? Why or why not?
