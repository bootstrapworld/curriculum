---
{layout="DS Title Slide"}
# Histograms

<!--
This slide deck includes an optional Kinesthetic Activity. Be sure to delete slide 5 if you do not plan to engage your students with the activity. 

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

There are 2 displays on @printable-exercise{pages/summarizing-columns.adoc}. The first display is a @vocab{Bar chart}.{style="font-size:16pt"}

- The x-axis lists the values of a categorical variable (`species`).{style="font-size:16pt"}
- The y-axis shows the @vocab{frequency} of categorical values in the dataset.{style="font-size:16pt"}
- It would be fine to re-order the columns any way we wish! The bar for “dogs” could have been drawn before the one for “cats”, without changing the meaning of the display.{style="font-size:16pt"} 
<!--

-->
---
{layout="LaunchR"}
# Introducing Histograms

@image{images/pet-weights.png, 250}

The second display is called a @vocab{histogram}.

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

---
{layout="Investigate-K"}
# Introducing Histograms

1. With your group, roll the dough into a thick cylinder. {style="font-size:12pt"}

1. Divide that cylinder in half.{style="font-size:12pt"} 

1. Take one of the halves and cut it in half _again_.{style="font-size:12pt"}

1. Cut one of the resulting pieces in half once more.{style="font-size:12pt"} 

The result should be *four* chunks of playdough, with a ratio of *1:1:2:4*.{style="font-size:12pt"}

The playdough represents a @vocab{sample}, with values falling into four intervals. The largest cylinder represents double the number of "data points" (amounts of dough) as the next largest, which in turn has double the data points of the two small ones.{style="font-size:12pt"}

Histograms pile the data points into equally-sized intervals, just as the cylinders of dough are all of the same width. __More dough means longer cylinders__, since the "interval width" (cylinder thickness) stays fixed.{style="font-size:12pt"}

1. Line up the cylinders from smallest-to-largest, laying them on a sheet of graph paper.{style="font-size:12pt"} 

1. Come up with labels for what the x- and y-axis might represent!{style="font-size:12pt"}

<!--
Perhaps they represent the number of teeth grownups have with most grownups having a full set of teeth, some missing one or two, and some outliers who've lost a significant number.
-->

---
{layout="Investigate"}
# Introducing Histograms

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

In your own words, can you explain how histograms and bar charts are different?

<!--
Bar charts are used for categorical data, showing the count for data in each category. Histograms are used for quantitative data, showing the distribution of the data points across the range.

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
# Choosing the Right Bin Size

Suppose we want to know how long it takes for animals from the shelter to be adopted.

* Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
* Find the contract for the `histogram` function.
* Make a histogram for the `"weeks"` column in the `animals-table`, using a bin size of 10.
* How many animals took between 0 and 10 weeks to be adopted? Between 10 and 20?
---
{layout="Investigate"}
# Choosing the Right Bin Size

* Try some other bin sizes (be sure to experiment with bigger and smaller bins!)
* What shapes emerge? What bin size gives you the best picture of the distribution?
* Are there any outliers? Are they high or low?
* Count how many animals took between 0 and 5 weeks to be adopted. How many took between 5 and 10 weeks?
* What else do you Notice? What do you Wonder?

<!--
Some observations you can share with the class, to get them started:

- We see most of the histogram’s area under the two bars between 0 and 10 weeks, so we can say it was most common for an animal to be adopted in 10 weeks or less.
- We see a small amount of the histogram’s area trailing out to unusually high values, so we can say that a couple of animals took an unusually long time to be adopted: one took even more than 30 weeks.
- More than half of the animals (17 out of 31) took just 5 weeks or less to be adopted. But the few unusually long adoption times pulled the average up to 5.8 weeks. We’ll talk more about Shape of a histogram in the next lesson, and about its effect on average (the mean) in the lesson after that.
-->
---
{layout="Investigate"}
# Choosing the Right Bin Size

**How do you describe a histogram?**

If someone asked what was a typical adoption time, we could say: “Almost all of the animals were adopted in 10 weeks or less, but a couple of animals took an unusually long time to be adopted -- even more than 20 or 30 weeks!” 

It would have been hard to give this summary by reading through the table, but the histogram makes it easy to see!

See if you can match descriptions to histograms, by completing @printable-exercise{reading-histograms.adoc}

<!--

-->
---
{layout="Synthesize"}
# Choosing the Right Bin Size

