---
{layout="DS Title Slide"}
# Grouped Samples

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchC"}
# Problems with a Single Population
@image{images/scatter-plot.png,550}

When looking at a scatter plot of animals, it looks like the amount an animal weighs may have something to do with how long it takes to be adopted.

<!--

-->
---
{layout="LaunchC"}
# Problems with a Single Population

@image{images/image-scatter-plot.png,550}

But if we label the dots by animal, we notice _every data point_ after 25 pounds belongs to a dog from the shelter! The cats are all clumped together in the lower weight range, making it hard to see how weeks to adoption may relate to a cat's weight.{style="font-size: 16pt"}

<!--

-->
---
{layout="InvestigateR"}
# Problems with a Single Population

@image{images/image-scatter-plot.png,550}

- Looking at this scatter plot, does it make sense to analyze all the animals together? Why or why not?{style="font-size: 16pt"}
- Are there some questions where it would be important to break up the animals into species-specific samples? What are they?{style="font-size: 16pt"}
- Are there some questions where it would be important to keep the whole population together? What are they?{style="font-size: 16pt"}
- Be ready to share your answers with the class!{style="font-size: 16pt"}

@teacher{
Divide the class into groups of 3-4, with one student identified as the "reporter".

Sample responses:
- Looking at this scatter plot (above), does it make sense to analyze all the animals together? Why or why not?
** _No. Every data point after 25 pounds belongs to a dog from the shelter. The cats are clumped in the lower weight range._
- Are there some questions where it would be important to break up the population into species-specific populations? What are they?
** _Sample response: Yes. If we want to know whether dogs or cats are more likely to be fixed, we would need to look at each species separately._
- Are there some questions where it would be important to keep the whole population together? What are they?
** _Sample response: Yes. If we want to know if, in general, young animals are adopted more quickly, we would look at the entire population._
}

---
{layout="Synthesize"}
# Problems with a Single Population

You've been handed a dataset from a country where half the people have access to amazing medical care, and the others have none at all. 

* Why might it be important to look at a subset of a population?
* Why is it sometimes bad to blindly take random samples?

@teacher{
Sample responses:

* Why might it be important to look at a particular sample of a population?
** _Sample response: Maybe we want to determine if emissions from a nearby factory impact the health of residents of one particular neighborhood._
* Why is it sometimes bad to blindly take random samples?
** _If we took a random sample of the population as a whole, we might think that they are generally middle-income and have average health. But if we ask the same question about the two groups _separately_, we would discover inequality hiding in plain sight!_
}

---
{layout="Launch"}
# Grouped Samples

Depending on the question we're asking, sometimes it makes more sense to ask about "just the cats" or "just the dogs".

**Averaging every animal together will give us an answer, but they may not be _useful_ answers.**

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
  sasha= row-n(animals-table, 0)
```
Let's use this skill to define _Tables..._
---
{layout="Launch"}
# Grouped Samples

We already know how to define values, and how to filter a dataset. So let’s put those skills together to define a grouped sample of the dogs in the shelter:{style="font-size:16pt"}

@show{(code '(define dogs (filter animals-table is-dog)))}

The `filter` function walks across each row in the table, and passes it to the `is-dog` function.{style="font-size:16pt"}
**If `is-dog` produces `true`, `filter` adds it to a new table.** Otherwise, it just silently moves on to the next row.{style="font-size:16pt"}}
Finally, we define the name `dogs` to be the table produced by `filter`.{style="font-size:16pt"}

}
---
{layout="Investigate"}
# Grouped Samples

A “kitten” is an animal who _is a cat_ and who _is young_. **How would you define a table of just kittens?**

* Turn to @printable-exercise{pages/samples-from-animals-dataset.adoc}, and see what @ifproglang{pyret}{code} @ifproglang{codap}{sequence of Transformers} will compute whether or not an animal is a kitten.
* Can you fill in the @ifproglang{pyret}{code} @ifproglang{codap}{function notation} for the other grouped samples?
@ifproglang{pyret}{
* When you're done, type these definitions into the Definitions Area.}
* Make a bar chart showing the distribution of `sex` in the `kittens` subset @ifproglang{pyret}{, by typing @show{(code '(bar-chart kittens "sex"))}}.

---
{layout="Synthesize"}
# Grouped Samples

* How could we filter _and_ sort a table?
* How can we combine functions?

---
{layout="Launch"}
# Displaying Samples

Making grouped and random samples is a powerful skill, which allows us to dig deeper than just making charts or asking questions about a whole dataset. 

**Now that we know how to make subsets, we can make much more sophisticated displays!**

---
{layout="LaunchR"}
# Displaying Samples

@image{images/AskQuestions.png, 100} 

__What's the ratio of fixed to unfixed *cats* at the shelter?__ 

Let's use the Data Cycle to get an answer, using our knowledge of grouped samples.

_Starting off: Is this a lookup, arithmetic, or statistical question?_

---
{layout="LaunchR"}
# Displaying Samples

@image{images/AskQuestions.png, 100} 

**1 - Is this a lookup, arithmetic, or statistical question?**

This is an Arithmetic Question. We know it's not a lookup question because there's no ratio written somewhere in the table for us to read. Instead, we'll have to count all the fixed cats and the unfixed cats, then compare the totals.

_Next: What rows do we need? What columns?_
<!--
Have students discuss their answers
-->

---
{layout="LaunchR"}
# Displaying Samples

@image{images/ConsiderData.png, 100}

**2 - What rows do we need? What columns?**

We know that we'll need to count *only the cats!*, and can ignore everything else. And once we've picked the rows for cats, the only column we want is the `fixed` column. This is a huge hint that *we'll need to filter the dataset!*

_Next: What kind of table or display are we building?_

<!--
Have students discuss their answers
-->
---
{layout="LaunchR"}
# Displaying Samples

@image{images/AnalyzeData.png, 100}

**3 - What kind of table or display are we building?**

We could use a bar-chart or a pie-chart to do this analysis, but since we care more about the ratio ("2x as many fixed as unfixed") than the count ("20 fixed vs. 10 fixed"), a pie chart is a better choice. We've decided what to make and we know which rows and columns we're plotting, so the next step is to _write the code!_

_Next: What did our displays tell us?_

<!--
Have students discuss their answers
-->
---
{layout="LaunchR"}
# Displaying Samples

@image{images/InterpretData.png, 100}

**4 - What did our displays tell us?**

In this case, we found out exactly how many fixed v. unfixed cats there are. But perhaps that's not the end of the story! 

We might have _new_ questions about whether a higher percentage of dogs are spayed and neutered than cats, or whether it's even possible to "fix" a tarantula. _All of this belongs in our data story!_

---
{layout="Investigate"}
# Displaying Samples

- Complete @printable-exercise{pages/data-displays2.adoc}, using what you've learned about samples to make more sophisticated data displays.
- Complete @printable-exercise{pages/analyzing-categorical-data2.adoc}.

---
{layout="Synthesize"}
# Displaying Samples

- What connections do you see between the "Consider Data" and "Analyze Data" steps?
- How do we know when we need to filter? How do we know when we _don't?_

---
{layout="Synthesize"}
# Your Analysis

- What grouped samples did you make for your dataset?
- What other samples would be good to examine? 
- Do you have suggestions for your colleagues?