---
{layout="DS Title Slide"}
# Standard Deviation

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Measuring "Deviance"

**The Animal Shelter Bureau reports that the mean age of shelter cats is 3 years.**

_Does this mean all the cats are close to 3 years old?_ 

_Why or why not?_

(Feel free to look at the Animals Dataset in your student workbook, or @opt-online-exercise{https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/edit?usp=sharing, the Animals Dataset spreadsheet})


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

<!--

-->
---
{layout="InvestigateC"}
# Measuring "Deviance"

@image{images/histogram-w-mean.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. A star labeling the mean is drawn on the x-axis at 3."} 

In this image, we've drawn a star to show the mean at 3. 

But there are _all sorts of datasets_ that have a mean of 3! 
<!--

-->
---
{layout="InvestigateC"}
# Measuring "Deviance"

@image{images/histogram-w-mean.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. A star labeling the mean is drawn on the x-axis at 3."} 

We could imagine a shelter where every cat is between 2 and 4, so **each cat only deviates from the mean by 1 year**! But we could also imagine a shelter with only kittens and very old cats, where **cats deviate by as much as 10 years from the mean!**

How far away is each data point from 3?
<!--

-->
---
{layout="LaunchC"}
# Measuring "Deviance"

@image{images/histogram-w-arrows.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. A star labeling the mean is drawn on the x-axis at 3, and  arrows show the distance between the mean and each point in the first interval."}

In this image, we've draw an arrow for each of the 1-year-old cats. That means there are four arrows running from the mean at 3 to the interval at 1, and each arrow has the label 2.

<!--

-->
---
{layout="Launch"}
# Measuring "Deviance"

**Complete numbers 4 to 6** of @printable-exercise{computing-stdev.adoc}, and then STOP.

To compute the standard deviation we square each distance and take the average, then take the square root of the average. The process of finding standard deviation manually is a bit laborious. Keeping organized is crucial; a partially-completed table is provided on the bottom half of worksheet to support students in doing so.

**Complete numbers 7-10** of @printable-exercise{computing-stdev.adoc}, where you will utilize the algorithm for computing standard deviation.

<!--
When completing #4-6 of the worksheet, students will need to stretch their visual imaginations a bit! In problem number 6, they are asked to summarize all 10 distances from the mean into a single number. The goal here is for students to make an educated guess about standard deviation (SD) _before_ learning the algorithm for computing it. Invite and encourage discussion about students' different approaches for guessing at the best summary number _before_ sharing the key idea about standard deviation!

Students are likely to hone in on the __Mean Average Deviation__, or MAD. Both SD and MAD measure variability or "spread" by computing individual deviations from the mean, but MAD averages these deviations and SD transforms them via square/square-root.
-->

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
	__Approximately 48.5__ Optional: For additional practice, have students complete @opt-printable-exercise{computing-stdev-2.adoc}.
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
{layout="Launch"}
# Measuring "Deviance"

- Make a histogram showing the ages of *all the cats* in the dataset.
- What is the shape of this histogram?
- How does it differ from the one we just looked at?

<!--

-->

---
{layout="LaunchC"}
# Measuring "Deviance"

Invite students to take a look at the histogram below. It is the same histogram we saw in the previous section, but now with an 11th cat that is 16 years old. That's quite an outlier!

@image{images/histogram-with-outlier.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. An 11th cat has been added at 16 years."} 

---
{layout="Launch"}
# Measuring "Deviance"

- What is the shape of this histogram?
- How does it differ from the one we just looked at?
- Turn to @printable-exercise{pages/effect-of-an-outlier.adoc} to explore the extent to which the inclusion of an outlier will affect the center and spread of a quantitative dataset._
- What did this outlier do to the mean? Refer back to @printable-exercise{computing-stdev.adoc} to help you.
- What did this outlier do to the standard deviation?
- Optional: To see how changes in data values affect the mean and standard deviation, complete @opt-printable-exercise{pages/match-mean-stdev-to-dataset.adoc}.

<!--
- What is the shape of this histogram?
** _The histogram has high outliers, therefore it is skewed right._
- How does it differ from the one we just looked at?
** _The previous histogram - with the 16-year-old cat omitted - was roughly symmetric._
- Turn to @printable-exercise{pages/effect-of-an-outlier.adoc} to explore the extent to which the inclusion of an outlier will affect the center and spread of a quantitative dataset._
- What did this outlier do to the mean? Refer back to @printable-exercise{computing-stdev.adoc} to help you.
** __Previously, the mean was 3; now it is approximately 4.33.__
- What did this outlier do to the standard deviation?
** _The outlier caused the standard deviation to increase by about 1.33._
- Optional: To see how changes in data values affect the mean and standard deviation, complete @opt-printable-exercise{pages/match-mean-stdev-to-dataset.adoc}.
-->

---
{layout="Investigate"}
# Measuring "Deviance"

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
# Measuring "Deviance"

- How much did adding an outlier change the mean? The standard deviation?
- Extreme values affect both the mean and standard deviation of a dataset.
- **Unusually low values _decrease_ the mean, while unusually high values _increase_ it.** Unusually low or high values increase the standard deviation, because it summarizes distance from the mean in either direction.

---
{layout="Launch"}
# Your Own Analysis

What can standard deviation tell you about quantitative columns in _your_ dataset?

---
{layout="Launch"}
# Your Own Analysis

- What is the standard deviation for these columns? Complete @printable-exercise{analysis-stdev-my-dataset.adoc}, and add your findings to the "Measures of Center and Spread" section.
- Do these measures bring up any interesting questions? If so, add them to the end of the document.

---
{layout="Synthesize"}
# Your Own Analysis

- Share your findings!
- Are some columns more spread out - with a larger standard deviation - than others?
- What does that mean about your data?
