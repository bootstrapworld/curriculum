@slidebreak
{layout="DS Title Slide"}
# The Data Cycle

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch"}
# Telling Your Data Story

**Are more animals fixed or unfixed?**

- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
- Working in pairs, turn to @printable-exercise{ds-intro/pages/animals-dataset.html, The Animals Dataset}, or open @link{https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/edit?usp=sharing, the Animals Spreadsheet}.
- You and your partner are going to answer a simple question: **are more animals fixed or unfixed?**

<!--

-->
@slidebreak
{layout="Launch"}
# Telling Your Data Story

Data Science is all about _asking questions of data_. Sometimes the answer is easy to compute. Sometimes the answer to a question is _already in the dataset_ - no computation needed.  And sometimes the answer just sparks more questions!

Data Scientists ask a ton of questions, and each question adds a chapter to their **data story**. Even if a question turns out to be a dead-end, it's valuable to share what the question was and what work you did to answer it!

<!--

-->
@slidebreak
{layout="LaunchR"}
# Telling Your Data Story

@image{images/data-cycle.png, 400}

The Data Cycle is a _roadmap_, which helps guide us in the process of data analysis.

1) We **Ask Questions** - which can be answered with data.{style="font-size:14pt"}

2) We **Consider Data**. This could be done by conducting a survey, observing and recording data, or finding a dataset.{style="font-size:14pt"}

3) We **Analyze the Data**, to produce data displays and new tables of filtered or transformed data, to identify patterns and relationships.{style="font-size:14pt"}

4) We **Interpret the Data**, answering questions and summarizing results. As we've already seen from the Animals Dataset, these interpretations often lead to _new_ questions....and the cycle begins again.{style="font-size:14pt"}

<!--

-->
@slidebreak
{layout="Synthesize"}
# Telling Your Data Story

**Are more animals fixed or unfixed?**

This was a pretty specific question, and it was straightforward to answer it. But the answers to even simple questions can lead to more interesting questions down the road!

_What other questions might come from counting the ratio of fixed to unfixed animals?_

<!--

-->
@slidebreak
{layout="LaunchR"}
# Ask Questions

@image{images/AskQuestions.png, 200}

**How do we know what questions to ask?**

There’s an art to asking the right questions, and good Data Scientists think hard about what kind of questions can and can’t be answered.

@slidebreak
{layout="Launch"}
# Ask Questions

Most questions can be broken down into one of four categories:

- **Lookup questions** - Answered simply by looking up a single value in the table and reading it out. Once you find the value, you’re done!{style="font-size:16pt"}

- **Arithmetic questions** - Answered by computing an answer within a single column.{style="font-size:16pt"}

- **Statistical questions** If we asked, "How old are animals at the shelter?", there are lots of ways to answer! We could report the _average_ age, the age that shows up _most frequently_ or the _range_ of the ages. Which one is "right"? As you'll see in this class, it depends...{style="font-size:16pt"}

- **Questions we can't answer** - Need data that we don't have. {style="font-size:16pt"}

<!--
Examples of lookup questions might be “How many legs does Felix have?” or "What species is Sheba?"

Examples of arithemetic questions might be “How much does the heaviest animal weigh?” or “What is the average age of animals from the shelter?”

Other  examples of statistical questions might include "How long does it take for an animal to get adopted?" or "What's a typical age for the cats?". There are also some statistical questions that deal with _relationships between *two* columns_: “Do cats tend to be adopted faster than dogs?” or “Are older animals heavier than young ones?”

We might wonder where the animal shelter is located, or what time of year the data was gathered! But the data in the table won't help us answer that question, so as Data Scientists we might need to do some research _beyond the data_. And if nothing turns up, we simply recognize that there are limits to what we can analyze.
-->
@slidebreak
{layout="LaunchR"}
# Ask Questions

@image{images/AskQuestions.png, 200}

**Lookup, Arithmetic, Statistical, or Can't Answer?**

* What kind of question is "Are more animals fixed or unfixed?"
* What kind of question is "How old is Toggle?"

<!--
* What kind of question is "Are more animals fixed or unfixed?"?
** It's an _arithmetic question_.
* What kind of question is "How old is Toggle?"
** It's a _lookup question_.
-->
@slidebreak
{layout="InvestigateR"}
# Ask Questions

@image{images/AskQuestions.png, 200}

- Turn to @printable-exercise{which-question-type.adoc}, and fill out the "Type" column in the table at the bottom. *For now, ignore the other columns.*
- Look at the Wonders you wrote on @printable-exercise{ds-intro/pages/questions-and-column-descriptions.adoc}. Are these Lookup, Arithmetic, or Statistical questions?
- @optional For more practice, complete @opt-printable-exercise{question-types-animals.adoc}, by coming up with examples of each type of question for the Animals Dataset.

<!--
- Students generally struggle to make the leap into asking statistical questions. It's worth taking time on this, to support them coming up with better (and more engaging!) questions later.
- They may think that "What's the average weight of the animals?" is a statistical question, because "average" is a term that shows up in statistics. But computing the average is just pure arithmetic! A _statistical_ question would be "What's the typical weight of an animal?", because it does not specify a particular arithmetic process. The answer could be the mean, the median, or even the mode! Figuring out which one to use depends on the distribution of the data, which we'll discuss more in a later lesson.
-->
@slidebreak
{layout="Synthesize"}
# Synthesize

