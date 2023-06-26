---

{layout="DS Title Slide"}

# Box Plots
<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Making Box Plots

**_FACT: The Animal Shelter Bureau says the average pet weighs almost 40 pounds_**

Once we have a summary number like "mean", it's important to ask another question:

_If the average pet is 40 pounds, just **how typical** is that?_

- Maybe all the pets weigh between 35 and 45 pounds, with every pet close to the mean. 
- But maybe all the pets are super small or huge, and no one is even _near_ to the mean!

---
{layout="Launch"}
# Making Box Plots

There are differences in every class of students. Not everyone likes the same music, not everyone dresses the same, etc. 

So we'd expect some deviation - or @vocab{spread} - in any class of students! Some classes are more different than others. 

How do we measure the @vocab{spread} of a population?

<!--

-->
---
{layout="LaunchC"}
# Making Box Plots

@right{@image{images/box-n-whisker-plot.png, 250}}Suppose we lined up all animals' weights from smallest to largest, and then split them in half by taking the @vocab{median}.{style="font-size:16pt"}

We can learn something about the @vocab{spread} of the dataset by taking the _median of each half_, splitting the population into four equal-sized @vocab{quartiles}.{style="font-size:16pt"}


<!--

-->
---
{layout="LaunchC"}
# Making Box Plots

@image{images/box-n-whisker-plot.png, 250}
Since each quartile has exactly 1/4th of the animals in it, we know that the "middle half" of the animals’ weights are spread between Q1 and Q3.{style="font-size:16pt"}

The first quartile (Q1) is the value for which 25% of the animals weighed that amount or less. _What animals does the *third* quartile represent_?{style="font-size:16pt"}

<!--
_The third quartile is the value for which 75% of the animals weighed that amount or less._
_Another way of saying that would be that it is the value for which 25% of the animals weigh that amount or more._
-->

---
{layout="LaunchC"}
# Making Box Plots

@image{images/box-n-whisker-plot.png, 250}
Besides looking at the median as center, and the spread between Q1 and Q3, we also gain valuable information from the spread of the entire dataset — that is, the distance between minimum and maximum. This is called the @vocab{range of a dataset}. 

<!--
*Note*: the term “Range” means something different in statistics than it does in algebra and programming!)
-->
---
{layout="Launch"}
# Making Box Plots

Splitting a dataset into @vocab{quartiles} gives us five numbers that we can play with to measure spread. To summarize what we've seen so far:

1. **Minimum**: _the smallest value in a dataset_
2. **Q2** / **Median**: _the middle value in a dataset_
3. **Q1**: _the median that falls between the minimum and Q2_
4. **Q3**: _the median that falls between Q2 and the maximum_
5. **Maximum**: _the largest value in a dataset_


---
{layout="Launch"}
# Making Box Plots

Taken together these are called the **5 Number Summary** of a dataset, and this summary is one tool for calculating spread. We can use these numbers to calculate two new values:

- Maximum - Minimum = **Range**:  _the distance spanned by the extreme values in the dataset_
- Q3 - Q1 = **IQR**:  _the "Interquartile Range", or the distance spanned by the middle half of the data_

<!--
*Note*: the term “Range” means something different in statistics than it does in algebra and programming!)
-->
---
{layout="Investigate"}
# Making Box Plots

We can use @vocab{box plots} to visualize the 5 number summary, the Range, and the Interquartile Range. Below is the contract for `box-plot`, along with an example that will make a box plot for the `pounds` column in the `animals-table`.{style="font-size:16pt"}

```
# box-plot :: (t::Table, col::String) -> Image
# Consumes a table and the name of the column
# and produces a box plot
```
- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.{style="font-size:16pt"}
- Type this into the Interactions Area, and see the resulting plot:{style="font-size:16pt"}

