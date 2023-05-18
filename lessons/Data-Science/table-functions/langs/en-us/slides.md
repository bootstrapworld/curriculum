---
{layout="DS Title Slide"}
# Table Functions

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Review

Pyret also allows us to define Tables __in code__, rather than using a spreadsheet. This file defines the table, one row at a time.

<!--
-->
---
{layout="Investigate"}
# Review

- This activity is about reading carefully and getting more comfortable with row-consuming functions.
- Load the @starter-file{table-functions}, go to the File menu, and click "Save a Copy".
- Take 5 minutes to complete @printable-exercise{pages/row-and-function-definitions.adoc}.


---
{layout="Launch"}
# Filtering Rows, Building Columns

Sometimes we want to *filter the rows* of a table by some criteria. In our animals dataset, for example, we might want to filter the table to show only the rows for dogs, or only the rows for cats older than 5. What are some ways to filter our table of students?


<!--
Select 6-8 students, each of whom will represent a unique Row of a dataset called “Students.”  Arrange them in a line at the front of the room.
-->


---
{layout="Launch"}
# Filtering Rows, Building Columns


- I am going to select a volunteer who will play the role of… `filter`!
- I will hand the volunteer a function card from the @handout{pages/function-cards.adoc, Function Cards} set. 
- Next, `filter` will read the card carefully, making sure they understand what it will do for each "Row" (student!) in the "Table", but they will __keep it a secret__.
- The volunteer playing Filter will walk from one student to the next, referring to the function (on the card) in order to determine if each student should step forward or step backward.

<!--
Choose your students and cards carefully! Some cards only work if you have at least one student with glasses, red hair, etc.
-->



---
{layout="Launch"}
# Filtering Rows, Building Columns

- `filter` _stands in front of Student 1 and checks if they are wearing glasses._
- *`filter` to Student 1 (who wears glasses)*: Step forward. (Student 1 steps forward.)
- `filter` _stands in front of Student 2 and checks if they are wearing glasses._
- *`filter` to Student 2 (who does not wear glasses)*: Step back. (Student 2 steps back.)

<!--
Have your `filter` volunteer go through all their peers, applying their card to each one. Based on who stepped forward and backward, what was on the card? Repeat for several cards. Give the volunteer a round of applause!
-->

---
{layout="Investigate"}
# Filtering Rows, Building Columns

Pyret Tables have their own functions for filtering tables - and more! Let's explore some of these.

Take 10 minutes to complete @printable-exercise{exploring-functions.adoc}


---
{layout="Investigate"}
# Filtering Rows, Building Columns

Did the activity help you to understand these two key ideas?

* `filter` consumes a Table and a _function that consumes Rows and produces Booleans_. It produces a new table containing only rows for which the function returns `true`.
* `build-column` consumes a Table, the name of a new column, and a _function that consumes Rows_. It produces a new table with that new column, and fills in the values by applying the function to every Row.

---
{layout="Investigate"}
# Filtering Rows, Building Columns

How would you filter and build using the Animals Dataset? For practice, complete @printable-exercise{pages/what-table-do-we-get.adoc}.

<!--
*Students often think that these functions _change_ the table!* In Pyret, all table functions produce a _brand new table_. If we want to save that table and use it later, we need to define it. For example: `cats = filter(animals-table, is-cat)`.
-->

---
{layout="Synthesize"}
# Filtering Rows, Building Columns

Using Table Functions is a _huge_ upgrade in our ability to analyze data!

- If the shelter is purchasing food for older cats, what filter would we write to determine how many cats to buy for?
- A dataset from Europe might list everything in metric (centimeters, kilograms, etc), so we could build a column to convert that to imperial units (inches, pounds, etc).
- A dataset about sports teams might include columns for how many games each team won and how many they lost, but it's more useful to build a column to see _what percentage of games_ those teams won.


---
{layout="Synthesize"}
# Filtering Rows, Building Columns

- What are some ways you might want to filter _your_ dataset?
- What are some columns you might want to build for _your_ dataset?
