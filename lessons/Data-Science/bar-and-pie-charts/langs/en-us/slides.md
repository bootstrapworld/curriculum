---
{layout="DS Title Slide"}
# Bar & Pie Charts

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Pie and Bar Charts

- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
- Where have you seen infographics and graphs used to display data in the real world?

<!--
Solicit student ideas for infographics, and/or provide some of your own
-->
---
{layout="LaunchR"}
# Pie and Bar Charts

@left{@image{images/legsp.png, 300}}

Here is the @vocab{Contract} for a function that makes @vocab{pie charts}:

@show{(contract "pie-chart" '("Table" "String") "Image" )}

And here is an example of _using_ the function:

@show{(code '(pie-chart animals-table "legs"))}

<!--

-->
---
{layout="Launch"}
# Pie and Bar Charts

@show{(code '(pie-chart animals-table "legs"))}

- What is the Name of this function?
- How many inputs are in its @vocab{Domain}?
- In the Interactions Area, type @show{(code '(pie-chart animals-table "legs"))} and hit "Enter". What happens?

<!--

-->
---
{layout="LaunchR"}
# Pie and Bar Charts

@left{@image{images/legsp.png,300}}

Hovering over a pie slice reveals the label, as well as the count and the percentage of the whole. In this example we see that there is 1 animal with 0 legs, representing 3.1% of the population.

We can also resize the window by dragging its borders. This allows us to experiment with the data before closing the window and generating the final, non-interactive image.

<!--

-->
---
{layout="Launch"}
# Pie and Bar Charts

`pie-chart` consumes a Table of data, along with the _name of a *categorical* column you want to display_. The computer counts the number of times that each value appears.

Then it draws a slice for each value, with the size being the percentage of cells with that value.

This pie chart shows the distribution of the number of `legs` across the shelter.

Can you make a pie chart for the `sex` column?

<!--
When students make a display of the `sex` of the animals, they will see that some animals are male, some are female and some are hermaphrodites. We use the descriptor _sex_ rather than _gender_ because sex refers to biology, whereas gender refers to identity. Hermaphrodite is the biological term for animals that carry eggs & produce sperm (nearly 1/3 of the non-insect animal species on the planet!). Plants that produce pollen & ovules are also hermaphrodites. While the term was previously used by the medical community to describe intersex people or people who identify as transgender or gender non-binary, it is not biologically accurate. Humans are not able to produce both viable eggs and sperm, so "hermaphrodite" is no longer considered an acceptable term to apply to people.

-->

---
{layout="Investigate-DN"}
# Pie and Bar Charts

Here is the @vocab{Contract} for another function, which makes @vocab{bar charts}:

@show{(contract "bar-chart" '("Table" "String") "Image" )}

- Which column of the animals table tells us which species the animal is?
- Use `bar-chart` to make a display showing how many animals there are of each species.

<!--

-->
---
{layout="Investigate"}
# Pie and Bar Charts

- Experiment with pie and bar charts, passing in different column names. If you get an error message, _read it carefully!_
- What do you think are the rules for what kinds of columns can be used by _bar-chart_ and _pie-chart_?
- When would you want to use one chart instead of another?
- Complete @printable-exercise{matching-bar-to-pie.adoc}.



<!--
Optional: To dig deeper into pie charts and bar charts, have students complete @opt-printable-exercise{bar-and-pie-notice.adoc}. They can also focus on one display at a time using @opt-printable-exercise{pie-chart-notice.adoc} or @opt-printable-exercise{bar-chart-notice.adoc}.
-->
---
{layout="Synthesize"}
# Pie and Bar Charts

* What strategies did you use to match the bar charts to the pie charts?
* Which displays do you find it easier to interpret? Why?
* What information is provided in bar charts that is hidden in pie charts?
* Why might this sometimes be problematic?

<!--
Common Misconceptions

* Pie charts and bar charts can show _counts_ or _percentages_ of categorical data. If there are more people with brown hair than blond hair, for example, a pie chart of hair color will have a larger slice or longer bar for "brown" than for "blond". In Pyret, pie charts show percentages, and bar charts show counts.
* A pie chart can only display one categorical variable, but a bar chart might be used to display two or more. Pie charts have a wedge for each represented category. Unlike in bar charts, empty categories will not be included in a pie chart. When comparing bar charts, it is important to read the scales on the y-axes. If the scales do not match, a taller bar may not represent a larger value.
* Bar charts look a lot like another kind of chart - called a "histogram" - which are actually quite different because they display _quantitative_ data, not categorical. This lesson focuses entirely on pie- and bar charts.
-->
---
{layout="Synthesize"}
# Pie and Bar Charts

Bar Charts and Pie Charts are mostly used to _display categorical columns_.

While bars in some bar charts should follow some logical order (alphabetical, small-medium-large, etc), the pie slices and bars can technically be placed in _any_ order, without changing the meaning of the chart.

<!--

-->
---
{layout="Launch"}
# Exploring other Displays

There are _lots_ of other functions, for all different kinds of data displays. 

Even if you don’t know what these plots are for yet, see if you can use your knowledge of Contracts to figure out how to use them!


<!--

-->
---
{layout="Investigate-DN"}
# Exploring other Displays

Complete @printable-exercise{pages/exploring-displays-1.adoc} and @printable-exercise{pages/exploring-displays-2.adoc}.

<!--
There are _many_ possible misconceptions about displays that students may encounter here. *But that's ok!* Understanding all those other plots is _not_ a learning goal for this lesson. Rather, the goal is to have them develop some loose familiarity, and to get more practice reading Contracts.
-->

---
{layout="InvestigateR"}
# Exploring other Displays

@image{images/legsp.png,300}

Turn to @printable-exercise{pages/kind-v-display.adoc}, and see if you can identify what kind of data each display needs!

<!--
Have students share their answers and discuss.

There are _many_ possible misconceptions about displays that students may encounter here. *But that's ok!* Understanding all those other plots is _not_ a learning goal for this lesson. Rather, the goal is to have them develop some loose familiarity, and to get more practice reading Contracts.

-->
---
{layout="Synthesize"}
# Exploring other Displays

* What displays did you find that work with just one column of data?
* What displays did you find that work with more than one column of data?
* What displays did you find that work with _categorical_ data?
* What displays did you find that work with _quantitative_ data?

<!--
* What displays did you find that work with just one column of data?
** _pie and bar charts, histograms and box plots_
* What displays did you find that work with more than one column of data?
** _scatter plots and lr-plots_
* What displays did you find that work with _categorical_ data?
** _pie and bar charts_
* What displays did you find that work with _quantitative_ data?
** _histograms, box plots, scatterplots, and lr-plots_
-->
---
{layout="Supplemental"}

# Additional Exercises:

- @opt-printable-exercise{bar-and-pie-notice.adoc}
- @opt-printable-exercise{bar-chart-notice.adoc}
- @opt-printable-exercise{pie-chart-notice.adoc}
