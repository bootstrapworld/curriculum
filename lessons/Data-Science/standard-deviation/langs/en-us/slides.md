---
{layout="DS Title Slide"}
# Standard Deviation

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Measuring "Deviance"

**The Animal Shelter Bureau reports that the @vocab{mean} age of shelter cats is 3 years.**

- Look at the Animals Dataset in your student workbook, or the @opt-online-exercise{https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/edit?usp=sharing, Animals Dataset spreadsheet}.
- Does a mean age of 3 years translate to all of the cats being close to 3 years old? Why or why not?

---
{layout="Launch"}
# Measuring "Deviance"

Let's take a look at some cats from our shelter.

- Turn to @printable-exercise{computing-stdev.adoc}, and **complete numbers 1-3**.
- What did you get for the mean? Does it match what the Animal Shelter Bureau says?
- Can you think of four ages, such that the mean age for all of them is 3?
- Can you think of a _different_ spread of four ages that would have the same mean?
- How many different sets of four ages can you think of, which all have a mean of 3?

<!--
Some possibilities include: {3,3,3,3}, {1,2,4,5}, {1,1,4,6}... any four ages that add up to 12 will work!
-->
---
{layout="Launch"}
# Measuring "Deviance"

Without a measure of @vocab{spread}, just knowing the mean doesn't tell us enough about the shape of the data. 

When summarizing a column, we'd like to use a measure that gathers data from every value. We already have one method of measuring spread: calculating the Five Number Summary and using it to generate a box plot. 

Unfortunately, that measure comes from only a small number of data points! If possible, we'd like to have a measure that summarizes the spread across _all_ the points.

<!--

-->
---
{layout="Launch"}
# Measuring "Deviance"

**@vocab{Standard deviation} is the most useful way to summarize @vocab{spread} of a quantitative column.**

Instead of focusing on the handful of data points used in our Five Number Summary, another way to measure spread is to focus on _the "typical" distance from the mean_. In other words, we want to know what kind of deviation is "standard" for all the points.

---
{layout="InvestigateC"}
# Measuring "Deviance"

@right{@image{images/histogram-w-mean.png, 450}} We could imagine a shelter where every cat is between 2 and 4, so *each cat only deviates from the mean by 1 year*! But we could also imagine a shelter with only kittens and very old cats, where *cats deviate by as much as 10 years from the mean!*

How far away is each data point from 3?


---
{layout="LaunchC"}
# Measuring "Deviance"

@image{images/histogram-w-arrows.png}

In this image, we've draw an arrow for each of the 1-year-old cats. That means there are four arrows running from the mean at 3 to the interval at 1, and each arrow has the label 2.


---
{layout="Launch"}
# Measuring "Deviance"

**Complete numbers 4 to 6** of @printable-exercise{computing-stdev.adoc}, and then STOP.

---
{layout="Launch"}
# Measuring "Deviance"

To compute the standard deviation we add the squares of all _N_ distances, divide by _N-1_, then take the square root of the result.

@teacher{The process of finding standard deviation manually is a bit laborious. Keeping organized is crucial; a partially-completed table is provided on the bottom half of the worksheet to support students in doing so.}

---
{layout="Launch"}
# Measuring "Deviance"

**Complete numbers 7-10** of @printable-exercise{computing-stdev.adoc}, where you will utilize the algorithm for computing standard deviation.

---
{layout="Synthesize"}
# Measuring "Deviance"

Now that you know how to compute standard deviation on your own, here is the contract for `stdev`, along with an example that will calculate the standard deviation for the `pounds` column in the animals-table:

```
# stdev :: (t :: Table, col :: String) -> Number
stdev(animals-table, "pounds")
```

What is the standard deviation for the weights of _all_ the animals at our dataset?

<!--
__Approximately 48.5__ @optional For additional practice, have students complete @opt-printable-exercise{computing-stdev-2.adoc}.
-->

---
{layout="Synthesize"}
# Measuring "Deviance"

- Can you explain why two datasets can have the same mean, but different standard deviations?
- What kind of dataset would have a standard deviation of zero?

<!--
- Can you explain why two datasets can have the same mean, but different standard deviations?
** _Mean is a measure of *central tendency*, whereas standard deviation measures the *variation* of some sample._
- What kind of dataset would have a standard deviation of zero?
** _A standard deviation of zero means that every number in the sample is exactly the same._
-->

---
{layout="LaunchC"}
# Comparing Standard Deviations

Take a look at the histogram below. It is the same histogram we saw in the previous section, but now with an 11th cat that is 16 years old. That's quite an outlier!

@center{@image{images/histogram-with-outlier.png, 500}}

---
{layout="Launch"}
# Comparing Standard Deviations

- What is the shape of this histogram?
- How does it differ from the one we just looked at?
- Turn to @printable-exercise{pages/effect-of-an-outlier.adoc} to explore the extent to which the inclusion of an outlier will affect the center and spread of a quantitative dataset.
- What did this outlier do to the mean? Refer back to @printable-exercise{computing-stdev.adoc} to help you.
- What did this outlier do to the standard deviation?
- @optional To see how changes in data values affect the mean and standard deviation, complete @opt-printable-exercise{pages/match-mean-stdev-to-dataset.adoc}.

@teacher{
- What is the shape of this histogram?
** _The histogram has high outliers, therefore it is skewed right._
- How does it differ from the one we just looked at?
** _The previous histogram - with the 16-year-old cat omitted - was roughly symmetric._
- Turn to @printable-exercise{pages/effect-of-an-outlier.adoc} to explore the extent to which the inclusion of an outlier will affect the center and spread of a quantitative dataset._
- What did this outlier do to the mean? Refer back to @printable-exercise{computing-stdev.adoc} to help you.
** __Previously, the mean was ~2.45; now it is ~5.83.__
- What did this outlier do to the standard deviation?
** _The outlier caused the standard deviation to increase by ~3.38._
- @optional To see how changes in data values affect the mean and standard deviation, complete @opt-printable-exercise{pages/match-mean-stdev-to-dataset.adoc}.
} 

