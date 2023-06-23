---
{layout="DS Title Slide"}
# Contracts: Making Tables and Displays
<!-- 
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Functions for Working with Tables

- Open the @starter-file{animals} and click "Run".
- In the Interactions Window on the right type `animals-table` and hit "Enter" to see the default view of the table.
- What do you Notice? 
- What do you Wonder? 

<!--
If this is the first time your students are seeing a table in @starter-file{editor}, you may also want to acknowledge line 7 of the Definitions area, where `animals-table` is defined along with the names of the 8 columns.
-->

---
{layout="Investigate-DN"}
# Functions for Working with Tables

- Turn to @printable-exercise{functions-for-tables.adoc} and complete numbers 1-6.

---
{layout="Investigate-DN"}
# Functions for Working with Tables

- What did these `sort` expressions do?
- Just below question 6, we see the contract for `sort`
- What does it mean that the Domain of `sort` is Table, String, Boolean?
- What does it mean that the Range of `sort` is Table?
- Complete questions 7-10.

---
{layout="Investigate-DN"}
# Functions for Working with Tables

- How did `sort` work with quantitative columns?
- What new questions did you think of that could be answered using `sort`?
- Complete @printable-exercise{functions-for-tables-cont.adoc}, working with the `count` and `first-n-rows` functions.

---
{layout="Synthesize"}
# Functions for Working with Tables


- How is the function of `count` different from `sort`?
- How does the function `first-n-rows` work?
- Does anyone have any questions about the functions or expressions you've worked with today?
- Where have you seen tables summarizing counts in the real world?
- How else do journalists and newscasters display summaries of data besides in tables?

---
{layout="Launch"}
# Functions for Making Displays

The `count` function summarized the data for a single variable in a new table. But the same information could be communicated as a picture! This is called data visualization, and Pyret has functions that can make displays for us!

<!--
Students will be introduced to functions for making one-variable displays in Pyret, including: @show{(code 'pie-chart)}, @show{(code 'bar-chart)}, @show{(code 'box-plot)} and @show{(code 'histogram)}.

The goal here is for students to become familiar with __using contracts to write expressions that will produce displays__. Knowing how to _make_ a histogram doesn't mean a student really understands histograms! We have dedicated, in-depth lessons that focus on each display mentioned in this lesson:

* @lesson-link{bar-and-pie-charts}
* @lesson-link{histograms}
* @lesson-link{histograms2}
* @lesson-link{box-plots}

We also have dedicated lessons for other displays not mentioned here, such as @lesson-link{scatter-plots}, @lesson-link{linear-regression}, @lesson-link{advanced-displays}, etc.
-->

---
{layout="Investigate-DN"}
# Functions for Making Displays

- Turn to @printable-exercise{exploring-displays-alt.adoc}.
- Let's look at the first function together.
- What is the name of the function?
- What is the Domain of the function?
- What is the Range of the function?
- Take a minute and see if you and your partner can write an expression that will generate a `bar-chart` and give me a thumbs up when you have one building.

---
{layout="Investigate-DN"}
# Functions for Making Displays

- Did `bar-chart` consume a categorical or quantitative column of data?
- What does the resulting display tell us?
- Make a sketch of the display you just built in Pyret.
- Then work to complete the page, generating each of the other 3 displays. Some of them may be new to you - you are not expected to be an expert in them yet, but you should be able to figure out how to use the contract to get them building!

---
{layout="Synthesize"}
# Functions for Making Displays

- Which displays worked with categorical data?
- Why might you choose a bar chart over a pie chart or vice versa?
- How are bar charts and histograms different?