- How would you explain the difference between Lookup. Arithmetic, and Statistical questions?
- When you looked back at your Wonders from the Animals Dataset, were they mostly Lookup questions? Arithmetic? Statistical?
- What are some examples of statistical questions the owner of a sports team might ask? Or a researcher who is trying to see if a cancer drug is effective? Or a principal who wants to know what will help their students the most?


<!--

-->

@slidebreak
{layout="LaunchR"}
# Consider Data

@image{images/ConsiderData.png, 200}

When considering data, we ask:

* **Which Rows** do we need?
* **Which Column(s)** do we care about?

@slidebreak
{layout="Launch"}
# Consider Data

Tables are made of **Rows** and **Columns**. 

Each Row represents one member of our population. In the Animals Dataset, each row represents a single animal. In a dataset of temperature readings, each row might represent the temperature at a particular hour.{style="font-size:16pt"}

Columns, on the other hand, represent information _about each row_. Every animal, for example, has columns for their name, species, sex, age, weight, legs, whether they are fixed or unfixed, and how long it took to be adopted.{style="font-size:16pt"}

@slidebreak
{layout="LaunchR"}
# Consider Data

@image{images/ConsiderData.png, 200}

If we want to know which cat is the heaviest, we _only care about rows for cats_, and _we only need the `pounds` column_. 

If we want to know how many fixed animals are rabbits, _we only care about rows for fixed animals_, and _we only need the `species` column_.

@slidebreak
{layout="LaunchR"}
# Consider Data

@image{images/ConsiderData.png, 200}

* If our question is "How old is Mittens?", what rows and column(s) do we need? 
* If our question is "Which animal is the heaviest?", what rows and column(s) do we need? 
* What rows and columns did we need to answer "Are more animals fixed or unfixed?"?

<!--
1. _We only need one row for Mittens, and we just need the `age` column_
2. _We need to compare every row, and we only look at the `pounds` column_
3. We needed to look at _all_ the rows, but the only column we care about is `fixed`.

-->
@slidebreak
{layout="InvestigateR"}
# Consider Data

@image{images/ConsiderData.png, 200}

- Return to @printable-exercise{which-question-type.adoc}. For each question, which rows would you need to answer them? Which columns would you look at? Write your answers in the last two columns of the table at the bottom.
- Complete @printable-exercise{which-rows-which-columns.adoc}.

<!--
Common Misconceptions
- Students often forget that questions like "Who is the oldest?" or "What is the most?" require looking at _every row_ in the table.
-->

@slidebreak
{layout="SynthesizeR"}
# Consider Data

@image{images/ConsiderData.png, 200}

Debrief your answers!

How does asking "Which rows? Which columns?" help us figure out @ifproglang{pyret}{what code to write}@ifproglang{codap}{which configurations to use}?

@slidebreak
{layout="LaunchR"}
# Analyzing Data

@image{images/AnalyzeData.png, 100}

Once we know what data we need, we can turn our attention to what we want to build with it!

- Do we need to filter out certain rows and make a new table?
@ifproglang{pyret}{- Do we need a pie chart?} A scatter plot?

What kinds of displays can help us analyze whether there are more fixed or unfixed animals? 

@slidebreak
{layout="LaunchR"}
# Analyzing Data

@image{images/AnalyzeData.png, 100}

**Are more animals fixed or unfixed?**
@ifproglang{pyret}{
We could use a bar-chart _or_ a pie-chart to do this analysis, but since we care more about the ratio ("2x as many fixed as unfixed") than the actual count ("20 fixed vs. 10 fixed") a pie chart is the better choice.} 

Once we've decided to make a bar chart and we know which rows and columns we're plotting, the next step is to @ifproglang{pyret}{_write the code!_}@ifproglang{codap}{choose the appropriate configuration.}

@ifproglang{pyret}{

@slidebreak
{layout="LaunchR"}
# Analyzing Data

@image{images/AnalyzeData.png, 100}

Once we've decided what to make and we know which rows and columns we're plotting, the next step is to _write the code!_

Once we know that we want a pie-chart, and that we're using it to look at the `fixed` column, analyzing the data is as easy as reading the Contract!
}

@slidebreak


{layout="InvestigateR"}
# Analyzing Data

@image{images/AnalyzeData.png, 100}

Turn to @printable-exercise{analyzing-with-displays.adoc}, and see if you can fill in the first 3 steps of the Data Cycle for a set of predefined questions. When you're finished, try to make the display in @proglang.


<!--
Have students share their results. What did their charts tell them?
-->
@slidebreak
{layout="SynthesizeR"}
# Analyzing Data

@image{images/InterpretData.png, 100}

In this case, we got a clear answer to our question. But perhaps that's not the end of the story! We might be curious about whether a higher percentage of dogs are spayed and neutered than cats, or whether it's even possible to "fix" a tarantula. _All of this belongs in our data story!_

@ifproglang{pyret}{
*How do Contracts and the Data Cycle work together, to help us figure out what program will answer our questions?*}

<!--
Have students share their results. What did their charts tell them?
-->
