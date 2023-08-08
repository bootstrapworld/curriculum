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
If this is the first time your students are seeing a table in @starter-file{editor}, you may also want to acknowledge line 7 of the Definitions Area, where `animals-table` is defined along with the names of the 8 columns.
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

@teacher{
- What did these `sort` expressions do?
** _They took in the `animals-table`, the "Name" column, and true or false... producing a new table, sorted alphabetically (A-Z for true and Z-A for false)_
- Just below question 6, we see the contract for `sort`
- What does it mean that the Domain of `sort` is Table, String, Boolean?
** _The functions needs a Table, a String (describing a column), and a Boolean (an order to sort the column by) in order to do its job._
- What does it mean that the Range of `sort` is Table?
** _The function produces a new table._	
}
---
{layout="Investigate"}
# Functions for Working with Tables

As you can imagine, there are many other functions that work with tables, each with a different set of inputs. For each of these functions, we need to keep track of three things:

1. *Name* -- the name of the function, which we type in whenever we want to use it
2. *Domain* -- the type(s) of data we give to the function
3. *Range* -- the type of data the function produces

The @vocab{Name}, @vocab{Domain} and @vocab{Range} are used to write a @vocab{Contract}.

---
{layout="Investigate"}
# Functions for Working with Tables

**Contracts are the _instruction manual_ for functions**

The Domain in the contract for `sort` tells us exactly what kind of inputs it needs, and in what order. The Range tells us exactly what we'll get back.

Complete question 7-10 on @printable-exercise{functions-for-tables.adoc}.


---
{layout="Investigate-DN"}
# Functions for Working with Tables

- How did `sort` work with quantitative columns?
- What new questions did you think of that could be answered using `sort`?
- Complete @printable-exercise{functions-for-tables-cont.adoc}, working with the `count` and `first-n-rows` functions.

@teacher{
- How did `sort` work with quantitative columns?
** _true sorted the values from least to greatest. false sorted the values from biggest to smallest._	
}
---
{layout="Synthesize"}
# Functions for Working with Tables

- How is the function of `count` different from `sort`?
- How does the function `first-n-rows` work?
- Does anyone have any questions about the functions or expressions you've worked with today?
- Where have you seen tables summarizing counts in the real world?
- How else do journalists and newscasters display summaries of data besides in tables?

@teacher{
- How is the function of `count` different from `sort`?
** `sort` _made a new table that was reordered_
** `count` _made a new table that summarized the data from a column of the original table!_
- How does the function `first-n-rows` work?
** _It makes a new smaller table with the number of rows you type into the expression._
- Does anyone have any questions about the functions or expressions you've worked with today?
- Where have you seen tables summarizing counts in the real world?
- How else do journalists and newscasters display summaries of data besides in tables?
** _Ideally someone will say bar charts!_	
}

---
{layout="Launch"}
# Composing with Circles of Evaluation  

What if we wanted to see the ten youngest animals? How could the `first-n-rows` and `sort` functions work together? What order should we use the functions in?

---
{layout="Investigate"}
# Composing with Circles of Evaluation  

One way to organize our thoughts is to diagram what we want to do, using the Circles of Evaluation. The rules are simple:

1) Every Circle of Evaluation must have one - and only one! - function, written at the top.

2) The arguments of the function are written left-to-right, in the middle of the Circle.

Values like Numbers, String, and Booleans are still written by themselves. It’s only when we want to _use a function_ that we need to draw a Circle, and write the values inside from left-to-right.

**Circles can contain other Circles!**

---
{layout="InvestigateC"}
# Composing with Circles of Evaluation  

If we want to see the ten youngest animals, our diagram would look like this.