- What would the histogram look like if most of the animals took more than 20 weeks to be adopted, but a couple of them were adopted in fewer than 5 weeks?
- What would the histogram look like if every animal was adopted in roughly the same length of time?
- What bin sizes worked best for analyzing `adoption`?

<!--
*Have students talk about the bin sizes they tried*. Encourage open discussion as much as possible here, so that students can make their own meaning about bin sizes before moving on to the next point.
-->
---
{layout="Synthesize"}
# Choosing the Right Bin Size

**Rule of thumb: a histogram should have between 5–10 bins.**

Histograms are a powerful way to display a dataset and assess its @vocab{shape}. Choosing the right bin size for a column has a lot to do with how data is distributed between the smallest and largest values in that column! With the right bin size, we can see the _shape_ of a quantitative column.
 
@teacher{
But how do we talk about or describe that shape, and what does the shape actually tell us? Our @lesson-link{visualizing-the-shape-of-data} lesson addresses all of these questions... and our @lesson-link{measures-of-center} lesson explores the effect of the shape of a histogram on the average (the mean).
}

---
{layout="Launch"}
# Data Exploration Project

Let’s review what we have learned about making and interpreting histograms.

- Does a histogram display categorical or quantitative data? How many columns of data does a histogram display?
- How is a histogram different from a bar chart?
- What do histograms show us about a dataset?
** Histograms allow us to see the shape of one column of dataset.
- How can you decide an appropriate bin size for your histogram?

@teacher{
- Does a histogram display categorical or quantitative data? How many columns of data does a histogram display?
** _Histograms display a single column of quantitative data._
- How is a histogram different from a bar chart?
** Because a bar chart displays categorical data, we can rearrange the bars in any order we wish. Because the quantitative data of a histogram must follow a natural order, bars cannot be rearranged.
- What do histograms show us about a dataset?
** Histograms allow us to see the shape of one column of dataset.
- How can you decide an appropriate bin size for your histogram?
** _A histogram should have 5-10 bins. We want to choose a bin size that lets us the shape of a quantitative column._
}

---
{layout="Investigate"}
# Data Exploration Project

Let’s connect what we know about histograms to your chosen dataset.

- Open your chosen dataset starter file in Pyret.
- Choose one quantitative column from your data set that you will represent with a histogram!
- What question does your display answer?
- Now, write down that question in the top section of @printable-exercise{box-plots/pages/data-cycle-quantitative.adoc}.
- Then, complete the rest of the data cycle, recording how you considered, analyzed and interpreted the question.
- Repeat this process for at least one more quantitative column.

@teacher{
- Open your chosen dataset starter file in Pyret.
** _Teachers: Students have the opportunity to choose a dataset that interests them from our @lesson-link{choosing-your-dataset/pages/datasets-and-starter-files.adoc, "List of Datasets"} in the @lesson-link{choosing-your-dataset} lesson._
- Choose one quantitative column from your data set that you will represent with a histogram!
- What question does your display answer?
** _Possible response: What is the shape of a particular quantitative column of my dataset?_
- Now, write down that question in the top section of @printable-exercise{box-plots/pages/data-cycle-quantitative.adoc}.
- Then, complete the rest of the data cycle, recording how you considered, analyzed and interpreted the question.
- Repeat this process for at least one more quantitative column.

Confirm that all students have created and understand how to interpret their histograms. Once you are confident that all students have made adequate progress, invite them to access their @starter-file{exploration-project} from Google Drive.
}

---
{layout="Investigate"}
# Data Exploration Project

- *It’s time to add to your @starter-file{exploration-project}.*
- Copy/paste at least two histograms. Be sure to also add any interesting questions that you developed while making and thinking about histograms.

@teacher{
** _You may need to help students locate the “Histogram” slide in the "Making Displays" section. They will need to duplicate the slide to add their second display. The “My Questions” section is at the end of the slide deck._
** _Note: During the next lesson, @lesson-link{visualizing-the-shape-of-data}, students will learn additional vocabulary to help them describe what they see in their histogram. They can add to their histogram interpretations at that point._
}

---
{layout="Synthesize"}
# Data Exploration Project

Share your findings with the class!

Did you discover anything surprising or interesting about your dataset?

What questions did the bar and pie charts inspire raise?

Did other students make any discoveries that were surprising or interesting to you? 

@teacher{(For instance: Did everyone find outliers? Was there more or less similarity than expected?)
}