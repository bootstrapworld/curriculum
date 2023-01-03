---
{layout="DS Title Slide"}
# Scatter Plots

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Making Scatter Plots

- Do you think that younger animals get adopted faster? Why or why not?
- What kind of data is `age`? What kind of data is `weeks`?
- What kind of display would help us analyze the relationship between age and adoption time?

**Pie** and **bar charts** help us see the _frequency_ of values in a _categorical_ column. **Histograms** and **box plots** help us explore the _distribution_ of values in a _quantitative_ column.

<!--

-->
---
{layout="Launch"}
# Making Scatter Plots

What we really want is a display that will help us search for **a relationship between two quantitative columns**, and that's exactly what scatter plots do.

Scatter plots reveal the relationship between two columns by plotting one on the x-axis and the other on the y-axis.

<!--

-->
---
{layout="Launch"}
# Making Scatter Plots

Before we can draw a @vocab{scatter plot}, we have to make an important decision: which variable is @vocab{explanatory} and which is the @vocab{response}? 

In this case, are we suspecting that an animal’s weight might explain how long it takes to be adopted? Or that adoption time can explain how much an animal weighs? 

The first one makes sense, and reflects our suspicion that age plays a role in adoption time.

<!--

-->
---
{layout="Investigate"}
# Making Scatter Plots

Complete @printable-exercise{pages/creating-scatterplot.adoc}, to get a feel for making scatter plots by hand.

<!--

-->
---
{layout="Investigate"}
# Making Scatter Plots

When you created the scatter plot by hand, you started with a Table. Then you plotted a series of dots, using one column for your x's, one column for your y's, and the `name` column to provide a label for each dot.

The `scatter-plot` function works exactly the same way: it starts with a table, and then needs to know which columns to use for labels, xs, and ys. Here's the contract:

`scatter-plot :: (t::Table, ls::String, xs::String, ys::String)`{style="font-size:15pt"}

<!--

-->
---
{layout="Investigate-DN"}
# Making Scatter Plots

* Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
* Make a scatter plot that displays the relationship between `age` and adoption time (`weeks`).
* Are there any patterns or trends that you see here?

<!--
Have students report back on their findings from the starter file and on @printable-exercise{pages/creating-scatter plot.adoc}.
-->
---
{layout="SynthesizeR"}
# Making Scatter Plots

@image{images/no-relationship.png, 250} 

Scatter plots show us a collection of points, arranged along two axes. If there's a relationship between these axes, we'll see clumps and clouds of points in the graph.

Think back to our discussion of random sampling and statistical inference. In this case, the @vocab{null hypothesis} is that there is no relationship between these two columns. The image on the right shows a collection of points, but the y-values don't seem to vary no matter what the x-values are.
<!--

-->
---
{layout="Synthesize"}
# Synthesize

Suppose we picked four animals at random out of our table, plotted them on a scatter plot, and they all fell in a line. Is this enough to reject the null hypothesis? 

_No! Four flips of a fair coin might still come up tails, and four points chosen from a scatter plot with no pattern might still fall on a line!_

As our sample size increases, however, the chance of us _seeing a pattern by random chance gets smaller and smaller._

<!--
**Ask Students**
* What pattern do you see in _your_ scatter plot?
* Are there any points that seem unusual? Why?
-->

---
{layout="Launch"}
# The Data Cycle

**Is age the only factor that determines how long it takes for an animal to get adopted?**

Many apartment buildings do not allow large breeds of dogs, and have a limit on how heavy a tenant's dog can be. Bigger dogs are not welcome in many apartments. 

_Perhaps the **weight** of an animal influences the adoption time!_

---
{layout="Launch"}
# The Data Cycle

Take a look at the animals dataset, either in your workbook or on the @link{https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/edit, spreadsheet}. 

Do you think there's a relationship between `pounds` and `weeks` in this table? Why or why not?

---
{layout="Investigate-DN"}
# The Data Cycle

Complete the first Data Cycle on @printable-exercise{pages/data-cycle-scatter-plot-animals.adoc}.

- What did you find when you looked at the scatter-plot?
- Does there appear to be a pattern or trend?
- What might be problematic about including every species in the same scatter plot of weight?
- What follow-up questions do you have?
<!--
Pose these questions to the whole class, and debrief as a large group.
-->
---
{layout="Investigate-DN"}
# The Data Cycle

Write your follow-up question in the second Data Cycle on @printable-exercise{pages/data-cycle-scatter-plot.adoc}, and complete the Data Cycle for your new question.

---
{layout="Synthesize"}
# The Data Cycle

We’ve got a lot of tools in our toolkit that help us think about an entire _column_ of a dataset:

- We have ways to find measures of center and spread for a given quantitative column.
- We have visualizations that let us see the shape of values in a quantitative column.
- We have visualizations that let us see frequencies or percentages in a categorical column.

---
{layout="Synthesize"}
# The Data Cycle

Now we also have a tool that lets us think about two columns at the same time!

What new questions did the Data Cycle lead you to ask? What did you find?

---
{layout="LaunchC"}
# Looking for Trends

Shown below is a scatter plot of the relationships between the animals' `pounds` and the number of `weeks` it takes to be adopted. **Do you see a trend?**

