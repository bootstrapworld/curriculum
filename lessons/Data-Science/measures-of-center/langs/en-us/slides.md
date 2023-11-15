@slidebreak
{layout="DS Title Slide"}
# Measures of Center

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch"}
# Mean

**According to the Animal Shelter Bureau, the average pet weighs almost 40 pounds.**

Some medicines are dosed by weight: heavier animals need a larger dose that could be dangerous for smaller animals. 

If someone from the shelter needs to give a dose of medicine to the animals, **is the “average” the best estimate we can use**?

<!--

-->
@slidebreak
{layout="Launch"}
# Mean

“The average pet weighs almost 40 pounds” is a statement about the entire dataset, which summarizes a whole column of values with a single number. 

Summarizing a big dataset means that some information gets lost, so it’s important to pick an appropriate summary. Picking the wrong summary can have serious implications! 

<!--

-->
@slidebreak
{layout="Launch"}
# Mean

- Students are sometimes summarized by two numbers -- their GPA and SAT scores -- which can impact where they go to college or how much financial aid they get.{style="font-size:14pt"}
- Schools are sometimes summarized by a few numbers -- student pass rates and attendance, for example -- which can determine whether or not a school gets funding.{style="font-size:14pt"}
- Adults are often summarized by a single number -- like their credit score -- which determines their ability to get a job or a home loan.{style="font-size:14pt"}
- When buying uniforms for a sports team, a coach might look for the most common size that the players wear.{style="font-size:14pt"}

_Can you think of other examples where someone uses a number or two to summarize something complex?_

<!--
Every kind of summary has situations in which it does a good job of reporting what’s typical, and others where it doesn’t really do justice to the data. In fact, the shape of the data can play a huge role in whether or not one kind of summary is appropriate!
-->
@slidebreak
{layout="Launch"}
# Mean

One of the ways that Data Scientists summarize quantitative data is by talking about its _center_ - literally asking "what is a typical value in this sample?", in the hopes of inferring something about a larger population.

**But there are many different ways to define "center", and each method has strengths and weaknesses.**

<!--

-->
{layout="Investigate-K"}
# Mean

The arithmetic mean is the number that "balances" all the other numbers in the sample. So let's do some real balancing!{style="font-size:14pt"}

_Each group of three will need a ruler, 4-8 pennies, and at least one pen or pencil._{style="font-size:14pt"}

1. The ruler represents a number line with values (weight) distributed equally across the line. If there's values at every inch from 0 to 12, where should the pencil be placed in order to balance the ruler on top of it?{style="font-size:14pt"}
2. Place a penny at 1 and 11. Where must the pencil be placed to balance those two values? What is the mean of the values [1, 11]?{style="font-size:14pt"}
3. Place pennies at 1, 9 and 11. Where must the pencil be placed to balance those two values? What is the mean of of the values [1, 9, 11]?{style="font-size:14pt"}
4. Suppose you were to place two pennies at 2, and a third penny at 8. Can you _predict_ where the pencil should be placed?{style="font-size:14pt"}

@slidebreak
{layout="InvestigateC"}
# Mean

- If we plotted all the pounds values as points on a number line, what could we say about the **average** of those values? 
- Is there a **midpoint**? 
- Is there a point that shows up **most often**? Each of these are different ways of “measuring center”.

<!--

-->

@slidebreak
{layout="Investigate"}
# Mean

The mean of a dataset is the sum of values divided by the number of values. To take the average of a column, we add all the numbers in that column and divide by the number of rows.

@ifproglang{pyret}{Pyret}@ifproglang{codap}{CODAP} has a way for us to compute the mean of any @vocab{quantitative} column in a Table. It consumes a Table and the name of the column you want to measure, and produces the mean -- or average -- of the numbers in that column.

