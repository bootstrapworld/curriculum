---
{layout="DS Title Slide"}
# Bar & Pie Charts

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Grouping by Value

- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
- Where have you seen infographics and graphs used to display data in the real world?

<!--
Solicit student ideas for infographics, and/or provide some of your own
-->
---
{layout="Launch"}
# Grouping by Value

- In the Interactions Area, type @show{(code '(count animals-table "species"))} and hit "Enter". What happens?
- Now type @show{(code '(bar-chart animals-table "species"))} and hit "Enter". What happens?
- What does each bar represent?
- What does this have to do with our `count` table?


<!--
1. __A table appears, with rows each species of animal, with a count of how many animals are in each species.__
2. __A bar chart appears.__
3. __The number of animals belonging to each specific species.__
4. __The height of each bar matches the count of each species.__

-->
---
{layout="Launch"}
# Grouping by Value

- Now type @show{(code '(count animals-table "pounds"))} and hit "Enter". What happens?
- Now type @show{(code '(bar-chart animals-table "pounds"))} and hit "Enter". What happens?
- What does each bar represent?


<!--
1. __A table appears, with rows showing each weight and how many animals have that weight.__
2. __A bar chart appears, with many equally-sized bars.__
3. __The number of animals having each specific weight.__

-->
---
{layout="LaunchR"}
# Grouping by Value

@image{images/bar-species.png, 300}

**Bar charts group data _by value_ to show frequency**

Hovering over a bar reveals the label, as well as the number of animals in that species. 

We can also resize the window by dragging its borders. This allows us to experiment with the data before closing the window and generating the final, non-interactive image.

<!--

-->
---
{layout="LaunchR"}
# Grouping by Value

@image{images/bar-species.png, 300}

Both `bar-chart` and `count` *group the data in one column by value*, creating "buckets" for each unique value and counting the number of rows in each bucket. Both functions show us the same information as the `count` function, but using a picture instead of a table.

**Which do you like better: the chart or a table? Why?**

<!--

-->
---
{layout="Investigate"}
# Grouping by Value

Here is the @vocab{Contract} for another function, which makes @vocab{pie charts}:

@show{(contract "pie-chart" '("Table" "String") "Image" )}

Now type @show{(code '(pie-chart animals-table "species"))} and hit "Enter". What happens?

<!--

-->

---
{layout="InvestigateR"}
# Pie and Bar Charts

@right{@image{images/pie-species.png, 300}} 

Hovering over a pie slice reveals the label, as well as the count and the @vocab{percentage} of the whole. In this example we see that there are 2 animals that are lizards, representing 6.3% of the population.

<!--

-->
---
{layout="Investigate"}
# Grouping by Value

- Use `pie-chart` to make a display showing how many animals there from each sex.
- Use `pie-chart` to make a display for the `pounds` column. How is this similar to `bar-chart`? How is it different?
- Why weren't these functions useful when grouping the `pounds` column?
- How is this similar to `bar-chart`? How is it different?
- When would you want to use one chart instead of another?

<!--

-->
---
{layout="Investigate"}
# Grouping by Value

Grouping by value works well for @vocab{categorical data}, when there lots of different data points can be sorted into a smaller number of buckets. But for @vocab{quantitative data} - which can have lots of different values - the number of buckets is too large to be useful.

---
{layout="Investigate"}
# Grouping by Value

Complete @printable-exercise{bar-and-pie-notice.adoc}, and @printable-exercise{matching-bar-to-pie.adoc}.

Optional: To dig deeper into each individual chart, @opt-printable-exercise{pie-chart-notice.adoc} or @opt-printable-exercise{bar-chart-notice.adoc}.

<!--
Common Misconceptions

* Pie charts and bar charts can show _counts_ or _percentages_ of categorical data. If there are more people with brown hair than blond hair, for example, a pie chart of hair color will have a larger slice or longer bar for "brown" than for "blond". In Pyret, pie charts show percentages, and bar charts show counts.
* A pie chart can only display one categorical variable, but a bar chart might be used to display two or more. Pie charts have a wedge for each represented category. Unlike in bar charts, empty categories will not be included in a pie chart. When comparing bar charts, it is important to read the scales on the y-axes. If the scales do not match, a taller bar may not represent a larger value.
* Bar charts look a lot like another kind of chart - called a "histogram" - which are actually quite different because they display _quantitative_ data, not categorical. This lesson focuses entirely on pie- and bar charts.
-->
---
{layout="Synthesize"}
# Grouping by Value

* What strategies did you use to match the bar charts to the pie charts?
* Which displays do you find it easier to interpret? Why?
* What information is provided in bar charts that is hidden in pie charts?

<!--
Answer to last question" _In a bar chart, categories with no values are shown as empty categories, but there are no wedges for categories with 0% on a pie chart._
-->
---
{layout="Synthesize"}
# Grouping by Value

As with the `count` functions, pie and bar charts *group data by value*, sorting it into buckets to show the frequency of each value. 

If our data is based on sample data from a larger population, we can use these charts to _infer_ the proportion of a whole population that might belong to each category. 

For example, the distribution of species in our shelter might help us make guesses about the distribution of species in other shelters.

---
{layout="Synthesize"}
# Grouping by Value

While bars in some bar charts should follow some logical order (alphabetical, small-medium-large, etc), the pie slices and bars can really be placed in _any_ order, without changing the meaning of the chart.

---
{layout="Launch"}
# Groups and Subgroups 

- Take a moment to answer the following questions: How many cats are male? How many cats are female?
- Do you think there are about as many male dogs as female dogs?
- Do you think this distribution is similar for every species at the shelter?


<!--

-->
---
{layout="Launch"}
# Groups and Subgroups 

Comparing groups is great, but sometimes we want to compare __sub-groups across groups__. 

In this example, we want to compare the distribution of sexes across each species.

<!--

-->

---
{layout="Launch"}
# Groups and Subgroups 

Fortunately, Pyret has two functions that let us specify both a group and a subgroup:

@show{(contract "stacked-bar-chart" '("Table" "String" "String") "Image" )}{style="font-size:17pt"}

@show{(contract "multi-bar-chart" '("Table" "String" "String") "Image" )}{style="font-size:17pt"}

- Try using both of these functions to show the distribution of sexes across species in our shelter.
- Which display do you think is easier to read?

Complete @printable-exercise{stacked-and-multi-notice.adoc}

<!--
-->
---
{layout="Investigate"}
# Groups and Subgroups 

**Stacked bar charts make it easier to compare _groups_ than subgroups**

* What displays did you find that work with just one column of data?
* What displays did you find that work with more than one column of data?
* What displays did you find that work with _categorical_ data?
* What displays did you find that work with _quantitative_ data?

<!--
-->
---
{layout="InvestigateR"}
# Groups and Subgroups 

@right{@image{images/stacked-species-sex.png, 300}} Stacked bar charts put the totals side-by-side, so it's easy to answer whether there are more dogs than cats in the shelter. But it's a little more difficult to see whether there are more male dogs than female dogs, because the bars are _on top of one another._

---
{layout="InvestigateR"}
# Groups and Subgroups 

@right{@image{images/multi-species-sex.png, 300}} 

**Multi bar charts make it easy to compare _subgroups_ than groups**

Multi bar charts put the subgroups side-by-side, so it's easy to answer whether there are more male dogs than female dogs in the shelter. But it's a little more difficult to see whether there are more dogs than cats, because there aren't any bars showing the totals.

- Complete @printable-exercise{matching-stacked-to-multi.adoc}

---
{layout="Synthesize"}
# Groups and Subgroups 

All of the charts we've looked at in this lesson work with @vocab{categorical data}, showing us the frequency of values in one or two groups.

- What kinds of questions need stacked or multi bar charts, rather than pie or bar charts?
- What kinds of questions are better answered by stacked bar charts?
- What kinds of questions are better answered by multi bar charts?

---
{layout="Supplemental"}

# Additional Exercises:

- @opt-printable-exercise{bar-chart-notice.adoc}
- @opt-printable-exercise{pie-chart-notice.adoc}
- @opt-project{infographic.adoc, rubric-infographic.adoc}