@image{images/pounds-v-weeks.png}

---
{layout="LaunchR"}
# Looking for Trends

@image{images/pounds-v-weeks.png}

A straight-line pattern in the cloud of points suggests a linear relationship between two columns. 

If we can find a line around which the points cluster (as we’ll do in a future lesson), it would be useful for **making predictions**. 

For example, our line might predict how many `weeks` a new dog would wait to be adopted, if it weighs 68 `pounds`.

---
{layout="Launch"}
# Looking for Trends

Do any data points seem unusually far away from the main cloud of points? Which animals are those? 

These points are called *unusual observations*. Unusual observations in a scatter plot are like outliers in a histogram, but more complicated because it’s the _combination_ of x and y values that makes them stand apart from the rest of the cloud.

---
{layout="Launch"}
# Looking for Trends

**Unusual observations are _always_ worth thinking about!**

- Sometimes they’re _just random_. Felix seems to have been adopted quickly, considering how much he weighs. Maybe he just met the right family early, or maybe we find out he lives nearby, got lost and his family came to get him. In that case, we might need to do some deep thinking about whether or not it’s appropriate to remove him from our dataset.

---
{layout="Launch"}
# Looking for Trends

**Unusual observations are _always_ worth thinking about!**

- Sometimes they can give you a _deeper insight_ into your data. Maybe Felix is a special, popular (and heavy!) breed of cat, and we discover that our dataset is missing an important column for breed!

---
{layout="Launch"}
# Looking for Trends

**Unusual observations are _always_ worth thinking about!**

- Sometimes unusual observations are _the points we are looking for_! What if we wanted to know which restaurants are a good value, and which are rip-offs? We could make a scatter plot of restaurant reviews vs. prices, and look for an observation that’s high above the rest of the points. That would be a restaurant whose reviews are _unusually good_ for the price. An observation way below the cloud would be a really bad deal.

---
{layout="InvestigateC"}
# Looking for Trends

**It's not just about the numbers!**

These numbers and scatter plot come from different datasets. The patterns in the scatter plot vary wildly, but the numbers that summarize dataset barely change at all!

@image{images/CloudToCircle.gif}
<!--
This animation is from Autodesk, which has an amazing page showing off how similar numbers can be generated from radically different scatterplots. If time allows, have students explore some of the visualizations on the @opt-online-exercise{https://www.autodesk.com/research/publications/same-stats-different-graphs, Autodesk website}!
-->

---
{layout="Investigate"}
# Looking for Trends

**Data Scientists and Statisticians use their eyes all the time**. Sometimes there's a pattern hiding in the data, which can't be seen just by focusing on numbers and measures. 

Until we really look at the _shape_ of the data, we aren't seeing the whole picture. 

---
{layout="Investigate-DN"}
# Looking for Trends

For practice, consider each of the following relationships. First think about what you _expect_, then make the scatter plot to see if it supports your hunch.

- How are the `pounds` of an animal related to its `age`?
- How are the number of `weeks` it takes for an animal to be adopted related to its number of `legs`?
- How are the number of `legs` an animal has related to its `age`?
- Do you see a linear (straight-line) relationship in any of these?
- Are there any unusual observations?
<!--
All of these are phrased as "how is the _explanatory variable_ related to the _response variable_"
-->
---
{layout="Synthesize"}
# Looking for Trends

It might be tempting to go straight into making a scatter plot to explore how weeks to adoption may be affected by age. But different animals have very different lifespans! 

Why does that matter?

---
{layout="Synthesize"}
# Looking for Trends

A 5-year-old tarantula is still really young, while a 5-year-old rabbit is fully grown. With differences like this, it doesn’t make sense to put them all on the same scatter plot. By mixing them together, we may be _hiding_ a real relationship, or creating the illusion of a relationship that isn’t really there!

---
{layout="Synthesize"}
# Looking for Trends

**It would be nice if the dots in our scatter plot were different colors or shapes, depending on the species.** That would give us a much better picture of what's really going on in the data. *But making a special image for every single row in the table would take a very long time!* If only there was a function with a contract like:

`species-dot :: (r :: Row) -> Image`

This function could take in a row from the animals table, and draw a special dot depending on the species. Unfortunately, no such function exists...yet!

---
{layout="Launch"}
# Your Own Analysis

What relationships do you think might be lurking in _your_ dataset?

Which pairs of columns would you like to examine?

---
{layout="Investigate-DN"}
# Your Own Analysis

- Turn to @printable-exercise{pages/data-cycle-scatter-plot.adoc}, and add them to the "Making Displays" section of your exploration document.
- Do these displays bring up any interesting questions? If so, add them to the end of the document.

---
{layout="Synthesize"}
# Your Own Analysis

- Which relationships did you look for?
- Do you see any possible relationships or trends?
- What do those findings mean?
- What new questions come up for you?

---
{layout="Synthesize"}
# Your Own Analysis

The Animals Dataset contains a number of sub-groups that we might want to compare to one another. For example: maybe we'd like to compare the average adoption time for dogs v. cats!
- Does your dataset contain any sub-groups? If so, what are they?
