---
{layout="DS Title Slide"}
# Histograms

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Introducing Histograms

- Turn to @printable-exercise{pages/summarizing-columns.adoc}, which contains a table of data, two kinds of displays, and some questions.
- Answer the questions at the bottom of the page.


<!--

-->
---
{layout="LaunchR"}
# Introducing Histograms

@image{images/pet-numbers.png, 250}

The display on the left side of the page is a @vocab{Bar chart}.

- The x-axis lists the values of a categorical variable (`species`).
- The y-axis shows the @vocab{frequency} of categorical values in the dataset.
- It would be fine to re-order the columns any way we wish! The bar for “dogs” could have been drawn before the one for “cats”, without changing the meaning of the display. 
<!--

-->
---
{layout="LaunchR"}
# Introducing Histograms

@image{images/pet-weights.png, 250}

The display on the right side is called a @vocab{histogram}.

- Histograms show the distribution of _quantitative_ data.
- Since quantitative data must follow a natural order, these bars _cannot_ be re-ordered.
- Histograms allow us to see the _shape_ of a dataset.
<!--

-->
---
{layout="Investigate"}
# Introducing Histograms

To build a histogram, we start by **sorting all of the numbers in our column from smallest to largest**, marking our x-axis from the smallest value to the largest value and **dividing the x-axis into equally-sized intervals,** or “bins”. 

Once we have our bins, we put each value in our dataset into the bin where it belongs, and then count how many values fall in each bin. This count determines the height of the bars on our y-axis.

Turn to @printable-exercise{pages/making-histograms.adoc}, and try drawing a histogram from a dataset.

<!--
For example, if our values ranged from 3 to 53 we might mark our x-axis from 0 to 60 and divide it into bins of width 10. If they range from 22 to 41 we might mark our x-axis from 20 to 45 and divide it into bins of width 5.
-->
---
{layout="Investigate"}
# Introducing Histograms

**Extreme values - which sit far above or below the others - are called _outliers_**

In the histogram we just made, we see that the data is clustered at the right-hand side of the histogram: most people in this sample have close to a full set of teeth, with some people missing a few more than others. But apparently there are five people with almost no teeth at all! These are very unusual, and they show up as a small bar far to the left of the cluster. Extreme data points like this are called @vocab{outliers}.

<!--

-->
---
{layout="Synthesize"}
# Introducing Histograms

In your own words, can you explain how are histograms and bar charts different?

<!--
*Common Misconceptions*
Note that intervals on this display include the left endpoint but not the right. If we included the right endpoint and someone had 0 teeth, we’d have to add on a bar from -5 to 0, which would be awfully strange!
-->
---
{layout="Launch"}
# Choosing the Right Bin Size 

**The size of the bins matters a lot!**

Bins that are too small will hide the shape of the data by breaking it into too many short bars. Bins that are too large will hide the shape by squeezing the data into just a few tall bars. In the last exercise, the bins were provided for you. 

But how do you choose a good bin-size?

<!--

-->
---
{layout="Investigate"}
# Introducing Histograms

Suppose we want to know how long it takes for animals from the shelter to be adopted.

* Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
* Find the contract for the `histogram` function.
* Make a histogram for the `"weeks"` column in the `animals-table`, using a bin size of 10.
* How many took between 0 and 10 weeks? Between 10 and 20?
---
{layout="Investigate"}
# Introducing Histograms

* Try some other bin sizes (be sure to experiment with bigger and smaller bins!)
* What shapes emerge? What bin size gives you the best picture of the distribution?
* Are there any outliers? Are they high or low?
* Count how many animals took between 0 and 5 weeks to be adopted. How many took between 5 and 10 weeks?

<!--
Some observations you can share with the class, to get them started:

- We see most of the histogram’s area under the two bars between 0 and 10 weeks, so we can say it was most common for an animal to be adopted in 10 weeks or less.
- We see a small amount of the histogram’s area trailing out to unusually high values, so we can say that a couple of animals took an unusually long time to be adopted: one took even more than 30 weeks.
- More than half of the animals (17 out of 31) took just 5 weeks or less to be adopted. But the few unusually long adoption times pulled the average up to 5.8 weeks. We’ll talk more about Shape of a histogram in the next lesson, and about its effect on average (the mean) in the lesson after that.
-->
---
{layout="Investigate"}
# Introducing Histograms

**How do you describe a histogram?**

If someone asked what was a typical adoption time, we could say: “Almost all of the animals were adopted in 10 weeks or less, but a couple of animals took an unusually long time to be adopted -- even more than 20 or 30 weeks!” 

It would have been hard to give this summary by reading through the table, but the histogram makes it easy to see!

See if you can match descriptions to histograms, by completing @printable-exercise{reading-histograms.adoc}

<!--

-->
---
{layout="Synthesize"}
# Introducing Histograms

- What would the histogram look like if most of the animals took more than 20 weeks to be adopted, but a couple of them were adopted in fewer than 5 weeks?
- What would the histogram look like if every animal was adopted in roughly the same length of time?
- What bin sizes worked best for analyzing `adoption`?

<!--
*Have students talk about the bin sizes they tried*. Encourage open discussion as much as possible here, so that students can make their own meaning about bin sizes before moving on to the next point.
-->
---
{layout="Synthesize"}
# Introducing Histograms

**Rule of thumb: a histogram should have between 5–10 bins.**

Choosing the right bin size for a column has a lot to do with how data is distributed between the smallest and largest values in that column! With the right bin size, we can see the _shape_ of a quantitative column. 

But how do we talk about that shape, and what does the shape actually tell us? The next lesson addresses all of these...

<!--

-->
