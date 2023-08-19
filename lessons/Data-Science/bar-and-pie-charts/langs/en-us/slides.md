---
{layout="DS Title Slide"}
# Bar & Pie Charts

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Grouping by Value

Open the @starter-file{animals} and click "Run".

- What do we need to type to see the animals table?
- How many dogs are there? How many rabbits?

---
{layout="Investigate"}
# Grouping by Value

Turn to @printable-exercise{count-bar-pie.adoc}, and complete the first section ("Making Bar and Pie Charts").

@teacher{
** __The height of each bar matches the count of each species.__
- How does this pie chart compare to the bar chart you just made?
** __The wedges show percentages, whereas the bar chart was labeled with the count. We could figure out how many animals were in the sample from the bar chart. With the pie chart we see how the categories compare to each other, but we have no way of knowing how many animals each wedge represents.__
}

---
{layout="Investigate"}
# Grouping by Value

Both `bar-chart` and `count` *group the data in one column by value*, creating "buckets" for each unique value and counting the number of rows in each bucket, one uses a picture and one uses a table.

@image{images/count-table.png, 160} @image{images/bar-chart-popout.png, 385} 

---
{layout="Investigate"}
# Grouping by Value

Hovering over a bar reveals the label, as well as the number of animals in that species. We can also resize the window by dragging its borders. This allows us to experiment with the data before closing the window and generating the final, non-interactive image.

**Bar charts group data _by value_ to show frequency as a count.**

---
{layout="InvestigateR"}
# Grouping by Value

@right{@image{images/pie-species-popout.png, 275}} Pie charts show us the @vocab{percentage} of the data points that fall in each category. Hovering over a pie slice reveals the label, as well as the count and the percentage of the whole. In this example we see that there is 1 animal that is a snail, representing 3.1% of the population.

**Pie charts group data _by value_ to show frequency as a percentage.**

---
{layout="Investigate"}
# Grouping by Value

If our data is based on sample data from a larger population, we can use these charts to _infer_ the proportion of a whole population that might belong to each category. For example, the distribution of species in our shelter might help us make guesses about the distribution of species in other shelters.

While bars in some bar charts should follow some logical order (alphabetical, small-medium-large, etc), the pie slices and bars can really be placed in _any_ order, without changing the meaning of the chart.

---
{layout="Investigate"}
# Grouping by Value

- Turn to @printable-exercise{bar-and-pie-notice.adoc} and take two minutes to notice and wonder about the displays.
- Then complete @printable-exercise{matching-bar-to-pie.adoc}.
- Return to @printable-exercise{count-bar-pie.adoc}, and complete the second section ("Comparing Bar and Pie Charts").

@teacher{
- Why isn't it useful to group the `pounds` column using these functions?
** _Grouping by value works well for @vocab{categorical data}, when lots of different data points can be sorted into a smaller number of buckets. But for @vocab{quantitative data} - which can have lots of different values - the number of buckets is too large to be useful._
- Look at the list of columns in the Definitions Area. For which columns do you expect pie charts to be most useful?
** _Species, Sex, Fixed, and Legs_ 
}
---
{layout="Synthesize"}
# Grouping by Value

- What did you Notice? What did you Wonder?
- How is `pie-chart` similar to `bar-chart`? How is it different?
- When would you want to use one chart instead of another?
- What strategies did you use to match the bar charts to the pie charts?
- Which displays do you find it easier to interpret? Why?
- What information is provided in bar charts that is hidden in pie charts?
- Why might this sometimes be problematic?

@teacher{
- What did you Notice? What did you Wonder? +
_Answers will vary, but here are some important points:_
** _One of the pie charts has more categories for race than the other and the bar charts have more categories for race than we see om either of the pie charts._ 
** _In a pie chart, when there isn't any data in a category it goes unrepresented, but in a bar chart its absence is made visible._
** _The scale is different for each bar chart, whereas for pie charts the percentages will always add to 100%._
- How is `pie-chart` similar to `bar-chart`? How is it different?
- When would you want to use one chart instead of another?
- What strategies did you use to match the bar charts to the pie charts?
- Which displays do you find it easier to interpret? Why?
- What information is provided in bar charts that is hidden in pie charts?
** _In a bar chart, every category is visible and those with no values are missing a bar. Categories containing 0% of the data aren't represented on a pie chart._
- Why might this sometimes be problematic?
** _Sample Answer: If a service isn't reaching a sector of the population, it's easier to ignore the issue if that population doesn't get represented in the display._
}

---
{layout="Launch"}
# Groups and Subgroups

- Take a moment to answer the following questions: How many cats are male? How many cats are female?
- Do you think there are about as many male dogs as female dogs?
- Do you think this distribution is similar for every species at the shelter?

Comparing groups is great, but sometimes we want to compare __sub-groups across groups__. In this example, we want to compare the distribution of sexes across each species.

@teacher{
- Take a moment to answer the following questions: How many cats are male? How many cats are female?
** __5 are male, 6 are female__	
}

---
{layout="Launch"}
# Groups and Subgroups

Fortunately, Pyret has two functions that let us specify both a group and a subgroup:

@show{(contract 'stacked-bar-chart '((t Table) (group String) (subgroup String)) "Image")}{style="font-size: 12pt"}

@show{(contract 'multi-bar-chart '((t Table) (group String) (subgroup String)) "Image")}{style="font-size: 12pt"}

- Try using both of these functions to show the distribution of sexes across species in our shelter.
- Which display do you think is easier to read?

---
{layout="InvestigateR"}
# Groups and Subgroups

Complete @printable-exercise{stacked-and-multi-notice.adoc}

On a stacked bar chart, we can easily to compare _groups_, but it is more difficult to compare subgroups.

@right{@image{images/stacked-species-sex.png, 300}} Stacked bar charts put the totals side by side, so it's easy to answer whether there are more dogs than cats in the shelter. But it's a little more difficult to see whether there are more male dogs than female dogs, because the bars are _on top of one another._{style="font-size:16pt"}

---
{layout="InvestigateR"}
# Groups and Subgroups

On a multi bar chart, we can easily compare _subgroups_, but it is more difficult to compare groups.

@right{@image{images/multi-species-sex.png, 300}} Multi bar charts put the subgroups side by side, so it's easy to answer whether there are more male dogs than female dogs in the shelter. But it's a little more difficult to see whether there are more dogs than cats, because there aren't any bars showing the totals.{style="font-size:16pt"}

---
{layout="Investigate"}
# Groups and Subgroups

Complete @printable-exercise{matching-stacked-to-multi.adoc}

---
{layout="Synthesize"}
# Groups and Subgroups

All of the charts we've looked at in this lesson work with @vocab{categorical data}, showing us the frequency of values in one or two groups.

- What kinds of questions need stacked or multi bar charts, rather than pie or bar charts?
- What kinds of questions are better answered by stacked bar charts?
- What kinds of questions are better answered by multi bar charts?

---
{layout="Supplemental"}
# Additional Exercises

- @opt-printable-exercise{bar-chart-notice.adoc}
- @opt-printable-exercise{pie-chart-notice.adoc}
- If you are looking to offer your students more practice making and interpreting these chart types in Pyret, we have a second teaching dataset on @opt-starter-file{food} for you to work with!