@show{(coe '(first-n-rows (sort animals-table "age" true) 10))}

To convert a Circle of Evaluation into code, we start at the outside and work our way in. After each function we write a pair of parentheses, and then convert each argument inside the Circle. The code for this Circle of Evaluation would be: 

@show{(code '(first-n-rows (sort animals-table "age" true) 10))}

---
{layout="InvestigateC"}
# Composing with Circles of Evaluation  

If we wanted to get extra fancy and see the species count for the youngest ten animals, we could add another layer to our Circle of Evaluation.

@show{(coe '(count (first-n-rows (sort animals-table "age" true) 10) "species"))}

That would translate to the following code:

@show{(code '(count (first-n-rows (sort animals-table "age" true) 10) "species"))}

---
{layout="Investigate"}
# Composing with Circles of Evaluation  

- Turn to @printable-exercise{coe-sort-count.adoc}. 
- Draw Circles of Evaluation and write code for each of the given scenarios.
- Then test your code out in @starter-file{animals}.

---
{layout="Synthesize"}
# Composing with Circles of Evaluation  

- What did you Notice?
- What did you wonder?

---
{layout="Launch"}
# Functions for Making Displays

The `count` function summarized the data for a single variable in a new table. But the same information could be communicated as a picture! This is called data visualization, and Pyret has functions that can make displays for us!

<!--
Students will be introduced to functions for making one-variable displays in Pyret, including: @show{(code 'pie-chart)}, @show{(code 'bar-chart)}, @show{(code 'box-plot)} and @show{(code 'histogram)}.

The goal here is for students to become familiar with __using contracts to write expressions that will produce displays__. Knowing how to _make_ a histogram doesn't mean a student really understands histograms! We have dedicated, in-depth lessons that focus on each display mentioned in this lesson:

* @lesson-link{bar-and-pie-charts}
* @lesson-link{histograms}
* @lesson-link{visualizing-the-shape-of-data}
* @lesson-link{box-plots}

We also have dedicated lessons for other displays not mentioned here, such as @lesson-link{scatter-plots}, @lesson-link{linear-regression}, @lesson-link{advanced-displays}, etc.
-->

---
{layout="Investigate-DN"}
# Functions for Making Displays

- Turn to @printable-exercise{exploring-displays.adoc}.
- Let's look at the first function together.
- What is the name of the function?
- What is the Domain of the function?
- What is the Range of the function?
- Take a minute and see if you and your partner can write an expression that will generate a `bar-chart` and give me a thumbs up when you have one building.

@teacher{
- Let's look at the first function together.
- What is the name of the function?
** _bar-chart_
- What is the Domain of the function?
** _Table, String_
- What is the Range of the function?
** _Image!_
- Take a minute and see if you and your partner can write an expression that will generate a `bar-chart` and give me a thumbs up when you have one building.
}
---
{layout="Investigate-DN"}
# Functions for Making Displays

- Did `bar-chart` consume a categorical or quantitative column of data?
- What does the resulting display tell us?
- Make a sketch of the display you just built in Pyret.

Complete the page, generating each of the other 3 displays. Some of them may be new to you - you are not expected to be an expert in them yet, but you should be able to figure out how to use the contract to get them building!

@teacher{
- Did `bar-chart` consume a categorical or quantitative column of data?
** _categorical_
- What does the resulting display tell us?
- Make a sketch of the display you just built in Pyret.
- Then work to complete the page, generating each of the other 3 displays. Some of them may be new to you - you are not expected to be an expert in them yet, but you should be able to figure out how to use the contract to get them building!
}

---
{layout="InvestigateR"}
# Functions for Making Displays

These functions can be visualized as another Circle of Evaluation:

@show{(coe '(pie-chart animals-table "species"))}

Just as we can use Circles of Evaluation with `sort`, `count`, and `first-n-rows`, we can put Circles to work to help us write code to build more specific displays.

---
{layout="Investigate"}
# Functions for Making Displays

- Turn to @printable-exercise{coe-displays.adoc} and apply Circles of Evaluation to figure out the code for building more specific displays.
- For more practice, try @opt-printable-exercise{matching-coe-to-descriptions.adoc}.

Displays are often most interesting when compared with other displays. For example, we may want to see how the age range of the animals adopted quickly compares to the age range of all the animals or of the animals that were adopted slowly. Consider what you might compare each of these displays against.

{layout="Synthesize"}
# Functions for Making Displays

- Which displays worked with categorical data?
- Why might you choose a bar chart over a pie chart or vice versa?
- How are bar charts and histograms different?

@teacher{
- Which displays worked with categorical data?
** `pie-chart` _and_ `bar-chart`
- Why might you choose a bar chart over a pie chart or vice versa?
** `pie-chart` _only makes sense when you have the full picture, since it's representing the proportion of the whole_
** `bar-chart` _shows the count_
- How are bar charts and histograms different?
** `bar-chart` _summarizes @vocab{categorical} data. Each bar represents the count of a specific category._
** `histogram` _displays the distribution of @vocab{quantitative} data across the range._
}
---
{layout="Supplemental"}
# Additional Exercises

For more practice composing table functions, you can complete 

- @opt-printable-exercise{coe-displays-2.adoc} and/or
- @opt-printable-exercise{matching-coe-to-descriptions.adoc}.