@ifproglang{pyret}{
@show{ (contract "mean" '("Table" "String") "Number" )}

What is the function's name? Domain? Range?
}

<!--
Notice that calculating the mean requires being able to add and divide, so the mean only makes sense for quantitative data. For example, the mean of a list of Presidents doesn’t make sense. Same thing for a list of zip codes: even though we can divide a sum of zip codes, the output doesn’t correspond to some “center” zip code.
-->

@slidebreak
{layout="Investigate"}
# Mean
- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.

@ifproglang{pyret}{
- Type `mean(animals-table, "pounds")`. What does this give us?}
@ifproglang{codap}{
- Let's find the mean of the animals' weights. Create a new graph with its points randomly positioned. Drag `Pounds` to the x-axis. From the `Measure` menu, select `Mean`. Hover your cursor over the blue line. What is the mean?}
- Does this support the Bureau’s claims?
- Now, turn to @printable-exercise{summarizing-columns-in-animals.adoc}. In the “measures of center” section, fill in the computed mean.

<!--
The mean is 39.715625. This does not support the Bureau's claims, because the mean is less than 40 pounds.
-->



@slidebreak
{layout="Synthesize"}
# Median

- Three animals weighing 5, 5, 10, and 100 pounds will have an average mean of 30 pounds. Can you think of another set of four animals that would have the same average? How many sets can you come up with?
- If you heard that the mean age of students in a kindergarten class was 21, would you be surprised? Why or why not?


@slidebreak
{layout="Launch"}
# Median

You computed the mean of that column to be almost exactly 40 pounds, but if we look at the dataset we'll quickly see that most of the animals weigh less than 40 pounds! 

In fact, more than half of the animals weigh less than _15 pounds_. What is throwing off the average so much?

<!--

-->

@slidebreak
{layout="Launch"}
# Median

_Kujo and Mr. Peanutbutter!_

In this case, the mean is being thrown off by a few extreme data points. These extreme points are called @vocab{outliers}, because they fall far outside of the rest of the dataset. 

Calculating the mean is great when all the points are fairly balanced on either side of the middle, but it distorts things for datasets with extreme outliers. 

The mean may also be thrown off by the presence of @vocab{skewness}: a lopsided shape due to values trailing off to the left or right.
<!--

-->

@slidebreak
{layout="Launch"}
# Median

Make a `histogram` of the `pounds` column, and try different bin sizes. Can you see the huge number of animals clumped to the left, with Kujo and Mr. Peanutbutter as outliers skewed to the right? 

A different way to measure center is to line up all of the data points -- in order -- and find a point in the center where half of the values are smaller and the other half are larger. This is the @vocab{median}, or “middle” value of a list.

<!--

-->

@slidebreak
{layout="Launch"}
# Median

Consider this list of ACT scores:

`25, 26, 28, 28, 28, 29, 29, 30, 30, 31, 32`

Here 29 is the median, because it separates the "bottom half” (5 values below it) from the top half” (5 values above it).

The algorithm for finding the median of a quantitative column is:

1. Sort the numbers{style="font-size:16pt"}
2. Cross out the highest and lowest numbers{style="font-size:16pt"}
3. Repeat until there is only one number left. If there are two numbers left at the end, take the _mean_ of those numbers{style="font-size:16pt"}
<!--

-->
@slidebreak
{layout="Investigate"}
# Median


@QandA{
@ifproglang{pyret}{
@Q{Pyret has a function to compute the median of a list as well. Find the Contract for `median` on the @dist-link{Contracts.shtml, Contracts Page}. @pathway-only{ _If you're working with a printed workbook, the contracts pages are included in the back._}}
@Q{Compute the median for the `pounds` column in the Animals Dataset, and add this to @printable-exercise{summarizing-columns-in-animals.adoc}.}
@A{The median is 11.3.}}



@ifproglang{codap}{
@Q{We can use CODAP to compute the median of a list as well. On the same graph that you created to find mean, go to the `Measure` menu and select `Median`. What value do you get when you hover over the red line that appears?}
@A{The median is 11.3.}}

@Q{Is it different than the mean?}
@A{Yes, it is very different!}

@Q{What can we conclude when the mean is so much greater than the median?}
@A{There are some very heavy animals that are causing the mean to be higher.}

@Q{For practice, compute the mean and median for the weeks and age columns.}
@A{Weeks: mean - 5.75; median - 4. Age: mean - 4.359375; median - 3.}}


@slidebreak
{layout="Synthesize"}
# Median

By looking at the histogram, we can see whether it's probably better to use the mean or median.

* Strong left skewness and/or low outliers can pull the mean down below the median.
* Right skewness and/or high outliers can pull the mean above the median. 

Mean is generally the best measure of center, because it includes information from every single point. But it's misleading for highly-skewed datasets, so statisticians fall back to the median.

@slidebreak
{layout="Launch"}
# Modes

The third measure of center is called the @vocab{modes} of a dataset. The @vocab{modes} of a dataset are the values that appear _most often_. 

Median and Mean always produce one number, but if two or more values are equally common, there can be more than one mode. If all values are equally common, then there is no mode at all! 

@slidebreak
{layout="Launch"}
# Modes

 Consider the following three datasets:
```
  1, 2, 3, 4
  1, 2, 2, 3, 4
  1, 1, 2, 3, 4, 4
```

- The first dataset has no mode at all!{style="font-size:14pt"}
- The mode of the second dataset is 2, since 2 appears more than any other number.{style="font-size:14pt"}
- The modes (plural!) of the last dataset are 1 and 4, because 1 and 4 both appear more often than any other element, and because they appear equally often.{style="font-size:14pt"}
@slidebreak
{layout="Launch"}
# Modes


@ifproglang{pyret}{
In Pyret, the modes are calculated by the modes function, which consumes a Table and the name of the column you want to measure, and produces a _List_ of Numbers.

@show{ (contract "modes" '("Table" "String") "List<Number>" )}}

@ifproglang{codap}{
The easiest way to determine modes in CODAP is to sort a column. Do this by clicking on the column name and then selecting either Sort option from the drop-down menu. Scan the column to see which values are the most common.}

@slidebreak
{layout="Investigate"}
# Modes

Compute the `modes` of the `pounds` column, and add it to @printable-exercise{pages/summarizing-columns-in-animals.adoc}. What did you get?

<!--
** _0.1 and 6.5_
-->  
@slidebreak
{layout="Synthesize"}
# Modes

The most common animal weights are 0.1 and 6.5! These are well below our mean and even our median, which is further evidence of outliers or skewness.

At this point, we have a lot of evidence that suggests the Bureau’s use of “mean” to summarize animal weights isn’t ideal.

@slidebreak
{layout="Synthesize"}
# Modes

We have three reasons to suspect that @vocab{mean} isn’t the best value to use:

- The median is only 11.3 pounds.
- The modes of our dataset are only 0.1 and 6.5 pounds, which suggests clusters of animals that weigh mere fractions of the mean.
- When viewed as a histogram, we can see the right skewness and high outliers in the dataset. Mean is sensitive to datasets with skewness and/or outliers.
@slidebreak
{layout="Synthesize"}
# Modes

**“In 2003, the average American family earned $43,000 a year -- well above the poverty line! Therefore very few Americans were living in poverty."**

Do you trust this statement? Why or why not? 

Consider how many policies or laws are informed by statistics like this! 

Knowing about measures of center helps us see through misleading statements.

@slidebreak
{layout="Synthesize"}
# Modes

When should each measure of center be used?

- If the data doesn’t show much skewness or have outliers, @vocab{mean} is the best summary because it incorporates information from every value.
- If the data has noticeable outliers or skewness, @vocab{median} gives a better summary of center than the mean.
- If there are very few possible values, such as AP Scores (1–5), the @vocab{mode} could be a useful way to summarize the dataset.

@teacher{
@optional We strongly recommend having students practice the Data Cycle with measures of center, using @opt-printable-exercise{pages/data-cycle-practice.adoc}. Sometimes what's created isn't a table _or_ a display, and this activity demonstrates that. It also drives home an important difference between Arithmetic and Statistical Questions.
}

@slidebreak
{layout="Launch"}
# Data Exploration Project (Measures of Center){style="font-size:27pt"}

Let’s review what we have learned about computing and interpreting three measures of center - mean, median, and modes.

- Describe how to compute mean, median, and modes.
- When @vocab{mean} provide the best summary?
- When does @vocab{median} provide the best summary?
- When are @vocab{mode}(s) a useful way to summarize a dataset?

@teacher{
- Describe how to compute mean, median, and modes.
- When @vocab{mean} provide the best summary?
** _It includes information from every single point, so it is useful when the data doesn't show much skewness or have outliers._
- When does @vocab{median} provide the best summary?
** _Statisticians fall back to the median when working with highly skewed datasets._
- When are @vocab{mode}(s) a useful way to summarize a dataset?
** _Mode(s) are most useful when a dataset has very few values._  
}

@slidebreak
{layout="Investigate"}
# Data Exploration Project (Measures of Center){style="font-size:27pt"}

Let’s connect what we know about measures of center to your chosen dataset.

- Open your chosen dataset starter file in Pyret.
- Choose two quantitative columns that you'd like to analyze.
- Use Pyret to compute the mean, median and modes of one of them.
- *It’s time to add to your @starter-file{exploration-project}.*
- Locate the "Measures of Center and Spread" section of your Exploration Project and, in the slide following the example, replace `Column A` with the title of the column you just investigated.

@slidebreak
{layout="Investigate"}
# Data Exploration Project (Measures of Center){style="font-size:27pt"}

- Then type in the mean, median and modes that you just identified. Leave the other rows blank. We will come back to them another day.
- On the next slide, repeat with `Column B` using the second column you're interested in.

@teacher{
** _Teachers: Students have the opportunity to choose a dataset that interests them from our @lesson-link{choosing-your-dataset/pages/datasets-and-starter-files.adoc, "List of Datasets"} in the @lesson-link{choosing-your-dataset} lesson._

Invite students to discuss their results and consider how to interpret them.}

@slidebreak
{layout="Investigate"}
# Data Exploration Project (Measures of Center){style="font-size:27pt"}

Once you've discussed your results and how to interpret them, add your interpretations to the two "Measures of Center and Spread" slides and record any questions that emerged in the "My Questions" section at the end of the slide deck.

@slidebreak
{layout="Synthesize"}
# Data Exploration Project (Measures of Center)

Share your findings!

Did you discover anything surprising or interesting about your dataset?

Which measures of center do you think were the most useful for their two chosen quantitative columns?

What questions did the measures of center inspire you to ask about their dataset?

When you compared their findings with other students, did they make any interesting discoveries?

@teacher{
(For instance: Did everyone find mode(s)? Did anyone have a measure of center that was dramatically influenced by an outlier?)
}

@slidebreak
{layout="Supplemental"}
# Additional Activities

- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fca8f6a3d4e1f382a33f56e, Mode(s)}
- @opt-printable-exercise{pages/critiquing-findings.adoc}
- @opt-printable-exercise{pages/data-cycle-practice.adoc}

