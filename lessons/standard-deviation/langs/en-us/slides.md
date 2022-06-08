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

<!--

-->
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

When summarizing a column, we'd like to use a measure that gathers data from every value. We already have one method of measuring spread: calculating the Five Number Summary and using it to generate a box-plot. 

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

@image{images/histogram-w-mean.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. A star labeling the mean is drawn on the x-axis at 3.", 450} 

In this image, we've drawn a star to show the mean at 3. 

But there are _all sorts of data sets_ that have a mean of 3! 
<!--

-->
---
{layout="InvestigateC"}
# Measuring "Deviance"

@image{images/histogram-w-mean.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. A star labeling the mean is drawn on the x-axis at 3.", 450} 

We could imagine a shelter where every cat is between 2 and 4, so **each cat only deviates from the mean by 1 year**! But we could also imagine a shelter with only kittens and very old cats, where **cats deviate by as much as 10 years from the mean!**

How far away is each data point from 3?
<!--

-->
---
{layout="LaunchC"}
# Measuring "Deviance"

@image{images/histogram-w-arrows.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. A star labeling the mean is drawn on the x-axis at 3, and  arrows show the distance between the mean and each point in the first interval.", 450}

In this image, we've draw an arrow for each of the 1-year-old cats. That means there are four arrows running from the mean at 3 to the interval at 1, and each arrow has the label 2.

<!--

-->
---
{layout="Launch"}
# Measuring "Deviance"

**Complete numbers 4 to 6** of @printable-exercise{computing-stdev.adoc}, and then STOP.

* We want to summarize all 10 distances from the mean into a single number. Which one of these seems closest: 1, 2, 4, or 5?
* _Be prepared to share: How did you select the summary number?_

**Complete numbers 7-10** of @printable-exercise{computing-stdev.adoc}

<!--
Make sure to STOP students before #7, and have them share and discuss their choice of summary
-->
---
{layout="Synthesize"}
# Measuring "Deviance"

- Can you explain why two datasets can have the same mean, but different standard deviations?
- What kind of dataset would have a standard deviation of zero?

<!--

-->

---
{layout="Launch"}
# Comparing Standard Deviations

Below is the contract for `stdev`, along with an example that will calculate the standard deviation for the `pounds` column in the animals-table:

```{style="font-weight:bold"}
# stdev :: (t :: Table, col :: String) -> Number
stdev(animals-table, "pounds")
```

What is the standard deviation for the weights of _all_ the animals at our dataset?

<!--

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

@image{images/histogram-with-outlier.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. An 11th cat has been added at 16 years.", 450} Here is the same histogram we saw before, but now with an extra cat that is 16 years old.

- Complete @printable-exercise{pages/effect-of-an-outlier.adoc}.

<!--

-->

---
{layout="LaunchC"}
# Measuring "Deviance"

@image{images/histogram-with-outlier.png, "A histogram showing the distribution of ages for 10 cats, between the ages of 1 and 8. An 11th cat has been added at 16 years.", 450}

- What did this outlier do to the mean?
- What did this outlier do to the standard deviation?
- OPTIONAL: To see how changes in values affect the mean and standard deviation, complete @opt-printable-exercise{pages/match-mean-stdev-to-dataset.adoc}.

<!--

-->

---
{layout="Investigate"}
# Measuring "Deviance"

The mean and standard deviation tell us where the data is centered and how far the data strays from that center.

- The mean time-to-adoption is 5.75 weeks. Does that mean most animals generally get adopted in 4-6 weeks?
- Turn to @printable-exercise{pages/analysis-stdev-animals.adoc} to get some practice using the Data Cycle to answer this question, then write your findings in the space at the bottom.

---
{layout="Synthesize"}
# Measuring "Deviance"

- How much did adding an outlier change the mean? The standard deviation?
- Extreme values affect both the mean and standard deviation of a data set.
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
