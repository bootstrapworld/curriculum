@slidebreak
{layout="DS Title Slide"}
# Table Functions

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch"}
# Review

- Load the @starter-file{table-functions}, go to the File menu, and click "Save a Copy".
- Hit "Run," then type `shapes-table` in the Interactions Area.
- The way this file defines a table is different from what we've encountered before. How is it different?

<!--
Pyret also allows us to define Tables __in code__, rather than using a spreadsheet. This file defines the `shapes-table` one row at a time.
-->

@slidebreak
{layout="Investigate"}
# Review

With your partner, take 5 minutes to complete @printable-exercise{pages/row-and-function-definitions.adoc}.

@slidebreak
{layout="Investigate"}
# Review

* Who can explain what `is-red` does?
* Who can explain what `is-polygon` does?
* Who can explain what `is-triangle` does?


<!--
Challenge students to use terminology like "looks up the value in the X column" when describing a lookup.

* Who can explain what `is-red` does?
** _It looks up the color of the row, and checks if it is equal to the string `"red"`._
* Who can explain what `is-polygon` does?
** _It looks up the value in the `polygon` column._
* Who can explain what `is-triangle` does?
** _It checks if the value in the `name` column contains `"triangle"`._
-->

@slidebreak
{layout="Synthesize"}
# Review

- Were you able to guess what the functions did before testing them out? What was your strategy for making an educated guess?
- What is the relationship between a _row definition_ and a _row-consuming function_?

@slidebreak
{layout="Launch"}
# Filtering Rows, Building Columns

Sometimes we want to *filter the rows* of a table by some criteria. In our animals dataset, for example, we might want to filter the table to show only the rows for dogs, or only the rows for cats older than 5. What are some ways to filter our table of students?


<!--
Select 6-8 students, each of whom will represent a unique Row of a dataset called “Students.”  Arrange them in a line at the front of the room.
-->


@slidebreak
{layout="Launch-RP"}
# Filtering Rows, Building Columns

- I need one volunteer who will play the role of `filter`, and another who will be their trusty helper function.
- The helper chooses one @handout{pages/function-cards.adoc, Function Card}. They’ll read it carefully, making sure they understand what it will do for each "Row" (student!), but **keeping it a secret**. @teacher{(Choose your students and cards carefully! Some cards only work if you have at least one student with glasses, red hair, etc.)}
- `filter` walks from one student to the next, pointing to each one and asking “keep ‘em?”.
- The helper will answer with whatever the function on the card would produce for that student: `true` or `false`
- If the helper replies "true", `filter` asks that student to take a step forward
- If the helper says "false", `filter` asks them to take a step back.

@slidebreak
{layout="Launch-RP"}
# Filtering Rows, Building Columns

Here’s how that might look if `filter` chose a function card `has-glasses`.

- `filter` stands in front of Student 1. “Keep ‘em?”
- The helper checks if they are wearing glasses, and says “true”
- `filter` to Student 1 (who wears glasses): Step forward. (Student 1 steps forward.)
- `filter` stands in front of Student 2. “Keep ‘em?”
- The helper checks if they are wearing glasses, and says “false”
- `filter` to Student 2 (who does not wear glasses): Step back. (Student 2 steps back.)

--

@teacher{
Have your helper function and `filter` work together to act out one round of this. Ask the `filter` if they can guess what's on the helper function's card, then ask the rest of the class. Give a _different_ card to a _different_ helper, and repeat the exercise.
}

@slidebreak
{layout="Investigate-DN"}
# Filtering Rows, Building Columns

Pyret Tables have their own functions for filtering tables - and more! Let's explore some of these.

Take 10 minutes to complete @printable-exercise{exploring-functions.adoc}


@slidebreak
{layout="Investigate"}
# Filtering Rows, Building Columns

Did the activity help you to understand these two key ideas?

* `filter` consumes a Table and a _function that consumes Rows and produces Booleans_. It produces a new table containing only rows for which the function returns `true`.
* `build-column` consumes a Table, the name of a new column, and a _function that consumes Rows_. It produces a new table with that new column, and fills in the values by applying the function to every Row.

@slidebreak
{layout="Investigate"}
# Filtering Rows, Building Columns

How would you filter and build using the Animals Dataset? For practice, complete @printable-exercise{pages/what-table-do-we-get.adoc}.

<!--
*Students often think that these functions _change_ the table!* In Pyret, all table functions produce a _brand new table_. If we want to save that table and use it later, we need to define it. For example: `cats = filter(animals-table, is-cat)`.
-->

@slidebreak
{layout="Synthesize"}
# Filtering Rows, Building Columns

Using Table Functions is a _huge_ upgrade in our ability to analyze data!

- If the shelter is purchasing food for older cats, what filter would we write to determine how many cats to buy for?
- A dataset from Europe might list everything in metric (centimeters, kilograms, etc), so we could build a column to convert that to imperial units (inches, pounds, etc).
- A dataset about sports teams might include columns for how many games each team won and how many they lost, but it's more useful to build a column to see _what percentage of games_ those teams won.


@slidebreak
{layout="Synthesize"}
# Filtering Rows, Building Columns

- What are some ways you might want to filter _your_ dataset?
- What are some columns you might want to build for _your_ dataset?