---
{layout="Investigate"}
# Comparing Standard Deviations

The mean and standard deviation tell us where the data is centered and how far the data strays from that center.

- The mean time-to-adoption is 5.75 weeks. Does that mean most animals generally get adopted in 4-6 weeks?
- Turn to @printable-exercise{pages/analysis-stdev-animals.adoc} to get some practice using the Data Cycle to answer this question, then write your findings in the space at the bottom.


<!--
MAD and SD are both measures of a certain kind of _distance_, literally asking "how are far from the mean are all the points in the dataset?". With each point being independent from the other, we can imagine a dataset with two points as a right triangle with two legs: how far apart are these points?

Before learning the distance formula, students might guess at a number of ways to compute the hypotenuse. They can quickly rule out the sum of the legs, and the difference between them. At some point they might suggest _averaging_ the lengths of the legs. Mean Average Deviation (MAD) does exactly that, by flattening each points' deviation into a single "dimension".

Of course, these legs exist on separate axes - so we need a formula for distances in more than one dimension. Computing the SD involves the _square root of a sum of squares_. That should sound suspiciously like the distance formula! Indeed, computing the SD for a dataset with two points is basically finding the (normalized) length of the hypoteneuse!

The pythagorean distance works in 3-dimensions as well (right pyramids!) - or for any number of dimensions - as does the formula for standard deviation. By treating each point as a separate dimension, DS allows each deviation to be considered independantly.

Why use one measure of spread instead the other? The answer is closely related to the difference between two measures of _center_! `Mean` incorporates data from every point, while `median` does not. However, `mean` is sensitive to the effect of extreme outliers or @vocab{skew}. In those cases, `median` is considered to be the better measure of center.

Treating each point independantly allows each deviation to contribute to the measure of spread, just as `mean` computes the measure of center. This is why SD is used most often, but like `mean` it is sensitive to extreme outliers or skew. In those cases, the MAD is considered a better measure of spread.
-->

---
{layout="Synthesize"}
# Comparing Standard Deviations

- How much did adding an outlier change the mean? The standard deviation?
- Extreme values affect both the mean and standard deviation of a dataset.
- **Unusually low values _decrease_ the mean, while unusually high values _increase_ it.** Unusually low or high values increase the standard deviation, because it summarizes distance from the mean in either direction.

---
{layout="Launch"}
# Data Exploration Project (Standard Deviation){style="font-size:27pt"}

Let’s review what we have learned about standard deviation.

- Do we compute standard deviation categorical data or quantitative data? How many columns of data does standard deviation tell us about?
- Standard deviation is a measure of @vocab{spread}. In your own words, what does @vocab{spread} mean?
- How can two datasets have the same mean, but different standard deviations?
- Both unusually low and unusually high values (outliers) *increase* the standard deviation. Explain why.

@teacher{
- Do we compute standard deviation categorical data or quantitative data? How many columns of data does standard deviation tell us about?
** _Standard deviation is a measure that tells us about the spread of a single quantitative column of data._
- Standard deviation is a measure of @vocab{spread}. In your own words, what does @vocab{spread} mean?
** _Spread is the extent to which values in a dataset vary, either from one another or from the center._
- How can two datasets have the same mean, but different standard deviations?
** _Mean is a measure of central tendency, whereas standard deviation measures the variation of some sample._
- Both unusually low and unusually high values (outliers) *increase* the standard deviation. Explain why.
** _Standard deviation summarizes distance from the mean in either direction._
}

---
{layout="Investigate"}
# Data Exploration Project (Standard Deviation){style="font-size:27pt"}

Let’s connect what we know about standard deviation to your chosen dataset.

- Open your chosen dataset starter file in Pyret.
- Use Pyret to compute its standard deviation.
- What question does your display answer?
- Write down that question in the top section of the @printable-exercise{analysis-stdev-my-dataset.adoc}.
- Complete the rest of the data cycle, recording how you considered, analyzed and interpreted the question.
- Repeat this process for at least one more quantitative column.

@teacher{
- Open your chosen dataset starter file in Pyret.
** _Teachers: Students have the opportunity to choose a dataset that interests them from our @lesson-link{choosing-your-dataset/pages/datasets-and-starter-files.adoc, "List of Datasets"} in the @lesson-link{choosing-your-dataset} lesson._
** - Choose one quantitative column that you'd like to analyze.
** _Note: Consider recommending that students choose the same column they used when they found their @lesson-link{measures-of-center}. If students use a different column, they will need to copy/paste additional slides into their slide deck._
- Use Pyret to compute its standard deviation.
- What question does your display answer?
** _Possible responses: How is the data for a certain column distributed? How does the standard deviation compare to the mean?_

Invite students to discuss their results and consider how to interpret them.
}

---
{layout="Investigate"}
# Data Exploration Project (Standard Deviation){style="font-size:27pt"}

- *It’s time to add to your @starter-file{exploration-project}.*
- Locate the "Measures of Center" section of your Exploration Project, and type in the the standard deviations you just identified.
- Add your interpretation of the standard deviation and record any questions that emerged.

---
{layout="Synthesize"}
# Data Exploration Project (Standard Deviation){style="font-size:27pt"}

Share your findings with the class!

Did you discover anything surprising or interesting about your dataset?

What questions did the standard deviations inspire you to ask?

When your compared their findings with other students, did they make any interesting discoveries?