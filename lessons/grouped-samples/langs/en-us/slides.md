---
{layout="DS Title Slide"}

# Grouped Samples
<!--

-->
---
{layout="LaunchC"}
# Problems with a Single Population
@image{images/scatter-plot.png,"A scatter plot with dots loosely clustered around a line with a positive slope",550}

When looking at a scatter plot of animals, it looks like the amount an animal weighs may have something to do with how long it takes to be adopted.

<!--

-->
---
{layout="LaunchC"}
# Problems with a Single Population

@image{images/image-scatter-plot.png,"A scatter plot with images of each species of animal in place of the dots, loosely clustered around a line with a positive slope",550}

But if we label the dots by animal, we notice _every data point_ after 25 pounds belongs to a dog from the shelter! The cats are all clumped together in the lower weight range, making it hard to see how weeks to adoption may relate to a cat's weight.

<!--

-->
---
{layout="InvestigateR"}
# Problems with a Single Population

@image{images/image-scatter-plot.png,"A scatter plot with images of each species of animal in place of the dots, loosely clustered around a line with a positive slope",550}

- Looking at this scatterplot, does it make sense to analyze all the animals together? Why or why not?
- Are there some questions where it would be important to break up the animals into species-specific samples? What are they?
- Are there some questions where it would be important to keep the whole population together? What are they?

<!--
Divide the class into groups of 3-4, with one student identified as the "reporter". Have the groups answer these questions.
-->
---
{layout="Synthesize"}
# Problems with a Single Population

Report back on your answers to these questions!

- Looking at this scatterplot, does it make sense to analyze all the animals together? Why or why not?
- Are there some questions where it would be important to break up the animals into species-specific samples? What are they?
- Are there some questions where it would be important to keep the whole population together? What are they?

<!--

-->
---
{layout="Synthesize"}
# Launch with image on the right

You've been handed a dataset from a country where half the people have access to amazing medical care, and the others have none at all. 

* Why might it be important to look at a subset of a population?
* Why is it sometimes bad to only take random samples?

<!--

-->
---
{layout="Synthesize"}
# Launch with image on the right

If we took a random sample of the population as a whole, we might think that they are generally middle-income and have average health. 

But if we ask the same question about the two groups _separately_, we would discover inequality hiding in plain sight!

<!--

-->
---
{layout="Launch"}
# Grouped Samples

Depending on the question we're asking, it makes more sense to ask them about "just the cats" or "just the dogs". 

Averaging every animal together will give us an answer, but they may not be _useful_ answers.

<!--

-->
---
{layout="Launch"}
# Grouped Samples

**Sometimes important facts about samples get _lost_ if we mix them with the rest of the population!**

Data Scientists define @vocab{grouped samples} of datasets, breaking them up into sub-groups that may be helpful in their analysis.

@ifproglang{pyret}{

---
{layout="Launch"}
# Grouped Samples

Earlier, you learned how to define values in Pyret. We can define Numbers, Strings, Images, and even rows:
```
  name = "Flannery"
  age  = 16
  logo = star(50, "solid", "red")
  sasha= animals-table.row-n(0)
```
Let's use this skill to define _Tables..._
---
{layout="Launch"}
# Grouped Samples

We already know how to define values, and how to filter a dataset. So let’s put those skills together to define a grouped sample of the dogs in the shelter:{font-size:14pt}
```
dogs  = animals-table.filter(is-dog)
```

The `.filter` method walks across each row in the table, and passes it to the `is-dog` function. If `is-dog` produces `true`, `.filter` adds it to a new table. Otherwise, it just silently moves on to the next row. Finally, we define the name `dogs` to be the table produced by `.filter`.{font-size:14pt}

}
---
{layout="Investigate"}
# Grouped Samples

A “kitten” is an animal who _is a cat_ and who _is young_. How would you define a table of just kittens?