@show{(code '(box-plot animals-table "pounds"))}{style="font-weight:bold"}


<!--

-->
---
{layout="InvestigateR"}
# Making Box Plots

This plot shows us the center and spread in our dataset according to those five numbers:{style="font-size:15pt"}

- **Minimum** (the left “whisker”) - the smallest value in the dataset . In our dataset, that’s just 0.1 pounds.{style="font-size:12pt"}
- **Q1** (the left edge of the box) - computed by taking the _median of the lower half of the values_. In the pounds column, that’s 3.9 pounds.{style="font-size:12pt"}
- **Q2** / Median value (the line in the middle), which is the middle Quartile of the whole dataset. We already computed this to be 11.3 pounds.{style="font-size:12pt"}
- **Q3** (the right edge of the box), which is computed by taking the _median of the upper half of the values_. That’s 60.4 pounds in our dataset.{style="font-size:12pt"}
- **Maximum** (the right “whisker”) - the largest value in the dataset . In our dataset, that’s 172 pounds.{style="font-size:12pt"}


@image{images/5-plot.png, 400}
---
{layout="Investigate"}
# Making Box Plots


* Turn to @printable-exercise{measures-of-center/pages/summarizing-columns-in-animals.adoc}
* Fill in the five-number summary for the `pounds` column, and sketch the box plot.
* What conclusions can you draw about the distribution of values in the `pounds` column?


<!--
_While the animals' weights range from 0.1 pounds to 172 pounds, 50% of the animals weigh 11.3 pounds or less. The animal that weighs 172 pounds may be an outlier._
-->
---
{layout="Synthesize"}
# Making Box Plots

- What percentage of points fall in the first quartile?
- What percentage of points fall in the second quartile?
- What percentage of points fall in the third quartile?
- What percentage of points fall in the fourth quartile?
- What percentage of points fall in the **Interquartile Range** (IQR)?
- What percentage of points fall within the Range?

<!--
- It is extremely common for students to forget that every quartile _always_ includes 25% of the dataset. This will need to be heavily reinforced.
- What percentage of points fall in the **Interquartile Range** (IQR)? _50%_
- What percentage of points fall within the Range? _100%_
-->

---
{layout="Launch"}
# Interpreting Box Plots

Just as pie and bar charts are ways of visualizing categorical data, **box plots and histograms are ways of visualizing the shape of quantitative data.** 

Box plots make it easy to see the 5-number summary, and compare the Range and Interquartile Range. 

Histograms make it easier to see skewness and more details of the shape, offering more granularity when using smaller bins.

<!--

-->
---
{layout="Investigate"}
# Interpreting Box Plots

In a histogram, left-skewness is seen as a long, left-facing tail.  

In a box plot, **left skewness** is seen as a longer left "whisker", or more spread in the left part of the box. 

Likewise, **right skewness** is shown as a longer right "whisker" or more spread in the right part of the box.

---
{layout="Launch"}
# Interpreting Box Plots

@table{3, header}
|               | Intervals | Points-per-Interval
| **Box Plots** | Variable  | Fixed
| **Histograms**| Fixed     | Variable

Box plots and Histograms can both tell us a lot about the shape of a dataset, but they do so by grouping data quite differently: 

<!--
*Histograms:* fixed intervals (“bins”) with variable numbers of data points in each one. Points “pile up in bins”, so we can see how many are in each. _Larger bars show where the clusters are._

*Box plots:* variable intervals (“quartiles”) with a fixed number of data points in each one. Treats data more like “pizza dough”, dividing it into four equal quarters showing where the data is tightly clumped or spread thin. _Smaller intervals show where the clusters are._
-->

---
{layout="Investigate-K"}
# Interpreting Box Plots

1. Each group of three should have a ruler and a ball of playdough.{style="font-size:14pt"} 
2. Draw a number line from 0-6 with the ruler, marking off the points at 0, 3, 4, 4.5 and 6 inches.{style="font-size:14pt"} 
3. Roll the dough into a thick cylinder.{style="font-size:14pt"} 
4. Divide that cylinder in half, and then split each half to form four __equally-sized cylinders__.{style="font-size:14pt"}  

_The playdough represents a @vocab{sample}, with values divided into four @vocab{quartiles}. Box plots stretch and squeeze these equal quartiles across a number line, so that each quartile fills up an interval in that quartile._{style="font-size:14pt"}  

5. On your number line, you have intervals from 0-3, 3-4, 4-4.5, and 4.5-6. {style="font-size:14pt"} 
6. Roll your cylinders so that they fill each of these intervals, retaining a uniform thickness.{style="font-size:14pt"} 

<!--
Notice that shorter intervals have __thicker cylinders__, and longer ones have skinny ones. Even though a box plot doesn't show us the thickness of the data points, we can tell that a small intervals has the same amount of data "squeezed" into it as a large interval.
-->

---
{layout="Investigate"}
# Interpreting Box Plots

- Complete @printable-exercise{pages/identifying-shape-boxplots.adoc} and see if you can describe box plots using what you know about skewness.
- To make connections between histograms and box plots, complete @printable-exercise{pages/matching-boxplots-to-histograms.adoc}

<!--

-->
---
{layout="Synthesize"}
# Synthesize

Histograms, box plots, and measures of center and spread are all different ways to get at the @vocab{shape} of our data. It's important to get comfortable using every tool in the toolbox when discussing shape!

We started talking about measures of center with a single question: __is "average" the right measure to use when talking about animals' weights?__ Now that we've explored the spread of the dataset, do you agree or disagree that average is the right summary?
<!--

-->
---
{layout="Launch"}
# Your Own Analysis 

**What are the quantitative columns in _your_ dataset? How are they distributed?**

Are all the values pretty close together, or really spread out?

Are they clumped on the right, with a few outliers skewing to the left? Or are they clumped on the left, with a few outliers skewing to the right?

---
{layout="Investigate"}
# Your Own Analysis 

- How are quantitative columns in your dataset distributed? Complete
@printable-exercise{data-cycle-quantitative.adoc}, and **explore two quantitative columns with box plots**.
- Then add these displays - and your interpretations! - to "Making Displays" section.
- Do these displays bring up any interesting questions? If so, add them to the end of the document.
- Complete @printable-exercise{shape-of-my-dataset.adoc}, and **explain the connection between measures of center and your box plots**. - Complete the "Measures of Center and Spread" section of the @starter-file{exploration-paper}.
---
{layout="Synthesize"}
# Your Own Analysis 

- Were any of them surprising?
- What, if any, outliers did you discover when making box plots?
- What measures of center make the most sense for one column or another?

---
{layout="Supplemental"}
# Additional Practice

- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/601c35a8e9fd103e94acee2b, Card Sort: What Information does the Box & Whisker Plot tell us?}
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fe89eeaaef67d0cea85ba5e, "Matching Vocabulary to Definitions"}
- @opt-project{stress-project.html, rubric-stress-or-chill.adoc} 
<!--

-->