* Turn to @printable-exercise{pages/samples-from-animals-dataset.adoc}, and see what @ifproglang{pyret}{code} @ifproglang{codap}{sequence of Transformers} will compute whether or not an animal is a kitten.
* Can you fill in the @ifproglang{pyret}{code} @ifproglang{codap}{function notation} for the other grouped samples?
@ifproglang{pyret}{
* When you're done, type these definitions into the Definitions Area.}
* Make a bar chart showing the distribution of `sex` in the `kittens` subset @ifproglang{pyret}{, by typing `bar-chart(kittens, "sex")`}.

---
{layout="Synthesize"}
# Synthesize

* Make bar charts showing the `sex` column for every grouped sample. 
* Which one best represents the distribution of species for the whole population? Why?

<!--
Debrief with students. Thoughtful question: how could we filter _and_ sort a table? How can we combine methods?
-->

---
{layout="Launch"}
# Displaying Samples

Making grouped and random samples is a powerful skill, which allows us to dig deeper than just making charts or asking questions about a whole dataset. 

Now that we know how to make subsets, we can make much more sophisticated displays!

---
{layout="Launch"}
# Displaying Samples

Let's start with question: __what's the ratio of fixed to unfixed *cats* at the shelter?__ Let's use the Data Cycle to get an answer, using our knowledge of grouped samples.

**Is this a lookup, arithmetic, or statistical question?**
<!--
Have students discuss their answers
-->

---
{layout="LaunchR"}
# Displaying Samples

@image{images/AskQuestions.png, "Ask Questions icon", 100} This is an Arithmetic Question. We know it's not a lookup question because there's no ratio written somewhere in the table for us to read. Instead, we'll have to count all the fixed cats and the unfixed cats, then compare the totals.

**What rows do we need? What columns?**
<!--
Have students discuss their answers
-->

---
{layout="LaunchR"}
# Displaying Samples

@image{images/ConsiderData.png, "Consider Data icon", 100}

We know that we'll need to count *only the cats!*, and can ignore everything else. And once we've picked the rows for cats, the only column we want is the `fixed` column. This is a huge hint that *we'll need to filter the dataset!*

**What kind of table or display are we building?**

<!--
Have students discuss their answers
-->
---
{layout="LaunchR"}
# Displaying Samples

@image{images/AnalyzeData.png, "Analyze Data icon", 100}

We could use a bar-chart _or_ a pie-chart to do this analysis, but since we care more about the ratio ("2x as many fixed as unfixed") than the actual count ("20 fixed vs. 10 fixed") a pie chart is a slightly better choice. Once we've decided what to make and we know which rows and columns we're plotting, the next step is to _write the code!_

**What did our displays tell us?**

<!--
Have students discuss their answers
-->
---
{layout="LaunchR"}
# Displaying Samples

@image{images/InterpretData.png, "Interpret Data icon", 100}

In this case, we got a clear answer to our question. But perhaps that's not the end of the story! 

We might be curious about whether a higher percentage of dogs are spayed and neutered than cats, or whether it's even possible to "fix" a tarantula. _All of this belongs in our data story!_

---
{layout="Synthesize"}
# Displaying Samples

- What connections do you see between the "Consider Data" and "Analyze Data" steps?
- How do we know when we need to filter? How do we know when we _don't?_

---
{layout="Launch"}
# Your Analysis

Think about your own dataset. Are there grouped samples that you'd like to explore separately? Here are a few examples, taken from some of the sample datasets:

- In the RI Schools dataset, it might be good to create grouped samples for public v. charter schools
- In the Movies dataset, it might be valuable to create grouped samples for modern movies, and analyze them separately from older movies.
- In the US Presidents dataset, it could be useful to make a grouped sample for each political party.

---
{layout="Launch"}
# Your Analysis

- What grouped samples make sense for your dataset?
- Name these subsets and write the Pyret code to test an individual row from your dataset on @printable-exercise{pages/samples-from-my-dataset.adoc}.
- Turn to @printable-exercise{pages/design-recipe-helper-funs.adoc}, and use the Design Recipe to write the filter functions that you planned out on @printable-exercise{pages/samples-from-my-dataset.adoc}. When the teacher has checked your work, type them into the Definitions Area and use the `.filter` method to define your new sample tables.

---
{layout="Synthesize"}
# Your Analysis

- What grouped samples did you make for your dataset?
- What other samples would be good to examine? 
- Do you have suggestions for your colleagues?
